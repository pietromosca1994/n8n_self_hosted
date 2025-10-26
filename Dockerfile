# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node

# Expose n8n port
EXPOSE 5678

# Copy .env file if you want to include local env variables (optional)
# COPY .env .env

# Set environment variables
ENV GENERIC_TIMEZONE=Europe/Berlin \
    N8N_BASIC_AUTH_ACTIVE=false \
    N8N_USER_MANAGEMENT_DISABLED=true \
    N8N_SECURE_COOKIE=false \
    N8N_DISABLE_UI_LOGIN=true \
    EXECUTIONS_PROCESS=worker \
    N8N_HOST=n8n-self-hosted-hhe2.onrender.com  \
    N8N_PORT=443 \
    N8N_PROTOCOL=https \
    N8N_RUNNERS_ENABLED=true \
    N8N_BLOCK_ENV_ACCESS_IN_NODE=false \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_USER_FOLDER=/mnt/mydisk/n8nData/.n8n \
    WEBHOOK_TUNNEL_URL=https://n8n-self-hosted-hhe2.onrender.com \
    WEBHOOK_URL=https://n8n-self-hosted-hhe2.onrender.com \
    N8N_EDITOR_BASE_URL=https://n8n-self-hosted-hhe2.onrender.com
    # DB_TYPE=postgresdb \
    # DB_POSTGRESDB_HOST=db \
    # DB_POSTGRESDB_PORT=5432 \
    # DB_POSTGRESDB_DATABASE=n8n \
    # DB_POSTGRESDB_USER=n8n \
    # DB_POSTGRESDB_PASSWORD=n8n

# Mount persistent folder (for Render, configure Persistent Disk in the dashboard)
VOLUME ["/mnt/mydisk/n8nData/.n8n"]

# Start n8n
CMD ["n8n"]
