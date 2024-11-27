#!/bin/bash

# Script Vars
DOMAIN_NAME="ju.rahem.dev"
EMAIL="reza.rahem224@gmail.com" 
REPO_URL="https://github.com/rezarahem/deploy-nextjs.git"
APP_DIR=~/myapp

# Clone the Git repository
if [ -d "$APP_DIR" ]; then
  echo "Directory $APP_DIR already exists. Pulling latest changes..."
  cd $APP_DIR && git pull
else
  echo "Cloning repository from $REPO_URL..."
  git clone $REPO_URL $APP_DIR
  cd $APP_DIR
fi

# Build and run the Docker containers from the app directory (~/myapp)
cd $APP_DIR
sudo docker-compose up --build -d

# Check if Docker Compose started correctly
if ! sudo docker-compose ps | grep "Up"; then
  echo "Docker containers failed to start. Check logs with 'docker-compose logs'."
  exit 1
fi


echo "Deployment complete. Your Next.js app and PostgreSQL database are now running. 
Next.js is available at https://$DOMAIN_NAME, and the PostgreSQL database is accessible from the web service."