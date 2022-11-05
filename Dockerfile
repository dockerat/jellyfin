FROM linuxserver/jellyfin:10.8.7


LABEL author="storezhang<华寅>"
LABEL email="storezhang@gmail.com"
LABEL qq="160290688"
LABEL wechat="storezhang"
LABEL description="Jellyfin镜像，集成常用功能：1、Intel Quick Sync硬解；2、增加中文字体解决乱码问题"


ENV TZ Asia/Shanghai


RUN set -ex \
    \
    \
    \
    # 替换国内源
    && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt clean -y \
    \
    && apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    \
    # 安装Quick Sync硬解
    && apt install -y intel-media-va-driver-non-free vainfo \
    \
    # 安装OpenCL色调映射驱动
    && apt install intel-opencl-icd \
    \
    # 安装中文字体
    && apt install -y fonts-noto-cjk-extra \
    \
    \
    \
    # 设置时区为上海
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    \
    \
    \
    # 清理镜像，减少无用包
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean
