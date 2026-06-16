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
  mock_test_id?: string;
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
  const [activeTab, setActiveTab] = useState<"hub" | "mock" | "course">("hub");
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
  
  // Mock test selection state
  const [existingMockTests, setExistingMockTests] = useState<QuizData[]>([]);
  const [selectedMockTestAction, setSelectedMockTestAction] = useState<"existing" | "new" | null>(null);
  const [selectedExistingMockTest, setSelectedExistingMockTest] = useState<QuizData | null>(null);
  
  // For mock: auto-select all modules when domain is selected
  const [selectedAllModules, setSelectedAllModules] = useState<ModuleData[]>([]);
  
  // For mock: number of questions to generate
  const [mockQuestionsCount, setMockQuestionsCount] = useState(10);

  // Course generation states
  const [generatedCourseContent, setGeneratedCourseContent] = useState<any>(null);
  const [courseLoadingModule, setCourseLoadingModule] = useState<string | null>(null);

  // Debug: log question types changes
  useEffect(() => {
    console.log('[UI] selectedQuestionTypes changed:', selectedQuestionTypes);
  }, [selectedQuestionTypes]);

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
          
          // For Mock tab: Auto-select all modules when fetched
          if (activeTab === "mock") {
            setSelectedAllModules(data.modules || []);
          }
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
  }, [selectedDomain, domains, activeTab]);

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
    setSelectedAllModules([]); // Clear selected all modules
    
    // For Mock tab: Auto-select all modules for this domain
    if (activeTab === "mock") {
      // Find the selected domain data
      const selectedDomainData = domains.find(d => d.topic_name === domain);
      if (selectedDomainData?.modules && selectedDomainData.modules.length > 0) {
        setSelectedAllModules(selectedDomainData.modules);
      }
    }
  };

  const handleModuleChange = (module: string) => {
    setSelectedModule(module);
    setQuizzes([]); // Clear quizzes when module changes
  };

  // Fetch existing mock tests when domain is selected in mock tab
  useEffect(() => {
    const fetchMockTests = async () => {
      if (activeTab !== "mock" || !selectedDomain || !selectedCertification) {
        setExistingMockTests([]);
        return;
      }

      try {
        const selectedDomainData = domains.find(d => d.topic_name === selectedDomain);
        const selectedCertData = certifications.find(c => c.title === selectedCertification);
        
        if (selectedDomainData?.topic_id && selectedCertData?.id) {
          const response = await fetch(
            `/api/mock-tests?category_id=${selectedDomainData.topic_id}&certification_id=${selectedCertData.id}&domain_name=${encodeURIComponent(selectedDomain)}`
          );
          if (!response.ok) {
            console.warn('Failed to fetch existing mock tests');
            setExistingMockTests([]);
            return;
          }
          const data = await response.json();
          setExistingMockTests(data.mockTests || []);
          
          // Auto-select first mock test action to "existing" if tests are available
          if ((data.mockTests || []).length > 0) {
            setSelectedMockTestAction("existing");
            setSelectedExistingMockTest(data.mockTests[0]);
          }
        }
      } catch (err) {
        console.error('Error fetching mock tests:', err);
        setExistingMockTests([]);
      }
    };

    fetchMockTests();
  }, [selectedDomain, selectedCertification, activeTab, domains, certifications]);

  const handleTabChange = (tab: "hub" | "mock" | "course") => {
    setActiveTab(tab);
    // Reset selections when switching tabs
    setSelectedCertification("");
    setSelectedDomain("");
    setSelectedModule("");
    setModules([]); // Clear modules when switching tabs
    setQuizzes([]); // Clear quizzes when switching tabs
    setSelectedAllModules([]); // Clear selected all modules when switching tabs
    setGeneratedCourseContent(null);
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
        questionTypes: selectedQuestionTypes,
      };

      console.log('[generateHubQuestions] Payload questionTypes:', payload.questionTypes);

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

  const generateMockQuestions = async () => {
    if (!selectedCertification || !selectedDomain) {
      setError("Please select certification and domain first");
      return;
    }

    // Check if we have modules selected (for mock questions, all modules should be auto-selected)
    if (selectedAllModules.length === 0) {
      setError("No modules available for the selected domain");
      return;
    }

    // Check if user has made a choice for mock test action
    if (!selectedMockTestAction) {
      setError("Please choose whether to create a new mock test or use an existing one");
      return;
    }

    // Check if questions count is valid
    if (!mockQuestionsCount || mockQuestionsCount < 1) {
      setError("Please specify the number of questions to generate (minimum 1)");
      return;
    }

    setIsGenerating(true);
    setError(null);

    try {
      const selectedCertData = certifications.find(c => c.title === selectedCertification);
      const selectedDomainData = domains.find(d => d.topic_name === selectedDomain);

      // Determine mock test ID based on user's choice
      let mockTestId: string;
      if (selectedMockTestAction === "existing" && selectedExistingMockTest) {
        mockTestId = selectedExistingMockTest.id;
      } else {
        // Create new mock test ID (domain-level, not module-specific)
        mockTestId = `mock_${selectedDomainData?.topic_id}_all_${Date.now()}`;
      }

      const payload: any = {
        certification_id: selectedCertData?.id,
        certification_name: selectedCertification,
        topic_id: selectedDomainData?.topic_id,
        topic_name: selectedDomain,
        topic_description: selectedDomainData?.topic_description || `${selectedDomain} domain knowledge`,
        modules: selectedAllModules,  // Send all selected modules
        mock_test_id: mockTestId,
        mock_test_action: selectedMockTestAction, // "existing" or "new"
        existing_mock_test: selectedMockTestAction === "existing" ? selectedExistingMockTest : null,
        questionTypes: selectedQuestionTypes,
        questionsPerModule: mockQuestionsCount, // Use the specified number of questions
      };

      console.log('[generateMockQuestions] Payload:', payload);

      const response = await fetch('/api/generate-mock-with-data', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
      });

      if (!response.ok) {
        throw new Error('Failed to generate mock questions');
      }

      const data = await response.json();
      setGeneratedSQL(data.sqlScript);
      setGeneratedQuestions(data.questions || []);
      
      // Reset mock test selection after generation
      setSelectedMockTestAction(null);
      setSelectedExistingMockTest(null);
      
    } catch (err) {
      console.error('Error generating mock questions:', err);
      setError('Failed to generate mock questions. Please try again.');
    } finally {
      setIsGenerating(false);
    }
  };

  const convertCourseContentToMarkdown = (content: any): string => {
    let markdown = '';

    // Header
    markdown += `# ${content.module_name}\n\n`;
    if (content.topic_name) {
      markdown += `**${content.topic_name}**\n\n`;
    }

    // Metadata
    markdown += `> Certification: ${content.certification_name}\n`;
    markdown += `> Duration: ${content.estimated_duration || '5-7 minutes'}\n\n`;

    // Overview
    if (content.overview) {
      markdown += `## Overview\n\n${content.overview}\n\n`;
    }

    // Learning Objectives
    if (content.learning_objectives && content.learning_objectives.length > 0) {
      markdown += `## 🎯 Learning Objectives\n\n`;
      content.learning_objectives.forEach((objective: string, idx: number) => {
        markdown += `${idx + 1}. ${objective}\n`;
      });
      markdown += `\n`;
    }

    // Content Sections
    if (content.content_sections && content.content_sections.length > 0) {
      content.content_sections.forEach((section: any, idx: number) => {
        markdown += `## ${idx + 1}. ${section.title}\n\n`;
        if (section.duration) {
          markdown += `*Duration: ${section.duration}*\n\n`;
        }
        markdown += `${section.content}\n\n`;

        // Key Points
        if (section.key_points && section.key_points.length > 0) {
          markdown += `### 🔑 Key Points\n\n`;
          section.key_points.forEach((point: string) => {
            markdown += `- ${point}\n`;
          });
          markdown += `\n`;
        }

        // Examples
        if (section.examples && section.examples.length > 0) {
          markdown += `### 💡 Examples\n\n`;
          section.examples.forEach((example: string, exIdx: number) => {
            markdown += `**Example ${exIdx + 1}:**\n\`\`\`\n${example}\n\`\`\`\n\n`;
          });
        }

        // Best Practices
        if (section.best_practices && section.best_practices.length > 0) {
          markdown += `### ✅ Best Practices\n\n`;
          section.best_practices.forEach((practice: string) => {
            markdown += `- ${practice}\n`;
          });
          markdown += `\n`;
        }
      });
    }

    // Summary
    if (content.summary) {
      markdown += `## Summary\n\n${content.summary}\n\n`;
    }

    // Next Steps
    if (content.next_steps && content.next_steps.length > 0) {
      markdown += `## 📋 Next Steps\n\n`;
      content.next_steps.forEach((step: string, idx: number) => {
        markdown += `${idx + 1}. ${step}\n`;
      });
      markdown += `\n`;
    }

    return markdown;
  };

  const generateCourseContent = async (moduleId: string, moduleName: string) => {
    if (!selectedCertification || !selectedDomain) {
      setError("Please select certification and domain first");
      return;
    }

    setCourseLoadingModule(moduleId);
    setError(null);

    try {
      const selectedCertData = certifications.find(c => c.title === selectedCertification);
      const selectedDomainData = domains.find(d => d.topic_name === selectedDomain);
      const selectedModuleData = modules.find(m => m.module_id === moduleId);

      const payload = {
        certification_id: selectedCertData?.id,
        certification_name: selectedCertification,
        topic_id: selectedDomainData?.topic_id,
        topic_name: selectedDomain,
        topic_description: selectedDomainData?.topic_description || `${selectedDomain} domain knowledge`,
        module_id: moduleId,
        module_name: moduleName,
        module_description: selectedModuleData?.module_description || `${moduleName} module content`,
        module_content: selectedModuleData?.module_content || "",
      };

      console.log('[generateCourseContent] Payload:', payload);

      const response = await fetch('/api/generate-course-content', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
      });

      if (!response.ok) {
        throw new Error('Failed to generate course content');
      }

      const data = await response.json();
      setGeneratedCourseContent(data);
      
    } catch (err) {
      console.error('Error generating course content:', err);
      setError('Failed to generate course content. Please try again.');
    } finally {
      setCourseLoadingModule(null);
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
              <button
                onClick={() => handleTabChange("course")}
                className={`flex-1 py-3 px-6 rounded-md font-semibold transition-all duration-200 ${
                  activeTab === "course"
                    ? "bg-purple-500 text-white shadow-lg"
                    : "text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                }`}
              >
                Generate Course
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

          {/* Module/Task Selection - Hidden for Mock Questions (auto-selected) */}
          {selectedDomain && activeTab === "mock" && (
            <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4">
              <p className="text-blue-800 dark:text-blue-200">
                <span className="font-semibold">ℹ️ Info:</span> All modules in the selected domain will be included in the mock test generation automatically.
              </p>
            </div>
          )}

          {/* Selected Summary */}
          {((activeTab === "hub" && selectedDomain) || (activeTab === "mock" && selectedDomain)) && (
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
                
                {/* Show modules: For Mock, show all selected modules; for Hub, show from API */}
                {activeTab === "mock" && selectedAllModules.length > 0 && (
                  <div>
                    <p><span className="font-semibold">Modules (Auto-selected):</span></p>
                    <div className="ml-4 space-y-1">
                      {selectedAllModules.map((module, index) => (
                        <p key={module.module_id} className="text-sm">
                          {index + 1}. {module.module_name}
                          <code className="bg-white/20 px-2 py-1 rounded text-xs ml-2">{module.module_id}</code>
                        </p>
                      ))}
                    </div>
                  </div>
                )}
                
                {/* For Hub tab: show modules from API */}
                {activeTab === "hub" && modules.length > 0 && (
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
                {activeTab === "hub" && modules.length === 0 && getCurrentModules().length > 0 && (
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

                {/* Mock Test Selection (only show for Mock tab) */}
                {activeTab === "mock" && (
                  <div className="mt-6 p-4 bg-white/10 rounded-lg border border-white/20">
                    <p className="font-semibold mb-3">📝 Select or Create Mock Test</p>
                    
                    {/* Show existing mock tests if available */}
                    {existingMockTests.length > 0 ? (
                      <div>
                        <p className="text-sm mb-2">Available Mock Tests ({existingMockTests.length}):</p>
                        <div className="space-y-2">
                          {existingMockTests.map((mockTest) => (
                            <div
                              key={mockTest.id}
                              onClick={() => {
                                setSelectedExistingMockTest(mockTest);
                                setSelectedMockTestAction("existing");
                              }}
                              className={`p-3 rounded-lg cursor-pointer transition border-2 ${
                                selectedExistingMockTest?.id === mockTest.id
                                  ? 'border-yellow-300 bg-yellow-100/20'
                                  : 'border-white/20 bg-white/10 hover:bg-white/20'
                              }`}
                            >
                              <div className="flex justify-between items-start">
                                <div>
                                  <p className="font-medium text-white">{mockTest.title}</p>
                                  <p className="text-xs text-gray-200">
                                    ID: {mockTest.mock_test_id || mockTest.id}
                                  </p>
                                </div>
                                <input
                                  type="radio"
                                  name="mockTestChoice"
                                  checked={selectedExistingMockTest?.id === mockTest.id}
                                  onChange={() => {
                                    setSelectedExistingMockTest(mockTest);
                                    setSelectedMockTestAction("existing");
                                  }}
                                  className="mt-1"
                                />
                              </div>
                            </div>
                          ))}
                        </div>
                        
                        {/* OR divider */}
                        <div className="my-3 text-center text-xs text-gray-300 font-semibold">— OR —</div>
                        
                        {/* Create new option */}
                        <div
                          onClick={() => {
                            setSelectedExistingMockTest(null);
                            setSelectedMockTestAction("new");
                          }}
                          className={`p-3 rounded-lg cursor-pointer transition border-2 ${
                            selectedMockTestAction === "new"
                              ? 'border-green-300 bg-green-100/20'
                              : 'border-white/20 bg-white/10 hover:bg-white/20'
                          }`}
                        >
                          <div className="flex justify-between items-center">
                            <div>
                              <p className="font-medium text-white">✨ Create New Mock Test</p>
                              <p className="text-xs text-gray-200">Start fresh with new questions</p>
                            </div>
                            <input
                              type="radio"
                              name="mockTestChoice"
                              checked={selectedMockTestAction === "new"}
                              onChange={() => {
                                setSelectedExistingMockTest(null);
                                setSelectedMockTestAction("new");
                              }}
                              className="mt-1"
                            />
                          </div>
                        </div>
                      </div>
                    ) : (
                      <div className="p-3 rounded-lg bg-blue-100/20 border border-blue-300/30">
                        <p className="text-sm text-gray-100">
                          ℹ️ No existing mock tests for this domain. A new one will be created automatically.
                        </p>
                      </div>
                    )}
                  </div>
                )}

                {/* Number of questions input (mock only) */}
                {activeTab === "mock" && (
                  <div className="mt-4">
                    <p className="font-semibold mb-2">Number of Questions to Generate</p>
                    <div className="flex items-center space-x-4">
                      <input
                        type="number"
                        min={1}
                        max={100}
                        value={mockQuestionsCount}
                        onChange={e => setMockQuestionsCount(Math.max(1, parseInt(e.target.value) || 1))}
                        className="w-24 px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      />
                      <span className="text-sm text-gray-600 dark:text-gray-400">
                        Questions will be generated with a mix of difficulties (easy, medium, hard)
                      </span>
                    </div>
                  </div>
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
                onClick={activeTab === "hub" ? generateHubQuestions : (activeTab === "mock" ? generateMockQuestions : undefined)}
                disabled={isGenerating || (activeTab as string) === "course"}
              >
                {isGenerating ? "Generating..." : (activeTab === "hub" ? "Generate Hub Questions" : "Generate Mock Questions")}
              </button>
            </div>
          )}

          {/* Course Content Display - Only for Course Tab */}
          {activeTab === "course" && selectedDomain && (
            <div className="bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg shadow-lg p-6 text-white">
              <h2 className="text-2xl font-semibold mb-4">Select a Module to Generate Course Content</h2>
              
              {modulesLoading ? (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {[1, 2, 3, 4].map((i) => (
                    <div key={i} className="p-4 rounded-lg border-2 border-white/20 animate-pulse bg-white/10">
                      <div className="h-6 bg-white/20 rounded"></div>
                    </div>
                  ))}
                </div>
              ) : modules.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {modules.map((module) => (
                    <button
                      key={module.module_id}
                      onClick={() => generateCourseContent(module.module_id, module.module_name)}
                      disabled={courseLoadingModule === module.module_id}
                      className={`p-4 rounded-lg border-2 transition-all duration-200 text-left ${
                        courseLoadingModule === module.module_id
                          ? 'border-yellow-300 bg-yellow-100/20 opacity-75'
                          : 'border-white/30 bg-white/10 hover:bg-white/20'
                      }`}
                    >
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <h3 className="font-semibold text-white mb-1">{module.module_name}</h3>
                          <p className="text-sm text-blue-100">{module.module_description}</p>
                          <code className="text-xs bg-white/20 px-2 py-1 rounded mt-2 inline-block">{module.module_id}</code>
                        </div>
                        {courseLoadingModule === module.module_id && (
                          <div className="ml-4 mt-1">
                            <div className="animate-spin h-5 w-5 border-2 border-white border-t-transparent rounded-full"></div>
                          </div>
                        )}
                      </div>
                    </button>
                  ))}
                </div>
              ) : (
                <p className="text-blue-100">No modules available for this domain.</p>
              )}
            </div>
          )}

          {/* Generated Course Content Display */}
          {activeTab === "course" && generatedCourseContent && (
            <div className="space-y-6">
              {/* Course Header */}
              <div className="bg-gradient-to-r from-indigo-600 to-blue-600 rounded-lg shadow-lg p-8 text-white">
                <h1 className="text-4xl font-bold mb-2">{generatedCourseContent.module_name}</h1>
                <p className="text-indigo-100 text-lg mb-4">{generatedCourseContent.topic_name}</p>
                <div className="flex items-center space-x-4 text-sm">
                  <span className="bg-white/20 px-4 py-2 rounded-full font-semibold">
                    📚 {generatedCourseContent.certification_name}
                  </span>
                  <span className="bg-white/20 px-4 py-2 rounded-full font-semibold">
                    ⏱️ {generatedCourseContent.estimated_duration || "5-7 minutes"}
                  </span>
                </div>
              </div>

              {/* Course Overview */}
              {generatedCourseContent.overview && (
                <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 border-l-4 border-blue-500">
                  <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">Overview</h2>
                  <p className="text-gray-700 dark:text-gray-300 text-lg leading-relaxed">
                    {generatedCourseContent.overview}
                  </p>
                </div>
              )}

              {/* Learning Objectives */}
              {generatedCourseContent.learning_objectives && generatedCourseContent.learning_objectives.length > 0 && (
                <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 border-l-4 border-green-500">
                  <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">🎯 Learning Objectives</h2>
                  <ul className="space-y-3">
                    {generatedCourseContent.learning_objectives.map((objective: string, idx: number) => (
                      <li key={idx} className="flex items-start">
                        <span className="inline-flex items-center justify-center h-7 w-7 rounded-full bg-green-500 text-white mr-3 flex-shrink-0 mt-0.5 font-semibold text-sm">
                          {idx + 1}
                        </span>
                        <span className="text-gray-700 dark:text-gray-300">{objective}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* Course Content Sections */}
              {generatedCourseContent.content_sections && generatedCourseContent.content_sections.length > 0 && (
                <div className="space-y-4">
                  {generatedCourseContent.content_sections.map((section: any, idx: number) => (
                    <div key={idx} className="bg-white dark:bg-gray-800 rounded-lg shadow-lg overflow-hidden border-l-4 border-purple-500">
                      <div className="bg-purple-50 dark:bg-purple-900/20 px-6 py-4 border-b border-purple-200 dark:border-purple-800">
                        <h3 className="text-xl font-semibold text-purple-900 dark:text-purple-100">
                          {idx + 1}. {section.title}
                        </h3>
                        {section.duration && (
                          <p className="text-sm text-purple-600 dark:text-purple-300 mt-1">⏱️ {section.duration}</p>
                        )}
                      </div>
                      <div className="p-6">
                        <div className="text-gray-700 dark:text-gray-300 prose dark:prose-invert max-w-none">
                          {section.content.split('\n').map((line: string, lineIdx: number) => (
                            line.trim() && (
                              <p key={lineIdx} className="mb-4 leading-relaxed">
                                {line}
                              </p>
                            )
                          ))}
                        </div>
                        
                        {/* Key Points */}
                        {section.key_points && section.key_points.length > 0 && (
                          <div className="mt-6 bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4 border-l-4 border-blue-500">
                            <h4 className="font-semibold text-blue-900 dark:text-blue-100 mb-3">🔑 Key Points:</h4>
                            <ul className="space-y-2">
                              {section.key_points.map((point: string, pointIdx: number) => (
                                <li key={pointIdx} className="flex items-start text-blue-800 dark:text-blue-200">
                                  <span className="mr-2">•</span>
                                  <span>{point}</span>
                                </li>
                              ))}
                            </ul>
                          </div>
                        )}

                        {/* Examples */}
                        {section.examples && section.examples.length > 0 && (
                          <div className="mt-6 bg-yellow-50 dark:bg-yellow-900/20 rounded-lg p-4 border-l-4 border-yellow-500">
                            <h4 className="font-semibold text-yellow-900 dark:text-yellow-100 mb-3">💡 Examples:</h4>
                            <div className="space-y-3">
                              {section.examples.map((example: string, exIdx: number) => (
                                <div key={exIdx} className="text-yellow-800 dark:text-yellow-200 text-sm">
                                  <p className="font-medium mb-1">Example {exIdx + 1}:</p>
                                  <p className="ml-4">{example}</p>
                                </div>
                              ))}
                            </div>
                          </div>
                        )}

                        {/* Best Practices */}
                        {section.best_practices && section.best_practices.length > 0 && (
                          <div className="mt-6 bg-green-50 dark:bg-green-900/20 rounded-lg p-4 border-l-4 border-green-500">
                            <h4 className="font-semibold text-green-900 dark:text-green-100 mb-3">✅ Best Practices:</h4>
                            <ul className="space-y-2">
                              {section.best_practices.map((practice: string, practIdx: number) => (
                                <li key={practIdx} className="flex items-start text-green-800 dark:text-green-200">
                                  <span className="mr-2">✓</span>
                                  <span>{practice}</span>
                                </li>
                              ))}
                            </ul>
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              )}

              {/* Summary */}
              {generatedCourseContent.summary && (
                <div className="bg-indigo-50 dark:bg-indigo-900/20 rounded-lg shadow-lg p-6 border-l-4 border-indigo-500">
                  <h2 className="text-2xl font-semibold text-indigo-900 dark:text-indigo-100 mb-4">Summary</h2>
                  <p className="text-indigo-800 dark:text-indigo-200 leading-relaxed text-lg">
                    {generatedCourseContent.summary}
                  </p>
                </div>
              )}

              {/* Next Steps */}
              {generatedCourseContent.next_steps && generatedCourseContent.next_steps.length > 0 && (
                <div className="bg-gradient-to-r from-teal-50 to-cyan-50 dark:from-teal-900/20 dark:to-cyan-900/20 rounded-lg shadow-lg p-6 border-l-4 border-teal-500">
                  <h2 className="text-2xl font-semibold text-teal-900 dark:text-teal-100 mb-4">📋 Next Steps</h2>
                  <ol className="space-y-3">
                    {generatedCourseContent.next_steps.map((step: string, stepIdx: number) => (
                      <li key={stepIdx} className="flex items-start">
                        <span className="inline-flex items-center justify-center h-7 w-7 rounded-full bg-teal-500 text-white mr-3 flex-shrink-0 font-semibold text-sm">
                          {stepIdx + 1}
                        </span>
                        <span className="text-teal-800 dark:text-teal-200">{step}</span>
                      </li>
                    ))}
                  </ol>
                </div>
              )}

              {/* Copy/Export Options */}
              <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 flex flex-wrap gap-4">
                <button
                  onClick={() => {
                    const courseText = JSON.stringify(generatedCourseContent, null, 2);
                    navigator.clipboard.writeText(courseText);
                    alert('Course content copied to clipboard!');
                  }}
                  className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold transition-colors"
                >
                  📋 Copy as JSON
                </button>
                <button
                  onClick={() => {
                    const markdownContent = convertCourseContentToMarkdown(generatedCourseContent);
                    navigator.clipboard.writeText(markdownContent);
                    alert('Course content copied as Markdown!');
                  }}
                  className="bg-purple-600 hover:bg-purple-700 text-white px-6 py-3 rounded-lg font-semibold transition-colors"
                >
                  📝 Copy as Markdown
                </button>
                <button
                  onClick={() => {
                    const markdownContent = convertCourseContentToMarkdown(generatedCourseContent);
                    const element = document.createElement('a');
                    element.setAttribute('href', 'data:text/markdown;charset=utf-8,' + encodeURIComponent(markdownContent));
                    element.setAttribute('download', `${generatedCourseContent.module_id}_course.md`);
                    element.style.display = 'none';
                    document.body.appendChild(element);
                    element.click();
                    document.body.removeChild(element);
                  }}
                  className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-3 rounded-lg font-semibold transition-colors"
                >
                  📥 Download as Markdown
                </button>
                <button
                  onClick={() => {
                    const courseText = `# ${generatedCourseContent.module_name}\n\n${JSON.stringify(generatedCourseContent, null, 2)}`;
                    const element = document.createElement('a');
                    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(courseText));
                    element.setAttribute('download', `${generatedCourseContent.module_id}_course.json`);
                    element.style.display = 'none';
                    document.body.appendChild(element);
                    element.click();
                    document.body.removeChild(element);
                  }}
                  className="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-lg font-semibold transition-colors"
                >
                  💾 Download JSON
                </button>
              </div>
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
                                  
                                  // Determine if this option is correct
                                  let isCorrect = false;
                                  let sequenceNumber: number | null = null; // For ordering questions
                                  const rawCorrect = question.correct_answer;
                                  
                                  // Handle ORDERING: correct_answer is an array like [2, 0, 3, 1]
                                  // Index in array = position in correct order, Value = option index
                                  if (question.type === 'ordering' && Array.isArray(rawCorrect)) {
                                    // Find position of current option index in the correct sequence
                                    const position = rawCorrect.indexOf(optIdx);
                                    if (position !== -1) {
                                      isCorrect = true;
                                      sequenceNumber = position + 1; // Convert to 1-based numbering
                                    }
                                  }
                                  // Handle MULTIPLE SELECT: correct_answer is an array [0, 2] or [1, 3]
                                  else if (Array.isArray(rawCorrect)) {
                                    // For multiple select: check if current index is in the array
                                    isCorrect = rawCorrect.includes(optIdx);
                                  } 
                                  // Handle MCQ: correct_answer is a string like "{0}" or "0"
                                  else {
                                    const optionText = String(option).trim();
                                    // Remove curly braces: {0} -> 0, {1} -> 1, etc
                                    const correctText = String(rawCorrect).trim().replace(/[{}]/g, '');
                                    
                                    // Try multiple matching strategies
                                    // Strategy 1: Match with index (0, 1, 2, 3)
                                    if (correctText === String(optIdx)) {
                                      isCorrect = true;
                                    }
                                    // Strategy 2: Match with letter (A, B, C, D)
                                    else if (correctText === optionLabel || correctText.toUpperCase() === optionLabel) {
                                      isCorrect = true;
                                    }
                                    // Strategy 3: Direct match with option text
                                    else if (correctText === optionText) {
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
                                  }
                                  
                                  // Debug log for first option
                                  if (optIdx === 0) {
                                    console.log('Question Type:', question.type);
                                    console.log('Correct Answer:', rawCorrect);
                                    console.log('Is Array?:', Array.isArray(rawCorrect));
                                  }
                                  
                                  return (
                                    <div
                                      key={optIdx}
                                      className={`p-3 rounded-lg border-2 transition-all ${
                                        isCorrect
                                          ? 'border-green-500 bg-green-100 shadow-md'
                                          : 'border-gray-200 bg-gray-50'
                                      }`}
                                    >
                                      <div className="flex items-start">
                                        <span className={`font-bold mr-2 text-lg ${isCorrect ? 'text-green-700' : 'text-gray-600'}`}>
                                          {optionLabel}.
                                        </span>
                                        <span className={isCorrect ? 'text-green-800 font-semibold' : 'text-gray-700'}>
                                          {option}
                                        </span>
                                        {/* Show sequence number for ordering questions */}
                                        {isCorrect && question.type === 'ordering' && sequenceNumber !== null && (
                                          <span className="ml-auto text-white text-sm font-bold bg-blue-600 px-3 py-1 rounded">
                                            #{sequenceNumber}
                                          </span>
                                        )}
                                        {/* Show checkmark for non-ordering correct answers */}
                                        {isCorrect && question.type !== 'ordering' && (
                                          <span className="ml-auto text-white text-sm font-bold bg-green-600 px-2 py-1 rounded">✓ CORRECT</span>
                                        )}
                                      </div>
                                    </div>
                                  );
                                })
                              ) : typeof question.options === 'object' ? (
                                Object.entries(question.options).map(([key, value]: [string, any], optIdx: number) => {
                                  // More robust matching logic for object options (Matching questions)
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
                                    console.log('=== Matching Question Debug ===');
                                    console.log('correct_answer raw:', question.correct_answer);
                                    console.log('First key:', key);
                                    console.log('First value:', value);
                                  }
                                  
                                  return (
                                    <div
                                      key={optIdx}
                                      className={`p-3 rounded-lg border-2 transition-all ${
                                        isCorrect
                                          ? 'border-green-500 bg-green-100 shadow-md'
                                          : 'border-gray-200 bg-gray-50'
                                      }`}
                                    >
                                      <div className="flex items-start">
                                        <span className={`font-bold mr-2 text-lg ${isCorrect ? 'text-green-700' : 'text-gray-600'}`}>
                                          {key}:
                                        </span>
                                        <span className={isCorrect ? 'text-green-800 font-semibold' : 'text-gray-700'}>
                                          {value as string}
                                        </span>
                                        {isCorrect && <span className="ml-auto text-white text-sm font-bold bg-green-600 px-2 py-1 rounded">✓ CORRECT</span>}
                                      </div>
                                    </div>
                                  );
                                })
                              ) : null}
                            </div>
                          </div>
                        )}

                        {/* Matching Questions Display (Left-Right Layout) */}
                        {question.type === 'matching' && question.pairs && (
                          <div className="bg-white rounded-lg p-4 mb-4 border border-gray-200">
                            <p className="text-sm font-semibold text-gray-700 mb-3">Matching Pairs:</p>
                            <div className="grid grid-cols-2 gap-6">
                              {/* Left Column */}
                              <div className="space-y-2">
                                <h4 className="font-semibold text-gray-700 text-sm mb-2">Items to Match:</h4>
                                {question.pairs.left && Array.isArray(question.pairs.left) && (
                                  question.pairs.left.map((leftItem: string, leftIdx: number) => (
                                    <div
                                      key={`left-${leftIdx}`}
                                      className="p-3 rounded-lg border-2 border-blue-300 bg-blue-50"
                                    >
                                      <span className="font-semibold text-blue-700 mr-2">{leftIdx}.</span>
                                      <span className="text-gray-800">{leftItem}</span>
                                    </div>
                                  ))
                                )}
                              </div>

                              {/* Right Column */}
                              <div className="space-y-2">
                                <h4 className="font-semibold text-gray-700 text-sm mb-2">Matches:</h4>
                                {question.pairs.right && Array.isArray(question.pairs.right) && (
                                  question.pairs.right.map((rightItem: string, rightIdx: number) => (
                                    <div
                                      key={`right-${rightIdx}`}
                                      className="p-3 rounded-lg border-2 border-green-300 bg-green-50"
                                    >
                                      <span className="font-semibold text-green-700 mr-2">{rightIdx}.</span>
                                      <span className="text-gray-800">{rightItem}</span>
                                    </div>
                                  ))
                                )}
                              </div>
                            </div>

                            {/* Show Correct Answer Mapping */}
                            {question.correct_answer && typeof question.correct_answer === 'object' && (
                              <div className="mt-4 p-3 bg-yellow-50 border-l-4 border-yellow-400 rounded">
                                <p className="text-sm font-semibold text-yellow-800 mb-2">Correct Mapping:</p>
                                <div className="space-y-1">
                                  {question.pairs.left && Array.isArray(question.pairs.left) && (
                                    question.pairs.left.map((leftItem: string, leftIdx: number) => {
                                      const correctAnswerObj = question.correct_answer;
                                      const rightMapping = correctAnswerObj?.right?.[leftIdx];
                                      return (
                                        <div key={`mapping-${leftIdx}`} className="text-sm text-yellow-700">
                                          <span className="font-semibold">{leftIdx}. {leftItem}</span>
                                          <span className="text-yellow-600"> → </span>
                                          <span>
                                            {rightMapping !== undefined && rightMapping !== null
                                              ? `${rightMapping}. ${question.pairs.right?.[rightMapping]}`
                                              : 'No mapping'}
                                          </span>
                                        </div>
                                      );
                                    })
                                  )}
                                </div>
                              </div>
                            )}
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
