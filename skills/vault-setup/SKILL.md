---
name: vault-setup
description: Interactive Obsidian vault configurator. Interviews the user across multiple tiers of questions and generates a personalized vault folder structure, CLAUDE.md, and starter slash commands. Use when someone wants to set up or restructure their Obsidian vault for use with Claude Code.
---

# Vault Setup — Interactive Obsidian Configurator

Interview the user across tiers and generate their personalized Obsidian vault structure,
CLAUDE.md system file, and starter slash commands. Do NOT ask all questions at once.
One tier at a time. Adapt follow-up questions based on prior answers.

---

## ENVIRONMENT SETUP (Run once before anything else)

Before the interactive prompts, check if `process_docs_to_obsidian.py` dependencies are ready.
If the user mentions they have existing files to import, they will need:

```
# 1. Install dependencies
pip install google-genai python-dotenv python-docx python-pptx

# 2. Set up your API key
cp .env.example .env
# Then open .env and paste your Google API key
# Get one free at: https://aistudio.google.com/apikey
```

The pre-processing script (`process_docs_to_obsidian.py`) uses **Gemini 3 Flash Preview**
(`gemini-3-flash-preview`) via the `google-genai` Python library. It reads your
`GOOGLE_API_KEY` from the `.env` file automatically.

---

## TIER 1 — Role

Use AskUserQuestion:

```
Question: "What best describes how you primarily use a computer for work?"

Options:
A) Business Owner / Operator
   — You run a team or company and need to track decisions, clients, projects, and operations
B) Developer / Builder
   — You write code, build tools, ship products, manage technical projects
C) Consultant / Freelancer / Agency
   — You work with clients, deliver projects, manage multiple relationships simultaneously
D) Student / Researcher
   — You study, write papers, synthesize knowledge from many sources
E) Creator / YouTuber / Podcaster
   — You make content: videos, newsletters, podcasts, social posts
```

---

## TIER 2 — Role-Specific Follow-Ups

Ask 3 questions based on the Tier 1 answer. Use AskUserQuestion one at a time.

### If A (Business Owner / Operator):

**Q2a:**
```
Question: "What consumes most of your mental bandwidth day-to-day?"
Options:
A) Team, hiring, and operations
B) Sales, clients, and revenue
C) Product, roadmap, and delivery
D) All of it equally — that's exactly the problem
```

**Q2b:**
```
Question: "Do you have a team?"
Options:
A) Solo — just me right now
B) Small team (2–5 people)
C) Growing team (6–20 people)
D) Established organization (20+)
```

**Q2c:**
```
Question: "What do you most want Claude Code to help with inside your vault?"
Options:
A) Synthesizing information so I can make faster decisions
B) Tracking everything so nothing falls through the cracks
C) Writing and communication — emails, briefs, reports
D) Building automations and workflows that run themselves
```

---

### If B (Developer / Builder):

**Q2a:**
```
Question: "What do you primarily build?"
Options:
A) Web or mobile apps and products
B) Scripts, automations, and internal tools
C) AI agents and LLM-powered systems
D) A mix of all of the above
```

**Q2b:**
```
Question: "Do you work with clients or on your own projects?"
Options:
A) Clients — I need to track their context separately
B) My own projects and products
C) Both — I have client work and personal projects running in parallel
```

**Q2c:**
```
Question: "Beyond code, what else do you want to track in this vault?"
Options:
A) Research, documentation, and learning notes
B) Personal notes and life planning alongside work
C) Just development work — I want it focused
D) Client relationships and project status
```

---

### If C (Consultant / Freelancer / Agency):

**Q2a:**
```
Question: "What type of work do you deliver to clients?"
Options:
A) Strategy and advisory (decks, frameworks, recommendations)
B) Technical work (code, integrations, systems)
C) Creative work (copy, design, content)
D) A mix — depends on the engagement
```

**Q2b:**
```
Question: "How many active clients do you typically manage at once?"
Options:
A) 1–3 (deep, focused relationships)
B) 4–10 (busy — tracking is becoming a challenge)
C) More than 10 (need a real system)
```

**Q2c:**
```
Question: "What do you most want to track per client?"
Options:
A) Meeting notes and decisions made
B) Project status and deliverable deadlines
C) Invoices, contracts, and business details
D) All of the above
```

---

### If D (Student / Researcher):

**Q2a:**
```
Question: "What are you primarily studying or researching?"
(Ask user to type their field or topic in a few words)
```

**Q2b:**
```
Question: "What do you most want to capture and organize?"
Options:
A) Notes from papers, books, and sources (literature review)
B) My own ideas, hypotheses, and thinking
C) Project timelines, deadlines, and tasks
D) Everything — one unified knowledge base
```

**Q2c:**
```
Question: "Do you want to separate personal life from academic work?"
Options:
A) Yes — completely separate vaults or sections
B) A little overlap is fine (e.g., personal goals alongside academic)
C) No — I want one unified system for everything
```

---

### If E (Creator / YouTuber / Podcaster):

**Q2a:**
```
Question: "What kind of content do you make?"
Options:
A) Video (YouTube, short-form, Reels)
B) Written (newsletter, blog, LinkedIn)
C) Both video and written
D) Podcast or audio
```

**Q2b:**
```
Question: "How many active projects or series are you running right now?"
Options:
A) 1–3 (focused, tight content operation)
B) 4–10 (growing catalogue, need to track)
C) More than 10 (prolific — organization is critical)
```

**Q2c:**
```
Question: "Do you work with clients, sponsors, or brand partners?"
Options:
A) Yes, regularly — need to track them properly
B) Sometimes — occasional deals
C) No — purely my own independent content
```

---

## TIER 3 — Existing Files (Always Ask)

```
Question: "Do you have existing files you want to bring into your vault?"
Options:
A) Yes — a lot (PDFs, Word docs, slide decks, old notes)
   — We'll use process_docs_to_obsidian.py with Gemini 3 Flash to handle this
B) Yes — a handful of files
   — Easy to bring in with the script or manually
C) Starting completely fresh
   — We'll seed the vault from scratch with Claude Code
```

---

## TIER 4 — AI Goals (Always Ask)

```
Question: "What do you most want Claude Code to do inside this vault day-to-day?"
Options:
A) Research and synthesize — pull from my notes to give smarter, contextual answers
B) Write in my voice — use my past work to match my style and thinking
C) Manage and organize — keep the vault sorted, linked, and up to date automatically
D) All of the above — I want the full compounding system
```

---

## GENERATION PHASE

After all 4 tiers are complete, generate everything below. No more questions.

---

### 1. Vault Folder Structure

Generate a top-level folder structure (max 7 folders) tailored to their answers.
Show as a clean directory tree with a one-line description per folder.

Example format:
```
vault/
├── 📁 clients/          # One subfolder per client with their full context
├── 📁 projects/         # Active project briefs, status, and deliverables
├── 📁 daily/            # Daily notes, quick captures, brain dumps
├── 📁 research/         # Deep research, saved articles, synthesis notes
├── 📁 decisions/        # Key decisions made and the reasoning behind them
├── 📁 inbox/            # Drop anything here — Claude Code will sort it
└── 📁 archive/          # Completed work (never delete, just move here)
```

Rules:
- Always include `inbox/` — it's where pre-processed files and new drops land
- Always include `archive/` — prevents deletion anxiety
- Folder names: short, lowercase, no spaces
- Max 7 top-level folders — if they want more, use subfolders

---

### 2. CLAUDE.md Template

Generate a ready-to-use CLAUDE.md tailored entirely to their role and answers.

```markdown
# CLAUDE.md — [Role/Name]'s Second Brain

## Who I Am
[1–2 paragraphs based on Tier 1–2 answers. Written in first person as Claude describing its owner.
Be specific — mention their role, what they do, what they're trying to accomplish.]

## Vault Structure
[Paste their folder tree with one-line purposes]

## Context Loading Rules
When working on [their primary domain]:
→ Read [most relevant folder] before starting

When starting the day:
→ Read daily/[today's date].md if it exists
→ Check inbox/ for any unprocessed files — sort them if found

When writing in my voice:
→ Read [writing/content folder] first to calibrate tone and style

When working on a specific client or project:
→ Read [clients/project-name] or [projects/name] first

## How to Maintain This Vault
- New files from outside always go into inbox/ first
- Daily notes: daily/YYYY-MM-DD.md
- Completed work moves to archive/ — never permanently delete
- Update this CLAUDE.md whenever conventions or priorities change

## My Conventions
[2–4 conventions specific to their role and answers.
E.g., for business owners: how decisions are documented.
For developers: how projects are structured.
For consultants: how client files are named.]
```

---

### 3. Starter Slash Commands

Generate 3 slash commands. For each, provide:
- Command name
- Plain English description of what it does
- Full SKILL.md content to paste into `.claude/skills/[name]/SKILL.md`

**Always include these two:**

---

**/daily** — Starts your day with vault context

```markdown
---
name: daily
description: Start the day. Read today's daily note or create one. Surface top priorities from active projects. Ask what we're working on.
---

Read today's daily note at daily/YYYY-MM-DD.md (use today's actual date).
If it doesn't exist, create it with this template:

# [Today's Date]

## Top of Mind

## Today's Focus

## Notes

Then read the inbox/ folder and list any unprocessed files found.
Read the most relevant active project or client folder for context.
Summarize the top 3 priorities for today based on recent notes.
Ask: "What are we working on today?"
```

---

**/tldr** — Crystallizes the current session into a vault note

```markdown
---
name: tldr
description: Save a summary of this conversation to the vault. Key decisions, things to remember, next actions. Store in the right folder automatically.
---

Summarize this conversation:
1. What was decided or figured out
2. Key things to remember
3. Next actions (if any)

Format as a clean markdown note with today's date in the title.
Save it to the most relevant folder based on the topic discussed.
If it relates to a client, save to clients/[name]/.
If it relates to a project, save to projects/[name]/.
If general, save to daily/ with today's date.

Also update memory.md (if it exists at the vault root) with any new patterns,
preferences, or conventions discovered in this session.
```

---

**Third command** — role-specific:

- **Business Owner** → `/standup`
  ```
  Read all active project and client folders briefly.
  Summarize what's in progress, what's blocked, and what needs a decision today.
  Format as a morning briefing: 5 bullets max per area.
  Ask: "What needs attention first?"
  ```

- **Developer** → `/project [name]`
  ```
  Read projects/[name]/ fully.
  Summarize current status, what was last worked on, and what's next.
  Load any relevant research or documentation from the vault.
  Ask: "Where are we picking up?"
  ```

- **Consultant** → `/client [name]`
  ```
  Read clients/[name]/ fully.
  Summarize their context: who they are, what we're working on, recent decisions.
  Surface any open items or upcoming deadlines.
  Ask: "What are we doing for [name] today?"
  ```

- **Student / Researcher** → `/research [topic]`
  ```
  Search the entire vault for notes related to [topic].
  Synthesize the key ideas, connections, and gaps found.
  List the source notes referenced.
  Ask: "What do you want to explore or write about this?"
  ```

- **Creator** → `/content`
  ```
  Read the content/ folder for recent scripts, briefs, and published work.
  Calibrate voice and style from past content.
  Ask: "What are we creating today — and what's it about?"
  Then help develop the idea using vault context.
  ```

---

### 4. Pre-Processing Instructions (If They Have Existing Files)

If they answered A or B in Tier 3, include this section after the commands:

```
## Bringing In Your Existing Files

You'll use process_docs_to_obsidian.py — a script that uses Gemini 3 Flash
to read any file type, extract the signal, and save clean Markdown notes.

SETUP (one time only):
  pip install google-genai python-dotenv python-docx python-pptx
  cp .env.example .env
  # Add your Google API key to .env
  # Get a free key at: https://aistudio.google.com/apikey

RUN:
  python process_docs_to_obsidian.py ~/your-files-folder ~/vault/inbox

WHAT IT DOES:
  → Reads PDFs, PPTX, DOCX, TXT files
  → Uses Gemini 3 Flash (gemini-3-flash-preview) to synthesize each file
  → Outputs clean, compressed Markdown with YAML frontmatter
  → Saves to your inbox/ folder (300–600 words per note, signal only)

AFTER IT RUNS:
  Open Claude Code in your vault and say:
  "Sort everything in inbox/ into the right folders based on CLAUDE.md"

  Claude Code will route each note to the correct folder automatically.
```

---

## FINAL OUTPUT ORDER

Present in this sequence:
1. **"Here's your vault structure:"** — folder tree
2. **"Here's your CLAUDE.md:"** — full file in a code block, ready to copy
3. **"Here are your 3 slash commands:"** — each with full SKILL.md content
4. If applicable: **"Here's how to bring in your existing files:"** — pre-processing instructions

Close with:
> "To get started: create these folders in your vault, drop the CLAUDE.md at the root,
> and open Claude Code from inside your vault with `claude`.
> Your second brain is ready — and this time, you won't forget to use it."

---

## DESIGN RULES

- Folder names: lowercase, no spaces, memorable
- Never more than 7 top-level folders
- CLAUDE.md always written in first person ("my vault", "I work on")
- Slash commands must be immediately useful on day 1, not aspirational
- The inbox/ → sort pattern is the core loop — always explain it
- .env.example is the shareable version; .env is always local/gitignored
