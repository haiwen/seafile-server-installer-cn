# Seafile 安装脚本

这里的安装脚本可以帮助您快速的安装好 Seafile 服务器，并配置好 MariaDB, Memcached, WebDAV, Ngnix 和开机自动启动脚本。注意，安装脚本会创建 seafile 系统用户，并以该用户来运行 Seafile 服务。版本升级时需要使用该用户来执行升级步骤，以保证文件权限的正确性。具体见本文末尾。


### 使用步骤

安装干净的 Ubuntu 14.04 或 CentOS 7 系统并切换成 root 账号 (sudo -i)。

获取安装脚本

Ubuntu 14.04:
```
wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-ubuntu-14-04-amd64-http
```

CentOS 7:
```
wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-centos-7-amd64-http
```

运行安装脚本并指定要安装的版本 (5.0.2)

```
bash seafile-server-ubuntu-14-04-amd64-http 5.0.2
```

脚本会让你选择要安装的版本, 按照提示进行选择即可:

* 如果要安装专业版, 需要先将下载好的专业版的包 `seafile-pro-server_5.0.1_x86-64.tar.gz` 放到 `/opt/` 目录下
* 如果是安装开源版，安装脚本在执行过程中会检查**/opt**目录下是否有指定版本号的安装包，如果存在则会安装此包，否则会从 Seafile 网站下载。所以，为了避免因下载失败而导致安装中断，您可以提前下载好安装包放到**/opt/**目录下。

该脚本运行完后会在命令行中打印配置信息和管理员账号密码，请仔细阅读。(你也可以查看安装日志 /opt/seafile/aio_seafile-server.log)

#### 通过 Web UI 对服务器进行配置

安装完成后，您需要通过 Web UI 服务器进行基本的配置，以便能正常的从网页端进行文件的上传和下载：

1. 首先在浏览器中输入服务器的地址，并用管理员账号和初始密码登录
2. 点击界面的右上角的工具按钮进入管理员界面
 
    ![工具按钮](http://manual-cn.seafile.com/images/tools-button.png)

3. 进入设置页面填写正确的服务器对外的 SERVICE_URL 和 FILE_SERVER_ROOT，比如

    ```
    SERVICE_URL: http://www.myseafile.com
    FILE_SERVER_ROOT: 'http://www.myseafile.com/seafhttp'
    ```
    
现在您可以退出管理员界面，并进行基本的测试。关于服务器的配置选项介绍和日常运维可以参考 http://manual-cn.seafile.com/config/index.html

### 如果安装脚本出错

如果安装脚本出错，您可以用下列命名来清空重试 (或者重置虚拟机)。

```
rm -rf /opt/seafile
```

### 启动关闭服务

自动安装脚本会在系统中安装开机自动启动脚本。您也可以使用该脚本来关闭/启动 Seafile 服务，命令如下：

Ubuntu 14.04:
```
service seafile-server stop
service seafile-server start
```

CentOS 7:
```
service seafile stop
service seahub stop

service seafile start
service seahub start
```

## 其他高级配置

### 备份 mysql

* 拷贝 `db-backup` 目录到 `/opt/seafile`
* 修改 `db-backup/db_backup.sh` 中的 `USER` `PASSWD`
* 执行 `crontab -e` 并添加内容 `0 1 * * * /opt/seafile/db-backup/db_backup.sh` (每天凌晨1：00进行备份)

### 配置邮件发送

参考 http://manual-cn.seafile.com/config/sending_email.html

## 升级和其他问题

### 版本升级

* 切换为 root 用户
* 关闭 seafile-server 相关服务
* 下载高版本的安装包到 /opt/seafile 目录，并解压
* 进入安装包下的 upgrade 目录，执行相关的升级脚本，具体可参考 http://manual.seafile.com/deploy/upgrade.html
* 启动 seafile-server 相关服务

### 迁移社区版到专业版

* 切换为 root 用户
* 关闭 seafile-server 相关服务
* 下载专业版安装包到 /opt/seafile 目录，并解压
* 进入解压好的安装包目录，执行 ./pro/pro.py setup --migrate，具体可参考 http://manual.seafile.com/deploy_pro/migrate_from_seafile_community_server.html
* 启动 seafile-server 相关服务
