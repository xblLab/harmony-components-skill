# mp4parser 视频编解码组件

## 简介

一个读取、写入操作音视频文件编辑的工具。支持视频裁剪、视频合成、音频裁剪、音频合成、视频取帧。

## 详细介绍

### 简介

一个读取、写入操作音视频文件编辑的工具。

### 编译运行

1. 通过 IDE 工具下载依赖 SDK，Tools->SDK Manager->Openharmony SDK 把 native 选项勾上下载，API 版本>=10
2. 开发板选择 RK3568，选择开发板类型是 rk3568，请使用最新的版本
3. 下载源码
4. 项目依赖 FFmpeg 库，关于 FFmpeg 的编译：FFmpeg 源码基于版本号:n4.3.8

### FFmpeg 依赖

1. 修改编译之前需要在交叉编译中支持编译 x86_64 架构，可以参考 adpater_architecture.md 文档。
2. FFmpeg:FFmpeg 版本 (n4.3.8):FFmpeg 源码链接，可以在交叉编译出库文件和头文件
   编译之前需要先修改 HPKBUILD 文件中 FFmpeg 的版本为 n4.3.8。

   ```diff
   pkgver=n6.0 
   //修改为
   pkgver=n4.3.8
   ```

3. 下载 FFmpeg 的 n4.3.8，执行以下命令获取对应的 sha512 值，替换 SHA512SUM 文件的内容。

   ```bash
   sha512sum FFmpeg-n4.3.8.zip
   ```

4. 在 cpp 目录下新增 third_party 目录和在 library 下新增 libs 目录，并将编译生成的 FFmpeg 库拷贝到该目录下，如下图所示

### 下载安装

```bash
ohpm install @ohos/mp4parser
```

### X86 模拟器配置

使用模拟器运行应用/服务

### 使用说明

#### 视频合成

```typescript
import {MP4Parser} from "@ohos/mp4parser";
import {ICallBack} from "@ohos/mp4parser";

/**
 * 视频合成
 */
private videoMerge() {
  let getLocalDirPath = getContext(this).cacheDir+"/";
  let that = this;
  let filePathOne = getLocalDirPath + "qqq.mp4";
  let filePathTwo = getLocalDirPath + "www.mp4";
  let outMP4 = getLocalDirPath + "mergeout.mp4";
  var callBack: ICallBack = {
    callBackResult(code: number) {
      that.btnText = "视频合成点击执行"
      that.imageWidth = 0
      that.imageHeight = 0
      if (code == 0) {
        AlertDialog.show({ message: $r('app.string.ok') })
      }
      else {
        AlertDialog.show({ message: $r('app.string.failed') })
      }
    }
  }
  MP4Parser.videoMerge(filePathOne, filePathTwo, outMP4, callBack);
}
```

#### 接口说明

| 方法名 | 参数 | 描述 |
| :--- | :--- | :--- |
| `MP4Parser.videoMerge` | `filePath_one: string`, `filePath_two: string`, `outPath: string`, `callBack: ICallBack` | `filePath_one`: 视频路径一<br>`filePath_two`: 视频路径二<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 视频合成 |
| `MP4Parser.videoClip` | `startTime: string`, `endTime: string`, `sourcePath: string`, `outPath: string`, `callBack: ICallBack` | `startTime`: 开始时间<br>`endTime`: 结束时间<br>`sourcePath`: 来源路径<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 视频裁剪 |
| `MP4Parser.videoMultMerge` | `sourcePath: string`, `outPath: string`, `callBack: ICallBack` | `sourcePath`: 来源路径<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 批量视频合成 |
| `MP4Parser.audioMerge` | `filePath_one: string`, `filePath_two: string`, `outPath: string`, `callBack: ICallBack` | `filePath_one`: 视频路径一<br>`filePath_two`: 视频路径二<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 音频合成 |
| `MP4Parser.audioClip` | `startTime: string`, `endTime: string`, `sourcePath: string`, `outPath: string`, `callBack: ICallBack` | `startTime`: 开始时间<br>`endTime`: 结束时间<br>`sourcePath`: 来源路径<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 音频裁剪 |
| `MP4Parser.audioMultMerge` | `sourcePath: string`, `outPath: string`, `callBack: ICallBack` | `sourcePath`: 来源路径<br>`outPath`: 输出路径<br>`callBack`: 回调事件<br>**功能**: 音频批量合成 |
| `MP4Parser.setDataSource` | `path: string`, `callBack: ICallBack` | `path`: 路径<br>`callBack`: 回调事件<br>**功能**: 设置视频源 |
| `MP4Parser.getFrameAtTimeRang` | `stimeUs: string`, `etimeUs: string`, `option: string`, `frameCallBack: IFrameCallBack` | `stimeUs`: 开始帧<br>`etimeUs`: 结束帧<br>`option`: 提取选项<br>`frameCallBack`: 回调事件<br>**功能**: 视频取帧 |
| `MP4Parser.stopGetFrame` | - | **功能**: 停止取帧 |
| `MP4Parser.ffmpegCmd` | `cmd: string`, `callBack: ICallBack` | `cmd`: FFmpeg 命令<br>`callBack`: 回调事件<br>**功能**: 调用 FFmpeg 指令 |

## 约束与限制

在下述版本验证通过：

*   DevEco Studio 版本：4.0 Release(4.0.3.413), SDK: (4.0.10.3)
*   DevEco Studio 版本：4.1 Canary(4.1.3.317)，OpenHarmony SDK: API11 (4.1.0.36)
*   DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)

## 目录结构

```text
|---- mp4parser  
|     |---- entry  # 示例代码文件夹
|     |---- library  # mp4parser 库文件夹
|           |---- MP4Parser.ets  # 对外接口
|     |---- README.MD  # 安装使用方法                    
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给组件，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

*   **2.0.7**
    *   Modify the optimization level of dynamic libraries
*   **2.0.7-rc.1**
    *   Fix the issue of errors caused by dependency introduction
*   **2.0.7-rc.0**
    *   Add getFrame interface
    *   Fix security compilation issues
    *   Add patch to fix vulnerability CVE-2025-0518
*   **2.0.6**
    *   Change Gitee to Gitcode
*   **2.0.6-rc.0**
    *   Supports H264 encoding
*   **2.0.5**
    *   support get video or audio meta data
*   **2.0.5-rc.2**
    *   reducing package size-Crop ffmpeg
*   **2.0.5-rc.1**
    *   Update to ffmpeg version 4.3.8
*   **2.0.5-rc.0**
    *   添加支持 libmp3lame 编码
*   **2.0.4**
    *   修复执行 ffmpeg 命令崩溃的问题
*   **2.0.3**
    *   更新版本号至 2.0.3
*   **2.0.3-rc.1**
    *   适配 x86 架构
    *   修复传入的 ffmpeg 命令长度超过 400 就报错的问题以及文件名包含空格就报错的问题
*   **2.0.3-rc.0**
    *   修复视频裁剪不够精确问题
    *   添加调用 ffmpeg 指令接口
*   **2.0.2-rc.0**
    *   修复不兼容 API9 问题
*   **2.0.1**
    *   1.ArkTS 语法整改
*   **2.0.0**
    *   1.适配 OHPM
    *   2.添加支持获取视频帧
*   **1.0.7**
    *   1.适配 DevEco Studio 3.1 Beta1 版本。
*   **1.0.6**
    *   更新项目适配 API9
*   **1.0.5**
    *   hvigor 工程结构整改
    *   支持视频合成
    *   支持视频裁剪
    *   支持音频合成
    *   支持音频裁剪

## 权限与隐私

| 类别 | 内容 |
| :--- | :--- |
| **基本信息** | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本：5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/mp4parser
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a654b6b211a642b0befc7d8a3fbf5215/PLATFORM?origin=template