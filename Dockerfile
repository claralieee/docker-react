# everything below this command is going to be under the builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
# second phase
# FROM statement terminates the previous phase
FROM nginx
# just communicate to other devs that needs mapping
# elastic beanstalk uses that as a port for incoming traffic
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html