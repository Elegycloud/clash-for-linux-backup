[TOC]

# 多语言

- [English Documentation (README_en)](README_en.md)

---

# 项目介绍

此项目是通过使用开源项目[clash（已跑路）](https://github.com/Dreamacro/clash)作为核心程序，再结合脚本实现简单的代理功能。<br>
clash核心备份仓库[Clash-backup](https://github.com/Elegycloud/clash-for-linux-backup)

主要是为了解决我们在服务器上下载GitHub等一些国外资源速度慢的问题。

# 免责声明
1.本项目使用GNU通用公共许可证（GPL）v3.0进行许可。您可以查看本仓库LICENSE进行了解

2.本项目的原作者保留所有知识产权。作为使用者，您需遵守GPL v3.0的要求，并承担因使用本项目而产生的任何风险。

3.本项目所提供的内容不提供任何明示或暗示的保证。在法律允许的范围内，原作者概不负责，不论是直接的、间接的、特殊的、偶然的或后果性的损害。

4.本项目与仓库的创建者和维护者完全无关，仅作为备份仓库，任何因使用本项目而引起的纠纷、争议或损失，与仓库的作者和维护者完全无关。

5.对于使用本项目所导致的任何纠纷或争议，使用者必须遵守自己国家的法律法规，并且需自行解决因使用本项目而产生的任何法律法规问题。

# 题外话
由于作者已经跑路，当前仓库仅进行备份，若有侵犯您的权利，请提交issues我会看到并删除仓库<br>

（2024/06/07 留：）其次就是，issue我没有时间回，很抱歉，欢迎各位来一起维护和解决这个仓库的问题！<br>

clash for linux 备份(备份号：202311091510)。
若喜欢本项目，请点个小星星！
<br>

# 使用须知

- 运行本项目建议使用root用户，或者使用 sudo 提权。
- 使用过程中如遇到问题，请优先查已有的 [issues](https://github.com/Elegycloud/clash-for-linux-backup/issues)。
- 在进行issues提交前，请替换提交内容中是敏感信息（例如：订阅地址）。
- 本项目是基于 [clash（已跑路）](https://github.com/Dreamacro/clash) 、[yacd](https://github.com/haishanh/yacd) 进行的配置整合，关于clash、yacd的详细配置请去原项目查看。
- 此项目不提供任何订阅信息，请自行准备Clash订阅地址。
- 运行前请手动更改`.env`文件中的`CLASH_URL`变量值，否则无法正常运行。
- 当前在RHEL系列和Debian,Kali Linux,ubuntu以及Linux系统中测试过，其他系列可能需要适当修改脚本。
- 支持 x86_64/aarch64 平台
- 【注意：部分带有桌面端Linux系统的需要在浏览器设置代理！否则有可能无法使用！】
- 【若系统代理无法使用，但是想要系统代理，请修改尝试修改start.sh中的端口后执行环境变量命令！】
- 【还是无法使用请更换当前网络环境（也是其中一个因素！）】
- 【部分Linux系统会出现谷歌，twitter，youtube等可能无法ping通，正常现象！】
> **注意**：当你在使用此项目时，遇到任何无法独自解决的问题请优先前往 [Issues](https://github.com/Elegycloud/clash-for-linux-backup/issue) 寻找解决方法。由于空闲时间有限，后续将不再对Issues中 “已经解答”、“已有解决方案” 的问题进行重复性的回答。

<br>

# 使用教程

## 下载项目

下载项目

```bash
$ git clone https://github.com/Elegycloud/clash-for-linux-backup.git clash-for-linux
```

进入到项目目录，编辑`.env`文件，修改变量`CLASH_URL`的值。

```bash
$ cd clash-for-linux
$ vim .env
```

> **注意：** `.env` 文件中的变量 `CLASH_SECRET` 为自定义 Clash Secret，值为空时，脚本将自动生成随机字符串。

<br>

## 启动程序

直接运行脚本文件`start.sh`

- 进入项目目录

```bash
$ cd clash-for-linux
```

- 运行启动脚本

```bash
$ sudo bash start.sh

正在检测订阅地址...
Clash订阅地址可访问！                                      [  OK  ]

正在下载Clash配置文件...
配置文件config.yaml下载成功！                              [  OK  ]

正在启动Clash服务...
服务启动成功！                                             [  OK  ]

Clash Dashboard 访问地址：http://<ip>:9090/ui
Secret：xxxxxxxxxxxxx

请执行以下命令加载环境变量: source /etc/profile.d/clash.sh

请执行以下命令开启系统代理: proxy_on

若要临时关闭系统代理，请执行: proxy_off

```

```bash
$ source /etc/profile.d/clash.sh
$ proxy_on
```

- 检查服务端口

```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```

- 检查环境变量

```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```

以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。

<br>

## 重启程序

如果需要对Clash配置进行修改，请修改 `conf/config.yaml` 文件。然后运行 `restart.sh` 脚本进行重启。

> **注意：**
> 重启脚本 `restart.sh` 不会更新订阅信息。

<br>

## 停止程序

- 进入项目目录

```bash
$ cd clash-for-linux
```

- 关闭服务

```bash
$ sudo bash shutdown.sh
```

服务关闭成功，请执行以下命令关闭系统代理：proxy_off

```bash
$ proxy_off
```

然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。


<br>

## Clash Dashboard

- 访问 Clash Dashboard

通过浏览器访问 `start.sh` 执行成功后输出的地址，例如：http://192.168.0.1:9090/ui

- 登录管理界面

在`API Base URL`一栏中输入：http://\<ip\>:9090 ，在`Secret(optional)`一栏中输入启动成功后输出的Secret。

点击Add并选择刚刚输入的管理界面地址，之后便可在浏览器上进行一些配置。

- 更多教程

此 Clash Dashboard 使用的是[yacd](https://github.com/haishanh/yacd)项目，详细使用方法请移步到yacd上查询。


<br>

## 终端界面选择代理节点

部分用户无法通过浏览器使用 Clash Dashboard 进行节点选择、代理模式修改等操作，为了方便用户可以在Linux终端进行操作，下面提供了一个功能简单的脚本以便用户可以临时通过终端界面进行配置。

脚本存放位置：`scripts/clash_proxy-selector.sh`

> **注意：**
>
> 使用脚本前，需要修改脚本中的 **Secret** 变量值为上述启动脚本输出的值，或者与 `.env` 文件中定义的 **CLASH_SECRET** 变量值保持一致。


<br>


# 常见问题

1. 部分Linux系统默认的 shell `/bin/sh` 被更改为 `dash`，运行脚本会出现报错（报错内容一般会有 `-en [ OK ]`）。建议使用 `bash xxx.sh` 运行脚本。

2. 部分用户在UI界面找不到代理节点，基本上是因为厂商提供的clash配置文件是经过base64编码的，且配置文件格式不符合clash配置标准。

   目前此项目已集成自动识别和转换clash配置文件的功能。如果依然无法使用，则需要通过自建或者第三方平台（不推荐，有泄露风险）对订阅地址转换。
   
3. 程序日志中出现`error: unsupported rule type RULE-SET`报错，解决方法查看官方[WIKI](https://github.com/Dreamacro/clash/wiki/FAQ#error-unsupported-rule-type-rule-set)
