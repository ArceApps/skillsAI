#!/usr/bin/env bash
# Validates the structure and content of a plan file or unified task file
# Usage: ./validate-plan.sh <path-to-file.md>

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0

error() {
    echo -e "${RED}✗ ERROR:${NC} " >&2
    ((ERRORS+=1))
}

warning() {
    echo -e "${YELLOW}⚠ WARNING:${NC} " >&2
    ((WARNINGS+=1))
}

success() {
    echo -e "${GREEN}✓${NC} "
}

info() {
    echo "ℹ "
}

# Check if file path is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-file.md>"
    exit 1
fi

PLAN_FILE=""

# Check if file exists
if [ ! -f "$PLAN_FILE" ]; then
    error "File not found: $PLAN_FILE"
    exit 1
fi

FILENAME=$(basename "$PLAN_FILE")
info "Validating file: $PLAN_FILE"
echo ""

# DETECT FORMAT TYPE
IS_UNIFIED_TASK=false
if [[ "$FILENAME" =~ ^TASK-[0-9]{4}-[0-9a-zA-Z-]+\.md$ ]] || [[ "$FILENAME" =~ ^TASK-[0-9]+.*\.md$ ]]; then
    IS_UNIFIED_TASK=true
    info "Detected format: Unified Task (TASK-XXXX)"
elif [[ "$FILENAME" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+-v[0-9]+\.md$ ]]; then
    IS_UNIFIED_TASK=false
    info "Detected format: Classic Plan (YYYY-MM-DD)"
else
    warning "Unknown filename format. Will attempt validation as Classic Plan."
fi

# 1. Check file naming convention (skip if unknown but warn)
if [ "$IS_UNIFIED_TASK" = true ]; then
    if [[ ! "$FILENAME" =~ ^TASK-[0-9]+.*\.md$ ]]; then
        warning "Unified Task filenames usually follow TASK-YYYY-NAME.md pattern"
    else
        success "Filename follows Task convention"
    fi
else
    # Classic validation logic for filenames
    if [[ ! "$FILENAME" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+-v[0-9]+\.md$ ]]; then
        error "Filename must follow pattern: YYYY-MM-DD-task-name-vN.md (got: $FILENAME)"
    else
        success "Filename follows naming convention"
    fi
fi

# 2. Check required sections based on format
CONTENT=$(cat "$PLAN_FILE")

if [ "$IS_UNIFIED_TASK" = true ]; then
    required_sections=(
        "^# TASK-.+"
        "^## [0-9]+\. 🎯 Objetivo y Alcance"
        "^## [0-9]+\. 🧠 Plan de Ejecución"
        "^## [0-9]+\. 📝 Bitácora de Trabajo"
    )
    section_names=(
        "Task Header (# TASK-...)"
        "Objetivo y Alcance"
        "Plan de Ejecución"
        "Bitácora de Trabajo"
    )
else
    required_sections=(
        "^# .+"
        "^## Objective"
        "^## Implementation Plan"
        "^## Verification Criteria"
        "^## Potential Risks and Mitigations"
        "^## Alternative Approaches"
    )
    section_names=(
        "Main heading (# Title)"
        "Objective section"
        "Implementation Plan section"
        "Verification Criteria section"
        "Potential Risks and Mitigations section"
        "Alternative Approaches section"
    )
fi

for i in "${!required_sections[@]}"; do
    if echo "$CONTENT" | grep -qE "${required_sections[$i]}"; then
        success "${section_names[$i]} present"
    else
        error "Missing required section: ${section_names[$i]}"
    fi
done

# 3. Check for markdown checkboxes (Common for both)
# Unified Tasks allow [x] for completed items, Classic prefers empty [ ] initially
if [ "$IS_UNIFIED_TASK" = true ]; then
    # Look for checkboxes in Plan de Ejecución
    if echo "$CONTENT" | grep -qE '^\- \[[ x]\]'; then
        success "Task list uses checkbox format"
    else
        warning "No checkboxes found in Task list"
    fi
else
    # Classic strict check
    if echo "$CONTENT" | sed -n '/^## Implementation Plan$/,/^## /p' | grep -qE '^\- \[ \]'; then
        success "Implementation Plan uses checkbox format"
    else
        error "Implementation Plan must use checkbox format: - [ ] Task description"
    fi
fi

# 4. Check for code blocks (Allowed in Unified Task logs, disallowed in Classic Plans)
CODE_FENCE='```'
if [ "$IS_UNIFIED_TASK" = false ]; then
    if echo "$CONTENT" | grep -q "$CODE_FENCE"; then
        error "Plan contains code blocks. Classic Plans should NEVER include code."
    else
        success "No code blocks found"
    fi
else
    # Unified Tasks can have code blocks in Bitácora
    success "Code blocks allowed in Unified Task format"
fi

# 5. Check for empty sections (Common)
if [ "$IS_UNIFIED_TASK" = false ]; then
    if echo "$CONTENT" | sed -n '/^## Objective$/,/^## /p' | grep -qE '^
 | grep -qE '^## '; then
        warning "Objective section appears to be empty"
    fi
fi

# 6. Check minimum number of checkboxes (at least 3 tasks)
CHECKBOX_COUNT=$(echo "$CONTENT" | grep -cE '^\- \[[ x]\]' || true)
if [ -z "$CHECKBOX_COUNT" ]; then
    CHECKBOX_COUNT=0
fi

if [ "$CHECKBOX_COUNT" -lt 2 ]; then
     warning "Plan has very few tasks ($CHECKBOX_COUNT). Consider adding more detail."
else
    success "Plan has $CHECKBOX_COUNT tasks"
fi

# Final summary
echo ""
echo "================================================"
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ Validation passed${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}  ($WARNINGS warnings)${NC}"
    fi
    exit 0
else
    echo -e "${RED}✗ Validation failed${NC}"
    echo -e "  ${RED}$ERRORS errors${NC}, ${YELLOW}$WARNINGS warnings${NC}"
    exit 1
fi

