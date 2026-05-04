FROM ghcr.io/chirpz-ai/pandaprobe-frontend:latest

USER root

ENV PORT=3000

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 3000

ENTRYPOINT []
CMD ["sh", "/app/start.sh"]
