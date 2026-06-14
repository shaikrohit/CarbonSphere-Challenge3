# Production Dockerfile for CarbonSphere on Google Cloud Run
FROM node:20-alpine

WORKDIR /app

# Copy dependency manifests
COPY package*.json ./

# Install all dependencies (including devDependencies needed for build)
RUN npm install

# Copy source code
COPY . .

# Compile optimized static bundle
RUN npm run build

# Install lightweight production static file server
RUN npm install -g serve

# Expose port
EXPOSE 8080

# Set environment for production runtime
ENV NODE_ENV=production

# Serve static site on port 8080 (Cloud Run default)
CMD ["serve", "-s", "dist", "-l", "8080"]
