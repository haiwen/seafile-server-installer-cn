[![Build Status](https://travis-ci.org/haiwen/seafile-server-installer-cn.svg?branch=master)](https://travis-ci.org/haiwen/seafile-server-installer-cn)

# Seafile 安装脚本

这里的安装脚本可以帮助您快速的安装好 Seafile 服务器，并配置好 MariaDB, Memcached, WebDAV, Ngnix 和开机自动启动脚本。

## 使用步骤

安装干净的 Ubuntu 16.04/18.04 或 CentOS 7/8 系统，并**做好镜像** (如果安装失败需要还原到镜像)。

切换成 root 账号 (sudo -i)

### 获取安装脚本

- 适用于 Seafile 7.1.x 及以上版本

    Ubuntu 18.04 (64bit):
    ```sh
    wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-7.1-ubuntu-admin64-http
    ```

    CentOS 8 (64bit):
    ```sh
    wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-7.1-centos-amd64-http
    ```

- 适用于 Seafile 6.x.x 及以上版本

    Ubuntu 16.04/18.04 (64bit):
    ```sh
    wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-ubuntu-amd64-http
    ```

    CentOS 7 (64bit):
    ```sh
    wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-centos-7-amd64-http
    ```

### 运行安装脚本并指定要安装的版本 (例如 6.0.13)

Ubuntu 16.04/18.04 (64bit):
```
bash seafile-server-ubuntu-amd64-http 6.0.13
```

CentOS 7 (64bit):
```
bash seafile-server-centos-7-amd64-http 6.0.13
```

脚本会让您选择要安装的版本, 按照提示进行选择即可:

* 如果要安装专业版, 需要先将下载好的专业版的包 `seafile-pro-server_6.0.13_x86-64.tar.gz` 放到 `/opt/` 目录下
* 如果是安装开源版，安装脚本在执行过程中会检查 `/opt`目录下是否有指定版本号的安装包，如果存在则会安装此包，否则会从 Seafile 网站下载。所以，为了避免因下载失败而导致安装中断，您可以提前下载好安装包放到`/opt/`目录下。

该脚本运行完后会在命令行中打印配置信息和管理员账号密码，请仔细阅读。(您也可以查看安装日志`/opt/seafile/aio_seafile-server.log`)，MySQL 的 root 用户密码存储在 `/root/.my.cnf` 中；MySQL 的 seafile 用户密码存储在 `/opt/seafile.my.cnf` 中。

### 通过 Web UI 对服务器进行配置

安装完成后，您需要通过 Web UI 服务器进行基本的配置，以便能正常的从网页端进行文件的上传和下载：

1. 首先在浏览器中输入服务器的地址，并用管理员账号和初始密码登录

2. 点击界面的右上角的头像按钮进入管理员界面

  ![管理员入口](http://manual-cn.seafile.com/images/system-admin-entrance.png)

3. 进入设置页面填写正确的服务器对外的 SERVICE_URL 和 FILE_SERVER_ROOT，比如

    ```
    SERVICE_URL: http://www.myseafile.com
    FILE_SERVER_ROOT: 'http://www.myseafile.com/seafhttp'
    ```

现在您可以退出管理员界面，并进行基本的测试。关于服务器的配置选项介绍和日常运维可以参考 https://cloud.seafile.com/published/seafile-manual-cn/config/README.md

### 如果安装脚本出错

如果安装脚本出错，您需要重置虚拟机到干净的镜像。

### 启动关闭服务

自动安装脚本会在系统中安装开机自动启动脚本。您也可以使用该脚本来关闭/启动 Seafile 服务，命令如下：

Ubuntu 16.04/18.04:
```
service seafile-server stop
service seafile-server start
```

CentOS 7/8:
```
systemctl stop seafile
systemctl stop seahub

systemctl start seafile
systemctl start seahub
```

## 其他高级配置

### 备份 mysql

* 拷贝 `db-backup` 目录到 `/opt/seafile`
* 修改 `db-backup/db_backup.sh` 中的 `USER` `PASSWD`
* 执行 `crontab -e` 并添加内容 `0 1 * * * /opt/seafile/db-backup/db_backup.sh` (每天凌晨1：00进行备份)

### 配置邮件发送

参考 https://cloud.seafile.com/published/seafile-manual-cn/config/sending_email.md

## 升级和其他问题

### 版本升级

* 关闭 seafile-server 相关服务
* 切换为 seafile 用户
* 下载高版本的安装包到 /opt/seafile 目录，并解压
* 进入安装包下的 upgrade 目录，执行相关的升级脚本，具体可参考 https://download.seafile.com/published/seafile-manual/upgrade/upgrade.md
* 启动 seafile-server 相关服务

### 迁移社区版到专业版

* 关闭 seafile-server 相关服务
* 切换为 seafile 用户
* 下载专业版安装包到 /opt/seafile 目录，并解压
* 进入解压好的安装包目录，执行 ./pro/pro.py setup --migrate，具体可参考 https://cloud.seafile.com/published/seafile-manual-cn/deploy_pro/migrate_from_seafile_community_server.md
* 启动 seafile-server 相关服务
