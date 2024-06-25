FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy the build directory to the working directory
COPY frontend/build .
	

# Expose the port that the app will run on
EXPOSE 3000
