# Command

- How to build a docker image

```
packer build -var-file=./vars.hcl .
packer build -var-file=./vars.json .
```

- Remove \<none> tag image

```
docker rmi $(docker images -a|grep "<none>"|awk '$1=="<none>" {print $3}')
```
