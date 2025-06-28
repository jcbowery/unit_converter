#!/bin/bash
set -e

echo "🛠 Installing lefthook..."

# Check if lefthook is installed
if ! command -v lefthook &> /dev/null
then
  echo "lefthook not found, installing..."

  # Attempt installation via npm (recommended cross-platform way)
  if command -v npm &> /dev/null
  then
    npm install -g @evilmartians/lefthook
  else
    echo "npm is not installed. Please install npm or lefthook manually:"
    echo "https://github.com/evilmartians/lefthook#installation"
    exit 1
  fi
else
  echo "✔ lefthook already installed."
fi

echo "🐍 Checking Python3 and pip3 for detect-secrets..."

if ! command python3 --version &> /dev/null; then
  echo "Python3 is not installed. Please install Python 3."
  exit 1
fi

if ! command pip3 --version &> /dev/null; then
  echo "pip3 is not installed. Please install pip."
  exit 1
fi

echo "Installing detect-secrets via pip3..."
pipx install detect-secrets

echo "✔ detect-secrets installed."

echo "Creating detect-secrets baseline..."
detect-secrets scan > .secrets.baseline

echo "Adding .secrets.baseline to git..."
git add .secrets.baseline

echo "Creating .lefthook.yml configuration..."

cat > .lefthook.yml << EOL
pre-commit:
  parallel: true
  commands:
    format:
      run: mix format --check-formatted
      verbose: true
    credo:
      run: mix credo --strict
      verbose: true
    test:
      run: mix test
      verbose: true
    detect-secrets:
      run: detect-secrets-hook --baseline .secrets.baseline
      verbose: true
EOL

echo "Installing lefthook hooks..."
lefthook install

echo "All set! 🎉

- .lefthook.yml created
- detect-secrets baseline created and added
- Git hooks installed

Run 'mix format', 'mix credo', and 'mix test' locally to verify."
