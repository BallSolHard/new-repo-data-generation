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



export default function Home() {
  const [activeTab, setActiveTab] = useState<"hub" | "mock">("hub");
  const [selectedCertification, setSelectedCertification] = useState<string>("");
  const [selectedDomain, setSelectedDomain] = useState<string>("");
  const [selectedModule, setSelectedModule] = useState<string>("");
  const [certifications, setCertifications] = useState<CertificationFromAPI[]>([]);
  const [domains, setDomains] = useState<DomainData[]>([]);
  const [modules, setModules] = useState<ModuleData[]>([]);
  const [quizzes, setQuizzes] = useState<QuizData[]>([]);
  const [loading, setLoading] = useState(true);
  const [domainsLoading, setDomainsLoading] = useState(false);
  const [modulesLoading, setModulesLoading] = useState(false);
  const [quizzesLoading, setQuizzesLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [generatedSQL, setGeneratedSQL] = useState<string>("");
  const [generatedQuestions, setGeneratedQuestions] = useState<any[]>([]);
  const [isGenerating, setIsGenerating] = useState(false);
  // per-module difficulty counts (distribution)
  const [easyCount, setEasyCount] = useState(1);
  const [mediumCount, setMediumCount] = useState(1);
  const [hardCount, setHardCount] = useState(1);
  // question types
  const [selectedQuestionTypes, setSelectedQuestionTypes] = useState<string[]>(['mcq']);

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
  console.log("Modules are ", modules);
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
    
    return [];
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
    
    return [];
  };

  const getCertificationsList = () => {
    return certifications.map(cert => cert.title);
  };

  const generateHubQuestions = async () => {
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

      const payload: any = {
        certification_id: selectedCertData?.id,
        certification_name: selectedCertification,
        topic_id: selectedDomainData?.topic_id,
        topic_name: selectedDomain,
        topic_description: selectedDomainData?.topic_description || `${selectedDomain} domain knowledge and best practices`,
        quiz_id: quizId,
        modules: modules,
        questionTypes: selectedQuestionTypes  // Add selected question types
      };

      // include difficulty distribution if any of the counts are non-zero
      const distribution: Record<string, number> = {};
      if (easyCount > 0) distribution.easy = easyCount;
      if (mediumCount > 0) distribution.intermediate = mediumCount;
      if (hardCount > 0) distribution.hard = hardCount;
      if (Object.keys(distribution).length > 0) {
        // also send questionsPerModule as total, route will compute itself
        payload.questionsPerModule = Object.values(distribution).reduce((s, v) => s + v, 0);
        payload.complexityLevelDistribution = distribution;
      }

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
      setGeneratedSQL(data.sqlScript);
      setGeneratedQuestions(data.questions || []);
      
    } catch (err) {
      console.error('Error generating hub questions:', err);
      setError('Failed to generate hub questions. Please try again.');
    } finally {
      setIsGenerating(false);
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

                {/* Difficulty distribution inputs (hub only) */}
                {activeTab === "hub" && (
                  <div className="mt-4">
                    <p className="font-semibold mb-2">Questions per module by difficulty</p>
                    <div className="flex space-x-4">
                      <div className="flex flex-col">
                        <label className="text-sm">Easy</label>
                        <input
                          type="number"
                          min={0}
                          value={easyCount}
                          onChange={e => setEasyCount(Math.max(0, parseInt(e.target.value) || 0))}
                          className="w-20 px-2 py-1 border rounded"
                        />
                      </div>
                      <div className="flex flex-col">
                        <label className="text-sm">Medium</label>
                        <input
                          type="number"
                          min={0}
                          value={mediumCount}
                          onChange={e => setMediumCount(Math.max(0, parseInt(e.target.value) || 0))}
                          className="w-20 px-2 py-1 border rounded"
                        />
                      </div>
                      <div className="flex flex-col">
                        <label className="text-sm">Hard</label>
                        <input
                          type="number"
                          min={0}
                          value={hardCount}
                          onChange={e => setHardCount(Math.max(0, parseInt(e.target.value) || 0))}
                          className="w-20 px-2 py-1 border rounded"
                        />
                      </div>
                    </div>
                    <p className="text-xs text-gray-500 mt-1">Leave values at 0 if you don't need that difficulty.</p>
                  </div>
                )}

                {/* Question Type Selection */}
                <div className="mt-6">
                  <p className="font-semibold mb-3">Question Types</p>
                  <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                    {[
                      { id: 'mcq', label: 'Multiple Choice (MCQ)', description: 'Single correct answer' },
                      { id: 'multiple', label: 'Multiple Select', description: 'Multiple correct answers' },
                      { id: 'ordering', label: 'Ordering', description: 'Sequence questions' },
                      { id: 'matching', label: 'Matching', description: 'Match pairs' }
                    ].map(type => (
                      <label key={type.id} className="flex items-center space-x-2 p-3 border rounded-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700 transition">
                        <input
                          type="checkbox"
                          checked={selectedQuestionTypes.includes(type.id)}
                          onChange={e => {
                            if (e.target.checked) {
                              setSelectedQuestionTypes([...selectedQuestionTypes, type.id]);
                            } else {
                              setSelectedQuestionTypes(selectedQuestionTypes.filter(t => t !== type.id));
                            }
                          }}
                          className="w-4 h-4 rounded"
                        />
                        <div>
                          <p className="font-medium text-sm">{type.label}</p>
                          <p className="text-xs text-gray-500 dark:text-gray-400">{type.description}</p>
                        </div>
                      </label>
                    ))}
                  </div>
                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-2">Select at least one question type</p>
                </div>
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

          {/* Generated Questions and SQL Display */}
          {(generatedSQL || generatedQuestions.length > 0) && (
            <div className="space-y-6">
              {/* Questions Display */}
              {generatedQuestions.length > 0 && (
                <div className="bg-white rounded-lg shadow-lg p-6 border-l-4 border-blue-500">
                  <h2 className="text-2xl font-semibold text-gray-800 mb-6">Generated Questions</h2>
                  <div className="space-y-6">
                    {generatedQuestions.map((question, index) => (
                      <div key={index} className="bg-gray-50 rounded-lg p-5 border border-gray-200 hover:shadow-md transition-shadow">
                        {/* Question Number and Type */}
                        <div className="flex items-start justify-between mb-3">
                          <span className="text-sm font-semibold text-blue-600 bg-blue-50 px-3 py-1 rounded-full">
                            Question {index + 1}
                          </span>
                          <div className="flex space-x-2">
                            {question.type && (
                              <span className="text-xs font-medium text-purple-600 bg-purple-50 px-3 py-1 rounded-full">
                                {question.type.toUpperCase()}
                              </span>
                            )}
                            {question.difficulty && (
                              <span className="text-xs font-medium text-green-600 bg-green-50 px-3 py-1 rounded-full">
                                {question.difficulty.charAt(0).toUpperCase() + question.difficulty.slice(1)}
                              </span>
                            )}
                          </div>
                        </div>

                        {/* Question Text */}
                        <p className="text-gray-800 font-medium mb-4 text-base leading-relaxed">
                          {question.text}
                        </p>

                        {/* Options Display */}
                        {question.options && (
                          <div className="bg-white rounded-lg p-4 mb-4 border border-gray-200">
                            <p className="text-sm font-semibold text-gray-700 mb-3">Options:</p>
                            <div className="space-y-2">
                              {Array.isArray(question.options) ? (
                                question.options.map((option: any, optIdx: number) => {
                                  const optionLabel = String.fromCharCode(65 + optIdx);
                                  
                                  // Normalize the correct answer and option for comparison
                                  const rawCorrect = question.correct_answer;
                                  const optionText = String(option).trim();
                                  // Remove curly braces: {0} -> 0, {1} -> 1, etc
                                  const correctText = String(rawCorrect).trim().replace(/[{}]/g, '');
                                  
                                  // Try multiple matching strategies
                                  let isCorrect = false;
                                  
                                  // Strategy 1: Direct match with option text
                                  if (correctText === optionText) {
                                    isCorrect = true;
                                  }
                                  // Strategy 2: Match with letter (A, B, C, D)
                                  else if (correctText === optionLabel || correctText.toUpperCase() === optionLabel) {
                                    isCorrect = true;
                                  }
                                  // Strategy 3: Match with index (0, 1, 2, 3)
                                  else if (correctText === String(optIdx)) {
                                    isCorrect = true;
                                  }
                                  // Strategy 4: Case-insensitive text match
                                  else if (correctText.toUpperCase() === optionText.toUpperCase()) {
                                    isCorrect = true;
                                  }
                                  // Strategy 5: Partial match (if correct answer contains the option or vice versa)
                                  else if (correctText.includes(optionText) || optionText.includes(correctText)) {
                                    isCorrect = true;
                                  }
                                  
                                  // Debug log for first option
                                  if (optIdx === 0) {
                                    console.log('Correct answer found at index:', correctText);
                                  }
                                  
                                  return (
                                    <div
                                      key={optIdx}
                                      className={`p-3 rounded-lg border-2 transition-all ${
                                        isCorrect
                                          ? 'border-green-500 bg-green-50 shadow-md'
                                          : 'border-gray-200 bg-gray-50'
                                      }`}
                                    >
                                      <div className="flex items-start">
                                        <span className={`font-bold mr-2 text-lg ${isCorrect ? 'text-green-600' : 'text-gray-600'}`}>
                                          {optionLabel}.
                                        </span>
                                        <span className={isCorrect ? 'text-green-700 font-semibold' : 'text-gray-700'}>
                                          {option}
                                        </span>
                                        {isCorrect && <span className="ml-auto text-green-600 text-sm font-bold bg-green-200 px-2 py-1 rounded">✓ CORRECT</span>}
                                      </div>
                                    </div>
                                  );
                                })
                              ) : typeof question.options === 'object' ? (
                                Object.entries(question.options).map(([key, value]: [string, any], optIdx: number) => {
                                  // More robust matching logic for object options
                                  let isCorrect = false;
                                  const correctValue = question.correct_answer;
                                  
                                  if (correctValue !== null && correctValue !== undefined) {
                                    const correctStr = String(correctValue).trim().toUpperCase();
                                    const keyStr = String(key).trim().toUpperCase();
                                    const valStr = String(value).trim().toUpperCase();
                                    
                                    isCorrect = 
                                      correctStr === keyStr || // Key match
                                      correctStr === valStr || // Value match
                                      correctValue === key || // Raw key match
                                      String(correctValue) === String(key); // String key match
                                  }
                                  
                                  if (optIdx === 0) {
                                    console.log('=== Object Question Debug ===');
                                    console.log('correct_answer raw:', question.correct_answer);
                                    console.log('First key:', key);
                                    console.log('First value:', value);
                                  }
                                  
                                  return (
                                    <div
                                      key={optIdx}
                                      className={`p-3 rounded-lg border-2 transition-all ${
                                        isCorrect
                                          ? 'border-green-500 bg-green-50 shadow-md'
                                          : 'border-gray-200 bg-gray-50'
                                      }`}
                                    >
                                      <div className="flex items-start">
                                        <span className={`font-bold mr-2 text-lg ${isCorrect ? 'text-green-600' : 'text-gray-600'}`}>
                                          {key}:
                                        </span>
                                        <span className={isCorrect ? 'text-green-700 font-semibold' : 'text-gray-700'}>
                                          {value as string}
                                        </span>
                                        {isCorrect && <span className="ml-auto text-green-600 text-sm font-bold bg-green-200 px-2 py-1 rounded">✓ CORRECT</span>}
                                      </div>
                                    </div>
                                  );
                                })
                              ) : null}
                            </div>
                          </div>
                        )}

                        {/* Explanation */}
                        {question.explanation && (
                          <div className="bg-yellow-50 border-l-4 border-yellow-500 p-4 rounded">
                            <p className="text-sm font-semibold text-yellow-800 mb-1">Explanation:</p>
                            <p className="text-sm text-yellow-700">{question.explanation}</p>
                          </div>
                        )}

                        {/* Validation Status */}
                        {question.validation_status && (
                          <div className="mt-3 text-xs">
                            <span className={`inline-block px-2 py-1 rounded font-medium ${
                              question.validation_status === 'correct'
                                ? 'bg-green-100 text-green-800'
                                : 'bg-red-100 text-red-800'
                            }`}>
                              {question.validation_status === 'correct' ? '✓ Validated' : '✗ Needs Review'}
                            </span>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Generated SQL Script Display */}
              {generatedSQL && (
                <div className="bg-gray-900 rounded-lg shadow-lg p-6 text-green-400">
                  <div className="flex justify-between items-center mb-4">
                    <h2 className="text-2xl font-semibold text-white">Generated SQL Script</h2>
                    <button
                      onClick={() => navigator.clipboard.writeText(generatedSQL)}
                      className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                    >
                      Copy to Clipboard
                    </button>
                  </div>
                  <div className="bg-black rounded-lg p-4 overflow-x-auto">
                    <pre className="text-sm font-mono whitespace-pre-wrap">{generatedSQL}</pre>
                  </div>
                  <div className="mt-4 text-sm text-gray-300">
                    <p>📝 Script includes 2 questions per module for the selected domain</p>
                    <p>🔗 Questions are automatically linked to the quiz</p>
                    <p>📊 Quiz question count is updated automatically</p>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
      </div>
    </>
  );
}
