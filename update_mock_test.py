#!/usr/bin/env python3
"""
Update mock test questions with module matching using Gemini API
"""

import os
import json
import sys
from typing import TypedDict, Optional
from datetime import datetime
from pathlib import Path
from dotenv import load_dotenv
import requests
from supabase import create_client, Client

# Load environment variables
env_path = Path(__file__).parent / ".env"
load_dotenv(dotenv_path=env_path)

# Type definitions
class MockTestQuestion(TypedDict):
    question_id: str
    mock_test_id: str
    question_text: str
    options: list
    topic_id: int
    question_order: int
    question_type: str
    explanation: str
    correct_answer: list
    pairs: Optional[dict]
    matches: Optional[dict]
    module_id: str
    time_spent_seconds: Optional[int]
    created_at: str

class Module(TypedDict):
    created_at: str
    module_name: str
    module_description: str
    topic_id: int
    ideal_completion_time: str
    module_content: str
    module_id: str

class ModuleMatchingResponse(TypedDict):
    question_id: str
    current_module_id: str
    matched_module_id: str
    confidence_score: float
    reasoning: str
    sql_update_statement: str

def generate_module_matching(
    questions: list[MockTestQuestion],
    modules: list[Module]
) -> list[ModuleMatchingResponse]:
    """Generate module matching using Gemini API"""
    
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        raise ValueError("GEMINI_API_KEY is not set in environment variables")
    
    # Format questions and modules for the prompt
    questions_text = "\n\n".join([
        f"[Question {idx + 1}]\nID: {q['question_id']}\nText: {q['question_text']}\nCurrent Module: {q['module_id']}\nExplanation: {q['explanation']}"
        for idx, q in enumerate(questions)
    ])
    
    modules_text = "\n\n".join([
        f"[Module: {m['module_id']}]\nName: {m['module_name']}\nDescription: {m['module_description']}\nContent: {m['module_content']}"
        for m in modules
    ])
    
    response_schema = {
        "type": "array",
        "items": {
            "type": "object",
            "properties": {
                "question_id": {
                    "type": "string",
                    "description": "The unique identifier of the question",
                },
                "current_module_id": {
                    "type": "string",
                    "description": "The current module_id assigned to the question",
                },
                "matched_module_id": {
                    "type": "string",
                    "description": "The recommended module_id based on semantic analysis (use format like m_19_2)",
                },
                "confidence_score": {
                    "type": "number",
                    "description": "Confidence score between 0 and 1 indicating how well the question matches the recommended module",
                },
                "reasoning": {
                    "type": "string",
                    "description": "Brief explanation of why this module was selected for this question",
                },
                "sql_update_statement": {
                    "type": "string",
                    "description": "SQL UPDATE statement to update this question. Format: UPDATE public.mock_test_questions SET module_id = 'NEW_MODULE_ID' WHERE question_text ILIKE '%QUESTION_TEXT_SNIPPET%';",
                },
            },
            "required": [
                "question_id",
                "current_module_id",
                "matched_module_id",
                "confidence_score",
                "reasoning",
                "sql_update_statement",
            ],
        },
    }
    
    prompt = f"""Analyze the following AWS SAA mock test questions and match them to the most appropriate module based on their content.

## AVAILABLE MODULES:
{modules_text}

## MOCK TEST QUESTIONS TO ANALYZE:
{questions_text}

## TASK:
For each question, provide:
1. The question_id
2. The current_module_id
3. The best matching module_id
4. A confidence score (0-1)
5. A brief reasoning explanation
6. An SQL UPDATE statement using the question text

## SQL FORMAT EXAMPLE:
UPDATE public.mock_test_questions SET module_id = 'm_19_2' WHERE question_text ILIKE '%backup strategy%';

## MATCHING RULES:
- Backup/recovery/RTO/RPO/DR/failover questions → m_19_2 (High Availability)
- Database/replication/multi-region database questions → m_20_3 (High-Performing Databases)
- Batch/scalability/serverless questions → m_19_1 (Scalable Architectures)

Return valid JSON array only."""
    
    try:
        response = requests.post(
            f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={api_key}",
            json={
                "contents": [
                    {
                        "parts": [
                            {
                                "text": prompt,
                            }
                        ],
                    }
                ],
                "generationConfig": {
                    "temperature": 0.2,
                    "maxOutputTokens": 16000,
                    "responseMimeType": "application/json",
                    "responseSchema": response_schema,
                    "topP": 0.9,
                    "topK": 40,
                },
            },
            headers={"Content-Type": "application/json"},
        )
        
        if not response.ok:
            error_data = response.json()
            raise Exception(error_data.get("error", {}).get("message", "Gemini API error"))
        
        data = response.json()
        
        if not data.get("candidates") or not data["candidates"][0].get("content"):
            print("Unexpected Gemini response format:", data)
            raise Exception("Unexpected response format from Gemini API")
        
        response_text = data["candidates"][0]["content"]["parts"][0]["text"]
        
        try:
            parsed_content = json.loads(response_text)
            return parsed_content
        except json.JSONDecodeError as json_error:
            print(f"\n❌ JSON Parsing Error: {json_error}")
            print(f"Response text (first 500 chars): {response_text[:500]}")
            print(f"Response text (last 500 chars): {response_text[-500:]}")
            raise Exception(f"Failed to parse Gemini response: {json_error}")
        
    except Exception as error:
        print(f"Error in generate_module_matching: {error}")
        raise

def generate_batch_update_sql(
    matches: list[ModuleMatchingResponse],
    min_confidence_threshold: float = 0.7
) -> dict:
    """Generate SQL update statements from matches"""
    
    update_statements = []
    changes = []
    updated = 0
    skipped = 0
    
    for match in matches:
        if match["matched_module_id"] != match["current_module_id"]:
            if match["confidence_score"] >= min_confidence_threshold:
                update_statements.append(match["sql_update_statement"])
                changes.append({
                    "questionId": match["question_id"],
                    "oldModule": match["current_module_id"],
                    "newModule": match["matched_module_id"],
                    "confidence": match["confidence_score"],
                })
                updated += 1
            else:
                skipped += 1
                print(f"⚠️  Skipped question {match['question_id']}: Low confidence ({match['confidence_score']:.2f})")
        else:
            print(f"✓ Question {match['question_id']}: Already in correct module ({match['current_module_id']})")
    
    return {
        "updateStatements": update_statements,
        "summary": {
            "total": len(matches),
            "updated": updated,
            "skipped": skipped,
            "changes": changes,
        },
    }

def main():
    """Main function"""
    
    # Mock test questions data
    questions: list[MockTestQuestion] = [
        {
            "question_id": "43b0ceb5-bf31-4fbb-affe-3b4894ca4d9e",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A backup strategy requires automated testing of backup integrity, point-in-time recovery across multiple services, and compliance with recovery objectives. The solution must verify backup completeness and provide recovery time estimates. What backup architecture ensures data protection?",
            "options": [
                "AWS Backup with automated restore testing, cross-service policies, and compliance monitoring",
                "Individual service backups with manual testing and custom verification",
                "Third-party backup solution with AWS service integration",
                "Custom backup scripts with automated testing and reporting"
            ],
            "topic_id": 19,
            "question_order": 63,
            "question_type": "mcq",
            "explanation": "Option A (incorrect) While AWS Backup offers robust automation, cross-service policies, and compliance monitoring, its managed nature may not provide the absolute level of granular control and bespoke customization required for extremely unique, niche, or highly specialized compliance standards and recovery procedures that explicitly call for custom verification beyond its predefined capabilities. Option B (correct) This architecture, despite its seemingly manual components, offers the highest degree of customization and granular control over backup, recovery, and verification processes for each individual service, enabling the implementation of bespoke scripting and tooling within \"custom verification\" to automate integrity testing, coordinate complex point-in-time recovery across diverse services, generate specific compliance reports, and derive highly accurate recovery time estimates tailored to very stringent or non-standard organizational recovery objectives. Option C (incorrect) Third-party backup solutions, despite AWS integration, introduce external dependencies, potential vendor lock-in, and an additional layer of complexity in managing cross-service consistency and deep customization compared to a solution built directly with AWS primitives and bespoke verification. Option D (incorrect) Custom backup scripts offer flexibility and automation but require significant operational overhead for maintenance, scalability, security, and especially the complex orchestration needed for truly integrated point-in-time recovery across multiple services, comprehensive verification, and compliance reporting without a robust underlying framework.",
            "correct_answer": [1],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "06a01c34-2b13-46de-a958-0c74bda955f1",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A database-driven application requires read replicas distributed across multiple regions for disaster recovery and local read performance. Write operations must be consistent across all regions, and failover should be automatic with minimal data loss. What database solution meets these requirements?",
            "options": [
                "Amazon RDS with Multi-AZ deployment and cross-region read replicas",
                "Amazon Aurora Global Database with automated failover capabilities",
                "Amazon DynamoDB with Global Tables and eventually consistent reads",
                "Amazon Redshift with cross-region snapshots and manual failover procedures"
            ],
            "topic_id": 19,
            "question_order": 7,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option B (Index 1)**\n\nAurora Global Database provides automated cross-region replication with sub-second failover, consistent writes, and RPO/RTO targets that meet disaster recovery requirements\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption A (INCORRECT):\n✗ This approach is outdated and doesn't align with AWS best practices.\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [1],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "58a6db98-b2df-4f96-883b-6d90830eb981",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A data processing pipeline must handle batch jobs that can take anywhere from minutes to hours to complete. The system should automatically retry failed jobs, scale processing capacity based on queue depth, and minimize costs during low-demand periods. What serverless approach accomplishes this?",
            "options": [
                "AWS Batch with EC2 Spot instances and Amazon SQS for job queuing",
                "AWS Lambda with SQS triggers and Dead Letter Queue for failed processing",
                "AWS Step Functions coordinating multiple Lambda functions with error handling",
                "Amazon ECS with Fargate Spot and CloudWatch Events for scheduling"
            ],
            "topic_id": 19,
            "question_order": 10,
            "question_type": "mcq",
            "explanation": "Option A (correct) AWS Batch is purpose-built for executing long-running, compute-intensive batch jobs efficiently, and its compute environments can be configured to use EC2 Spot instances for significant cost savings, automatically scaling based on the depth of jobs in the associated SQS queue. Option B (incorrect) AWS Lambda functions have a maximum execution duration of 15 minutes, making them unsuitable for batch jobs that can take \"hours\" to complete, even with SQS triggers and Dead Letter Queues for error handling. Option C (incorrect) While AWS Step Functions can orchestrate complex workflows and handle error states, it primarily coordinates underlying compute services like Lambda, which is limited to 15-minute executions, making it an inefficient or unsuitable choice for individual batch jobs that can run for \"hours\". Option D (incorrect) Amazon ECS with Fargate Spot can run long-duration tasks at a reduced cost, but this option specifies CloudWatch Events for *scheduling* rather than directly providing or implying an integrated solution for automatically scaling processing capacity based on SQS queue depth, which AWS Batch offers out-of-the-box.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "197d04ca-8cdf-446a-a791-374ee233eb62",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A backup system must ensure data integrity across multiple storage locations while providing fast recovery capabilities. The system should automatically verify backup completeness and provide point-in-time recovery options. What backup strategy provides comprehensive data protection?",
            "options": [
                "AWS Backup with cross-region replication and automated restore testing",
                "Manual snapshots with custom scripts for integrity verification",
                "EBS snapshots with lifecycle policies and manual recovery procedures",
                "S3 Cross-Region Replication with versioning enabled for data protection"
            ],
            "topic_id": 19,
            "question_order": 31,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAWS Backup provides centralized backup management across services, automated cross-region replication, point-in-time recovery, and built-in backup verification capabilities\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "aa0aa41b-94ec-42b3-820d-a67237669fed",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A backup strategy requires point-in-time recovery capabilities across multiple database types with centralized management and automated testing. The solution should verify backup integrity and provide recovery time estimates. What backup architecture provides comprehensive capabilities?",
            "options": [
                "AWS Backup with cross-service backup policies and automated restore testing",
                "Individual service backup solutions with manual coordination and testing",
                "Custom scripts with S3 storage and manual recovery procedures",
                "Database-native backup tools with separate management for each service"
            ],
            "topic_id": 19,
            "question_order": 63,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAWS Backup provides centralized backup management across multiple AWS services, automated backup testing, point-in-time recovery capabilities, and comprehensive monitoring with recovery time estimates\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "76a5eb5d-8c51-4420-8c39-1493ad3e3284",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A global logistics company needs real-time tracking of shipments across multiple regions with automatic failover to secondary regions during outages. The system must maintain data consistency and provide RPO of under 1 minute. Which database architecture meets these requirements? (Select TWO)",
            "options": [
                "Amazon DynamoDB Global Tables with strong consistency reads",
                "Aurora Global Database with automated cross-region failover",
                "Amazon RDS with Multi-AZ deployment and cross-region read replicas",
                "Amazon DocumentDB with cross-region clusters",
                "Amazon ElastiCache with Global Datastore for session management"
            ],
            "topic_id": 19,
            "question_order": 6,
            "question_type": "multiple",
            "explanation": "Option A (incorrect) Amazon DynamoDB Global Tables provide multi-region replication and allow strong consistency reads within a region, but they do not offer automatic application-level failover for write operations to a secondary region during an outage, requiring manual intervention or custom logic. Option B (correct) Aurora Global Database provides automated cross-region failover capabilities with an RPO typically measured in seconds (often under 1 minute) due to physical replication, maintaining high data consistency and meeting all specified requirements. Option C (incorrect) Amazon RDS with Multi-AZ deployment provides intra-region failover, and while cross-region read replicas allow for read distribution, promoting a cross-region replica to handle writes during a regional outage is a manual or semi-manual process, not an automated cross-region failover. Option D (incorrect) Amazon DocumentDB currently lacks a native \"cross-region cluster\" or \"global database\" feature that provides automated write failover to a secondary region during an outage, requiring manual intervention for cross-region disaster recovery. Option E (correct) Amazon ElastiCache with Global Datastore provides automatic, sub-second failover to a healthy secondary region with no data loss, thus achieving an RPO of 0 for failover, and supports multi-region distribution of real-time tracking data efficiently.",
            "correct_answer": [1, 4],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "4fe38950-30a1-44f8-b00b-eaeb04a6d82d",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A supply chain management system requires real-time visibility across global operations with automatic failover between regions during disasters. The system must maintain transaction integrity and provide RPO of 30 seconds. Which multi-region architecture ensures business continuity?",
            "options": [
                "Aurora Global Database with automated failover and DynamoDB Global Tables for configuration",
                "RDS Multi-AZ with cross-region read replicas and manual failover procedures",
                "DynamoDB Global Tables with strong consistency and Lambda-based automation",
                "DocumentDB with cross-region clusters and application-level failover logic"
            ],
            "topic_id": 19,
            "question_order": 30,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAurora Global Database provides automated cross-region failover with RPO under 30 seconds and maintains transaction integrity, while DynamoDB Global Tables handle configuration data with global consistency\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "414e56e2-1d2f-4fe7-a0f2-b2edb7387745",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A backup and recovery solution must verify backup integrity across multiple AWS services including EC2, RDS, and EFS. The system should provide automated testing, point-in-time recovery, and compliance reporting. What comprehensive backup strategy ensures data protection?",
            "options": [
                "AWS Backup with cross-service backup policies and automated restore testing",
                "Individual service backup solutions with custom integrity verification",
                "Third-party backup software with AWS service integration",
                "Manual backup procedures with scripted verification processes"
            ],
            "topic_id": 19,
            "question_order": 31,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAWS Backup provides centralized backup management across multiple AWS services with automated restore testing to verify backup integrity and compliance reporting for enterprise backup requirements\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "7ab7aefd-4b00-4389-8148-8caab9fa0c6d",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A disaster recovery plan requires automated failover between regions with RTO of 5 minutes and RPO of 1 minute for a mission-critical database. The solution must handle both planned maintenance and unplanned outages seamlessly. What database architecture meets stringent recovery requirements?",
            "options": [
                "Aurora Global Database with automated failover and continuous data replication",
                "RDS Multi-AZ with cross-region manual failover and point-in-time recovery",
                "DynamoDB Global Tables with application-level failover logic",
                "Aurora with read replicas and Lambda-based automated failover"
            ],
            "topic_id": 19,
            "question_order": 41,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAurora Global Database provides automated cross-region failover with RPO under 1 minute and RTO under 5 minutes, supporting both planned maintenance and unplanned disaster scenarios with minimal intervention\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "10ea8b0d-daee-4844-aebf-4497ec7c7a1f",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A disaster recovery strategy requires data replication across three regions with automated failover and rollback capabilities. The system must handle both regional outages and data corruption scenarios. What multi-region architecture provides comprehensive DR?",
            "options": [
                "Aurora Global Database with multiple secondary regions and automated failover",
                "Cross-region replication with manual failover and rollback procedures",
                "Multi-region active-active architecture with conflict resolution",
                "Primary-secondary replication with tertiary backup region"
            ],
            "topic_id": 19,
            "question_order": 53,
            "question_type": "mcq",
            "explanation": "**CORRECT ANSWER: Option A (Index 0)**\n\nAurora Global Database supports multiple secondary regions with automated failover capabilities, providing protection against regional outages and data corruption with fast recovery and rollback options\n\n✓ Why this option is correct:\n• Uses the specific AWS service or pattern designed precisely for this problem type\n• Covers all aspects mentioned in the scenario without gaps\n• Includes necessary components for monitoring, scaling, and security\n• Implements patterns recommended by AWS for production workloads\n• Provides cost optimization and operational efficiency\n• Integrates seamlessly with other AWS services\n\n**Why Other Options Are Incorrect:**\n\nOption B (INCORRECT):\n✗ While this service exists, it serves a different primary purpose\n✗ Attempting to use this service would require significant workarounds\n✗ The service lacks key features needed for this specific scenario\n✗ Performance and cost would be suboptimal compared to the correct choice\n\nOption C (INCORRECT):\n✗ While this option addresses part of the requirement, it leaves critical gaps\n✗ You would need to combine this with other services to complete the solution\n✗ The partial coverage means this cannot stand alone as a complete solution\n✗ Critical aspects of the scenario would remain unaddressed\n\nOption D (INCORRECT):\n✗ This option doesn't provide a complete solution.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "a899bdc8-d2e1-449f-91bf-410f97c22847",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A disaster recovery strategy requires replication of critical data to multiple regions with automated failover capabilities. The solution must minimize recovery time while ensuring data consistency across regions. What multi-region architecture provides optimal recovery capabilities?",
            "options": [
                "Aurora Global Database with automated failover and read replicas in multiple regions",
                "RDS Multi-AZ with cross-region manual snapshots and restore procedures",
                "DynamoDB Global Tables with eventually consistent multi-master replication",
                "S3 Cross-Region Replication with Lambda-triggered failover automation"
            ],
            "topic_id": 19,
            "question_order": 53,
            "question_type": "mcq",
            "explanation": "Option A (correct) because Aurora Global Database is purpose-built for multi-region disaster recovery, offering automated failover to a secondary region with an RTO often under one minute and an RPO typically in seconds, ensuring strong data consistency. Option B (incorrect) because RDS Multi-AZ provides high availability within a single region, and cross-region manual snapshots with restore procedures do not offer automated failover and result in a significantly higher recovery time objective (RTO) and potential data loss (RPO). Option C (incorrect) because while DynamoDB Global Tables provide multi-region replication and low recovery time, they employ eventually consistent multi-master replication, which does not guarantee immediate data consistency across regions as required. Option D (incorrect) because S3 Cross-Region Replication is for object storage and does not inherently provide automated failover capabilities or transactional consistency for application workloads across regions; Lambda-triggered automation would be complex and custom, not a standard solution for database-level failover.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "aa8246c8-4145-43a5-b960-38567e4429f0",
            "mock_test_id": "aws_saa_mock2_abc123",
            "question_text": "A disaster recovery strategy requires automated infrastructure recreation, data replication, and application deployment across regions. The system should support both pilot light and warm standby approaches based on criticality levels. What combination provides flexible DR capabilities?",
            "options": [
                "AWS CloudFormation StackSets for multi-region deployment with Lambda-based automation",
                "AWS CodePipeline with cross-region deployment stages and S3 cross-region replication",
                "AWS Control Tower with Account Factory and automated resource provisioning",
                "Infrastructure as Code with Terraform and manual failover procedures"
            ],
            "topic_id": 19,
            "question_order": 8,
            "question_type": "mcq",
            "explanation": "Option A (correct) AWS CloudFormation StackSets provide a powerful mechanism for deploying and managing identical infrastructure stacks across multiple AWS accounts and regions from a single template, enabling automated infrastructure recreation and application deployment for DR. Lambda-based automation can then orchestrate data replication, failover logic, and resource scaling required for both pilot light and warm standby approaches. Option B (incorrect) AWS CodePipeline is primarily a CI/CD service focused on automating software release processes, including deployments across regions, and S3 Cross-Region Replication handles S3 data, but it doesn't inherently provide the comprehensive infrastructure recreation and orchestration capabilities needed for full disaster recovery beyond application code deployment. Option C (incorrect) AWS Control Tower helps establish a secure, multi-account AWS environment and manage accounts through Account Factory and automated resource provisioning at an organizational level, but it does not directly provide the automated infrastructure recreation, data replication, and application deployment mechanisms for specific DR scenarios of existing workloads. Option D (incorrect) While Infrastructure as Code with Terraform is excellent for defining and provisioning infrastructure, the inclusion of \"manual failover procedures\" contradicts the key requirement for \"automated infrastructure recreation\" and \"application deployment across regions\" in a flexible DR strategy.",
            "correct_answer": [0],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
        {
            "question_id": "c72a9114-c9c6-4b14-9c92-0ce1570eb511",
            "mock_test_id": "aws_saa_mock_exam_xyz789",
            "question_text": "A disaster recovery plan requires automatic failover to a secondary region with an RTO of 15 minutes and RPO of 5 minutes. The primary database handles high transaction volumes and must maintain data consistency. What database configuration meets these requirements?",
            "options": [
                "RDS Multi-AZ with cross-region automated backups",
                "Aurora Global Database with automated failover capabilities",
                "DynamoDB Global Tables with eventually consistent replication",
                "RDS with read replicas and manual promotion procedures"
            ],
            "topic_id": 19,
            "question_order": 41,
            "question_type": "mcq",
            "explanation": "Option A (incorrect) RDS Multi-AZ provides high availability within a single region and automated failover to a standby in a different AZ, but cross-region automated backups require manual restoration and configuration, which is slow and cannot meet the 15-minute RTO or 5-minute RPO for automatic cross-region failover. Option B (correct) Aurora Global Database provides fully managed, fast, and automatic cross-region failover capabilities with an RTO typically under 1 minute and RPO in seconds due to very low-latency asynchronous replication, easily meeting the specified RTO and RPO while maintaining strong data consistency for high transaction volumes. Option C (incorrect) DynamoDB Global Tables offer eventual consistency for cross-region replication, which does not satisfy the strict requirement to \"maintain data consistency\" for high-transaction workloads that typically demand strong consistency across regions for disaster recovery. Option D (incorrect) RDS with read replicas in another region requires manual promotion procedures and manual application endpoint updates during a disaster, failing to meet the automatic failover requirement and potentially exceeding the 5-minute RPO due to asynchronous replication lag variations.",
            "correct_answer": [1],
            "pairs": None,
            "matches": None,
            "module_id": "m_2_3",
            "time_spent_seconds": None,
            "created_at": "2026-03-11 01:41:54.116876+00",
        },
    ]
    
    # Modules data
    modules: list[Module] = [
        {
            "created_at": "2025-09-01 10:40:24.998564+00",
            "module_name": "High Availability Architectures",
            "module_description": "Ensuring fault tolerance and high availability.",
            "topic_id": 19,
            "ideal_completion_time": "2025-08-22 03:00:00",
            "module_content": "Covers multi-AZ deployments and disaster recovery strategies.",
            "module_id": "m_19_2",
        },
        {
            "created_at": "2025-09-01 10:40:24.998564+00",
            "module_name": "Scalable Architectures",
            "module_description": "Designing loosely coupled and scalable systems.",
            "topic_id": 19,
            "ideal_completion_time": "2025-08-22 03:00:00",
            "module_content": "Includes microservices, serverless, and container orchestration.",
            "module_id": "m_19_1",
        },
        {
            "created_at": "2025-09-01 10:40:24.998564+00",
            "module_name": "High-Performing Databases",
            "module_description": "Optimizing database performance.",
            "topic_id": 20,
            "ideal_completion_time": "2025-08-22 01:30:00",
            "module_content": "Covers Aurora, DynamoDB, and caching strategies.",
            "module_id": "m_20_3",
        },
    ]
    
    try:
        print("🚀 Starting module matching process...\n")
        print(f"📊 Processing {len(questions)} questions...\n")
        
        # Generate module matches using Gemini
        matches = generate_module_matching(questions, modules)
        
        print("✅ Module matching completed!\n")
        
        # Generate SQL update statements
        result = generate_batch_update_sql(matches, 0.65)
        update_statements = result["updateStatements"]
        summary = result["summary"]
        
        print("📋 UPDATE SUMMARY:")
        print(f"   Total questions analyzed: {summary['total']}")
        print(f"   Questions to update: {summary['updated']}")
        print(f"   Skipped (low confidence): {summary['skipped']}\n")
        
        if summary["changes"]:
            print("🔄 PROPOSED CHANGES:")
            for change in summary["changes"]:
                confidence_pct = int(change["confidence"] * 100)
                print(f"   {change['questionId']}: {change['oldModule']} → {change['newModule']} (confidence: {confidence_pct}%)")
            print()
        
        print("💾 SQL UPDATE STATEMENTS:")
        print("----------------------------------------")
        if update_statements:
            for statement in update_statements:
                print(statement)
            print("----------------------------------------\n")
            
            # Create a batch SQL file
            batch_sql_content = "\n".join([
                "-- Auto-generated SQL update statements for mock test questions",
                "-- Generated by: update_mock_test.py",
                f"-- Timestamp: {datetime.now().isoformat()}",
                f"-- Total updates: {len(update_statements)}",
                "",
                "BEGIN TRANSACTION;",
                "",
                *update_statements,
                "",
                "COMMIT;",
            ])
            
            timestamp = datetime.now().isoformat().replace(":", "-").split(".")[0]
            filename = f"/Users/ranjanbatra/Ranjan_Programming_repos/studytech/new-studytech/sql/update_mock_questions_modules_{timestamp}.sql"
            
            Path(filename).parent.mkdir(parents=True, exist_ok=True)
            with open(filename, "w") as f:
                f.write(batch_sql_content)
            
            print(f"✨ SQL file saved: {filename}\n")
        else:
            print("No updates needed - all questions are in correct modules.\n")
            
    except Exception as error:
        print(f"❌ Error during module matching: {error}")
        sys.exit(1)

if __name__ == "__main__":
    main()
