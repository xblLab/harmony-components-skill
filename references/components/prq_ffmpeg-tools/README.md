# FFmpeg 工具库组件

## 简介

在 HarmonyOS 中调用 FFmpeg 命令行工具（fftools），最终驱动 FFmpeg.so 执行音视频处理任务。

## 详细介绍

### 简介

HarmonyOS FFmpeg 工具库 —— 在 HarmonyOS 中调用 FFmpeg 命令行工具（fftools），最终驱动 FFmpeg.so 执行音视频处理任务。同时提供硬件加速能力，在保证稳定性的前提下显著提升处理效率。

### 安装

```bash
ohpm install @prq/ffmpeg-tools
```

### 特性

本库的核心能力是将 FFmpeg 命令行工具封装为 ArkTS 可调用的 Native 接口，支持：

- 提供统一、可编程的音视频处理能力
- 支持转码、提取、下载等常见场景
- 内置完善的任务管理与进度控制机制
- 提供硬件解码与编码加速能力，在保证稳定性的前提下显著提升处理效率，适合对性能与能耗敏感的音视频场景。

### 最低运行版本

```json5
"compatibleSdkVersion": "5.0.0(12)"
```

### 功能验证

#### 1. 零拷贝

已测试从网络 MP4 下载并转换为 mkv、avi、mp4 等格式，输出结果正常可用。

示例执行命令：

```bash
ffmpeg -i https://example.com/video.mp4 -c:v copy -c:a copy -f avi -y /data/storage/el2/base/haps/entry/files/output.avi
```

性能统计：

- 原视频大小：4981937 字节（约 4.75MB），时长 2 分钟
- MP4 → MP4（copy）：耗时 0.42s，输出 4981937 字节
- MP4 → MKV（copy）：耗时 0.35s，输出 4831.78 KB

示例结果：

- 进行多个格式转换
- 提取到电脑上播放

#### 2. 硬解硬编

**视频加水印**

示例执行命令：

```bash
ffmpeg -i https://sns-video-al.xhscdn.com/stream/110/405/01e583cb6e0fed5a010370038c8ad962fb_405.mp4 
-i /data/storage/el2/base/haps/entry/files/watermark_selected.png -filter_complex [0:v][1:v]overlay=main_w-overlay_w-10:main_h-overlay_h-10[outv] -map [outv] -map 0:a -c:v h264_ohosavcodec -c:a copy -y /data/storage/el2/base/haps/entry/files/watermark_output.mp4
```

这里使用的是 `h264_ohosavcodec` 进行硬解码和硬编码相关处理。

性能统计：

- 2 分钟时长视频，硬解加水印耗时约 15.68S
- `[1:41:13 PM]`：输出文件大小:90712.12 KB

示例结果：

- 提取到电脑上播放

### 快速开始

#### 基本使用

```typescript
import { FFmpegManager, FFmpegFactory, ContainerFormat, TaskCallback } from '@prq/ffmpeg-tools';

// 获取管理器实例
const manager = FFmpegManager.getInstance();

// 执行视频格式转换（零拷贝）
const taskId = manager.execute(
  FFmpegFactory.remux(inputPath, outputPath, ContainerFormat.FLV),
  120000, // 超时时间（毫秒）
  {
    onStart: () => console.log('任务开始'),
    onProgress: (progress: number) => console.log(`进度：${(progress * 100).toFixed(1)}%`),
    onSuccess: () => console.log('转换成功'),
    onFailure: () => console.log('转换失败')
  } as TaskCallback
);

// 取消任务
manager.cancel(taskId);
```

#### 开启 Native 日志

```typescript
import { FFMpegUtils } from '@prq/ffmpeg-tools';

// 开启 FFmpeg native 层日志输出
FFMpegUtils.showLog(true);
```

#### 零拷贝操作（最快）

```typescript
import { FFmpegFactory, ContainerFormat } from '@prq/ffmpeg-tools';

// 封装格式转换
FFmpegFactory.remux(input, output, ContainerFormat.MP4);  // 默认 MP4
FFmpegFactory.remux(input, output, ContainerFormat.FLV);  // MP4 → FLV
FFmpegFactory.remux(input, output, ContainerFormat.AVI);  // MP4 → AVI
FFmpegFactory.remux(input, output, ContainerFormat.MKV);  // MP4 → MKV
FFmpegFactory.remux(input, output, ContainerFormat.TS);   // MP4 → TS

// 视频裁剪
FFmpegFactory.cut(input, output, '00:00:10', '30');  // 从 10 秒开始裁剪 30 秒

// 音频提取
FFmpegFactory.extractAudio(input, output);  // 提取 AAC 音频
```

#### 硬解硬编操作（h264_ohosavcodec）

```typescript
import { FFmpegFactory } from '@prq/ffmpeg-tools';

// 视频缩放
FFmpegFactory.scale(input, output, 1280, 720);  // 缩放到 720p

// 视频转码
FFmpegFactory.transcode(input, output);         // 默认转码
FFmpegFactory.transcode(input, output, '2M');   // 指定码率 2Mbps

// 添加水印（右下角）
FFmpegFactory.watermark(input, watermarkImg, output);

// 视频拼接
FFmpegFactory.concat([video1, video2, video3], output);
```

#### 网络流媒体

```typescript
import { FFmpegFactory } from '@prq/ffmpeg-tools';

// RTSP 流录制
FFmpegFactory.downloadRtsp(rtspUrl, output);           // 持续录制
FFmpegFactory.downloadRtsp(rtspUrl, output, 60);       // 录制 60 秒

// HLS 流下载
FFmpegFactory.downloadHls(hlsUrl, output);
```

#### 高级定制（FFmpegCommandBuilder）

```typescript
import { FFmpegCommandBuilder } from '@prq/ffmpeg-tools';

// 链式构建自定义命令
const cmd = new FFmpegCommandBuilder()
  .input(inputPath)
  .hwaccel()                    // 启用硬解硬编
  .scale(1280, 720)             // 缩放
  .fps(30)                      // 帧率
  .videoBitrate('2M')           // 视频码率
  .audioCodec('aac')            // 音频编码
  .audioBitrate('128k')         // 音频码率
  .output(outputPath)
  .build();

// 执行命令
manager.execute(cmd, 180000, callback);
```

## 实现方案

### 总体思路

将 FFmpeg 命令行工具（fftools）封装为 ArkTS 可调用的 Native 库，ArkTS 以 API 形式驱动常见转码/下载任务。

### 跨语言通信

采用 AKI 框架 实现 ArkTS（ETS） ⇄ C++ 的双向调用：

- **ETS → Native**：通过 JSBIND_PFUNCTION 宏将执行接口注册到 ArkTS；请求进入 Native 后由框架投递到线程池执行
- **Native → ETS**：通过带 UUID 的回调机制上报任务进度与最终结果，回调可以把异步状态传回 ETS 层

### FFtools 源码改造

- 原 FFmpeg 在严重错误时会调用 exit() 导致进程退出
- 为避免影响宿主进程，已将 exit_program() 改为基于 setjmp/longjmp 的非局部跳转方案，使出错时能优雅返回错误码并由上层处理（而非终止进程）
- **状态隔离**：Native 层使用 thread_local 来尽可能隔离每个任务的局部状态，避免不同任务互相污染

### 并发处理

实测发现：FFmpeg 内部仍大量依赖全局变量与共享状态——因此不适合在同一进程内多线程并发执行多个 FFTools 实例；并发运行会导致互相干扰、崩溃或数据错乱。
当前策略：任务调度层通过限制工作线程数量为 1，保证串行执行。

## API

### FFmpegFactory（零配置命令工厂）

#### 视频处理

| 方法 | 说明 |
| :--- | :--- |
| `remux(input, output, format?)` | 封装格式转换（零拷贝） |
| `cut(input, output, startTime, duration)` | 视频裁剪（零拷贝） |
| `extractAudio(input, output)` | 提取音频（AAC） |
| `scale(input, output, width, height)` | 视频缩放（硬解硬编） |
| `watermark(input, watermarkImg, output)` | 添加水印（硬编码） |
| `transcode(input, output, bitrate?)` | 视频转码（硬解硬编） |
| `concat(inputFiles, output)` | 视频拼接（硬解硬编） |
| `downloadRtsp(rtspUrl, output, duration?)` | RTSP 流录制 |
| `downloadHls(hlsUrl, output)` | HLS 流下载 |

#### 图片处理

| 方法 | 说明 |
| :--- | :--- |
| `videoToGif(input, output, fps?, width?)` | 视频转 GIF（默认 10fps, 320px 宽） |
| `videoSnapshot(input, output, time?)` | 视频截图（默认第 1 秒） |
| `videoToImages(input, outputPattern, fps?)` | 视频批量截图（默认每秒 1 张） |
| `imagesToVideo(inputPattern, output, fps?)` | 图片序列合成视频（默认 25fps） |
| `imageScale(input, output, width, height?)` | 图片缩放（height=-1 保持宽高比） |
| `imageConvert(input, output, quality?)` | 图片格式转换（quality: 1-31，默认 2） |
| `imageWatermark(input, watermark, output, position?)` | 图片添加水印（支持 5 个位置） |
| `imageHStack(inputs, output)` | 图片横向拼接 |
| `imageVStack(inputs, output)` | 图片纵向拼接 |
| `imageRotate(input, output, angle)` | 图片旋转（90/180/270 度） |
| `imageCrop(input, output, width, height, x?, y?)` | 图片裁剪 |
| `imageAddText(input, output, text, fontSize?, color?, x?, y?)` | 图片添加文字 |

### FFmpegCommandBuilder（高级定制）

| 方法 | 说明 |
| :--- | :--- |
| `input(path)` | 添加输入文件 |
| `output(path)` | 设置输出文件 |
| `hwaccel()` | 启用硬件加速（硬解 + 硬编） |
| `hwDecode()` | 仅启用硬件解码 |
| `hwEncode()` | 仅启用硬件编码 |
| `filter(expr)` | 添加视频滤镜 |
| `scale(width, height)` | 视频缩放 |
| `fps(value)` | 设置帧率 |
| `videoCodec(codec)` | 设置视频编码器 |
| `audioCodec(codec)` | 设置音频编码器 |
| `videoBitrate(bitrate)` | 设置视频码率 |
| `audioBitrate(bitrate)` | 设置音频码率 |
| `preset(value)` | 设置 x264 预设 |
| `crf(value)` | 设置 CRF 质量 |
| `format(fmt)` | 设置输出格式 |
| `startTime(time)` | 设置开始时间 |
| `duration(time)` | 设置持续时长 |
| `arg(key, value?)` | 添加额外参数 |
| `build()` | 构建命令数组 |
| `buildString()` | 构建命令字符串（调试用） |

### FFmpegManager

| 方法 | 说明 |
| :--- | :--- |
| `getInstance()` | 获取单例实例 |
| `execute(commands, duration, callback)` | 执行任务 |
| `executeWithPriority(commands, duration, priority, callback)` | 带优先级执行 |
| `cancel(taskId)` | 取消任务 |
| `cancelAll()` | 取消所有任务 |
| `getPendingTaskCount()` | 获取等待任务数 |
| `getActiveTaskCount()` | 获取活动任务数 |

### FFMpegUtils

| 方法 | 说明 |
| :--- | :--- |
| `executeFFmpegCommand(options)` | 执行 FFmpeg 命令（底层接口） |
| `showLog(show)` | 开启/关闭 Native 层日志 |

### TaskCallback

| 回调 | 说明 |
| :--- | :--- |
| `onStart()` | 任务开始 |
| `onProgress(progress)` | 进度更新 (0-1) |
| `onSuccess()` | 任务成功 |
| `onFailure()` | 任务失败 |
| `onCancelled?()` | 任务取消 |
| `onTimeout?()` | 任务超时 |
| `onError?(error)` | 错误信息 |

### ContainerFormat

| 格式 | 说明 |
| :--- | :--- |
| `MP4` | MP4 格式 |
| `FLV` | FLV 格式 |
| `MKV` | MKV 格式 |
| `AVI` | AVI 格式 |
| `TS` | MPEG-TS 格式 |

### TaskPriority

| 优先级 | 说明 |
| :--- | :--- |
| `HIGH` | 高优先级 |
| `NORMAL` | 普通优先级（默认） |
| `LOW` | 低优先级 |

## 使用注意事项

- **网络权限**：访问网络 URL 需要在 module.json5 中添加权限：

```json5
"requestPermissions": [
  { "name": "ohos.permission.INTERNET" }
]
```

- **包体积优化**：当前 libffmpegutils.so 约 70MB（依赖完整 FFmpeg 库）
  - 建议在 module.json5 中开启压缩：`"compressNativeLibs": true`
  - 可参考华为官方方案进行拆分与裁剪：[华为开发者博客](https://developer.huawei.com/consumer/cn/market/prod-detail/ca1d48b462c948efa7be4f6369d2cca2/PLATFORM?origin=template)
- **架构支持**：仅支持 arm64-v8a 架构
- **系统要求**：HarmonyOS 5.0+ (API 12+)
- **并发限制**：FFmpeg 内部使用全局变量，不支持多线程并发执行，任务会串行处理

**当前优化：**

优化包体积管理，aki 通过依赖引入，其自带了多个架构的 so 文件，nativeLib 配置来过滤无用的架构

```json5
"buildOption": {
    "napiLibFilterOption": {
      "excludes": [
        "**/armeabi-v7a/**",
        "**/x86_64/**"
      ]
    }
  },
```

## License

MIT

## 更新记录

#### [2.2.5] - 2026-02-06

**Fixed**

- README 样式优化

#### [2.2.4] - 2026-02-02

**Fixed**

- 修复显式设置了目标码率后，输出视频始终以较高码率生成，码率参数未生效的问题。

#### [2.2.3] - 2026-01-27

**Added**

- 视频裁剪能力支持：新增视频裁剪方法

#### [2.2.2] - 2026-01-12

**Fixed**

- 修复 HAR 包缺少 libaki_jsbind.so 导致的 "Cannot read property JSBind of undefined" 错误

#### [2.2.1] - 2026-01-09

**Added**

- native 层可以正确的返回错误

#### [2.2.0] - 2025-12-26

**Added**

- native 层日志支持：默认开启 native 日志
- 降低 API 版本要求：将 最低 SDK 版本从 17 降低到 12，让库可以在更多设备上运行

#### [2.1.0] - 2025-12-25

**Added**

- 图片处理支持：新增 13 个图片处理方法
  - `videoToGif()` - 视频转 GIF 动图
  - `videoSnapshot()` - 视频截图（单帧）
  - `videoToImages()` - 视频批量截图
  - `imagesToVideo()` - 图片序列合成视频
  - `imageScale()` - 图片缩放
  - `imageConvert()` - 图片格式转换
  - `imageWatermark()` - 图片添加水印（支持 5 个位置）
  - `imageHStack()` - 图片横向拼接
  - `imageVStack()` - 图片纵向拼接
  - `imageRotate()` - 图片旋转（90/180/270 度）
  - `imageCrop()` - 图片裁剪
  - `imageAddText()` - 图片添加文字

**Fixed**

- 修复视频缩放失败问题：移除输入前的硬解码器指定，避免音频流解析错误
  - 问题：`-c:v h264_ohosavcodec -i input` 导致音频流解码失败
  - 解决：改为 `-i input ... -c:v h264_ohosavcodec` 只在输出时使用硬编码
- 优化音频处理：视频缩放时音频使用 copy 模式，提升性能

**Changed**

- 更新 README 文档，新增图片处理 API 说明
- 优化 FFmpegFactory 代码结构，按功能分类
- 圣诞节快乐

#### [2.0.0] - 2025-12-16

**Added**

- 硬件加速支持：新增 h264_ohosavcodec 硬解硬编支持
- **FFmpegFactory 重构**：零配置 API，拿来即用
  - `remux()` - 封装格式转换（零拷贝）
  - `cut()` - 视频裁剪（零拷贝）
  - `extractAudio()` - 音频提取
  - `scale()` - 视频缩放（硬解硬编）
  - `watermark()` - 添加水印（硬编码）
  - `transcode()` - 视频转码（硬解硬编）
  - `concat()` - 视频拼接（硬解硬编）
  - `downloadRtsp()` - RTSP 流录制
  - `downloadHls()` - HLS 流下载
- **FFmpegCommandBuilder**：链式 API 构建自定义命令
  - 支持 `hwaccel()`, `hwDecode()`, `hwEncode()` 硬件加速
  - 支持 `scale()`, `fps()`, `filter()` 滤镜
  - 支持 `videoCodec()`, `audioCodec()`, `videoBitrate()` 编码参数
- **ContainerFormat 枚举**：MP4, FLV, MKV, AVI, TS
- **Native 日志控制**：`FFMpegUtils.showLog(true/false)`

**Changed**

- 重构 FFmpegFactory，移除旧的 buildMp42Xxx 方法
- 默认使用硬件编解码器 h264_ohosavcodec
- 更新 README 文档

**Breaking Changes**

- FFmpegFactory API 完全重构，旧方法已移除
- 需要链接 HarmonyOS 媒体系统库（native_media_codecbase, native_media_core, native_media_vdec, native_media_venc）

#### [1.0.2] - 2025-12-10

**Added**

- 完善 README 文档：相关文档

#### [1.0.1] - 2025-12-10

**Added**

- 添加 homepage 字段
- 添加 example 示例目录
- 完善 README 文档：实现方案、功能验证、使用注意事项

**Fixed**

- 修复 repository 链接

#### [1.0.0] - 2025-12-10

**Added**

- 初始版本发布
- FFmpegManager：单工作线程 + 优先级任务队列架构
- FFmpegFactory：预置常用格式转换命令
- FFMpegUtils：底层 FFmpeg 命令执行封装
- 支持视频格式转换：MP4、FLV、AVI、MKV、TS
- 支持音频提取：MP3、AAC
- 支持网络流媒体下载
- 任务优先级支持（HIGH、NORMAL、LOW）
- 进度回调支持
- 任务取消支持
- 完整的错误处理机制

## 权限与隐私

| 基本信息 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 <br> Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 <br> Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| 元服务 | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| 设备类型 | 平板 <br> Created with Pixso. |
| 设备类型 | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 <br> Created with Pixso. |

## 安装方式

```bash
ohpm install @prq/ffmpeg-tools
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ca1d48b462c948efa7be4f6369d2cca2/PLATFORM?origin=template