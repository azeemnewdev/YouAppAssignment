FROM node:18-alpine

WORKDIR /usr/src/app

# Copy root package files and install deps
COPY package*.json ./
# COPY yarn.lock ./

# RUN yarn install --production
RUN npm install --production

# Copy dist output for app and library
COPY dist/apps/youapp-api-gateway ./dist/apps/youapp-api-gateway
COPY dist/libs/data-library ./dist/libs/data-library

WORKDIR /usr/src/app/dist/apps/youapp-api-gateway

EXPOSE 3000

CMD ["node", "main.js"]