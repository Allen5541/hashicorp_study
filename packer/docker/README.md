# Command

- How to build a `docker` image

```bash
packer build -var-file=./vars.hcl .
packer build -var-file=./vars.json .
```

- Remove `<none>` tag image from `docker`

```bash
docker rmi $(docker images -a|grep "<none>"|awk '$1=="<none>" {print $3}')
```
