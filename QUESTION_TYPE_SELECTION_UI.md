# Question Type Selection UI — Feature Documentation

## Overview

Added UI controls to generate different question types on both **Hub** and **Mock** question generation interfaces. Users can now select from 4 question types:
1. **MCQ** (Multiple Choice)
2. **Multiple Select** (Multiple correct answers)
3. **Ordering** (Sequence questions)
4. **Matching** (Match pairs)

---

## Changes Made

### 1. **State Management** (`src/app/page.tsx`)

**Added new state variable:**
```typescript
const [selectedQuestionTypes, setSelectedQuestionTypes] = useState<string[]>(['mcq']);
```

**Default:** MCQ only
**Type:** Array of strings matching question type IDs

---

### 2. **UI Component — Question Types Selector**

**Location:** Below the difficulty distribution controls in the generation form

**Features:**
- **Grid layout:** 2 columns on mobile, 4 columns on desktop
- **Checkbox controls:** Multiple selection enabled
- **Visual feedback:** Hover states and descriptions
- **Dark mode support:** Full dark theme compatibility

**Question Types Available:**
```
┌─────────────────────────────────────────────────────────────┐
│ Question Types                                              │
├─────────────────────────────────────────────────────────────┤
│ ☐ Multiple Choice (MCQ)        ☐ Multiple Select            │
│   Single correct answer           Multiple correct answers   │
│                                                               │
│ ☐ Ordering                      ☐ Matching                  │
│   Sequence questions              Match pairs                │
└─────────────────────────────────────────────────────────────┘
```

**HTML Structure:**
```typescript
{[
  { id: 'mcq', label: 'Multiple Choice (MCQ)', description: 'Single correct answer' },
  { id: 'multiple', label: 'Multiple Select', description: 'Multiple correct answers' },
  { id: 'ordering', label: 'Ordering', description: 'Sequence questions' },
  { id: 'matching', label: 'Matching', description: 'Match pairs' }
].map(type => (
  <label key={type.id} className="flex items-center space-x-2 p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
    <input type="checkbox" ... />
    <div>
      <p className="font-medium text-sm">{type.label}</p>
      <p className="text-xs text-gray-500">{type.description}</p>
    </div>
  </label>
))}
```

---

### 3. **Payload Update**

**API Request now includes:**
```typescript
const payload: any = {
  // ...existing fields...
  modules: modules,
  questionTypes: selectedQuestionTypes  // NEW: Selected question types array
};
```

**Example payload:**
```json
{
  "certification_id": 1,
  "certification_name": "AWS Solutions Architect",
  "topic_id": 2,
  "topic_name": "Storage",
  "modules": [...],
  "questionTypes": ["mcq", "multiple", "ordering"],
  "questionsPerModule": 3,
  "complexityLevelDistribution": {...}
}
```

---

## User Interaction Flow

### Step 1: Select Question Types
```
User clicks checkbox to select desired question types
  ↓
selectedQuestionTypes state updates
  Example: ['mcq', 'multiple', 'ordering']
```

### Step 2: Generate Questions
```
User clicks "Generate Hub Questions" button
  ↓
Payload includes: questionTypes: ['mcq', 'multiple', 'ordering']
  ↓
API receives request with selected types
  ↓
Pipeline generates mix of selected question types
```

### Step 3: Response Processing
```
Generated questions include type field
  {
    "type": "mcq",
    "text": "...",
    ...
  }
  OR
  {
    "type": "multiple",
    "text": "...",
    ...
  }
```

---

## Backend Integration

### API Endpoint: `/api/generate-hub`

**Accepts:**
```typescript
{
  questionTypes: string[]  // ['mcq', 'multiple', 'ordering', 'matching']
}
```

**Current Implementation:**
- If `questionTypes` not provided → defaults to `['mcq']`
- If empty array → uses default `['mcq']`
- Multiple types in array → generates questions of each type

**File:** `src/app/api/generate-hub/route.ts`

---

## Generated Question Output

### Question with Type Information

```json
{
  "id": "q_12345",
  "text": "What is Amazon S3 primarily used for?",
  "type": "mcq",
  "options": ["Storage", "Compute", "Database", "Networking"],
  "correct_answer": 0,
  "explanation": "...",
  "cognitive_level": "recall"
}
```

### Multiple Select Question

```json
{
  "id": "q_12346",
  "text": "Select all services that provide storage capabilities:",
  "type": "multiple",
  "options": ["S3", "EC2", "EBS", "RDS"],
  "correct_answer": [0, 2],
  "explanation": "...",
  "cognitive_level": "analysis"
}
```

### Ordering Question

```json
{
  "id": "q_12347",
  "text": "Order the following steps in correct sequence:",
  "type": "ordering",
  "options": ["Create VPC", "Create Subnet", "Create EC2", "Create Security Group"],
  "correct_answer": [0, 1, 3, 2],
  "explanation": "...",
  "cognitive_level": "application"
}
```

### Matching Question

```json
{
  "id": "q_12348",
  "text": "Match AWS services to their primary use cases",
  "type": "matching",
  "options": {
    "left": ["S3", "EC2", "RDS", "Lambda"],
    "right": ["Storage", "Compute", "Database", "Serverless"]
  },
  "correct_answer": {"left": [0, 1, 2, 3], "right": [0, 1, 2, 3]},
  "explanation": "...",
  "cognitive_level": "analysis"
}
```

---

## UI Styling

### Tailwind Classes Used

```typescript
className="grid grid-cols-2 md:grid-cols-4 gap-3"  // Responsive grid
className="flex items-center space-x-2 p-3 border rounded-lg"  // Checkbox item
className="cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700"  // Hover state
className="font-medium text-sm"  // Type label
className="text-xs text-gray-500 dark:text-gray-400"  // Description
```

### Color Scheme
- **Light mode:** Gray background, hover to light gray
- **Dark mode:** Dark gray background, hover to darker gray
- **Text:** Dark on light, light on dark (automatic)

---

## Validation

### Frontend Validation
- **At least one type must be selected** (implicit: if none selected, still works with defaults)
- **Array length:** 1-4 question types maximum

### Backend Validation
- In `src/app/api/generate-hub/route.ts`
- Validates `questionTypes` array
- Defaults to `['mcq']` if missing

---

## Implementation Details

### State Update Function
```typescript
// Add type to selection
setSelectedQuestionTypes([...selectedQuestionTypes, type.id]);

// Remove type from selection
setSelectedQuestionTypes(selectedQuestionTypes.filter(t => t !== type.id));
```

### Default Selection
```typescript
// By default, only MCQ is selected
const [selectedQuestionTypes, setSelectedQuestionTypes] = useState<string[]>(['mcq']);
```

### Checkbox Handler
```typescript
onChange={e => {
  if (e.target.checked) {
    // Add to selection
    setSelectedQuestionTypes([...selectedQuestionTypes, type.id]);
  } else {
    // Remove from selection
    setSelectedQuestionTypes(selectedQuestionTypes.filter(t => t !== type.id));
  }
}}
```

---

## Files Modified

| File | Changes |
|------|---------|
| `src/app/page.tsx` | Added state, UI component, payload update |

---

## API Integration Points

### 1. Request Preparation
```typescript
const payload: any = {
  // ...
  questionTypes: selectedQuestionTypes  // Sent to API
};

const response = await fetch('/api/generate-hub', {
  method: 'POST',
  body: JSON.stringify(payload)
});
```

### 2. Backend Route
```typescript
// src/app/api/generate-hub/route.ts
interface RequestBody {
  // ...
  questionTypes?: QuestionType[];  // Accepts array
}
```

### 3. Pipeline Propagation
```typescript
// src/lib/pipeline/index.ts
const questionTypes = params.questionTypes || 
                     (params.questionType ? [params.questionType] : ['mcq']);
```

---

## Examples

### Example 1: Generate MCQ + Multiple Select Only
```
User selects:
  ☑ Multiple Choice (MCQ)
  ☑ Multiple Select
  ☐ Ordering
  ☐ Matching

Generated payload:
  { questionTypes: ['mcq', 'multiple'] }

Result: Mix of MCQ and Multiple Select questions
```

### Example 2: Generate All Question Types
```
User selects:
  ☑ Multiple Choice (MCQ)
  ☑ Multiple Select
  ☑ Ordering
  ☑ Matching

Generated payload:
  { questionTypes: ['mcq', 'multiple', 'ordering', 'matching'] }

Result: Mix of all 4 question types
```

### Example 3: Generate Only Ordering
```
User selects:
  ☐ Multiple Choice (MCQ)
  ☐ Multiple Select
  ☑ Ordering
  ☐ Matching

Generated payload:
  { questionTypes: ['ordering'] }

Result: All ordering questions
```

---

## Future Enhancements

### Possible Additions
1. **Type distribution ratio** — Specify % of each type
2. **Type-specific settings** — Options per question type
3. **Templates** — Save question type preferences
4. **Preset combinations** — "Full mix", "MCQ only", etc.
5. **Distribution preview** — Show expected question counts per type

---

## Summary

**UI now supports:**
- ✅ Selection of 4 question types (MCQ, Multiple, Ordering, Matching)
- ✅ Checkbox-based multi-select interface
- ✅ Responsive grid layout (2 cols mobile, 4 cols desktop)
- ✅ Dark mode support
- ✅ Payload includes selected types
- ✅ Backend ready to handle mixed question types

**User benefits:**
- 🎯 Generate diverse question types in single request
- 🎨 Beautiful, intuitive UI
- 📱 Mobile-friendly interface
- 🌓 Dark/light theme support
- ⚡ Fast, responsive interaction

