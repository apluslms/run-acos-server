A Docker container that runs the [ACOS server](https://github.com/acos-server/acos-server)
exposed to port 3000.

The container may be used on its own to test exercises directly in the ACOS server,
or it may be used as an exercise service to
[the A+ frontend](https://hub.docker.com/r/apluslms/run-aplus-front/)
([repository](https://github.com/apluslms/run-aplus-front) and
[source code](https://github.com/apluslms/a-plus)).

The image is intended for local testing and development, not for production.

## Developing Acos

The `package.json` file in this repository is used to install additional
ACOS content types and packages as NPM modules to the container. It replaces
the original package.json file in the ACOS server repository.

It is possible to mount ACOS content types and/or packages from the host machine
into the container in case you want to run and test them in the container while
developing them. Likewise, ACOS logs may be stored in the host by mounting
the log directory.

During development it is also possible to run [Nodemon](https://nodemon.io/),
which allows to automatically reload the server when changes in the content
types and/or packages are detected (currently HTML, JS, JSON, CSS and XML files
are supported). By using nodemon it is possible to reduce the number of times
the docker container needs to be shut down and started again.

In order to use Nodemon you should add the `command: npm run dev`
option to the `docker-compose.yml` file

### Usage

Partial example of `docker-compose.yml`:

```yaml
version: '3'

services:
  acos:
    image: apluslms/run-acos-server
    ports:
      - "3000:3000"
    # set the user ID of the container process with environment variables (optional)
    #user: $USER_ID:$USER_GID
    volumes:
      # mount the log directory so that logs are stored in the host directory (optional)
      # the host directory should be created before starting the container so that
      # the host user has permission to modify the directory, especially if
      # the container process is executed with the user ID of the host user
      #- ./_data/acos/:/var/log/acos
      # mount packages under development from the native host (optional)
      - /host/path/to/acos-mycontentpackage/:/usr/src/acos-server/node_modules/acos-mycontentpackage
      - /host/path/to/acos-mycontenttype/:/usr/src/acos-server/node_modules/acos-mycontenttype
    # the command option is optional and intended for development purpouses of the Acos content types
    # or Acos packages. If the command option is removed the container will run node instead of nodemon
    # you can verify the available scripts in the package.json file
    command: npm run dev
```
