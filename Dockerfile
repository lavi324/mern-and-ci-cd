FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY frontend/package*.json .

# Copy the entire frontend directory to the working directory
COPY frontend/ ./

# Expose the port that the app will run on
EXPOSE 3000
