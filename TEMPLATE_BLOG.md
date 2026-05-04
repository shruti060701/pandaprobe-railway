# Deploy and Host PandaProbe-self-hosted on Railway

PandaProbe is an open-source observability platform built specifically for AI agents. It captures traces, runs evaluations, and tracks metrics across your agent workflows — whether you're using LangGraph, CrewAI, Claude Agent SDK, or OpenAI Agents SDK. One `instrument()` call, and you can see every LLM call, tool invocation, and token count your agent makes.

## About Hosting PandaProbe-self-hosted

If you're building AI agents in production, you already know the debugging problem. An agent calls an LLM, which calls a tool, which calls another LLM — and when something breaks, you're reading raw logs trying to reconstruct what happened. PandaProbe fixes that with automatic trace capture. Self-hosting on Railway means your agent traces, API keys, and customer data never leave your infrastructure — critical for teams handling sensitive workflows in healthcare, finance, or legal. This template deploys the full PandaProbe stack: FastAPI backend, Celery workers, Next.js dashboard, PostgreSQL, and Redis. Railway handles SSL, private networking between services, and container restarts. Total cost runs ~$10-15/month for all six services, compared to $29-299/month for PandaProbe Cloud.

## Common Use Cases

- **Agent debugging in production** — When your LangGraph agent gives a wrong answer at 3am, you don't want to reproduce it locally. PandaProbe captures the full trace — every LLM call, tool response, and decision branch — so you can replay exactly what happened from the dashboard
- **LLM cost tracking across agents** — Token counts add up fast when agents chain multiple LLM calls. PandaProbe tracks token usage per trace, per agent, per model, so you can spot which workflows are burning through your OpenAI budget before the invoice arrives
- **Evaluation pipelines for agent quality** — Run automated evals against your agent responses using built-in scoring. Compare model performance (GPT-4o vs Claude vs Gemini) on the same tasks with actual production data, not synthetic benchmarks
- **Multi-framework observability** — Running LangGraph for some agents and CrewAI for others? PandaProbe traces both with the same SDK. One dashboard for your entire agent fleet, regardless of framework
- **Compliance and audit trails** — Regulated industries need to prove what their AI did and why. PandaProbe's trace history gives you a timestamped, searchable record of every agent decision — exactly what auditors ask for

## Dependencies for PandaProbe-self-hosted Hosting

- **PostgreSQL** — Stores trace data, evaluation results, user accounts, and project metadata. Railway provisions this automatically with persistent storage and private networking
- **Redis** — Powers the Celery job queue for background trace processing and scheduled evaluations. Railway manages this with persistent storage

### Deployment Dependencies

- [PandaProbe Official Website](https://pandaprobe.com)
- [PandaProbe Documentation](https://docs.pandaprobe.com)
- [PandaProbe GitHub Repository](https://github.com/chirpz-ai/pandaprobe)
- [PandaProbe Python SDK](https://github.com/chirpz-ai/pandaprobe-sdk)

### Implementation Details

This template deploys four application services from pre-built GHCR images, plus two Railway-managed databases:

```
# Backend API (FastAPI)
Image: ghcr.io/chirpz-ai/pandaprobe-backend:latest
Port: 8000
Health: /health

# Worker (Celery) — same image, different command
CMD: celery -A app.infrastructure.queue.celery_app worker --autoscale=10,2

# Beat (Celery scheduler) — same image, different command
CMD: celery -A app.infrastructure.queue.celery_app beat

# Frontend (Next.js dashboard)
Image: ghcr.io/chirpz-ai/pandaprobe-frontend:latest
Port: 3000
```

The backend, worker, and beat services share the same environment variables for PostgreSQL and Redis connections, auto-wired through Railway's template variable references. LLM provider keys (OpenAI, Anthropic, Gemini) are optional — add them in Railway's Variables tab only for the providers you actually use.

## Why Deploy PandaProbe-self-hosted on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying PandaProbe-self-hosted on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
