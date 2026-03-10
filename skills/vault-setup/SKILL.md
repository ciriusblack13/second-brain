---
name: vault-setup
description: Interactive Obsidian vault configurator. Two rounds of 4 questions each (8 total), then creates vault structure and vault-context.md.
---

# Vault Setup — Interactive Obsidian Configurator

Run from INSIDE the Obsidian vault folder.

**CRITICAL: Exactly TWO AskUserQuestion calls. Each call has exactly 4 questions shown as tabs. Never more, never fewer calls.**

---

## ROUND 1 — Who you are (4 questions, one call)

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
    question: "What consumes most of your mental bandwidth right now?",
    header: "Bandwidth",
    options: [
      { label: "Team & people", description: "Hiring, managing, keeping everyone aligned" },
      { label: "Clients & revenue", description: "Pipeline, relationships, deals, delivery" },
      { label: "Projects & execution", description: "Shipping things, hitting deadlines, tracking progress" },
      { label: "Ideas & strategy", description: "Figuring out what to do next, research, planning" }
    ]
  },
  {
    question: "How do you prefer to capture notes and ideas?",
    header: "Capture style",
    options: [
      { label: "Daily brain dumps", description: "Write everything to a daily note and sort later" },
      { label: "Straight into folders", description: "Each note goes directly where it belongs" },
      { label: "Voice or transcripts", description: "I dictate or paste transcripts, want Claude to clean and file them" },
      { label: "No system yet", description: "That's exactly why I'm here" }
    ]
  },
  {
    question: "Work only, or personal life too?",
    header: "Scope",
    options: [
      { label: "Work only", description: "Business, clients, projects — keep it professional" },
      { label: "Work + personal goals", description: "Include priorities and things I'm working on outside work too" },
      { label: "Full life OS", description: "One place for everything — work, personal, health, finance, ideas" },
      { label: "Start work, add later", description: "Work first, expand when I'm ready" }
    ]
  }
])
```

---

## ROUND 2 — What you need (4 questions, one call)

```
AskUserQuestion([
  {
    question: "What's fallen through the cracks most in your work?",
    header: "Biggest pain",
    options: [
      { label: "People & follow-ups", description: "Things I said I'd do with team or clients that got forgotten" },
      { label: "Decisions & reasoning", description: "I make decisions but lose the context and why behind them" },
      { label: "Ideas & opportunities", description: "Good ideas I had but never acted on because I forgot them" },
      { label: "Projects & deadlines", description: "Things in progress that stall because I lost track" }
    ]
  },
  {
    question: "Do you have existing files to import into your vault?",
    header: "Existing files",
    options: [
      { label: "Yes — a lot", description: "PDFs, Word docs, slides, old notes — years of stuff" },
      { label: "Yes — a handful", description: "A few key files to start with" },
      { label: "Starting fresh", description: "No existing files — building from zero" },
      { label: "Not sure yet", description: "I'll figure this out later" }
    ]
  },
  {
    question: "How often do you make decisions you'd want to reference later?",
    header: "Decisions",
    options: [
      { label: "Daily — constantly", description: "I'm deciding things all day and need to track the reasoning" },
      { label: "Weekly — meaningful ones", description: "A handful of significant decisions per week" },
      { label: "Rarely — only big ones", description: "Only major or irreversible decisions need capturing" },
      { label: "Never tracked before", description: "Open to starting — just haven't done it" }
    ]
  },
  {
    question: "What do you most want Claude Code to do in this vault day-to-day?",
    header: "Daily goal",
    options: [
      { label: "Faster decisions", description: "Surface the right context so I can decide quickly and move on" },
      { label: "Track everything", description: "Nothing falls through — people, projects, commitments, ideas" },
      { label: "Write in my voice", description: "Use my past notes to match my tone when drafting anything" },
      { label: "All of the above", description: "I want the full compounding system" }
    ]
  }
])
```

---

## GENERATION — After both rounds

### Step 1: Create folder structure

Based on role:
- Business Owner → `mkdir -p inbox daily people operations decisions projects archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/standup`
- Developer → `mkdir -p inbox daily projects research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/project`
- Consultant → `mkdir -p inbox daily clients projects research archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/client`
- Creator → `mkdir -p inbox daily content research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/content`

If scope includes personal/full life OS, also: `mkdir -p personal goals`

### Step 2: Write vault-context.md

```markdown
# About Me

[2 sentences — role, what matters most, what they're optimizing for]

# My Vault Structure

[Actual folder tree just created, one-line purpose per folder]

# How I Work

- Capture style: [from answer]
- Biggest pain point: [from answer]
- Decision frequency: [from answer]
- Scope: [work only / work + personal / full life OS]

# Context Rules

When I mention a decision → check decisions/ for related past decisions first
When I mention a person, client, or project → look in [relevant folder] for their context
When I ask you to write something → read recent daily/ notes to match my voice
When I drop something in inbox/ → ask if I want it sorted now or later
```

### Step 3: Write skill files

**`.claude/skills/daily/SKILL.md`** — read today's note or create one, check inbox, surface top 3 priorities, ask "What are we working on?"

**`.claude/skills/tldr/SKILL.md`** — summarize conversation, save to right folder, update memory.md

Role-specific third skill:
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
who you are, how you work, and where things live. You never have to
re-explain yourself.

Add this one line to any project's CLAUDE.md to wire it up:

  At the start of every session, read [absolute path]/vault-context.md

Your slash commands:
  /daily      — start your day with vault context
  /tldr       — save any session to the right folder
  /[role cmd] — [one line description]

Have files to import?
  python scripts/process_docs_to_obsidian.py ~/your-files inbox/
  Then: "Sort everything in inbox/ into the right folders"
```
