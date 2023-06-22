FROM node:18-alpine
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/app
COPY package.json yarn.lock .env.example ./
COPY . .
ENV PATH /opt/node_modules/.bin:$PATH
RUN npm install -g knex
RUN yarn install --immutable
EXPOSE 80
CMD ["yarn", "start"]
