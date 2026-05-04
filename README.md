# PandaProbe — AI Agent Observability on Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template/TEMPLATE_CODE)

Deploy [PandaProbe](https://pandaprobe.com), the open-source AI agent engineering platform, on Railway with one click. Trace, evaluate, and monitor your AI agents across LangGraph, CrewAI, Claude Agent SDK, and OpenAI Agents SDK.

## What's Included

| Service | Image | Purpose |
|---|---|---|
| **App** | `ghcr.io/chirpz-ai/pandaprobe-backend` | FastAPI backend + API |
| **Worker** | Same image, Celery worker | Background task processing |
| **Beat** | Same image, Celery beat | Scheduled task runner |
| **Frontend** | `ghcr.io/chirpz-ai/pandaprobe-frontend` | Next.js dashboard UI |
| **PostgreSQL** | Railway Managed | Traces, evals, metrics storage |
| **Redis** | Railway Managed | Celery job queue + caching |

## How to Deploy

1. Click the "Deploy on Railway" button
2. Railway provisions all 6 services automatically
3. Open the frontend URL to access the dashboard
4. Install the Python SDK: `pip install pandaprobe`
5. Add `instrument()` to your agent code and start tracing

## Estimated Cost

~$10-15/month on Railway (4 app services + 2 managed databases).

## License

PandaProbe is licensed under [Apache 2.0](https://github.com/chirpz-ai/pandaprobe/blob/main/LICENSE).
