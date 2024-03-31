FROM nginx

COPY public/ /usr/share/nginx/html/public
COPY src/Unlight.swf /usr/share/nginx/html
