FROM nginx:1.21.3-alpine

EXPOSE 80

COPY ./build/web /usr/share/nginx/html