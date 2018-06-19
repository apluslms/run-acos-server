A Docker container that runs the [ACOS server](https://github.com/acos-server/acos-server)
exposed to port 8080.

The container may be used on its own to test exercises directly in the ACOS server,
or it may be used as an exercise service to
[the A+ frontend](https://hub.docker.com/r/apluslms/run-aplus-front/)
([repository](https://github.com/apluslms/run-aplus-front) and
[source code](https://github.com/Aalto-LeTech/a-plus)).

The image is intended for local testing and development, not for production.

The `package.json` file in this repository is used to install additional
ACOS content types and packages as NPM modules to the container. It replaces
the original package.json file in the ACOS server repository.

It is possible to mount ACOS content types and/or packages from the host machine
into the container in case you want to run and test them in the container while
developing them.

### Usage

Partial example of `docker-compose.yml`:

```yaml
version: '3'

services:
  acos:
    image: apluslms/run-acos-server
    ports:
      - "3000:3000"
    volumes:
      # mount the log directory so that logs are stored in the host directory (optional)
      # mounting the log directory does not work due to file permission issues, i.e.,
      # the acos server process has no permissions to write to the directory if
      # a bind mount is in use
      #- ./_data/acos/:/var/log/acos
      # mount packages under development from the native host (optional)
      - /host/path/to/acos-mycontentpackage/:/usr/src/acos-server/node_modules/acos-mycontentpackage
      - /host/path/to/acos-mycontenttype/:/usr/src/acos-server/node_modules/acos-mycontenttype
```

