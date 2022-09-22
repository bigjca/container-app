FROM node:16 as build

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/* /usr/share/nginx/html/app/

# Copy nginx config
COPY nginx.conf  /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 9443