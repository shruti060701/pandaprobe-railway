FROM ghcr.io/chirpz-ai/pandaprobe-backend:latest

USER root

CMD ["/app/.venv/bin/celery", "-A", "app.infrastructure.queue.celery_app", "worker", "--loglevel=info", "--autoscale=10,2"]
