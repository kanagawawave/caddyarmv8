# Description: Dockerfile for building caddy with plugins
FROM arm64v8/caddy:builder-alpine AS builder

# Install additional packages if needed (check xcaddy requirements)
RUN apk add --no-cache

# Build caddy with plugins
RUN xcaddy build \
  --with github.com/mholt/caddy-l4 \
  --with github.com/caddy-dns/cloudflare

# Build final image
FROM arm64v8/caddy:alpine

# Copy caddy from builder
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
