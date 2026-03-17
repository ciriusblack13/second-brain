---
category: reference
updated: 2026-03-17
tags: [infra, vps, gobot, openclaw]
---

# Infrastruttura tecnica

## VPS1 — GoBot (Panthera/Jiji)

- **IP:** 69.62.121.131
- **User:** jiji
- **Process manager:** PM2
- **Bot Telegram:** @pantera_g10x_bot
- **Architettura:** Hybrid mode — webhook Telegram → VPS → Cloudflare tunnel → Mac (Claude Code CLI). Fallback: OpenRouter su VPS.
- **Database:** Convex (primary), Supabase (fallback)
- **Agenti:** General, CEO, CFO, CMO, Research, Critic, CTO, COO

## VPS2 — OpenClaw

- **IP:** 187.124.22.190
- **User:** openclaw (SSH key auth)
- **Service:** systemd `openclaw-gateway`
- **Reverse proxy:** Traefik SSL su openclaw.g10x.pro (porta 18789)
- **Bot Telegram:** @jiji_g10x_bot
- **Modello:** openai-codex/gpt-5.2
- **Rabbit R1** connesso via WSS

## Hardware

- Rabbit R1 — comprato al lancio, connesso a OpenClaw gateway su VPS2 come interfaccia vocale/AI portatile
- Cercando MacBook Pro usato M1 Pro/Max 32GB per setup portatile (Capo Verde)
