# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node

# Expose n8n port
EXPOSE 5678

# Create n8n data directory as root and set ownership
USER root
RUN mkdir -p /mnt/mydisk/n8nData \
    && chown -R node:node /mnt/mydisk/n8nData

# Switch back to non-root user
USER node

# Copy .env file if you want to include local env variables (optional)
COPY .env .env

# Set environment variables
# NOTE render doesn't support IPv6
ENV GENERIC_TIMEZONE=Europe/Berlin \
    N8N_BASIC_AUTH_ACTIVE=false \
    N8N_USER_MANAGEMENT_DISABLED=true \
    N8N_SECURE_COOKIE=false \
    N8N_DISABLE_UI_LOGIN=true \
    N8N_HOST=n8n-self-hosted-hhe2.onrender.com  \
    N8N_PORT=443 \
    N8N_PROTOCOL=https \
    N8N_BLOCK_ENV_ACCESS_IN_NODE=false \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_USER_FOLDER=/mnt/mydisk/n8nData \
    WEBHOOK_TUNNEL_URL=https://n8n-self-hosted-hhe2.onrender.com \
    WEBHOOK_URL=https://n8n-self-hosted-hhe2.onrender.com \
    N8N_EDITOR_BASE_URL=https://n8n-self-hosted-hhe2.onrender.com \
    DB_TYPE=postgresdb \
    DB_POSTGRESDB_HOST=aws-1-eu-central-1.pooler.supabase.com \
    DB_POSTGRESDB_PORT=6543 \
    DB_POSTGRESDB_DATABASE=postgres \
    DB_POSTGRESDB_USER=postgres.nwymkghybangtxtrbfdc \
    DB_POSTGRESDB_SCHEMA=public \
    DB_POSTGRESDB_SSL=true \
    DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

# Mount persistent folder (for Render, configure Persistent Disk in the dashboard)
VOLUME ["/mnt/mydisk/n8nData"]

# Use the official n8n entrypoint; CMD can be left out or use "start"
ENTRYPOINT ["tini", "--", "n8n"]
CMD ["start"]

