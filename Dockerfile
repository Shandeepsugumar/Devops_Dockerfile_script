# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy the entire WP folder into the Nginx web server directory
COPY ./index.html /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80
