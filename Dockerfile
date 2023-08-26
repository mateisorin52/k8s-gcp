# Stage 1: Build the application
FROM --platform=linux/amd64 node:16 AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Run the application
FROM --platform=linux/amd64 node:16
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
CMD [ "node", "dist/main.js" ]