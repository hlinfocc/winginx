适用于Windows系统的Nginx安装程序
==========================

[![GitHub release](https://img.shields.io/github/v/tag/hlinfocc/winginx.svg?label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC)](https://github.com/hlinfocc/winginx/releases)
[![GitHub release](https://img.shields.io/badge/%E7%AB%8B%E5%8D%B3%E4%B8%8B%E8%BD%BD-cf2727)](https://github.com/hlinfocc/winginx/releases)

[中文文档](README.md) | [README](README_EN.md)


Nginx for Windows 是一个将 Nginx 在 Microsoft Windows 平台下作为服务运行的安装程序。
Nginx 版本会在编译时从 Nginx 官网下载 - http://nginx.org/
为了实现服务行为，它使用“Non Sucking Service Manager” - http://nssm.cc/ 

## 如何使用？

本程序依赖需NSIS，要安装NSIS，在Debian/Ubuntu/Deepin下:

### 0.安装NSIS依赖

```
apt-get install nsis
```

安装之后，只需构建 NSIS 脚本即可

nsis也可以到官网下载编译。


## 1.修改/升级版本

为了使用较新的 Nginx 或 NSSM版本，需要编辑 build.sh 文件，修改开头部分版本号变量，选择适当的版本号： 

```
#NGINX主线版本(Mainline version)
nginx_mainline_version=X.Y.Z
#NGINX稳定版本(Stable version)
nginx_stable_version=I.J.K
#NSSM版本(NSSM version)
NSSM_VERSION=M.N

```

X.Y.Z为nginx的版本号,例如：1.23.3

I.J.K为nginx的版本号,例如：1.22.1

M.N为NSSM版本号,例如：2.24

### 2.构建

执行build.sh即可自动构建主线版本和稳定版本

```
$ build.sh
```

 > 如果提示没有权限，请执行`chmod +x build.sh`，授可执行权限

构建后的名为`nginx-service-mainline-\*.exe`和`nginx-service-stable-\*.exe`的二进制文件位于“build”文件夹中（其中\*为nginx的版本号），并且可以安装在任何 Windows 32 和 64 位系统。


## 3.注意事项

安装后配置文件位于安装目录下的conf目录，网站配置位于nginx.conf.d目录


