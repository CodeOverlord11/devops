# Use lightweight nginx image
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your static site files into nginx's serve directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# nginx runs automatically — no CMD needed
