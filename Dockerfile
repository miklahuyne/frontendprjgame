# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Build Next.js
RUN npm run build

# ---------- Run stage ----------
FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=10000

COPY --from=builder /app ./

EXPOSE 10000

CMD ["npm", "start"]
