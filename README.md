# GOGS

To be used as submodule to other compose projects to provide local git server

## Usage (in other compose projects)

```
git submodule add https://github.com/hpcsc/gogs
git submodule update --init
```

This gogs submodule expects parent project to provide 2 environment variables `GOGS_VERSION` and `POSTGRES_VERSION` for docker-compose file

When using with parent project, `docker-compose.gogs.yml` needs to be passed in explicitly to docker-compose command (or set `COMPOSE_FILE` variable)

## Examples of usage

- [https://github.com/hpcsc/teamcity](https://github.com/hpcsc/teamcity)
- [https://github.com/hpcsc/gocd](https://github.com/hpcsc/gocd)
