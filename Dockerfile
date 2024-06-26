# Use the official Node.js image as the base image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY frontend/package*.json ./

# Copy the entire frontend directory to the working directory
COPY frontend/ ./

# Install serve to serve the built files
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000


