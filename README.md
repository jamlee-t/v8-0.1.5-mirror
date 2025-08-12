# v8-0.1.5-mirror

编译步骤

```bash
# 禁止 warn 当做 error
sed -i 's/-Werror//g' src/SConscript 

# 镜像已替换好 old-release 镜像源
docker pull navit/ubuntu:8.04

# 安装必备软件
# scons: v0.97.0d20071203.r2509。
# g++: 4.2
apt-get install build-essential scons

# 编译
scons

# 或者编译 debug 版本 scons mode=debug

# 编译 shell
g++ -I. -L./release -o shell shell.cc -lv8 -lpthread -lrt
```