# Seafile 安装脚本

这里的安装脚本可以帮助您快速的安装好 Seafile 服务器，并配置好 MariaDB, Memcached, WebDAV, Ngnix 和开机自动启动脚本。


### 使用步骤

安装干净的 Ubuntu 14.04 系统并切换成 root 账号 (sudo -i)。

获取安装脚本

```
wget https://raw.githubusercontent.com/haiwen/seafile-server-installer-cn/master/seafile-server-ce-ubuntu-14-04-amd64-http
```

运行安装脚本并指定要安装的版本 (4.1.2)

```
bash seafile-server-ce-ubuntu-14-04-amd64-http 4.1.2

注：安装脚本在执行过程中会检查**/opt**目录下是否有指定版本号的安装包，如果存在则会安装此包，否则会从 Seafile 网站下载。所以，为了避免因下载失败而导致安装中断，您可以提前下载好安装包放到**/opt/**目录下。
```

该脚本运行完后会在命令行中打印配置信息和管理员账号密码，请仔细阅读。该脚本会自动判断服务器的 IP 地址，并设置配置文件中相应选项。如果检测到的 IP 地址不对，会影响网页端文件的上传和下载。如果出现这个问题，您需要修改两个配置条目：

/opt/seafile/ccnet/ccnet.conf 中的 SERVICE_URL:

    SERVICE_URL = http://www.myseafile.com

/opt/seafile/seahub_settings.py 中的 FILE_SERVER_ROOT:

    FILE_SERVER_ROOT = 'http://www.myseafile.com/seafhttp'


### 测试

现在您可以在浏览器中输入服务器地址来进行测试。

### 升级到专业版/企业版

* 首先关闭 Seafile 服务： `service seafile-server stop; pkill -f seahub`。其中 `pkill -f seahub` 是为了确保 seahub 进程被关闭掉。
* 下载企业版到 /opt/seafile 下，并解压 (tar xf seafile-pro-server_4.1.2_x86-64.tar.gz)
* 下载 license 文件，并放置在 /opt/seafile 下
* 运行升级脚本

    ```
    cd seafile-pro-server_4.1.2;
    ./pro/pro.py setup --migrate
    ```

* 改正目录权限： `chown -R seafile.nogroup /opt/seafile/`
* 启动 Seafile 服务 `service seafile-server start`


### 如果安装脚本出错

如果安装脚本出错，您可以用下列命名来清空重试

```
rm -rf /opt/seafile
```

