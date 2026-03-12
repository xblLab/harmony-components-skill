#!/bin/bash
# 鸿蒙组件通用安装脚本
# Usage: install.sh <component_id> [project_root]

set -e

COMPONENT_ID="$1"
PROJECT_ROOT="${2:-.}"

if [[ -z "${COMPONENT_ID}" ]]; then
    echo "Error: component_id is required."
    echo "Usage: $0 <component_id> [project_root]"
    exit 1
fi

# Resolve script directory to find install.json
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_JSON="${SCRIPT_DIR}/../references/components/${COMPONENT_ID}/install.json"

if [[ ! -f "${INSTALL_JSON}" ]]; then
    echo "Error: install.json not found for component '${COMPONENT_ID}'"
    echo "Expected path: ${INSTALL_JSON}"
    exit 1
fi

# Read install_method from install.json; if ohpm, run ohpm install and exit
INSTALL_METHOD=$(node -e "
const fs = require('fs');
const j = JSON.parse(fs.readFileSync('${INSTALL_JSON}', 'utf8'));
console.log(j.install_method || 'oss');
" 2>/dev/null || echo "oss")

if [[ "${INSTALL_METHOD}" == "ohpm" ]]; then
    OHPM_PACKAGE=$(node -e "
const fs = require('fs');
const j = JSON.parse(fs.readFileSync('${INSTALL_JSON}', 'utf8'));
console.log(j.ohpm_package || '');
" 2>/dev/null || echo "")
    if [[ -z "${OHPM_PACKAGE}" ]]; then
        echo "Error: ohpm_package not found in install.json for ohpm component"
        exit 1
    fi
    if [[ ! -f "${PROJECT_ROOT}/oh-package.json5" ]]; then
        echo "Error: oh-package.json5 not found in ${PROJECT_ROOT}"
        echo "Please run this script from your HarmonyOS project root directory."
        exit 1
    fi
    echo "Installing ${COMPONENT_ID} via ohpm..."
    (cd "${PROJECT_ROOT}" && ohpm install "${OHPM_PACKAGE}")
    echo ""
    echo "Component installed successfully via ohpm!"
    exit 0
fi

# Read oss_url and zip_name from install.json (using node for JSON parsing)
OSS_URL=$(node -e "
const fs = require('fs');
const j = JSON.parse(fs.readFileSync('${INSTALL_JSON}', 'utf8'));
if (!j.oss_url) process.exit(1);
console.log(j.oss_url);
")
ZIP_NAME=$(node -e "
const fs = require('fs');
const j = JSON.parse(fs.readFileSync('${INSTALL_JSON}', 'utf8'));
console.log(j.zip_name || '');
" 2>/dev/null || echo "")

TEMP_DIR="/tmp"

echo "Installing ${COMPONENT_ID}..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed. Please install Node.js first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

# Check if json5 package is installed, if not install it globally
if ! node -e "require('json5')" 2>/dev/null; then
    echo "Installing json5 package..."
    npm install -g json5
fi

# Check if oh-package.json5 exists
if [[ ! -f "${PROJECT_ROOT}/oh-package.json5" ]]; then
    echo "Error: oh-package.json5 not found in ${PROJECT_ROOT}"
    echo "Please run this script from your HarmonyOS project root directory."
    exit 1
fi

# Download component (extract filename from URL if zip_name not in install.json)
if [[ -n "${ZIP_NAME}" ]]; then
    DOWNLOAD_FILE="${ZIP_NAME}.zip"
else
    DOWNLOAD_FILE="${COMPONENT_ID}.zip"
fi

# Download component
echo "Downloading component..."
curl -L -o "${TEMP_DIR}/${DOWNLOAD_FILE}" "${OSS_URL}"

# Create components directory
mkdir -p "${PROJECT_ROOT}/components"

# Extract to temp first, then move to components/<component_id>
EXTRACT_TEMP="${TEMP_DIR}/harmony_extract_$$"
mkdir -p "${EXTRACT_TEMP}"
echo "Extracting component..."
unzip -o "${TEMP_DIR}/${DOWNLOAD_FILE}" -d "${EXTRACT_TEMP}"
EXTRACTED_DIR=$(ls -1 "${EXTRACT_TEMP}" | head -n 1)
mv "${EXTRACT_TEMP}/${EXTRACTED_DIR}" "${PROJECT_ROOT}/components/${COMPONENT_ID}"
rm -rf "${EXTRACT_TEMP}"

# Clean up
echo "Cleaning up..."
rm "${TEMP_DIR}/${DOWNLOAD_FILE}"

# Update oh-package.json5
echo "Updating oh-package.json5..."
export PROJECT_ROOT
export COMPONENT_NAME="${COMPONENT_ID}"
node << 'NODE_SCRIPT'
const fs = require('fs');
const path = require('path');

const json5Path = require('child_process').execSync('npm root -g').toString().trim();
const JSON5 = require(path.join(json5Path, 'json5'));

const projectRoot = process.env.PROJECT_ROOT || '.';
const componentName = process.env.COMPONENT_NAME;
const pkgPath = path.join(projectRoot, 'oh-package.json5');
const depValue = 'file:./components/' + componentName;

try {
    const content = fs.readFileSync(pkgPath, 'utf8');
    const pkg = JSON5.parse(content);

    if (!pkg.dependencies) {
        pkg.dependencies = {};
    }

    if (!pkg.dependencies[componentName]) {
        pkg.dependencies[componentName] = depValue;
        fs.writeFileSync(pkgPath, JSON5.stringify(pkg, null, 2));
        console.log('✓ Added dependency: ' + componentName + ' -> ' + depValue);
    } else {
        console.log('✓ Dependency already exists: ' + componentName);
    }
} catch (err) {
    console.error('Error updating oh-package.json5:', err.message);
    process.exit(1);
}
NODE_SCRIPT

echo ""
echo "Component installed successfully!"
echo ""
echo "Next steps:"
echo "1. Run 'ohpm install' to install the dependency"
echo "2. Import the component in your code"
