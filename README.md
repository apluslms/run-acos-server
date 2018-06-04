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


### Usage

Partial example of `docker-compose.yml`:

```yaml
version: '3'

services:
  acos:
    image: apluslms/run-acos-server
    ports:
      - "8070:3000"
```

