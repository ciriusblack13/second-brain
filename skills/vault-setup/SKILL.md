---
name: vault-setup
description: Interactive Obsidian vault configurator. Asks ALL questions in ONE single AskUserQuestion call (4 tabs simultaneously), then creates the vault structure and vault-context.md.
---

# Vault Setup — Interactive Obsidian Configurator

Run this from INSIDE the Obsidian vault folder.

**CRITICAL: Fire ONE single AskUserQuestion call with ALL 4 questions at once. Do not split into multiple calls. The user sees all 4 as tabs simultaneously.**

---

## THE ONE CALL — 4 questions, all at once

```
AskUserQuestion([
  {
    question: "What best describes how you primarily use a computer for work?",
    header: "Your role",
    options: [
      { label: "Business Owner", description: "Running a team or company — decisions, operations, growth" },
      { label: "Developer / Builder", description: "Writing code, shipping products, building tools" },
      { label: "Consultant / Freelancer", description: "Client work, project delivery, multiple relationships" },
      { label: "Creator / Podcaster", description: "Making content — videos, newsletters, podcasts" }
    ]
  },
  {
    question: "What's fallen through the cracks most in your work?",
    header: "Biggest pain",
    options: [
      { label: "People & follow-ups", description: "Things I said I'd do, hiring pipeline, 1:1 notes" },
      { label: "Client commitments", description: "Deliverables, deadlines, things I promised" },
      { label: "My own decisions", description: "I make decisions but lose the reasoning behind them" },
      { label: "Ideas & opportunities", description: "Good ideas I forgot to act on" }
    ]
  },
  {
    question: "Do you have existing files to import?",
    header: "Existing files",
    options: [
      { label: "Yes — a lot", description: "PDFs, Word docs, slides — years of stuff to bring in" },
      { label: "Yes — a handful", description: "A few files to start with" },
      { label: "Starting fresh", description: "No existing files — building from zero" },
      { label: "Not sure yet", description: "I'll decide later" }
    ]
  },
  {
    question: "Work only, or personal life too?",
    header: "Scope",
    options: [
      { label: "Work only", description: "Business, projects, clients — keep it professional" },
      { label: "Work + personal goals", description: "Include priorities and things outside work too" },
      { label: "Full life OS", description: "One place for everything — work, personal, health, ideas" },
      { label: "Start work, expand later", description: "Work first, add personal when ready" }
    ]
  }
])
```

---

## GENERATION — After the one call

### Step 1: Create folder structure

Based on role, run one bash mkdir:

- Business Owner → `mkdir -p inbox daily people operations decisions projects archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/standup`
- Developer → `mkdir -p inbox daily projects research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/project`
- Consultant → `mkdir -p inbox daily clients projects research archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/client`
- Creator → `mkdir -p inbox daily content research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/content`

If scope includes personal, also add: `personal/` and `goals/`

### Step 2: Write vault-context.md

Write `vault-context.md` to the current directory based on ALL their answers:

```markdown
# About Me

[2 sentences: role, what they do, what matters most to them]

# My Vault Structure

[Folder tree with one-line purpose per folder — actual folders just created]

# How I Work

- I capture ideas by: [infer from role + pain point]
- My biggest pain point is: [from answer]
- Scope: [work only / work + personal / full life OS]

# Context Rules

When I mention a decision → check decisions/ for related past decisions first
When I mention a person or client → look in [people/ or clients/] for their context
When I ask you to write something → read recent daily/ notes to match my voice
When I drop a file in inbox/ → ask me if I want it sorted now
```

### Step 3: Write skill files

Write directly to `.claude/skills/`:

**`.claude/skills/daily/SKILL.md`:**
Read today's daily note or create one. Check inbox/ for unprocessed files. Surface top 3 priorities. Ask: "What are we working on today?"

**`.claude/skills/tldr/SKILL.md`:**
Summarize this conversation: decisions made, things to remember, next actions. Save to the most relevant folder. Update memory.md.

**Role-specific:**
- Business Owner → `.claude/skills/standup/SKILL.md`: briefing across projects, decisions, people
- Developer → `.claude/skills/project/SKILL.md`: load a project's full context and status
- Consultant → `.claude/skills/client/SKILL.md`: load a client's full context
- Creator → `.claude/skills/content/SKILL.md`: read content folder, calibrate voice, develop idea

### Step 4: Write memory.md

```markdown
# Memory

## Session Log
[Updated by Claude Code after each session]

## My Preferences
[Added as Claude learns them]
```

### Step 5: Clean output

```
Your vault is set up.

[actual folder tree]

vault-context.md is your vault's identity file — Claude reads it to know
who you are, how you work, and where things live. No re-explaining yourself.

Add this to any project's CLAUDE.md to wire it up:

  At the start of every session, read [absolute path]/vault-context.md

Your slash commands:
  /daily      — start your day with vault context
  /tldr       — save any session to the right folder
  /[role cmd] — [one line]

Have files to import?
  python scripts/process_docs_to_obsidian.py ~/your-files inbox/
  Then: "Sort everything in inbox/ into the right folders"
```
