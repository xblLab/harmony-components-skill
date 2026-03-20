# videotrimmer 视频编辑组件

## 简介

在 OpenHarmony 环境下，提供视频剪辑能力的三方库，常用于视频剪辑。

## 详细介绍

### 简介
videotrimmer 是在 OpenHarmony 环境下，提供视频剪辑能力的三方库。

### 效果展示

### 安装教程
```bash
ohpm install @ohos/videotrimmer
```

### 使用说明
目前支持 MP4 格式。

#### 视频格式是否支持
*   **MP4**: 是
*   **H264**: 是

#### 使用 VideoTrimmerView

**构建 VideoTrimmerOption 对象:**

```typescript
getContext(this).resourceManager.getMediaContent($r('app.media.app_icon'))
    .then(uint8 => {
        let imageSource = image.createImageSource(uint8.buffer as any); // 步骤一：文件转为 pixelMap 然后变换 给 Image 组件
        imageSource.createPixelMap().then(pixelmap => {
            this.videoTrimmerOption = {
                srcFilePath: this.filePath,
                listener: {
                    onStartTrim: () => {
                        console.log('dodo  开始裁剪')
                        this.dialogController.open()
                    },
                    onFinishTrim: (path: string) => {
                        console.log('dodo  裁剪成功 path=' + path)
                        this.outPath = path;
                        this.dialogController.close()
                    },
                    onCancel: () => {
                        console.log('dodo  用户取消')
                        router.replaceUrl({ url: 'pages/Index', params: { outFile: this.outPath } })
                    }
                },
                loadFrameListener: {
                    onStartLoad: () => {
                        console.log('dodo  开始获取帧数据')
                        this.dialogController.open()
                    },
                    onFinishLoad: () => {
                        console.log('dodo  获取帧数据结束')
                        this.dialogController.close()
                    }
                },
                frameBackground: "#FF669900",
                framePlaceholder: pixelmap
            }
        })
    })
```

**界面 build() 中使用 VideoTrimmerView 组件，传入 VideoTrimmerOption 对象:**

```typescript
build() {
    Row() {
        Column() {
            VideoTrimmerView({ videoTrimmerOption: this.videoTrimmerOption!! })
        }
        .width('100%')
    }
    .height('100%')
}
```

## 接口说明

### VideoTrimmerOption 视频剪辑选项

| 字段 | 描述 |
| :--- | :--- |
| `srcFilePath` | 视频源路径 |
| `listener` | 裁剪回调 |
| `loadFrameListener` | 加载帧回调 |
| `VIDEO_MAX_TIME` | 指定裁剪长度 默认值 10 秒 |
| `VIDEO_MIN_TIME` | 最小剪辑时间 |
| `MAX_COUNT_RANGE` | seekBar 的区域内一共有多少张图片 |
| `THUMB_WIDTH` | 裁剪视频预览长方形条状左右边缘宽度 |
| `PAD_LINE_WIDTH` | 裁剪视频预览长方形条状上下边缘高度 |
| `framePlaceholder` | 当加载帧没有完成，默认的占位图 |
| `frameBackground` | 裁剪视频预览长方形条状区域背景颜色 |

### VideoTrimListener 视频剪辑回调

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| `onStartTrim()` | 无 | 开始剪辑 |
| `onFinishTrim(outputFile:string)` | `outputFile:string` | 完成剪辑 |
| `onCancel()` | 无 | 取消剪辑 |

### VideoLoadFramesListener 视频加载回调

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| `onStartLoad()` | 无 | 开始加载视频帧 |
| `onFinishLoad()` | 无 | 完成加载视频帧 |

## 约束与限制

在下述版本验证通过：
*   DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)
*   DevEco Studio: NEXT Developer Beta3-5.0.3.530, SDK: API12 (5.0.0.35)

**HSP 场景适配：**
VideoTrimmerOption 配置类新增可选参数 context，在 HSP 场景下需要传入正确的 context，才能保证三方库后续正确获取 Resource 资源。非 HSP 场景不影响原功能，context 可以不传。

## 目录结构

```text
|----ohos_video_trimmer
|     |----entry  # 示例代码文件夹
|           |----pages # 页面测试代码
|               |----index.ets # 测试入口页面
|               |----Video.ets 		# 剪辑主要测试页面
|               |----FileUtils.ets	# 工具类
|     |---- screenshots # 截图
|     |---- videotrimmer  # video_trimmer 库文件夹
|           |---- src  # video_trimmer 库核心代码
|               |----components
|                   |----RangeSeekBarView.ets		# 自定义组件，选定视频剪辑长度
|                   |----TimeUtils.ets           # 时间处理工具类
|                   |----VideoLoadFramesListener.ets # 加载帧回调接口
|                   |----VideoThumbListView.ets     # 自定义组件，视频帧列表
|                   |----VideoTrimListener.ets      # 视频剪辑回调接口
|                   |----VideoTrimmerOption.ets     # 视频剪辑选项
|                   |----VideoTrimmerView.ets       # 自定义视频剪辑组件
|     |---- README.MD  # 安装使用方法
|     |---- README_zh.MD  # 安装使用方法
```

## 关于混淆

代码混淆，请查看代码混淆简介。
如果希望 videotrimmer 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/ijkplayer
./oh_modules/@ohos/videotrimmer
```

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 1.1.4
Release the official version 1.1.4

### 1.1.4-rc.3
Optimize video preview playback

### 1.1.4-rc.2
Optimize loading speed

### 1.1.4-rc.1
Replace the deprecated APIs of the system

### 1.1.4-rc.0
Modify the incorrect non-null check
Modify deprecated interface

### 1.1.3
Release the official version 1.1.3

### 1.1.2
修复 1.1.1 版本依赖库 mp4parse 的 so 包加载失败问题

### 1.1.1
在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66) 上验证通过

### 1.1.0
适配 V2 装饰器

### 1.0.1
ArkTs 语法适配
适配 DevEco Studio: 4.1 Canary2 (4.1.3.322), SDK: API11 (4.1.3.1)
1.0.1 正式版本发布

### 1.0.1-rc.2
为了适配 HSP 场景，VideoTrimmerOption 类新增当前场景上下文 context 可选参数传入，在 HSP 场景下需要传正确的 context，非 HSP 场景不影响，context 可以不传。
修复视频裁剪长度与预期相差 1s 的问题。

### 1.0.1-rc.1
ArkTs 语法适配。
适配 DevEco Studio: 4.0 Release (4.0.3.600), SDK: API10 (4.0.10.11)。

### 1.0.1-rc.0
修复不兼容 API9 问题。

### 1.0.0
videotrimmer 是在 OpenHarmony 环境下，提供视频剪辑能力的三方库。
支持配置裁剪最大时长和最小时长。
支持可滑动选择裁剪范围。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/videotrimmer
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/95ed54f8f7234440851ab73bb9641974/PLATFORM?origin=template