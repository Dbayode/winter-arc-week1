FROM node:22-alpine

WORKDIR /app

COPY --chown=node:node app/package.json ./
COPY --chown=node:node app/server.js ./

USER node

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/node"]

CMD ["server.js"]
