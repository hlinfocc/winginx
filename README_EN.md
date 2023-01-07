Nginx for Windows
=================

[![GitHub release](https://img.shields.io/github/v/tag/hlinfocc/winginx.svg?label=release)](https://github.com/hlinfocc/winginx/releases)
[![GitHub release](https://img.shields.io/badge/Download-cf2727)](https://github.com/hlinfocc/winginx/releases)

[中文文档](README.md) | [README](README_EN.md)


Nginx for Windows is an installer that set up a Nginx instance
running as a service under Microsoft Windows platforms. 
The Nginx version will be downloaded in compilation time from Nginx's official site - http://nginx.org/
To achieve service behaviour it uses the "Non Sucking Service Manager" - http://nssm.cc/

Usage
-----

In order to build this script, you must have NSIS installed. Under Debian/Ubuntu:

```
apt-get install nsis
```
Afterwards, just build the NSIS script:

Execute `build.sh` to automatically build the mainline version and stable version

```
$ build.sh
```

 > If you are prompted that you do not have permission, please execute `chmod +x build.sh` to grant executable permission

A binary called `nginx-service-mainline-\*.exe` and `nginx-service-stable-\*.exe` (\* is nginx version)will be created inside the "build" folder and can be installed on
any Windows 32&64 bits by just double clicking on it.


New versions
------------

In order to use a newer version of Nginx or NSSM, you need to edit the `build.sh` file, modify the version number variable at the beginning, and select the appropriate version number:

```
#NGINX主线版本(Mainline version)
nginx_mainline_version=X.Y.Z
#NGINX稳定版本(Stable version)
nginx_stable_version=I.J.K
#NSSM版本(NSSM version)
NSSM_VERSION=M.N
```

The X.Y.Z is Nginx Mainline Version,eg:1.23.3.

The I.J.K is Nginx Stable version,eg:1.22.1.

The M.N is NSSM Version,eg: 2.24.

Notice
--------

The post installation configuration file is located in the conf directory under the installation directory, and the website configuration is located in nginx Conf.d directory
