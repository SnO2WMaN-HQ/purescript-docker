FROM node:16 AS builder
WORKDIR /app

RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

COPY pnpm-lock.yaml ./
RUN pnpm fetch --dev

COPY package.json ./
RUN pnpm install --offline --dev

COPY packages.dhall spago.dhall ./
COPY src ./src
RUN pnpm run build

FROM node:16-slim AS runner
WORKDIR /app

ENV PORT 8080

COPY --from=builder /app/dist ./dist

EXPOSE $PORT

CMD ["node", "dist/main.js"]