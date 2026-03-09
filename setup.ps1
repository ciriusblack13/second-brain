# ─────────────────────────────────────────────────────────────────────────────
#  SECOND BRAIN — Windows Setup (PowerShell)
#  Run with: powershell -ExecutionPolicy Bypass -File setup.ps1
# ─────────────────────────────────────────────────────────────────────────────

$Purple = "`e[35m"
$Green  = "`e[32m"
$Orange = "`e[33m"
$White  = "`e[1;37m"
$Dim    = "`e[2m"
$Reset  = "`e[0m"

Clear-Host
Write-Host ""
Write-Host "${Purple}" -NoNewline
Write-Host @"
  ___  ___  ___ ___  _  _ ___     ___ ___  _   ___ _  _
 / __|| __|| __/ _ \| \| ||   \  | _ )_ _|/_\ |_ _| \| |
 \__ \| _| | _| (_) | .` || |) | | _ \| | / _ \ | || .` |
 |___/|___||___\___/|_|\_||___/  |___/___/_/ \_\___|_|\_|
"@
Write-Host "${Reset}"
Write-Host "  Obsidian + Claude Code - Your AI-powered second brain"
Write-Host ""
Write-Host "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""

# ─── STEP 1: Check winget ────────────────────────────────────────────────────
Write-Host "${White}Step 1/5 — Checking winget${Reset}"
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "  winget not found. Install it from the Microsoft Store: App Installer"
    Write-Host "  Or update Windows to 11/latest Windows 10."
    exit 1
}
Write-Host "  ${Green}✓${Reset} winget available"

# ─── STEP 2: Obsidian ────────────────────────────────────────────────────────
Write-Host ""
Write-Host "${White}Step 2/5 — Installing Obsidian${Reset}"
$obsidian = winget list --id Obsidian.Obsidian 2>$null
if (-not $obsidian) {
    Write-Host "  Installing Obsidian..."
    winget install --id Obsidian.Obsidian --silent --accept-package-agreements --accept-source-agreements
    Write-Host "  ${Green}✓${Reset} Obsidian installed"
} else {
    Write-Host "  ${Green}✓${Reset} Obsidian already installed"
}

# ─── STEP 3: Claude Code ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "${White}Step 3/5 — Installing Claude Code${Reset}"
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing Claude Code via winget..."
    winget install --id Anthropic.ClaudeCode --silent --accept-package-agreements --accept-source-agreements
    Write-Host "  ${Green}✓${Reset} Claude Code installed"
    Write-Host "  ${Dim}  Note: close and reopen terminal for 'claude' to be available${Reset}"
} else {
    Write-Host "  ${Green}✓${Reset} Claude Code already installed"
}

# ─── STEP 4: Python deps ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "${White}Step 4/5 — Installing Python dependencies${Reset}"
if (Get-Command pip -ErrorAction SilentlyContinue) {
    pip install -q google-genai python-dotenv python-docx python-pptx pillow 2>$null
    Write-Host "  ${Green}✓${Reset} Python packages installed"
} else {
    Write-Host "  ${Orange}⚠${Reset}  Python not found. Install from python.org then re-run."
}

# ─── STEP 5: Vault setup ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "${White}Step 5/5 — Setting up your vault${Reset}"
Write-Host ""
Write-Host "  Where should your second brain live?"
Write-Host "  ${Dim}Press Enter for default: $env:USERPROFILE\second-brain${Reset}"
$vaultInput = Read-Host "  Vault path"
if (-not $vaultInput) { $vaultInput = "$env:USERPROFILE\second-brain" }

$vaultPath = $vaultInput
New-Item -ItemType Directory -Force -Path $vaultPath | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\inbox" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\daily" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\projects" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\research" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\archive" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\.claude\skills\vault-setup" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\.claude\skills\daily" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\.claude\skills\tldr" | Out-Null
New-Item -ItemType Directory -Force -Path "$vaultPath\scripts" | Out-Null

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item "$scriptDir\CLAUDE.md"   "$vaultPath\CLAUDE.md"   -Force
Copy-Item "$scriptDir\memory.md"   "$vaultPath\memory.md"   -Force
Copy-Item "$scriptDir\skills\vault-setup\SKILL.md" "$vaultPath\.claude\skills\vault-setup\SKILL.md" -Force
Copy-Item "$scriptDir\skills\daily\SKILL.md"       "$vaultPath\.claude\skills\daily\SKILL.md"       -Force
Copy-Item "$scriptDir\skills\tldr\SKILL.md"        "$vaultPath\.claude\skills\tldr\SKILL.md"        -Force
Copy-Item "$scriptDir\scripts\process_docs_to_obsidian.py" "$vaultPath\scripts\" -Force

Write-Host "  ${Green}✓${Reset} Vault created at $vaultPath"

# API key
Write-Host ""
Write-Host "  ${Dim}Get your free Google API key: https://aistudio.google.com/apikey${Reset}"
$apiKey = Read-Host "  Paste your Google API key (or press Enter to skip)"
if ($apiKey) {
    "GOOGLE_API_KEY=$apiKey" | Out-File "$vaultPath\.env" -Encoding UTF8
    Write-Host "  ${Green}✓${Reset} API key saved"
} else {
    Copy-Item "$scriptDir\.env.example" "$vaultPath\.env" -Force
    Write-Host "  ${Orange}⚠${Reset}  Add your key to $vaultPath\.env before processing files"
}

# Import existing files
Write-Host ""
Write-Host "  Do you have existing files to import? (PDFs, Word docs, slides)"
$importFolder = Read-Host "  Enter folder path (or press Enter to skip)"
if ($importFolder -and (Test-Path $importFolder)) {
    Write-Host "  Processing files with Gemini 3 Flash..."
    Set-Location $vaultPath
    python scripts\process_docs_to_obsidian.py $importFolder $vaultPath\inbox
}

# Done
Write-Host ""
Write-Host "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""
Write-Host "  ${Green}Your second brain is ready.${Reset}"
Write-Host ""
Write-Host "  ${White}Next steps:${Reset}"
Write-Host "  1. Open Obsidian and select vault: $vaultPath"
Write-Host "  2. Settings → General → Enable Command Line Interface"
Write-Host "  3. Open a terminal in your vault:"
Write-Host "     cd $vaultPath"
Write-Host "     claude"
Write-Host "  4. Run: /vault-setup"
Write-Host ""

# Open Obsidian
Start-Process "obsidian://" -ErrorAction SilentlyContinue
