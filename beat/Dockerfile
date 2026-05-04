FROM ghcr.io/chirpz-ai/pandaprobe-backend:latest

USER root

ENV APP_ENV=development

CMD ["/app/.venv/bin/celery", "-A", "app.infrastructure.queue.celery_app", "beat", "--loglevel=info"]
