# Reporting Engine - Frontend Application

Standalone React frontend for the Reporting Engine. Provides UI for report designer, viewer, scheduling, and analytics.

## Quick Start

### Prerequisites
- Node.js 20+
- Docker & Docker Compose (for containerized deployment)

### Development

```bash
# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Development server (with hot reload)
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

### Docker Deployment

```bash
# Build and start with Docker Compose
docker-compose up -d --build

# View logs
docker-compose logs -f frontend

# Stop services
docker-compose down
```

## Environment Variables

See `.env.example` for all available options.

Key variables:
- `VITE_API_URL` - Backend API URL (default: http://localhost:8080/api/v1)
- `NODE_ENV` - production or development
- `VITE_API_TIMEOUT` - API request timeout in ms

## Available Scripts

- `npm run dev` - Start development server with Vite
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Check code quality
- `npm run test` - Run tests
- `npm run format` - Format code with Prettier

## Build Output

```
dist/
├── index.html
├── assets/
│   ├── js/
│   ├── css/
│   └── images/
└── ...
```

## Deployment

### Docker Compose (Recommended)

```bash
docker-compose up -d --build
```

Access at: http://localhost:3000

### Docker Build Only

```bash
docker build -t reporting-frontend:latest .
docker run -p 3000:3000 reporting-frontend:latest
```

### Static Hosting

The `dist/` folder contains static files that can be deployed to any static hosting service:
- AWS S3 + CloudFront
- Netlify
- Vercel
- GitHub Pages
- Nginx

```bash
# Build first
npm run build

# Upload dist/ folder to your hosting service
```

### Nginx Configuration

```nginx
server {
    listen 3000;
    server_name localhost;

    root /usr/share/nginx/html;
    index index.html;

    # SPA routing - send all requests to index.html
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy (optional)
    location /api/ {
        proxy_pass http://backend:8080/api/;
    }
}
```

## Features

- 📊 **Report Designer** - Create custom reports with drag-and-drop
- 👀 **Report Viewer** - View and interact with reports
- 📈 **Analytics** - Statistical analysis and forecasting
- 📅 **Scheduling** - Schedule report generation and delivery
- 📥 **Export** - Export reports in multiple formats (PDF, Excel, etc.)
- 🔒 **Authentication** - Secure login with JWT
- 📱 **Responsive** - Works on desktop, tablet, and mobile

## Technology Stack

- React 18
- TypeScript
- Redux Toolkit (state management)
- Material-UI (component library)
- Vite (build tool)
- Recharts (data visualization)

## Performance

- Lazy loading of routes
- Code splitting for smaller bundles
- Optimized images
- CSS minification
- JavaScript minification and compression

## Production Checklist

- [ ] Set `NODE_ENV=production`
- [ ] Update `VITE_API_URL` to production backend
- [ ] Disable debug logging
- [ ] Enable security headers (CSP, X-Frame-Options, etc.)
- [ ] Setup CORS properly
- [ ] Configure SSL/TLS
- [ ] Setup monitoring and error tracking
- [ ] Test on multiple browsers

## Support

For issues or questions, check the main project documentation.
