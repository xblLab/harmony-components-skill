# videocompressor 视频压缩组件

## 简介

videoCompressor 是一款 ohos 高性能视频压缩器。

## 详细介绍

### 介绍

videoCompressor 是一款 ohos 高性能视频压缩器。

### 目前实现的能力

- 支持视频压缩

## 使用本工程

有两种方式可以下载本工程：

### 开发者如果想要使用本工程，可以使用 git 命令

```bash
git clone https://gitcode.com/openharmony-sig/ohos_videocompressor.git --recurse-submodules
```

点击下载按钮，把本工程下到本地，再把 `third_party_bounds_checking_function` 代码下载后，放入 `videoCompressor/src/cpp/boundscheck` 目录下，这样才可以编译通过。

## 下载安装

```bash
ohpm install @ohos/videocompressor
```

## X86 模拟器配置

使用模拟器运行应用/服务。

## 使用

### 1. 视频压缩接口展示

```typescript
let videoCompressor = new VideoCompressor();
videoCompressor.compressVideo(getContext(), this.selectFilePath, CompressQuality.COMPRESS_QUALITY_HIGH).then((data) => {
    if (data.code == CompressorResponseCode.SUCCESS) {
        console.log("videoCompressor HIGH message:" + data.message + "--outputPath:" + data.outputPath);
    } else {
        console.log("videoCompressor HIGH code:" + data.code + "--error message:" + data.message);
    }
}).catch((err) => {
    console.log("videoCompressor HIGH get error message" + err.message);
})
```

## 支持的视频规格

### 支持的解封装格式

| 媒体格式封装格式 | 视频 |
| :--- | :--- |
| | mp4、mpeg.ts |

### 支持的视频解码格式

| 视频解码类型 |
| :--- |
| AVC(H.264)、HEVC(H.265) |

### 支持的音频解码格式

| 音频解码类型 |
| :--- |
| AAC |

### 支持的视频编码格式

| 视频编码类型 |
| :--- |
| AVC(H.264)、HEVC(H.265) |

### 支持的音频编码格式

| 音频编码类型 |
| :--- |
| AAC |

### 支持的封装格式

| 媒体格式封装格式 | 视频 |
| :--- | :--- |
| | mp4 |

## 接口说明

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| `compressVideo` | `context: Context`<br>`inputFilePath: string`<br>`quality: CompressQuality` | `context`: 上下文<br>`inputFilePath`: 需要压缩的视频路径<br>`quality`: 压缩视频质量<br>视频压缩接口 |

单元测试用例详情见 [TEST.md](./TEST.md)。

## 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 `videocompressor` 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```bash
-keep
./oh_modules/@ohos/videocompressor
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: (5.0.3.500), SDK: API12 (5.0.0.25)
- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)

## 目录结构

```text
|----ohos_videocompressor
|     |---- entry  # 示例代码文件夹
|     |---- videoCompressor  # ohos_videocompressor 库文件夹
|           |---- index.ets  # 对外接口
|     |---- README_CN.md  # 使用说明文档
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue。给组件，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 1.0.6

- Modify the optimization level of dynamic libraries

### 1.0.5

- Release official version

### 1.0.5-rc.1

- Add obfuscation configuration to the document
- Switch the repository address to gitcode

### 1.0.5-rc.0

- Fix the issue where some 10 bit videos cannot be compressed

### 1.0.4

- 在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66) 验证通过

### 1.0.4-rc.3

- 修复开启了 HDR Vivid 录制的视频压缩失败的问题

### 1.0.4-rc.2

- 支持 HEVC(H.265) 格式视频压缩

### 1.0.4-rc.1

- 支持不包含音频的视频压缩
- 修复视频压缩后方向不对的问题

### 1.0.4-rc.0

- 修复视频无法压缩成功的问题

### 1.0.3

- 支持 x86 编译

### 1.0.2

- 正式版本 1.0.2

### 1.0.2-rc.1

- 修复视频有多个轨道时，无用轨道影响解封装流程的问题

### 1.0.2-rc.0

- 修复不兼容 API9 问题

### 1.0.1

- 修复视频丢帧问题

### 1.0.0

- videoCompressor 是一款 ohos 高性能视频压缩器。
- 目前实现的能力：支持视频压缩

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

- 不涉及

### SDK 合规使用指南

- 不涉及

### 兼容性

- HarmonyOS 版本：5.0.0

### 应用类型

- 应用

### 元服务

- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.3

## 安装方式

```bash
ohpm install @ohos/videocompressor
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0d29fbecedfc4c22a2c99c19ddf2aa0c/PLATFORM?origin=template