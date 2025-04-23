# ---------- build stage ----------
    FROM node:20-bookworm-slim AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    COPY . .
    RUN npm run build
    
    # ---------- runtime stage ----------
    FROM node:20-bookworm-slim
    WORKDIR /app
    ENV NODE_ENV=production
    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/node_modules ./node_modules
    EXPOSE 3000
    CMD ["node", "dist/main.js"]