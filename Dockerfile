FROM node:14

COPY frontend/build /usr/share/nginx/html

EXPOSE 3000


