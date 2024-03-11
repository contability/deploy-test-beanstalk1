FROM node:13.12.0-alpine
WORKDIR ./
COPY package.json package-lock.json ./
RUN npm install 
COPY . ./
EXPOSE 5173