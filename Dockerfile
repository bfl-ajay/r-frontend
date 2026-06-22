# Reporting Engine - Frontend App
# Standalone Docker build

FROM node:20-alpine AS builder
WORKDIR /build

# Install system dependencies
RUN apk add --no-cache python3 make g++

# Copy package files
COPY package*.json ./
COPY tsconfig.json vite.config.ts ./

# Install dependencies
RUN npm ci --legacy-peer-deps

# Copy source code
COPY src ./src
COPY index.html ./

# Build with Vite
RUN npm run build

# Production stage - use nginx
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Copy built files from builder
COPY --from=builder /build/dist .

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
