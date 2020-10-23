FROM caddy:2.1.1-alpine
WORKDIR /app

RUN wget https://raw.githubusercontent.com/MoeClub/OneList/master/Rewrite/amd64/linux/OneList && \
    chmod +x OneList
COPY Caddyfile /app/Caddyfile
COPY index.html /app/index.html
ADD start.sh /start.sh

EXPOSE 443 80
ENTRYPOINT ["sh","/start.sh"]