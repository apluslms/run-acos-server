FROM node:6-stretch

# Create app directory
WORKDIR /usr/src/app

# install acos-server itself
RUN git clone https://github.com/acos-server/acos-server.git . \
  && rm package-lock.json \
  && echo 'require("coffeescript/register");' | cat - app.js > temp && mv temp app.js

# At the moment, we need to add coffeescript manually to the beginning of app.js.
# In the future, the pointandclick and draganddrop content types will be distributed
# in compiled JavaScript format so that coffeescript is not needed.


# copy a modified package.json file of the acos-server
# it has additional dependencies in order to install more content types and content packages
COPY package.json ./
RUN npm install


EXPOSE 3000

CMD [ "npm", "start" ]

