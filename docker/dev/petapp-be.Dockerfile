FROM node:17.5.0-alpine3.15 as build
WORKDIR /tmp
COPY petapp-be/package*.json ./
COPY petapp-be/tsconfig*.json ./
RUN yarn install
COPY petapp-be/src ./src
COPY petapp-be/.env ./.env
RUN yarn build
FROM build as runner
RUN yarn add pm2 -g
WORKDIR /app
COPY --from=build /tmp/node_modules ./node_modules
COPY --from=build /tmp/dist ./dist
COPY petapp-be/ecosystem.config.js ./ecosystem.config.js
COPY petapp-be/.env ./.env
ENV PORT=4000
EXPOSE 4000
ENTRYPOINT [ "npx","pm2","start","ecosystem.config.js","--no-daemon"]