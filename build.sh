#!/bin/bash

#NGINX主线版本(Mainline version)
nginx_mainline_version=1.27.1
#NGINX稳定版本(Stable version)
nginx_stable_version=1.26.2
#NSSM版本(NSSM version)
NSSM_VERSION=2.24

#查看系统是否支持中文
ISZHCN=$(locale -a |grep "zh_CN" | wc -l)

ColorTextln()
{
  echo -e "\e[0;$2m $1\e[0m"
}
Echo()
{
    echo -e "${1}"
}
EchoRed()
{
    ColorTextln "${1}" "31"
}

EchoGreen()
{
    echo $(ColorTextln "$1" "32")
}
EchoBlue()
{
    echo $(ColorTextln "$1" "34")
}
EchoCN()
{
    if [ $ISZHCN -gt 0 ];then
        $1 "$2"
    else
        $1 "$3"
    fi
}

replaceVersion()
{
    if [[ $1 ]];then
        sed -i "s/\(NGINX_VERSION=\)\([0-9]*.[0-9]*.[0-9]*.\)/NGINX_VERSION=${1}/" ./Makefile
        sed -i "s/\(\!define\ PRODUCT_VERSION\ \)\(\"[0-9]*.[0-9]*.[0-9]*.\"\)/\!define\ PRODUCT_VERSION\ \"${1}\"/" ./src/nginx.nsi
    else
        EchoCN "EchoRed" "nginx版本号参数异常" "The nginx version number parameter is abnormal"
        exit 1
    fi
    if [[ $2 ]];then
        sed -i "s/\(NSSM_VERSION=\)\([0-9]*.[0-9]*.\)/NSSM_VERSION=${2}/" ./Makefile
    else
        EchoCN "EchoRed" "NSSM版本号参数异常" "The NSSM version number parameter is abnormal"
        exit 1
    fi
}


makeMainlineVersion()
{
    EchoCN "EchoBlue" "开始制作mainline版本[${nginx_mainline_version}]..." "Start making the mainline version[${nginx_mainline_version}]..."
    replaceVersion $nginx_mainline_version $NSSM_VERSION
    make
    if [ -f "build/nginx-service-${nginx_mainline_version}.exe" ];then
        echo "cp ./build/nginx-service-${nginx_mainline_version}.exe ./build/nginx-service-mainline-${nginx_mainline_version}.exe"
        \cp ./build/nginx-service-${nginx_mainline_version}.exe ./build/nginx-service-mainline-${nginx_mainline_version}.exe
        \cp ./build/nginx-service-${nginx_mainline_version}.exe ./dist/nginx-service-mainline-${nginx_mainline_version}.exe
        EchoCN "EchoBlue" "mainline版本[${nginx_mainline_version}]制作成功!" "The mainline version [${nginx_mainline_version}] was created successfully!"
    fi
}

makeStableVersion()
{
    EchoCN "EchoBlue" "开始制作stable版本[${nginx_stable_version}]..." "Start making the stable version[${nginx_stable_version}]..."
    replaceVersion $nginx_stable_version $NSSM_VERSION
    make
    if [ -f "build/nginx-service-${nginx_stable_version}.exe" ];then
        echo "cp ./build/nginx-service-${nginx_stable_version}.exe ./build/nginx-service-stable-${nginx_stable_version}.exe"
        \cp ./build/nginx-service-${nginx_stable_version}.exe ./build/nginx-service-stable-${nginx_stable_version}.exe
        \cp ./build/nginx-service-${nginx_stable_version}.exe ./dist/nginx-service-stable-${nginx_stable_version}.exe
        EchoCN "EchoBlue" "stable版本[${nginx_stable_version}]制作成功!" "The stable version [${nginx_stable_version}] was created successfully!"
    fi
}
cleanOldVersion(){
    buildqty=$(ls ./build/ |grep ".exe" |wc -l)
    if [ $buildqty -gt 0 ];then
        EchoCN "EchoBlue" "清除build目录下的旧版本版本!" "Clear the old version for build!"
        \rm -rf ./build/nginx-*.exe
    fi
    distqty=$(ls ./dist/ |grep ".exe" |wc -l)
    if [ $distqty -gt 0 ];then
        EchoCN "EchoBlue" "清除dist目录下的旧版本版本!" "Clear the old version for dist!"
        \rm -rf ./dist/nginx-*.exe
    fi
}

cleanOldVersion

makeStableVersion

makeMainlineVersion