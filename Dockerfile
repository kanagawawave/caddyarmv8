FROM --platform=linux/arm64/v8 caddy:builder-alpine  AS builder

# Install additional packages if needed (check xcaddy requirements)
RUN apk add --no-cache

# Build caddy with plugins
RUN xcaddy build \
  --with github.com/mholt/caddy-l4 \
  --with github.com/caddy-dns/cloudflare

# Build final image
FROM caddy:latest

# Copy caddy from builder
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
