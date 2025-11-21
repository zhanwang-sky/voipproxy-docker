# voipproxy-docker

## 构建镜像

说明：\
`Dockerfile.base`用于构建基础镜像，安装必要的依赖库。

**构建基础镜像**
```shell
docker build -t voipproxy-base -f Dockerfile.base .
```

**构建服务镜像**
```shell
docker build -t voipproxy -f Dockerfile .
```
