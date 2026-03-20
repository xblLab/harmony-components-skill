# Mars 跨平台网络组件

## 简介

Mars 是一个跨平台的网络组件，包括主要用于网络请求中的长连接，短连接，是基于 socket 层的解决方案，在网络调优方面有更好的可控性，暂不支持 HTTP 协议。Mars 极大的方便了开发者的开发效率。

## 详细介绍

### 简介

Mars 是一个跨平台的网络组件，包括主要用于网络请求中的长连接，短连接，是基于 socket 层的解决方案，在网络调优方面有更好的可控性，暂不支持 HTTP 协议。Mars 极大的方便了开发者的开发效率。

### 效果演示

### 编译运行

要编译通过 mars 需要在 mars\library\src\main\cpp 添加 openssl 依赖，需要自行编译 openssl 集成到应用 hap。

1. 修改编译之前需要在交叉编译中支持编译 x86_64 架构，可以参考 adpater_architecture.md 文档。
2. 编译之前需要先修改 HPKBUILD 文件中 openssl 的版本：

```bash
// Change the version number.
pkgver=OpenSSL_1_1_1w
```

下载 openssl 的 OpenSSL_1_1_1w 版本，执行以下命令获取对应的 sha512 值，替换 SHA512SUM 文件的内容。

```bash
sha512num openssl-OpenSSL_1_1_1w.tar.gz
```

4. 在 cpp 目录下添加编译生成的 openssl 文件夹（会在 lycium 目录下生成 usr 文件夹里面会生成 openssl 文件夹）。

Windows 和 Mac 请先合入 patch，然后再编译此项目，参考以下两步：

**下载源码**

```bash
git clone https://gitcode.com/openharmony-sig/mars.git --recurse-submodules
```

**合入 patch**，顺序执行下面的命令即可自动合入 patch。

```bash
chmod +x automatically_apply_mars_patch_files.sh
./automatically_apply_mars_patch_files.sh
```

至此 patch 合入完成。

### 下载安装

```bash
ohpm install @ohos/mars
```

### 使用说明

**第一步：** 初始化，导入 Mars 组件到自己项目中；

```typescript
import { Mars, StnLogic, Xlog, BuildConfig } from '@ohos/Mars/';
import MarsServiceNative from '../wrapper/service/MarsServiceNative';
import MarsServiceProfile from '../wrapper/service/MarsServiceProfile';
import marsnapi from 'libmarsnapi.so';
```

**第二步：** 方法调用，通过 marsnapi 调用对应方法；

```typescript
marsnapi.BaseEvent_onCreate();
```

### 接口说明

- `StnLogic.setLonglinkSvrAddr(host: string, ports: number[], debugIP?: string): number` - Sets the DEBUG IP address of a persistent connection.
- `StnLogic.StnLogic_setShortlinkSvrAddr(port: number, debugIP?: string): number` - Sets the DEBUG IP address of a non-persistent connection.
- `StnLogic.setDebugIP(host: string, ip: string): number` - Sets the DEBUG IP address, regardless of persistent and non-persistent connections.
- `StnLogic.startTask(task: StnLogic.Task): number` - Starts a task.
- `StnLogic.stopTask(taskID: number): number` - Stops a task.
- `StnLogic.hasTask(taskID: number): boolean` - Checks whether a task exists.
- `StnLogic.redoTask(): number` - Redoes all persistent and non-persistent connection tasks. Note that this API will cause a persistent connection to reconnect.
- `StnLogic.clearTask(): number` - Stops and clears all unfinished tasks.
- `StnLogic.reset(): number` - Stops and clears all unfinished tasks and performs initialization again.
- `StnLogic.resetAndInitEncoderVersion(packerEncoderVersion: number): number` - Stops and clears all unfinished tasks, performs initialization again, and resets the encoder version.
- `StnLogic.setBackupIPs(host: string, ips: string[]): number` - Sets the backup IP address, which is used when both the persistent and non-persistent connections are unavailable.
- `StnLogic.makesureLongLinkConnected(): number` : Checks the status of the persistent connection. If the connection fails, the system will try to reconnect it.
- `StnLogic.setSignallingStrategy(period: number, keepTime: number): number` - Sets the signaling keepalive policy.
- `StnLogic.keepSignalling(): number` - Sends a signaling keepalive packet.
- `StnLogic.stopSignalling(): number` - Stops signaling keepalive.
- `StnLogic.setClientVersion(clientVersion: number): number` - Sets the client version to be added to the proprietary protocol header of the persistent connection.
- `StnLogic.getLoadLibraries(): Array` - Obtains the loaded modules at the bottom layer.
- `StnLogic.req2Buf(taskID: number, userContext: any, channelSelect: number, host: string): object` : Obtains the data sent by the upper layer.
- `StnLogic.buf2Resp(taskID: number, userContext: any, respBuffer: ArrayBuffer, channelSelect: number): number` : Sends the received signaling response packet to the upper layer for parsing.
- `StnLogic.trafficData(send: number, recv: number): void` - Reports the traffic consumed by signaling.
- `SdtLogic.setCallBack` - Sets the signaling detection callback instance, which is used to notify the upper layer of the detection result.
- `SdtLogic.setHttpNetcheckCGI(_callBack: StnLogic.ICallBack): void` - Sets a URI for HTTP connectivity detection.
- `Xlog.logWrite(logInfo: Xlog.XLoggerInfo, log: string) : any` - Sets log writing mode 1.
- `Xlog.logWrite2(level: number, tag: string, filename: string, funcname: string, line: number, pid: number, tid: number, maintid: number, log: string): void` - Sets log writing mode 2.
- `Xlog.native_logWrite2(logInstancePtr: number, level: number, tag: string, filename: string, funcname: string, line: number, pid: number, tid: number, maintid: number, log: string): any` - Sets a custom log writing mode.
- `Xlog.setLogLevel(logInstancePtr: number): any` - Sets the log level.
- `Xlog.getLogLevel(logInstancePtr: number): any` - Obtains the log level.
- `Xlog.newXlogInstance(logConfig: Xlog.XLogConfig): any` - Creates a single Xlog instance.
- `Xlog.releaseXlogInstance(nameprefix: string): any` - Releases a single Xlog instance.

### 约束与限制

在下述版本验证通过：

- DevEco Studio: 4.1Canary (4.1.3.414), OpenHarmony SDK: API 11 (4.1.0.55)
- IDE: DevEco Studio NEXT Developer Preview2: 4.1.3.600, OpenHarmony SDK: API11 (4.1.0)

### 目录结构

```text
|---- library  
|     |---- cpp  # Sample code
|           |---- mars # C++ library files
|     |---- ets
|           |---- sdt  
|                 |---- SdtLogic # sdt external APIs
|           |---- stn  
|                 |---- StnLogic # stn external APIs
|           |---- xlog # xlog external APIs
|                 |---- Xlog # xlog external APIs
|---- README.md  # Readme
|---- README_zh.md  # Readme
```

### 开源协议

本项目基于 MIT License，请自由地享受和参与开源。

### 更新记录

#### 2.0.6
1. Change log level from INFO to DEBUG 

#### 2.0.5
1. The shared library is compiled with -O3 optimization and supports LTO

#### 2.0.4
1. Fix the crash caused by the xlog printing log content being too long.

#### 2.0.3
Release 2.0.3

#### 2.0.3-rc.0
1. Code obfuscation

#### 2.0.2
1. Fix 906 IDE running XTS error。
2. Fix the issue of the release mode entering the chat window crashing
3. Chore:Added supported device types

#### 2.0.2-rc.1
1. Fix the issue of the release mode entering the chat window crashing

#### 2.0.2-rc.0
1. 修复 906 版本 IDE 运行 XTS 报错问题。

#### 2.0.1
1. 修复断网重连问题。
2. 修复 appfree crash 问题。
3. 修复消息中断问题
4. 修复在任务结束后，onTaskEnd 函数没有回调结果的问题。
5. 修复建立网络长连接，网络连接状态没有回调的问题。
6. 修复 library 打包失败问题。
7. 修复 xlog 无法写入日志文件问题。
8. 修复消息、断网重连不稳定问题。
9. 修复 xlog 文本长度超过 1024 导致的 crash 问题。
10. 修复 xlog 控制台不输出日志问题。

#### 2.0.1-rc.3
1. 修复断网重连问题。
2. 修复 appfree crash 问题。
3. 修复消息中断问题

#### 2.0.1-rc.2
修复 2.0.1-rc.1 版本的 har 包异常，不能正常使用的问题。

#### 2.0.1-rc.1
修复在任务结束后，onTaskEnd 函数没有回调结果的问题。
适配 x86 架构

#### 2.0.1-rc.0
修复建立网络长连接，网络连接状态没有回调的问题。

#### 2.0.0
ArkTS 新语法适配
适配 DevEco Studio 版本：4.1.3.414，OpenHarmony SDK: 4.1.0.55。
原项目是直接上传源码，基于源码封装 napi。本次适配删除了 cpp/mars 目录，将源码以 submodules 的形式引入，将封装的 napi 以 patch 的形式应用，实现与原项目对等的能力。

#### 1.0.0
Mars 实现的功能具体如下：
- marsnapi.BaseEvent_onCreate();
- marsnapi.BaseEvent_onInitConfigBeforeOnCreate(packer_encoder_version);
- marsnapi.BaseEvent_onDestroy();
- marsnapi.BaseEvent_onForeground(true);
- marsnapi.BaseEvent_onNetworkChange();
- marsnapi.BaseEvent_onSingalCrash(sig);
- marsnapi.BaseEvent_onExceptionCrash();
- marsnapi.StnLogic_setLonglinkSvrAddr(profile.longLinkHost(), profile.longLinkPorts(), "");
- marsnapi.StnLogic_startTask(_task);
- marsnapi.StnLogic_stopTask();
- marsnapi.StnLogic_hasTask(taskid);
- marsnapi.StnLogic_redoTask();
- marsnapi.StnLogic_clearTask();
- marsnapi.StnLogic_makesureLongLinkConnected();
- marsnapi.StnLogic_setSignallingStrategy();

### 兼容性信息

| 项目 | 信息 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/mars
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/67066756525d42799db3931f94ac8631/PLATFORM?origin=template