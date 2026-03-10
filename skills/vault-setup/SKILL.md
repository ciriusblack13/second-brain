---
name: vault-setup
description: Interactive Obsidian vault configurator. Interviews the user across 3 multi-tab wizard screens (each screen = one AskUserQuestion call with multiple questions shown as tabs), creates the vault folder structure and vault-context.md, then gives them a single snippet to paste into any project CLAUDE.md to auto-inject their vault context at startup.
---

# Vault Setup — Interactive Obsidian Configurator

Run this from INSIDE the Obsidian vault folder.
Sets up the VAULT only — not the user's project CLAUDE.md.

**CRITICAL: Each screen = ONE AskUserQuestion call with ALL questions for that screen passed together as an array. This creates a tabbed wizard UI. Never fire questions one at a time.**

---

## SCREEN 1 — Role (1 question, 4 options max)

ONE AskUserQuestion call with 1 question:

```
questions: [
  {
    question: "What best describes how you primarily use a computer for work?",
    header: "Your role",
    options: [
      { label: "Business Owner / Operator", description: "Running a team or company — decisions, operations, growth" },
      { label: "Developer / Builder", description: "Writing code, shipping products, building tools" },
      { label: "Consultant / Freelancer", description: "Client work, project delivery, multiple relationships" },
      { label: "Creator / YouTuber / Podcaster", description: "Making content — videos, newsletters, podcasts" }
    ]
  }
]
```

---

## SCREEN 2 — Role follow-ups + capture style (3 questions, ONE call)

Based on the role answer, fire ONE AskUserQuestion call with 3 questions at the same time. Max 4 options per question.

### If Business Owner:
```
questions: [
  {
    question: "What consumes most of your mental bandwidth?",
    header: "Bandwidth",
    options: [
      { label: "Team & operations", description: "Hiring, managing people, keeping processes running" },
      { label: "Sales & clients", description: "Pipeline, relationships, revenue, deal flow" },
      { label: "Product & roadmap", description: "What to build, priorities, shipping" },
      { label: "All equally", description: "It's all on my plate at once" }
    ]
  },
  {
    question: "Team size?",
    header: "Team",
    options: [
      { label: "Solo", description: "No direct reports, running everything myself" },
      { label: "Small (2–5)", description: "Small tight team, everyone wears multiple hats" },
      { label: "Growing (6–20)", description: "Coordination is becoming a real challenge" },
      { label: "Larger (20+)", description: "Established org with layers" }
    ]
  },
  {
    question: "How do you prefer to capture ideas?",
    header: "Capture style",
    options: [
      { label: "Daily brain dumps", description: "Write everything to a daily note, sort later" },
      { label: "Straight into folders", description: "Each note goes directly where it belongs" },
      { label: "Voice or transcripts", description: "I dictate or paste transcripts, want Claude to file them" },
      { label: "No system yet", description: "That's exactly why I'm here" }
    ]
  }
]
```

### If Developer:
```
questions: [
  {
    question: "What do you primarily build?",
    header: "Build type",
    options: [
      { label: "Apps & products", description: "Web, mobile, SaaS" },
      { label: "Scripts & automations", description: "Internal tools, pipelines, workflows" },
      { label: "AI tools & agents", description: "LLM-powered systems, Claude integrations" },
      { label: "Mix of all", description: "Depends on the week" }
    ]
  },
  {
    question: "Client work or own projects?",
    header: "Work type",
    options: [
      { label: "Clients", description: "I need to track their context separately" },
      { label: "Own projects", description: "Focused on my own roadmap" },
      { label: "Both", description: "Client work and personal projects running in parallel" },
      { label: "Not sure yet", description: "Still figuring this out" }
    ]
  },
  {
    question: "How do you prefer to capture ideas?",
    header: "Capture style",
    options: [
      { label: "Daily brain dumps", description: "Write everything to a daily note, sort later" },
      { label: "Straight into folders", description: "Each note goes directly where it belongs" },
      { label: "Voice or transcripts", description: "I dictate or paste transcripts, want Claude to file them" },
      { label: "No system yet", description: "That's exactly why I'm here" }
    ]
  }
]
```

### If Consultant / Freelancer:
```
questions: [
  {
    question: "Type of work you deliver?",
    header: "Work type",
    options: [
      { label: "Strategy & advisory", description: "Decks, frameworks, recommendations" },
      { label: "Technical", description: "Code, systems, integrations" },
      { label: "Creative", description: "Copy, design, content" },
      { label: "Mix", description: "Depends on the engagement" }
    ]
  },
  {
    question: "How many active clients?",
    header: "Clients",
    options: [
      { label: "1–3", description: "Deep focused relationships" },
      { label: "4–10", description: "Busy — tracking is becoming a challenge" },
      { label: "More than 10", description: "Need a real system" },
      { label: "None yet", description: "Just getting started" }
    ]
  },
  {
    question: "How do you prefer to capture ideas?",
    header: "Capture style",
    options: [
      { label: "Daily brain dumps", description: "Write everything to a daily note, sort later" },
      { label: "Straight into folders", description: "Each note goes directly where it belongs" },
      { label: "Voice or transcripts", description: "I dictate or paste transcripts, want Claude to file them" },
      { label: "No system yet", description: "That's exactly why I'm here" }
    ]
  }
]
```

### If Creator:
```
questions: [
  {
    question: "Type of content?",
    header: "Content type",
    options: [
      { label: "Video (YouTube)", description: "Scripts, thumbnails, titles, analytics" },
      { label: "Written", description: "Newsletter, blog, LinkedIn" },
      { label: "Both", description: "Video and written" },
      { label: "Podcast / audio", description: "Episodes, guests, show notes" }
    ]
  },
  {
    question: "Active projects right now?",
    header: "Volume",
    options: [
      { label: "1–3", description: "Focused, tight content operation" },
      { label: "4–10", description: "Growing — need to track" },
      { label: "More than 10", description: "Prolific — organization is critical" },
      { label: "Just starting", description: "Building from scratch" }
    ]
  },
  {
    question: "How do you prefer to capture ideas?",
    header: "Capture style",
    options: [
      { label: "Daily brain dumps", description: "Write everything to a daily note, sort later" },
      { label: "Straight into folders", description: "Each note goes directly where it belongs" },
      { label: "Voice or transcripts", description: "I dictate or paste transcripts, want Claude to file them" },
      { label: "No system yet", description: "That's exactly why I'm here" }
    ]
  }
]
```

---

## SCREEN 3 — Goals + context (4 questions, ONE call)

ONE AskUserQuestion call with 4 questions:

```
questions: [
  {
    question: "Existing files to import?",
    header: "Existing files",
    options: [
      { label: "Yes — a lot", description: "PDFs, Word docs, slides — years of stuff" },
      { label: "Yes — a handful", description: "A few files to start with" },
      { label: "Starting fresh", description: "No existing files — building from zero" },
      { label: "Not sure yet", description: "I'll figure this out later" }
    ]
  },
  {
    question: "What's fallen through the cracks most in your work?",
    header: "Pain point",
    options: [
      { label: "People & team", description: "Follow-ups, hiring items, 1:1 notes" },
      { label: "Client & project commitments", description: "Deadlines, promises, deliverables" },
      { label: "My own decisions", description: "I make decisions but lose the reasoning" },
      { label: "Ideas & opportunities", description: "Good ideas I forgot to act on" }
    ]
  },
  {
    question: "Work only, or personal life too?",
    header: "Scope",
    options: [
      { label: "Work only", description: "Keep it clean — business and projects only" },
      { label: "Work + personal goals", description: "Include priorities and things outside work too" },
      { label: "Full life OS", description: "One place for everything — work, personal, health, finance" },
      { label: "Start work, add later", description: "Work first, expand when ready" }
    ]
  },
  {
    question: "What should Claude Code do in this vault day-to-day?",
    header: "Daily goal",
    options: [
      { label: "Faster decisions", description: "Surface the right context so I can decide quickly" },
      { label: "Track everything", description: "Nothing falls through — people, projects, commitments" },
      { label: "Write in my voice", description: "Match my tone and thinking from past notes" },
      { label: "All of the above", description: "I want the full compounding system" }
    ]
  }
]
```

---

## GENERATION — After all 3 screens

### Step 1: Create folders with Bash

Run mkdir adapted to their role:

- Business Owner → `mkdir -p inbox daily people operations decisions projects archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/standup`
- Developer → `mkdir -p inbox daily projects research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/project`
- Consultant → `mkdir -p inbox daily clients projects research archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/client`
- Creator → `mkdir -p inbox daily content research clients archive scripts .claude/skills/daily .claude/skills/tldr .claude/skills/content`

### Step 2: Write vault-context.md

Write `vault-context.md` to the current directory. This is the vault's identity file — NOT a CLAUDE.md.

```markdown
# About Me

[1-2 paragraphs — personal, specific, based on all their answers]

# My Vault Structure

[Folder tree with one-line purpose per folder]

# How I Work

[3-4 specific facts about their work style based on answers — capture style, decision frequency, scope preference, pain points]

# Context Rules

When I'm working on [primary domain]: → Check [most relevant folder] first
When I mention a [client/person/project]: → Look in [relevant folder] for context
When I ask you to write something: → Read recent daily/ notes to match my voice
```

### Step 3: Write skill files

Write `/daily`, `/tldr`, and the role-specific skill directly to `.claude/skills/`.

Role-specific skills:
- Business Owner → `/standup` in `.claude/skills/standup/SKILL.md`
- Developer → `/project` in `.claude/skills/project/SKILL.md`
- Consultant → `/client` in `.claude/skills/client/SKILL.md`
- Creator → `/content` in `.claude/skills/content/SKILL.md`

### Step 4: Write memory.md

```markdown
# Memory

## Session Log
[Updated by Claude Code after each session]

## My Preferences
[Added as Claude learns them]
```

### Step 5: Output — clean and scannable

```
Your vault is set up.

[actual folder tree]

vault-context.md is your vault's identity file — Claude reads it to know
who you are, how you work, and where things live. You never have to
re-explain yourself.

To wire it into any project, add this one line to that project's CLAUDE.md:

  At the start of every session, read [absolute path]/vault-context.md
  for full context about who I am, my work, and my conventions.

Your slash commands:
  /daily      — start your day with vault context
  /tldr       — save any session to the right folder  
  /[role cmd] — [one line description]

If you have files to import:
  python scripts/process_docs_to_obsidian.py ~/your-files inbox/
  Then: "Sort everything in inbox/ into the right folders"
```

No walls of text. Scannable in 20 seconds.
