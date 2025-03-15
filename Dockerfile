FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf  # ✅ This line ensures Nginx uses your custom config

COPY --from=build /app/dist/ecommerce_frontend /usr/share/nginx/html

EXPOSE 80
