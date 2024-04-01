FROM nginx

COPY res/public/ /usr/share/nginx/html/public
COPY Unlight.swf /usr/share/nginx/html
