# Frontend Application - Deployment Guide

## Quick Deployment

### Option 1: Docker Compose (Easiest)

```bash
cd frontend-app

# Copy environment file
cp .env.example .env

# Edit .env if needed (default connects to localhost:8080)
nano .env

# Start frontend
docker-compose up -d --build

# View logs
docker-compose logs -f
```

Access app at: `http://localhost:3000`

### Option 2: Local Development

```bash
cd frontend-app

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Run development server with hot reload
npm run dev
```

The dev server will start at `http://localhost:5173` with automatic reloading.

### Option 3: Docker Build Only

```bash
cd frontend-app

# Build image
docker build -t reporting-frontend:latest .

# Run container
docker run -p 3000:3000 reporting-frontend:latest
```

### Option 4: Static Deployment

```bash
# Build production bundle
npm run build

# Upload contents of dist/ folder to your hosting:
# - AWS S3 + CloudFront
# - Netlify
# - Vercel
# - GitHub Pages
# - Your own web server
```

## Environment Configuration

1. Copy `.env.example` to `.env`
2. Update API URL if needed:
   ```bash
   VITE_API_URL=https://api.yourdomain.com/api/v1
   ```

## Production Deployment

### Using Static Hosting (AWS S3 + CloudFront)

```bash
# Build
npm run build

# Upload to S3
aws s3 cp dist/* s3://your-bucket/ --recursive

# Invalidate CloudFront
aws cloudfront create-invalidation --distribution-id YOUR_ID --paths "/*"
```

### Using Vercel

```bash
npm install -g vercel

# Deploy
vercel
```

### Using Netlify

```bash
npm install -g netlify-cli

# Deploy
netlify deploy --prod
```

### Using Docker on Your Server

```bash
# Build image
docker build -t reporting-frontend:1.0.0 .

# Push to registry
docker push your-registry/reporting-frontend:1.0.0

# On server: docker-compose up
# Update image tag in docker-compose.yml
```

## SSL/TLS Configuration

### Using Nginx

```nginx
server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    root /usr/share/nginx/html;
    index index.html;

    # Serve static files
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 365d;
        add_header Cache-Control "public, immutable";
    }

    # SPA routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy
    location /api/ {
        proxy_pass http://backend:8080/api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Using Let's Encrypt with Docker

```bash
docker run -it --rm -v /etc/letsencrypt:/etc/letsencrypt \
  certbot/certbot certonly -d yourdomain.com
```

## Performance Optimization

- [ ] Enable gzip compression
- [ ] Setup CDN for static files
- [ ] Enable browser caching (Cache-Control headers)
- [ ] Use minified production build
- [ ] Enable lazy code splitting
- [ ] Compress images

## Security Checklist

- [ ] Set CSP (Content Security Policy) headers
- [ ] Enable HTTPS/SSL
- [ ] Set X-Frame-Options header
- [ ] Set X-Content-Type-Options header
- [ ] Remove debug logging
- [ ] Validate all user input
- [ ] Sanitize HTML output (already done with DOMPurify)
- [ ] Test with backend CORS properly configured

## Monitoring & Logging

### Setup Error Tracking (Sentry)

```javascript
// In main.tsx
import * as Sentry from "@sentry/react";

Sentry.init({
  dsn: "YOUR_SENTRY_DSN",
  environment: import.meta.env.MODE,
  tracesSampleRate: 0.1
});
```

### Setup Application Monitoring

Use your preferred APM tool:
- Datadog
- New Relic
- Elastic APM

## Performance Metrics

After deployment, monitor:
- Lighthouse score (aim for 90+)
- Core Web Vitals
- API response times
- Error rate
- User engagement metrics

## Support

See README.md for more details.
