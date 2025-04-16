# Use an official Node.js 10 image with Alpine for a small footprint
FROM node:10-alpine

# Create app directory and set correct ownership for non-root user
RUN mkdir -p /home/node/app/node_modules && \
    chown -R node:node /home/node/app

# Set working directory
WORKDIR /home/node/app

# Copy dependency files and change user before running npm install
COPY package*.json ./

# Switch to the non-root user
USER node

# Install dependencies
RUN npm install

# Copy the rest of the application files with proper ownership
COPY --chown=node:node . .

# Expose application port
EXPOSE 8080

# Run the application
CMD [ "node", "app.js" ]

