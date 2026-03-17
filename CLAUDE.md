# Second Brain — Vault Multi-Agente

Questo vault è la memoria persistente per José e i suoi agenti AI.

## Struttura

```
me/          → Zona personale José (daily, projects, journal, inbox)
shared/      → Leggibile da tutti gli agenti (profile, goals, contacts, knowledge)
agents/      → Memoria per agente
  gobot/     → Agenti GoBot (general, research, content, finance, strategy, critic, cto, coo)
  nanoclaw/  → Agenti NanoClaw (futuro)
```

## Regole di accesso

- **GoBot agenti:** leggono `shared/` + `agents/gobot/{proprio-nome}/` + `agents/gobot/_shared/`. Scrivono SOLO nella propria cartella.
- **GoBot General (orchestratore):** può leggere TUTTE le cartelle `agents/gobot/`.
- **NanoClaw (futuro):** legge `shared/` + `agents/nanoclaw/`. Scrive solo in `agents/nanoclaw/`.
- **José:** accede a tutto.

## Convenzioni

- Ogni agente mantiene un `session.md` con log delle ultime sessioni
- I fatti permanenti vanno in `shared/knowledge/`
- Gli obiettivi vanno in `shared/goals.md`
- Il formato data è YYYY-MM-DD
- I file markdown usano frontmatter YAML quando utile

## Quando scrivi in questo vault

1. Prima leggi il file esistente per non sovrascrivere
2. Appendi, non sostituire (tranne goals.md che va aggiornato in-place)
3. Aggiungi timestamp a ogni entry
