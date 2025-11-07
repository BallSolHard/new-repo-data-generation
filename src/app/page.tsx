"use client";

import { useState, useEffect } from "react";
import TopBar from "@/components/Sidebar";

// Type definitions for API response
type CertificationFromAPI = {
  id: number;
  title: string;
  description?: string;
  active: boolean;
  domains?: DomainData[];
};

type DomainData = {
  topic_id: number;
  topic_name: string;
  topic_description?: string;
  ideal_completion_time?: number;
  certification_id: number;
  modules?: ModuleData[];
};

type ModuleData = {
  module_id: string;
  module_name: string;
  module_description?: string;
  topic_id: number;
  ideal_completion_time?: string;
  module_content?: string;
};

type QuizData = {
  id: string;
  title: string;
  created_at: string;
  difficulty: string;
  questions: number;
  duration: number;
  modified_at: string;
  popularity: number;
  category_id: string;
  certification_id: number;
  question_type: string;
  is_completed: boolean;
};

// Sample data structure for certifications (fallback)
type CertificationData = {
  [certName: string]: {
    domains: {
      [domainName: string]: {
        modules: string[];
      };
    };
  };
};

const fallbackCertificationData: CertificationData = {
  "AWS Solutions Architect": {
    domains: {
      "Design Secure Architectures": {
        modules: [
          "Identity and Access Management",
          "Network Security",
          "Data Protection",
          "Monitoring and Logging"
        ]
      },
      "Design Resilient Architectures": {
        modules: [
          "Multi-tier Architecture",
          "High Availability",
          "Disaster Recovery",
          "Scalability"
        ]
      },
      "Design High-Performing Architectures": {
        modules: [
          "Compute Services",
          "Storage Solutions",
          "Database Services",
          "Networking"
        ]
      },
      "Design Cost-Optimized Architectures": {
        modules: [
          "Cost Management",
          "Resource Optimization",
          "Pricing Models",
          "Monitoring Costs"
        ]
      }
    }
  },
  "Azure Fundamentals": {
    domains: {
      "Cloud Concepts": {
        modules: [
          "Cloud Benefits",
          "Cloud Service Types",
          "Cloud Deployment Models"
        ]
      },
      "Azure Services": {
        modules: [
          "Compute Services",
          "Networking Services",
          "Storage Services",
          "Database Services"
        ]
      },
      "Security and Compliance": {
        modules: [
          "Azure Security",
          "Governance and Compliance",
          "Privacy and Trust"
        ]
      },
      "Pricing and Support": {
        modules: [
          "Azure Subscriptions",
          "Planning and Management",
          "Support Options"
        ]
      }
    }
  },
  "Google Cloud Associate": {
    domains: {
      "Cloud Infrastructure": {
        modules: [
          "Compute Engine",
          "Kubernetes Engine",
          "App Engine",
          "Cloud Functions"
        ]
      },
      "Data Services": {
        modules: [
          "Cloud Storage",
          "Cloud SQL",
          "BigQuery",
          "Datastore"
        ]
      },
      "Networking": {
        modules: [
          "VPC Networks",
          "Load Balancing",
          "Cloud CDN",
          "Cloud DNS"
        ]
      },
      "Security and Identity": {
        modules: [
          "IAM",
          "Cloud Security",
          "Encryption",
          "Monitoring"
        ]
      }
    }
  }
};

export default function Home() {
  const [activeTab, setActiveTab] = useState<"hub" | "mock">("hub");
  const [selectedCertification, setSelectedCertification] = useState<string>("");
  const [selectedDomain, setSelectedDomain] = useState<string>("");
  const [selectedModule, setSelectedModule] = useState<string>("");
  const [certifications, setCertifications] = useState<CertificationFromAPI[]>([]);
  const [domains, setDomains] = useState<DomainData[]>([]);
  const [modules, setModules] = useState<ModuleData[]>([]);
  const [quizzes, setQuizzes] = useState<QuizData[]>([]);
  const [fallbackCertifications] = useState<CertificationData>(fallbackCertificationData);
  const [loading, setLoading] = useState(true);
  const [domainsLoading, setDomainsLoading] = useState(false);
  const [modulesLoading, setModulesLoading] = useState(false);
  const [quizzesLoading, setQuizzesLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [generatedSQL, setGeneratedSQL] = useState<string>("");
  const [isGenerating, setIsGenerating] = useState(false);
  const [questionsPerModule, setQuestionsPerModule] = useState<number>(1);
  const [isExecuting, setIsExecuting] = useState(false);
  const [executionResult, setExecutionResult] = useState<string | null>(null);
  const [isEditingSQL, setIsEditingSQL] = useState(false);
  const [editableSQL, setEditableSQL] = useState<string>("");
  const [validationResults, setValidationResults] = useState<any>(null);

  // Fetch certifications from API on component mount
  useEffect(() => {
    const fetchCertifications = async () => {
      try {
        setLoading(true);
        const response = await fetch('/api/certifications');
        if (!response.ok) {
          throw new Error('Failed to fetch certifications');
        }
        const data = await response.json();
        setCertifications(data.certifications || []);
        setError(null);
      } catch (err) {
        console.error('Error fetching certifications:', err);
        setError('Failed to load certifications. Using fallback data.');
        setCertifications([]);
      } finally {
        setLoading(false);
      }
    };

    fetchCertifications();
  }, []);

  // Fetch domains when certification is selected
  useEffect(() => {
    const fetchDomains = async () => {
      if (!selectedCertification) {
        setDomains([]);
        return;
      }

      try {
        setDomainsLoading(true);
        const selectedCert = certifications.find(c => c.title === selectedCertification);
        
        if (selectedCert?.id) {
          const response = await fetch(`/api/domains?certification_id=${selectedCert.id}`);
          if (!response.ok) {
            throw new Error('Failed to fetch domains');
          }
          const data = await response.json();
          setDomains(data.domains || []);
        }
      } catch (err) {
        console.error('Error fetching domains:', err);
        // Use embedded domains from certification if API fails
        const selectedCert = certifications.find(c => c.title === selectedCertification);
        setDomains(selectedCert?.domains || []);
      } finally {
        setDomainsLoading(false);
      }
    };

    if (selectedCertification && certifications.length > 0) {
      fetchDomains();
    }
  }, [selectedCertification, certifications]);

  // Fetch modules when domain is selected
  useEffect(() => {
    const fetchModules = async () => {
      if (!selectedDomain) {
        setModules([]);
        return;
      }

      try {
        setModulesLoading(true);
        const selectedTopicData = domains.find(d => d.topic_name === selectedDomain);
        
        if (selectedTopicData?.topic_id) {
          const response = await fetch(`/api/modules?topic_id=${selectedTopicData.topic_id}`);
          if (!response.ok) {
            throw new Error('Failed to fetch modules');
          }
          const data = await response.json();
          setModules(data.modules || []);
        }
      } catch (err) {
        console.error('Error fetching modules:', err);
        // Fallback to embedded modules or static data
        setModules([]);
      } finally {
        setModulesLoading(false);
      }
    };

    if (selectedDomain && domains.length > 0) {
      fetchModules();
    }
  }, [selectedDomain, domains]);

  // Fetch quizzes when module is selected (for Mock Questions) or domain is selected (for Hub Questions)
  useEffect(() => {
    const fetchQuizzes = async () => {
      // For Hub Questions: fetch after domain selection
      // For Mock Questions: fetch after module selection
      const shouldFetchQuizzes = 
        (activeTab === "hub" && selectedDomain && selectedCertification) ||
        (activeTab === "mock" && selectedModule && selectedDomain && selectedCertification);

      if (!shouldFetchQuizzes) {
        setQuizzes([]);
        return;
      }

      try {
        setQuizzesLoading(true);
        const selectedTopicData = domains.find(d => d.topic_name === selectedDomain);
        const selectedCertData = certifications.find(c => c.title === selectedCertification);
        
        if (selectedTopicData?.topic_id && selectedCertData?.id) {
          const response = await fetch(`/api/quiz?category_id=${selectedTopicData.topic_id}&certification_id=${selectedCertData.id}`);
          if (!response.ok) {
            throw new Error('Failed to fetch quizzes');
          }
          const data = await response.json();
          setQuizzes(data.quizzes || []);
        }
      } catch (err) {
        console.error('Error fetching quizzes:', err);
        setQuizzes([]);
      } finally {
        setQuizzesLoading(false);
      }
    };

    if (domains.length > 0 && certifications.length > 0) {
      fetchQuizzes();
    }
  }, [selectedModule, selectedDomain, selectedCertification, domains, certifications, activeTab]);

  const handleCertificationChange = (cert: string) => {
    setSelectedCertification(cert);
    setSelectedDomain("");
    setSelectedModule("");
  };

  const handleDomainChange = (domain: string) => {
    setSelectedDomain(domain);
    setSelectedModule("");
    setModules([]); // Clear modules when domain changes
  };

  const handleModuleChange = (module: string) => {
    setSelectedModule(module);
    setQuizzes([]); // Clear quizzes when module changes
  };

  const handleTabChange = (tab: "hub" | "mock") => {
    setActiveTab(tab);
    // Reset selections when switching tabs
    setSelectedCertification("");
    setSelectedDomain("");
    setSelectedModule("");
    setGeneratedSQL("");
    setEditableSQL("");
    setIsEditingSQL(false);
    setValidationResults(null);
    setQuestionsPerModule(1); // Reset questions per module
    setModules([]); // Clear modules when switching tabs
    setQuizzes([]); // Clear quizzes when switching tabs
  };

  const getCurrentDomains = () => {
    if (!selectedCertification) return [];
    
    // Use fetched domains if available
    if (domains.length > 0) {
      return domains.map(d => d.topic_name);
    }
    
    // Use API data if available
    if (certifications.length > 0) {
      const cert = certifications.find(c => c.title === selectedCertification);
      return cert?.domains?.map(d => d.topic_name) || [];
    }
    
    // Fallback to static data
    return Object.keys(fallbackCertifications[selectedCertification as keyof typeof fallbackCertifications]?.domains || {});
  };

  const getCurrentModules = () => {
    if (!selectedCertification || !selectedDomain) return [];
    
    // Use fetched modules if available (from API)
    if (modules.length > 0) {
      return modules.map(m => m.module_name);
    }
    
    // Use API data if available (embedded in domains)
    if (certifications.length > 0) {
      const cert = certifications.find(c => c.title === selectedCertification);
      const domain = cert?.domains?.find(d => d.topic_name === selectedDomain);
      return domain?.modules?.map(m => m.module_name) || [];
    }
    
    // Fallback to static data
    const cert = fallbackCertifications[selectedCertification as keyof typeof fallbackCertifications];
    return cert?.domains[selectedDomain as keyof typeof cert.domains]?.modules || [];
  };

  const getCertificationsList = () => {
    // Use API data if available, otherwise use fallback
    if (certifications.length > 0) {
      return certifications.map(cert => cert.title);
    }
    return Object.keys(fallbackCertifications);
  };

  const generateHubQuestions = async () => {
    setGeneratedSQL("");
    setExecutionResult(null);
    if (!selectedCertification || !selectedDomain) {
      setError("Please select certification and domain first");
      return;
    }

    setIsGenerating(true);
    setError(null);

    try {
      const selectedCertData = certifications.find(c => c.title === selectedCertification);
      const selectedDomainData = domains.find(d => d.topic_name === selectedDomain);
      const quizId = quizzes.length > 0 ? quizzes[0].id : `quiz_domain${selectedDomainData?.topic_id}_generated`;

      const payload = {
        certification_id: selectedCertData?.id,
        certification_name: selectedCertification,
        topic_id: selectedDomainData?.topic_id,
        topic_name: selectedDomain,
        topic_description: selectedDomainData?.topic_description || `${selectedDomain} domain knowledge and best practices`,
        quiz_id: quizId,
        questionsPerModule: questionsPerModule,
        modules: modules.length > 0 ? modules : getCurrentModules().map((name, index) => ({
          module_id: `fallback_${index + 1}`,
          module_name: name,
          module_description: `Knowledge and skills related to ${name}`,
          module_content: `Core concepts and practical applications of ${name} in ${selectedDomain}`
        }))
      };
      const response = await fetch('/api/generate-hub', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
      });
      
      if (!response.ok) {
        throw new Error('Failed to generate hub questions');
      }

      const data = await response.json();
      console.log("GENERATED DATA FOR SQL:", data);
      setGeneratedSQL(data.script);
      setEditableSQL(data.script);
      setValidationResults(data);
   
      
    } catch (err) {
      console.error('Error generating hub questions:', err);
      setError('Failed to generate hub questions. Please try again.');
    } finally {
      setIsGenerating(false);
    }
  };

  const handleEditSQL = () => {
    setIsEditingSQL(true);
    setEditableSQL(generatedSQL);
  };

  const handleSaveSQL = () => {
    setGeneratedSQL(editableSQL);
    setIsEditingSQL(false);
  };

  const handleCancelEdit = () => {
    setEditableSQL(generatedSQL);
    setIsEditingSQL(false);
  };

  const executeSQL = async () => {
    const sqlToExecute = isEditingSQL ? editableSQL : generatedSQL;
    if (!sqlToExecute) {
      setError("No SQL script to execute");
      return;
    }

    setIsExecuting(true);
    setExecutionResult(null);
    setError(null);

    try {
      const response = await fetch('/api/execute-sql', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
          sql: sqlToExecute,
          operation: 'insert_questions'
        })
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to execute SQL script');
      }

      const data = await response.json();
      setExecutionResult(`Successfully executed! ${data.message || 'Questions inserted into database.'}`);
      
    } catch (err) {
      console.error('Error executing SQL:', err);
      setError(`Failed to execute SQL script: ${err instanceof Error ? err.message : 'Unknown error'}`);
    } finally {
      setIsExecuting(false);
    }
  };
 
  return (
    <>
      <TopBar />
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800">
        <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-4">
            StudyTech Content Engine
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300">
            Select your certification path and explore domains and modules
          </p>
        </div>

        {/* Tab Navigation */}
        <div className="max-w-6xl mx-auto mb-8">
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-2">
            <div className="flex space-x-1">
              <button
                onClick={() => handleTabChange("hub")}
                className={`flex-1 py-3 px-6 rounded-md font-semibold transition-all duration-200 ${
                  activeTab === "hub"
                    ? "bg-purple-500 text-white shadow-lg"
                    : "text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                }`}
              >
                Generate Hub Questions
              </button>
              <button
                onClick={() => handleTabChange("mock")}
                className={`flex-1 py-3 px-6 rounded-md font-semibold transition-all duration-200 ${
                  activeTab === "mock"
                    ? "bg-purple-500 text-white shadow-lg"
                    : "text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                }`}
              >
                Generate Mock Questions
              </button>
            </div>
          </div>
        </div>

        {/* Selection Cards */}
        <div className="max-w-6xl mx-auto space-y-8">
          {/* Error Message */}
          {error && (
            <div className="bg-yellow-50  dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-4">
              <p className="text-yellow-800 dark:text-yellow-200">{error}</p>
            </div>
          )}

          {/* Certification Selection */}
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
            <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
              Choose Certification
            </h2>
            {loading ? (
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                {[1, 2, 3].map((i) => (
                  <div key={i} className="p-4 rounded-lg border-2 border-gray-200 dark:border-gray-600 animate-pulse">
                    <div className="h-6 bg-gray-200 dark:bg-gray-700 rounded"></div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                {getCertificationsList().map((cert) => (
                  <button
                    key={cert}
                    onClick={() => handleCertificationChange(cert)}
                    className={`p-4 rounded-lg border-2 transition-all duration-200 ${
                      selectedCertification === cert
                        ? "border-purple-500 bg-purple-50 dark:bg-purple-900/20 text-purple-700 dark:text-purple-300"
                        : "border-gray-200 dark:border-gray-600 hover:border-purple-300 dark:hover:border-purple-500"
                    }`}
                  >
                    <div className="font-semibold cursor-pointer text-gray-900 dark:text-white">
                      {cert}
                    </div>
                  </button>
                ))}
              </div>
            )}
          </div>

          {/* Domain Selection */}
          {selectedCertification && (
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
              <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
                Select Domain
              </h2>
              {domainsLoading ? (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {[1, 2].map((i) => (
                    <div key={i} className="p-4 rounded-lg border-2 border-gray-200 dark:border-gray-600 animate-pulse">
                      <div className="h-6 bg-gray-200 dark:bg-gray-700 rounded"></div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {getCurrentDomains().map((domain) => (
                    <button
                      key={domain}
                      onClick={() => handleDomainChange(domain)}
                      className={`p-4 rounded-lg border-2 transition-all duration-200 text-left ${
                        selectedDomain === domain
                          ? "border-purple-500 bg-purple-50 dark:bg-purple-900/20 text-purple-700 dark:text-purple-300"
                          : "border-gray-200 dark:border-gray-600 hover:border-purple-300 dark:hover:border-purple-500"
                      }`}
                    >
                      <div className="font-semibold text-gray-900 dark:text-white">
                        {domain}
                      </div>
                    </button>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* Module/Task Selection - Only show for Mock Questions */}
          {selectedDomain && activeTab === "mock" && (
            <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
              <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
                Choose Module/Task
              </h2>
              {modulesLoading ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {[1, 2, 3].map((i) => (
                    <div key={i} className="p-4 rounded-lg border-2 border-gray-200 dark:border-gray-600 animate-pulse">
                      <div className="h-6 bg-gray-200 dark:bg-gray-700 rounded"></div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {getCurrentModules().map((module: string) => (
                    <button
                      key={module}
                      onClick={() => handleModuleChange(module)}
                      className={`p-4 rounded-lg border-2 transition-all duration-200 text-left ${
                        selectedModule === module
                          ? "border-purple-500 bg-purple-50 dark:bg-purple-900/20 text-purple-700 dark:text-purple-300"
                          : "border-gray-200 dark:border-gray-600 hover:border-purple-300 dark:hover:border-purple-500"
                      }`}
                    >
                      <div className="font-semibold text-gray-900 dark:text-white">
                        {module}
                      </div>
                    </button>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* Selected Summary */}
          {((activeTab === "hub" && selectedDomain) || (activeTab === "mock" && selectedModule)) && (
            <div className="bg-gradient-to-r from-purple-500 to-purple-600 rounded-lg shadow-lg p-6 text-white">
              <h2 className="text-2xl font-semibold mb-4">Your Selection</h2>
              <div className="space-y-2">
                <p><span className="font-semibold">Mode:</span> {activeTab === "hub" ? "Hub Questions" : "Mock Questions"}</p>
                <p>
                  <span className="font-semibold">Certification:</span> {selectedCertification}
                  {(() => {
                    const selectedCertData = certifications.find(c => c.title === selectedCertification);
                    return selectedCertData ? <code className="bg-white/20 px-2 py-1 rounded text-sm ml-2">{selectedCertData.id}</code> : null;
                  })()}
                </p>
                <p>
                  <span className="font-semibold">Domain:</span> {selectedDomain}
                  {(() => {
                    const selectedDomainData = domains.find(d => d.topic_name === selectedDomain);
                    return selectedDomainData ? <code className="bg-white/20 px-2 py-1 rounded text-sm ml-2">{selectedDomainData.topic_id}</code> : null;
                  })()}
                </p>
                {/* Show all modules for the selected domain (for both Hub and Mock Questions) */}
                {modules.length > 0 && (
                  <div>
                    <p><span className="font-semibold">Modules:</span></p>
                    <div className="ml-4 space-y-1">
                      {modules.map((module, index) => (
                        <p key={module.module_id} className="text-sm">
                          {index + 1}. {module.module_name}
                          <code className="bg-white/20 px-2 py-1 rounded text-xs ml-2">{module.module_id}</code>
                        </p>
                      ))}
                    </div>
                  </div>
                )}
                {/* Fallback to current modules list if API modules not available */}
                {modules.length === 0 && getCurrentModules().length > 0 && (
                  <div>
                    <p><span className="font-semibold">Modules:</span></p>
                    <div className="ml-4 space-y-1">
                      {getCurrentModules().map((moduleName, index) => (
                        <p key={moduleName} className="text-sm">
                          {index + 1}. {moduleName}
                          <code className="bg-white/20 px-2 py-1 rounded text-xs ml-2">fallback-{index + 1}</code>
                        </p>
                      ))}
                    </div>
                  </div>
                )}
                {quizzesLoading ? (
                  <p><span className="font-semibold">Quiz ID:</span> <span className="animate-pulse">Loading...</span></p>
                ) : quizzes.length > 0 ? (
                  <p><span className="font-semibold">Quiz ID:</span> <code className="bg-white/20 px-2 py-1 rounded text-sm">{quizzes[0].id}</code></p>
                ) : (
                  <p><span className="font-semibold">Quiz ID:</span> <span className="text-gray-300">No quiz available</span></p>
                )}
              </div>
              
              {/* Questions per Module Selection */}
              <div className="mt-4 flex items-center space-x-4">
                <label htmlFor="questionsPerModule" className="font-semibold">
                  Questions per Module:
                </label>
                <select
                  id="questionsPerModule"
                  value={questionsPerModule}
                  onChange={(e) => setQuestionsPerModule(Number(e.target.value))}
                  className="bg-white/20 border border-white/30 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-white/50 focus:border-white/50"
                >
                  <option value={1} className="text-gray-900">1 Question</option>
                  <option value={2} className="text-gray-900">2 Questions</option>
                  <option value={3} className="text-gray-900">3 Questions</option>
                  <option value={4} className="text-gray-900">4 Questions</option>
                  <option value={5} className="text-gray-900">5 Questions</option>
                </select>
                <span className="text-sm text-white/80">
                  Total: {questionsPerModule * (modules.length || getCurrentModules().length)} questions
                </span>
              </div>
              
              <button 
                className="mt-4 bg-white text-purple-600 px-6 py-2 rounded-lg font-semibold hover:bg-gray-100 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                onClick={activeTab === "hub" ? generateHubQuestions : undefined}
                disabled={isGenerating}
              >
                {isGenerating ? "Generating..." : (activeTab === "hub" ? "Generate Hub Questions" : "Generate Mock Questions")}
              </button>

            </div>
          )}

          {/* Validation Status Indicator */}
          {validationResults && validationResults.questions && (
            <div className={`rounded-lg shadow-lg p-4 ${
              validationResults.questions.every((q: any) => q.confidence_score === 1)
                ? "bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800"
                : "bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800"
            }`}>
              <div className="flex items-center space-x-3">
                {validationResults.questions.every((q: any) => q.confidence_score === 1) ? (
                  <>
                    <div className="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center">
                      <svg className="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                      </svg>
                    </div>
                    <div>
                      <h3 className="text-lg font-semibold text-green-800 dark:text-green-200">All Questions Validated ✓</h3>
                      <p className="text-green-700 dark:text-green-300">
                        All {validationResults.questions.length} questions passed validation with confidence score of 1.
                      </p>
                    </div>
                  </>
                ) : (
                  <>
                    <div className="w-8 h-8 bg-amber-500 rounded-full flex items-center justify-center">
                      <svg className="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.732-.833-2.5 0L5.232 15.5c-.77.833.192 2.5 1.732 2.5z"></path>
                      </svg>
                    </div>
                    <div className="flex-1">
                      <h3 className="text-lg font-semibold text-amber-800 dark:text-amber-200">Validation Issues Detected ⚠️</h3>
                      <p className="text-amber-700 dark:text-amber-300 mb-2">
                        {validationResults.questions.filter((q: any) => q.confidence_score === 0).length} out of {validationResults.questions.length} questions need review.
                      </p>
                      <div className="space-y-2">
                        {validationResults.questions
                          .filter((q: any) => q.confidence_score === 0)
                          .map((question: any, index: number) => (
                            <div key={index} className="bg-amber-100 dark:bg-amber-900/30 rounded-lg p-3">
                              <p className="font-semibold text-amber-800 dark:text-amber-200 text-sm">
                                Question ID: {question.id}
                              </p>
                              <p className="text-amber-700 dark:text-amber-300 text-sm">
                                Status: {question.validation_status}
                              </p>
                              {question.validation_notes && (
                                <p className="text-amber-600 dark:text-amber-400 text-xs mt-1">
                                  {question.validation_notes}
                                </p>
                              )}
                              {question.new_correct_answer && (
                                <p className="text-amber-600 dark:text-amber-400 text-xs mt-1">
                                  Suggested answer: {question.new_correct_answer}
                                </p>
                              )}
                            </div>
                          ))
                        }
                      </div>
                    </div>
                  </>
                )}
              </div>
            </div>
          )}
          {/* Execution Result Display */}
          {executionResult && (
            <div className="bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg p-4">
              <div className="flex items-center space-x-2">
                <div className="w-6 h-6 bg-green-500 rounded-full flex items-center justify-center">
                  <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path>
                  </svg>
                </div>
                <h3 className="text-lg font-semibold text-green-800 dark:text-green-200">Execution Successful</h3>
              </div>
              <p className="text-green-700 dark:text-green-300 mt-2">{executionResult}</p>
            </div>
          )}
          {/* Generated SQL Script Display */}
          {generatedSQL && (
            <div className="bg-gray-900 rounded-lg shadow-lg p-6 text-green-400">
              <div className="flex justify-between items-center mb-4">
                <h2 className="text-2xl font-semibold text-white">
                  Generated SQL Script
                  {isEditingSQL && <span className="text-yellow-400 text-lg ml-2">(Editing)</span>}
                </h2>
                <div className="flex space-x-3">
                  {!isEditingSQL ? (
                    <>
                      <button
                        onClick={handleEditSQL}
                        className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors flex items-center space-x-2"
                      >
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                        </svg>
                        <span>Edit</span>
                      </button>
                      <button
                        onClick={() => navigator.clipboard.writeText(generatedSQL)}
                        className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                      >
                        Copy to Clipboard
                      </button>
                      <button
                        onClick={executeSQL}
                        disabled={isExecuting}
                        className="bg-green-600 hover:bg-green-700 disabled:bg-green-400 disabled:cursor-not-allowed text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                      >
                        {isExecuting ? "Executing..." : "Execute SQL"}
                      </button>
                    </>
                  ) : (
                    <>
                      <button
                        onClick={handleCancelEdit}
                        className="bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                      >
                        Cancel
                      </button>
                      <button
                        onClick={handleSaveSQL}
                        className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                      >
                        Save Changes
                      </button>
                    </>
                  )}
                </div>
              </div>
              <div className="bg-black rounded-lg p-4 overflow-x-auto">
                {!isEditingSQL ? (
                  <pre className="text-sm font-mono whitespace-pre-wrap">{generatedSQL}</pre>
                ) : (
                  <textarea
                    value={editableSQL}
                    onChange={(e) => setEditableSQL(e.target.value)}
                    className="w-full h-96 bg-black text-green-400 font-mono text-sm p-4 rounded-lg border border-gray-600 focus:border-blue-500 focus:outline-none resize-none"
                    placeholder="Edit your SQL script here..."
                  />
                )}
              </div>
            </div>
          )}
        </div>
      </div>
      </div>
    </>
  );
}
