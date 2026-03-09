<div align="center">

```
  ███████╗███████╗ ██████╗ ██████╗ ███╗   ██╗██████╗
  ██╔════╝██╔════╝██╔════╝██╔═══██╗████╗  ██║██╔══██╗
  ███████╗█████╗  ██║     ██║   ██║██╔██╗ ██║██║  ██║
  ╚════██║██╔══╝  ██║     ██║   ██║██║╚██╗██║██║  ██║
  ███████║███████╗╚██████╗╚██████╔╝██║ ╚████║██████╔╝
  ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝

  ██████╗ ██████╗  █████╗ ██╗███╗   ██╗
  ██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║
  ██████╔╝██████╔╝███████║██║██╔██╗ ██║
  ██╔══██╗██╔══██╗██╔══██║██║██║╚██╗██║
  ██████╔╝██║  ██║██║  ██║██║██║ ╚████║
  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
```

### The second brain you always wanted — but could never build. Until now.

**[Obsidian](https://obsidian.md) + [Claude Code](https://claude.ai/code) · One command · Any platform**

</div>

---

## The Problem

You've tried to build a second brain before.

Maybe Notion. Maybe Apple Notes. Maybe a folder of markdown files you swore you'd organize.

Every time, the same outcome: you'd set it up, use it for a week, and then completely forget it existed.

The problem was never the tool. **It was that you had to remember to use it.**

That changes now.

---

## What This Is

A one-command setup that wires **Obsidian** (your local knowledge vault) to **Claude Code** (your AI agent), so that:

- Claude Code **reads your notes** before answering — it knows your projects, your clients, your voice
- Claude Code **writes your notes** after working — your vault builds itself from your sessions
- Your existing files (PDFs, docs, slides) get **synthesized and imported automatically** via Gemini 3 Flash
- Everything stays **local, private, and yours** — no cloud lock-in, no subscription creep

The result: an AI that knows who you are from the first prompt of every session. Not because you told it. Because it read your vault.

---

## Quick Start

**macOS**
```bash
git clone https://github.com/promptadvisers/second-brain.git
cd second-brain
./setup.sh
```

**Windows** (PowerShell)
```powershell
git clone https://github.com/promptadvisers/second-brain.git
cd second-brain
powershell -ExecutionPolicy Bypass -File setup.ps1
```

That's it. The script installs everything, creates your vault, and optionally imports your existing files.

> Prefer to set things up manually? See [Manual Setup](#manual-setup) below.

---

## What the Setup Script Does

```
Step 1 — Install Obsidian         (via Homebrew / winget)
Step 2 — Install Claude Code CLI  (official installer)
Step 3 — Install Python deps      (Gemini Flash for file processing)
Step 4 — Create your vault        (inbox, daily, projects, research, archive)
Step 5 — Configure API key        (Google AI — free tier works fine)
Step 6 — Import existing files    (optional — Gemini reads and synthesizes them)
         └─> Opens Obsidian pointed at your new vault
```

---

## After Setup

### 1. Enable the Obsidian CLI
```
Obsidian → Settings → General → Enable Command Line Interface
```
This adds the `obsidian` command to your PATH so you can open your vault from the terminal. ([CLI docs](https://help.obsidian.md/cli))

### 2. Open Claude Code in your vault
```bash
cd ~/second-brain
claude
```

### 3. Run your first command
```
/vault-setup
```

Claude Code will interview you about your role and work, then generate a personalized `CLAUDE.md` and suggest slash commands for your specific workflow. Business owner gets different folders than a developer. Creator gets different slash commands than a consultant.

---

## Slash Commands

Three commands come pre-installed. More get added as you use the system.

| Command | What it does |
|---------|-------------|
| `/vault-setup` | Interviews you (role, projects, goals) and generates your personalized vault structure + CLAUDE.md + custom slash commands |
| `/daily` | Starts your day — reads today's note or creates one, surfaces your top priorities, asks what you're working on |
| `/tldr` | At the end of any session, saves a structured summary to the right folder in your vault automatically |

---

## Importing Existing Files

Have years of PDFs, Word docs, and slide decks sitting in folders? Don't manually convert them.

```bash
python3 scripts/process_docs_to_obsidian.py ~/your-files ~/second-brain/inbox
```

**What happens:**
1. Every file gets read by **Gemini 3 Flash** (`gemini-3-flash-preview`)
2. Signal is extracted, noise is discarded (legal boilerplate, headers, filler)
3. A clean compressed Markdown note is saved to your `inbox/` (300–600 words max)

Then open Claude Code and say: *"Sort everything in inbox/ into the right folders."*

It reads your CLAUDE.md, understands your vault structure, and routes every note to where it belongs.

**Supported formats:** `.pdf` `.docx` `.pptx` `.txt` `.md`

---

## How the Memory Works

Your vault is structured so Claude Code can find the right context for any task:

```
~/second-brain/
├── CLAUDE.md        ← The brain of the brain. Read at every session start.
├── memory.md        ← Session log. Updated by Claude Code after each conversation.
├── inbox/           ← Drop zone. Anything new lands here first.
├── daily/           ← Daily notes (YYYY-MM-DD.md). Your running log.
├── projects/        ← Active projects. Claude reads the relevant one before helping.
├── research/        ← Synthesized knowledge. Sources, notes, ideas.
└── archive/         ← Completed work. Never delete — just archive.
```

**The compounding effect:**
- Session 1: Claude knows your folder structure
- Session 5: Claude knows your projects, your voice, your preferences
- Session 20: Claude is your personalized operating system — it knows more about your knowledge base than you consciously remember

---

## Requirements

| Tool | Platform | How to get it |
|------|----------|--------------|
| Obsidian | macOS / Windows / Linux | `brew install --cask obsidian` or `winget install Obsidian.Obsidian` |
| Claude Code | macOS / Linux | `curl -fsSL https://claude.ai/install.sh \| sh` |
| Claude Code | Windows | `winget install Anthropic.ClaudeCode` |
| Python 3.8+ | All | [python.org](https://python.org) |
| Google API key | All | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) — free |
| Claude account | All | [claude.ai](https://claude.ai) — Pro recommended for heavy use |

---

## Repository Structure

```
second-brain/
├── setup.sh                           ← macOS/Linux one-command setup
├── setup.ps1                          ← Windows one-command setup
├── CLAUDE.md                          ← Vault system file (personalized by /vault-setup)
├── memory.md                          ← Session memory (auto-updated by Claude Code)
├── .env.example                       ← Copy to .env, add your Google API key
├── scripts/
│   └── process_docs_to_obsidian.py   ← Gemini 3 Flash file synthesizer
├── skills/
│   ├── vault-setup/SKILL.md          ← Interactive vault configurator
│   ├── daily/SKILL.md                ← Daily standup command
│   └── tldr/SKILL.md                 ← Session summary command
└── vault-template/
    ├── inbox/   daily/   projects/
    ├── research/   archive/
```

---

## Manual Setup

Prefer to install each piece yourself:

**1. Install Obsidian**

| Platform | Command |
|----------|---------|
| macOS | `brew install --cask obsidian` |
| Windows | `winget install Obsidian.Obsidian` |
| Linux | [AppImage download](https://obsidian.md/download) |

**2. Enable the Obsidian CLI**
`Settings → General → Enable Command Line Interface`

**3. Install Claude Code**

| Platform | Command |
|----------|---------|
| macOS / Linux | `curl -fsSL https://claude.ai/install.sh \| sh` |
| Windows | `winget install Anthropic.ClaudeCode` |

**4. Clone and set up manually**
```bash
git clone https://github.com/promptadvisers/second-brain.git
mkdir -p ~/second-brain/{inbox,daily,projects,research,archive,.claude/skills}
cp second-brain/CLAUDE.md second-brain/memory.md ~/second-brain/
cp -r second-brain/skills ~/second-brain/.claude/
cp -r second-brain/scripts ~/second-brain/
cp second-brain/.env.example ~/second-brain/.env
# Add your Google API key to .env
cd ~/second-brain && claude
```

---

## FAQ

**Is my data private?**
Yes. Obsidian stores everything as local markdown files on your computer. Nothing is uploaded to any server. Claude Code processes your files locally in the folder you open it in. The only time anything leaves your machine is when you call the Gemini API to process existing files — and that's optional.

**Do I need a paid Claude account?**
The free tier works for light use. For daily use with long sessions, Claude Pro ($20/month) gives substantially more usage than equivalent API costs in other tools.

**What if I already have an Obsidian vault?**
The setup script asks where your vault is. Point it at your existing vault — it'll copy the CLAUDE.md template, skills, and scripts into it without touching your existing notes.

**Can I use this without the file processing?**
Absolutely. The Gemini API key and file processing are optional. The core system (Obsidian + Claude Code + CLAUDE.md + slash commands) works without it.

---

<div align="center">

Built by [Mark Kashef](https://youtube.com/@marwankashef) · [Prompt Advisers](https://promptadvisers.com)

*If this helped you build your second brain, drop a ⭐ — it helps others find it.*

</div>
