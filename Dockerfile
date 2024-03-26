FROM node:20.11.1-alpine3.18

RUN npm install -g pnpm

USER node

WORKDIR /home/node/app

COPY --chown=node:node package.json pnpm-lock.yaml ./

RUN pnpm i

COPY --chown=node:node . .

EXPOSE 3000

RUN pnpm run build

CMD [ "pnpm", "start" ]
