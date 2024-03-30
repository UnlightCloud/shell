FROM nginx

COPY public/ /usr/share/nginx/html
COPY src/Unlight.swf /usr/share/nginx/html
