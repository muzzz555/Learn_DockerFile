# node (builder) (stage 1)
FROM node:16-alpine AS builder
WORKDIR /usr/astro
COPY ./package* .
RUN npm install
COPY . .
RUN npm run build

# alpine run nginx (stage 2)
FROM nginx:1-alpine
WORKDIR /usr/share/nginx/html

# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
# RUN cp -r /usr/astro/dist/* /usr/share/nginx/html
COPY --from=builder /usr/astro/dist /usr/share/nginx/html/
EXPOSE 80

# 0. npm install (window --> Debian)
# 1. npm run build  (window --> Docker)
# 2. docker build . (Docker)
# 3.docker run -p 80:80 (Docker)
