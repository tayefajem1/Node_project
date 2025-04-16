FROM node:18-alpine

# Install build tools
RUN apk add --no-cache python3 make g++

# Create app directory and set ownership
WORKDIR /home/node/app
RUN mkdir -p node_modules && chown -R node:node /home/node/app

# Copy package files
COPY package*.json ./

# Install dependencies as root (optional: switch to USER node after)
RUN npm install

# Copy rest of the app
COPY --chown=node:node . .

# Switch to non-root user (after install)
USER node

EXPOSE 8080
CMD ["node", "app.js"]
