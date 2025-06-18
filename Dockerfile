# Stage 1 skipped because there's no build process

# Stage 2: Serve static content with nginx
FROM nginx:alpine

# Set working directory to nginx web root
WORKDIR /usr/share/nginx/html

# Remove default nginx content
RUN rm -rf ./*

# Copy static files into nginx web root
COPY . .

# Expose port 80 (optional if running with -p)
EXPOSE 80
