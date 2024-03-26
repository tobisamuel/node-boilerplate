# build
FROM node:20.11.1 AS build
WORKDIR /build
RUN npm install -g pnpm
COPY . ./
RUN pnpm i && pnpm run build
COPY . .


# runtime
FROM alpine:3.19
RUN apk add --update nodejs
RUN addgroup -S node && adduser -S node -G node
USER node

RUN mkdir /home/node/app
WORKDIR /home/node/app
COPY --from=build --chown=node:node /build .

EXPOSE 3000

CMD [ "node", "dist/index.js" ]
