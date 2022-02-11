# mwb-dummy

Simple docker image to execute mysql-workbench script inside a dummy desktop.

Sould be used as docker action.

## Example

```bash
docker build --tag mwb-dummy-desktop:latest -f Dockerfile . &&
docker run --name test -v "/mnt/d/develop/test/xubuntu/test:/var/mwb" mwb-dummy-desktop:latest mysql-workbench --version
```