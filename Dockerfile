FROM node:lts-alpine

# make the 'app' folder the current working directory
WORKDIR /app

COPY package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# # build app for production with minification
RUN npm run build

EXPOSE 8080

# aktifkan production
# CMD [ "http-server", "dist" ]

# aktifkan development
CMD ["npm", "run", "dev"]
