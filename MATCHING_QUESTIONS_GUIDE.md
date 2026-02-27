# Matching Questions Implementation Guide

## Overview
Matching questions have been successfully integrated into the StudyTech Content Engine. This document explains how matching questions work alongside existing question types (MCQ, Multiple Select, and Ordering).

## Database Structure

### Question Table Fields
For matching questions, the `question` table uses these fields:

- **id**: Standard question ID format `q_{topic_id}_{module_id}_{index}`
- **text**: Question prompt (e.g., "Match each term to its description.")
- **type**: `'matching'` (new type added)
- **options**: JSON object with display labels `{"A": "Term1", "B": "Term2", "C": "Term3"}`
- **correct_answer**: Always `NULL` for matching questions
- **explanation**: Text explaining the correct matches
- **pairs**: JSON object containing the matching items:
  ```json
  {
    "left": ["Term1", "Term2", "Term3"],
    "right": ["Description1", "Description2", "Description3"]
  }
  ```
- **matches**: JSON object containing the correct relationships:
  ```json
  {
    "left": [0, 1, 2],
    "right": [1, 2, 0]
  }
  ```

### Understanding the Matches Format
The `matches` field defines which left item matches which right item:
- `left`: Always `[0, 1, 2, ...]` (sequential indices for left items)
- `right`: Array of indices pointing to the correct right items

Example: If `matches.right = [1, 2, 0]`, then:
- Left item 0 matches with Right item 1
- Left item 1 matches with Right item 2  
- Left item 2 matches with Right item 0

## Question Type Comparison

| Type | Options Format | Correct Answer | Pairs | Matches |
|------|---------------|---------------|--------|---------|
| MCQ | `["A", "B", "C", "D"]` | `"{1}"` | `NULL` | `NULL` |
| Multiple | `["A", "B", "C", "D"]` | `"{0,2}"` | `NULL` | `NULL` |
| Ordering | `["Step1", "Step2", "Step3", "Step4"]` | `"{0,1,2,3}"` | `NULL` | `NULL` |
| Matching | `{"A": "Term1", "B": "Term2", "C": "Term3"}` | `NULL` | `{pairs object}` | `{matches object}` |

## AI Generation Process

### Question Types for Matching
The system uses specialized matching question types:
- `'term-definition'`: Match terms with definitions
- `'service-feature'`: Match services with features
- `'concept-application'`: Match concepts with applications
- `'tool-purpose'`: Match tools with purposes
- `'architecture-component'`: Match patterns with components
- `'protocol-function'`: Match protocols with functions
- `'technology-benefit'`: Match technologies with benefits
- `'role-responsibility'`: Match roles with responsibilities
- `'metric-measurement'`: Match metrics with measurements
- `'pattern-use-case'`: Match patterns with use cases

### AI Response Format
When generating matching questions, the AI returns:
```json
{
  "module_id": "m_5_1",
  "question_number": 1,
  "text": "Match each AI/ML concept to its primary application.",
  "options": {
    "A": "Deep Learning",
    "B": "Computer Vision", 
    "C": "Natural Language Processing"
  },
  "pairs": {
    "left": ["Deep Learning", "Computer Vision", "Natural Language Processing"],
    "right": ["Text analysis and chatbots", "Neural networks with multiple layers", "Image recognition and analysis"]
  },
  "matches": {
    "left": [0, 1, 2],
    "right": [1, 2, 0]
  },
  "correct_answer": null,
  "explanation": "Deep Learning uses neural networks with multiple layers, Computer Vision handles image recognition and analysis, and NLP focuses on text analysis and chatbots."
}
```

## SQL Generation

### SQL Insert Example
```sql
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES (
    'q_domain5_1_m_5_1_10',
    'Match each AI/ML term to its description.',
    'matching',
    '{"A": "Computer vision", "B": "NLP", "C": "Inference"}'::json,
    NULL,
    'Computer vision deals with image and video analysis, NLP (Natural Language Processing) handles human language, and inference is the process of making predictions with a trained model.',
    NOW(),
    'quiz_domain5_1',
    NOW(),
    10,
    '{"left": ["Computer vision", "NLP", "Inference"], "right": ["Making a trained model predict", "Understanding images & video", "Processing human language"]}'::json,
    '{"left": [0, 1, 2], "right": [1, 2, 0]}'::json,
    'm_5_1'
) ON CONFLICT (id) DO NOTHING;
```

## User Interface

### Question Type Dropdown
The UI now includes a fourth option:
- Multiple Choice (MCQ)
- Multiple Select  
- Ordering Questions
- **Matching Questions** (new)

### Display Logic
For matching questions, the interface should:
1. Show left items as numbered list: `1. Term1, 2. Term2, 3. Term3`
2. Show right items as lettered options: `A. Description1, B. Description2, C. Description3`
3. Allow drag-and-drop or click-to-match interaction
4. Store user responses in matching format
5. Compare against the `matches` field for scoring

## Validation System

### Validation Response Format
For matching questions, the validator returns:
```json
{
  "is_correct": false,
  "correct_answer_index": {
    "left": [0, 1, 2], 
    "right": [1, 0, 2]
  },
  "confidence": "high",
  "validation_notes": "Brief explanation of the correct matches"
}
```

### Validation Logic
The system:
1. Checks if each left-right pairing is factually correct
2. Verifies all relationships are accurate for the certification context
3. Suggests corrections using the same matching format
4. Provides confidence scores and explanatory notes

## Implementation Files Modified

### Core Files
- `src/app/api/generate-hub/types.ts`: Added matching interfaces and updated GeneratedQuestion
- `src/app/api/generate-hub/route.ts`: Added matching question processing and SQL generation
- `src/app/api/generate-hub/prompts/generation.ts`: Added matching-specific prompts and instructions
- `src/app/api/generate-hub/prompts/validation.ts`: Added matching validation logic
- `src/app/page.tsx`: Added matching option to UI dropdown

### Documentation
- `matching-questions-implementation.sql`: Comprehensive implementation guide
- `matching-questions-sql-examples.sql`: Real-world SQL examples with detailed explanations

## Usage Examples

### Generate Matching Questions
Use the existing API endpoint with `questionType: "matching"`:
```json
{
  "certification_id": "cert_1",
  "topic_id": "topic_5", 
  "quiz_id": "quiz_domain5_1",
  "questionType": "matching",
  "questionsPerModule": 2
}
```

### Expected Output
The system generates SQL with proper PostgreSQL JSON formatting, including escaped quotes and proper array structures for the `pairs` and `matches` fields.

## Benefits

1. **Educational Value**: Matching questions test different cognitive skills than MCQ
2. **Variety**: Provides more engaging question formats for certification preparation
3. **Flexibility**: Works with existing validation and generation infrastructure
4. **Scalability**: Supports 3-4 matching pairs per question with room for expansion

## Testing

The implementation is ready for testing with:
- AI question generation for matching types
- SQL script generation with proper PostgreSQL formatting  
- Validation system with matching-specific logic
- UI integration with dropdown selection

All question types (MCQ, Multiple Select, Ordering, Matching) now work together in a unified system.
