FROM node:6-stretch

RUN mkdir /var/log/acos \
  && chmod 1777 /var/log/acos

# Create app directory
WORKDIR /usr/src/acos-server

# install acos-server itself
RUN git clone https://github.com/acos-server/acos-server.git . \
  && (echo "On branch $(git rev-parse --abbrev-ref HEAD)"; echo; git log -n5) > GIT \
  && rm -rf .git \
  && rm package-lock.json \
  && echo 'require("coffeescript/register");' | cat - app.js > temp && mv temp app.js

# At the moment, we need to add coffeescript manually to the beginning of app.js.
# In the future, the pointandclick and draganddrop content types will be distributed
# in compiled JavaScript format so that coffeescript is not needed.


# copy a modified package.json file of the acos-server
# it has additional dependencies in order to install more content types and content packages
COPY package.json ./
COPY config.js ./
RUN rm -rf node_modules \
  && npm install --only=production
# no devDependencies installed from package.json

VOLUME /var/log/acos
EXPOSE 3000

CMD [ "npm", "start" ]

