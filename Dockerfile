FROM node:argon

# Create app directory
RUN mkdir /frontend
WORKDIR /frontend

# Install app dependencies
COPY package.json /frontend
COPY bower.json /frontend
RUN npm install
RUN npm install -g bower
RUN bower install --allow-root

# Bundle app source
COPY . /frontend

EXPOSE 3000
CMD [ "npm", "start" ]
