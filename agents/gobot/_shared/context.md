# Jiji — Contesto Condiviso

Questo file è letto da TUTTI gli agenti. Contiene informazioni cross-agent.

## Architettura Jiji

Jiji è un unico assistente che opera su due canali:
- **VPS (GoBot)** — Telegram bot, always-on, Anthropic API
- **Mac (Panthera)** — Claude Code, coding pesante, filesystem locale

Entrambi leggono e scrivono nello STESSO vault (second-brain).
La memoria è condivisa: facts, goals, contacts, knowledge, session logs.
Quello che uno impara, l'altro lo sa.

## Decisioni recenti

- [2026-03-18] Integrazione vault completata: Panthera (Mac) ora usa lo stesso vault di GoBot (VPS). Un unico Jiji, due canali.

## Note operative

_(nessuna ancora)_
