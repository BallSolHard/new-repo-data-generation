#!/usr/bin/env python3
"""
Wrapper script to run validation with environment variables loaded
"""

import sys
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables from .env file
env_path = Path(__file__).parent / "content-engine" / ".env"
load_dotenv(dotenv_path=env_path)

# Now import and run the validation script
sys.path.insert(0, str(Path(__file__).parent / "oldfiles"))

from validate_questions_gemini import main

if __name__ == "__main__":
    main()
