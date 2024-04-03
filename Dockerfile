# Step 1: Start with a base image
FROM node:18.12.1 as build

# Step 2: Set a working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of your application
COPY . .

# Step 6: Build the application
RUN npm run build

# Step 7: Start with a base image for the server
FROM nginx:1.21.6-alpine

# Step 8: Copy the build output to replace the default nginx contents.
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start Nginx
CMD ["nginx", "-g", "daemon off;"]
