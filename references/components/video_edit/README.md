# 视频编辑组件

## 简介

本组件提供了完整的视频编辑功能，包括视频裁剪、拼接、画中画、提词器、字幕添加等核心编辑能力，支持视频帧预览、拖动排序、分割、缩放等操作，并提供视频导出功能。

## 详细介绍

### 简介

本组件提供了完整的视频编辑功能，包括视频裁剪、拼接、画中画、提词器、字幕添加等核心编辑能力，支持视频帧预览、拖动排序、分割、缩放等操作，并提供视频导出功能。

### 视频编辑页面合成编辑

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

#### 资源依赖

组件内部使用了媒体资源，请确保应用资源目录包含必要的图标资源。

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
b. 在项目根目录 `build-profile.json5` 添加 `video_edit` 和 `video_common` 模块。在项目根目录 `build-profile.json5` 填写 `video_edit` 路径。其中 XXX 为组件存放的目录名。

```json5
{
  "modules": [
    {
      "name": "video_edit",
      "srcPath": "./XXX/video_edit"
    },
    {
      "name": "video_common",
      "srcPath": "./XXX/video_common"
    }
  ]
}
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。XXX 为组件存放的目录名称。

```json5
{
  "dependencies": {
    "video_edit": "file:./XXX/video_edit"
  }
}
```

d. 在 `entry` 的 `entry\oh-package.json5` 添加。

```json5
"dependencies": {
"@ohos/mp4parser": "2.0.6"
}
```

### 添加多线程配置文件

a. 在 `entry\src\main\ets` 文件夹下创建名称为“workers”文件夹，在 `entry\src\main\ets\workers` 文件夹下创建名称为“FFmPegWorker.ets”文件。
b. 在 `entry\src\main\ets\workers\FFmPegWorker.ets` 添加。

```ets
import { ErrorEvent, MessageEvents, worker } from '@kit.ArkTS';
import { MP4Parser } from '@ohos/mp4parser';

// 创建 worker 线程端口
const workerPort = worker.workerPort;

// 使用命名类型，避免内联对象字面量类型
interface WorkerMsg {
 id: number;
 k: 'ffmpeg' | 'clip' | 'merge';
 cmd?: string;
 start?: string;
 end?: string;
 input?: string;
 output?: string;
 txt?: string;
 out?: string;
}

interface WorkerReply {
 id: number;
 code: number;
}

// 接收主线程消息（JSON 字符串），解析后执行对应任务
workerPort.onmessage = (e: MessageEvents): void => {
 let payload: string = e.data;
 let codeToSend = -1;
 try {
     const msg = JSON.parse(payload) as WorkerMsg;
     if (msg.k === 'ffmpeg') {
         const cmd = msg.cmd!;
         MP4Parser.ffmpegCmd(cmd, {
             callBackResult: (code: number) => {
             codeToSend = code;
             const reply: WorkerReply = { id: msg.id, code: codeToSend };
             workerPort.postMessage(JSON.stringify(reply));
             }
         });
         return;
     }
     if (msg.k === 'clip') {
         const start = msg.start!;
         const end = msg.end!;
         const input = msg.input!;
         const output = msg.output!;
         MP4Parser.videoClip(start, end, input, output, {
             callBackResult: (code: number) => {
                 codeToSend = code;
                 const reply: WorkerReply = { id: msg.id, code: codeToSend };
                 workerPort.postMessage(JSON.stringify(reply));
             }
         });
         return;
     }
     if (msg.k === 'merge') {
         const txt = msg.txt!;
         const out = msg.out!;
         MP4Parser.videoMultMerge(txt, out, {
             callBackResult: (code: number) => {
                 codeToSend = code;
                 const reply: WorkerReply = { id: msg.id, code: codeToSend };
                 workerPort.postMessage(JSON.stringify(reply));
             }
         });
         return;
     }
     // 未知任务类型
     const reply: WorkerReply = { id: msg.id, code: codeToSend };
     workerPort.postMessage(JSON.stringify(reply));
 } catch (err) {
     const fallback: WorkerReply = { id: -1, code: codeToSend };
     workerPort.postMessage(JSON.stringify(fallback));
 }
}      

// worker 线程错误回调
workerPort.onerror = (err: ErrorEvent) => {}
```

c. 在项目 `entry` 模块下 `build-profile.json5` 中添加 workers 路径配置。

```json5
{
    "buildOption": {
        "sourceOption": {
            "workers": [
                "./src/main/ets/workers/FFmPegWorker.ets"
            ]
        }
    }
}
```

### 引入组件

```ets
import { VideoEditDetailPage, VideoEditDetailVM, ExportVideoPage } from 'video_edit';
```

### 调用组件

详细参数配置说明参见 API 参考。

## API 参考

### 接口

#### VideoEditDetailPage

`VideoEditDetailPage(options?: VideoEditDetailPageOptions)`

视频编辑详情页面组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | VideoEditDetailPageOptions | 否 | 视频编辑页面参数 |

#### ExportVideoPage

`ExportVideoPage(options?: ExportVideoPageOptions)`

视频导出页面组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ExportVideoPageOptions | 否 | 视频导出参数 |

### 对象说明

#### VideoEditDetailPageOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pageParam | TValueType | 否 | 页面参数 |

#### TVariantType 对象说明

| 类型 | 说明 |
| :--- | :--- |
| string, boolean, number, null, Array, Object, Object[], (() => void) | 枚举 |

#### ExportVideoPageOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| exportData | exportVideo | 是 | 导出视频数据 |

#### exportVideo 对象说明

导出视频数据模型。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| videoFormat | string | 是 | 视频格式 |
| videoResolution | string | 是 | 视频分辨率 |
| totalDuration | number | 是 | 总时长 |
| keyFrame | string | 是 | 关键帧 |
| basicVideoData | BasicVideoData[] | 是 | 基础视频数据 |
| exportPipVideo | exportPipVideo[] | 是 | 画中画视频数据 |
| exportSubTitle | exportSubTitle | 是 | 字幕数据 |
| isVip | boolean | 是 | 是否 VIP 用户 |

#### BasicVideoData 对象说明

基础视频数据模型。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| basicUrl | string | 是 | 视频 URL |
| frameList | frameListData[] | 是 | 帧列表 |
| index | number | 是 | 索引 |
| startTime | number | 是 | 开始时间 |
| endTime | number | 是 | 结束时间 |
| duration | number | 是 | 时长 |
| leftShort | number | 是 | 左侧手柄移动距离 |
| scroller | Scroller | 是 | 滚动控制器 |

#### frameListData 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| index | number | 是 | 序列号 |
| mPixelMap | image.PixelMap | 是 | 图像数据 |
| url | string | 是 | 地址 URI |

#### exportPipVideo 对象说明

画中画视频数据模型。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| isEdit | boolean | 是 | 是否编辑 |
| isShape | boolean | 是 | 是否形状 |
| uri | string | 是 | 视频 URI |
| pipFrameList | frameListData[] | 是 | 帧列表 |
| startTime | number | 是 | 开始时间 |
| endTime | number | 是 | 结束时间 |
| duration | number | 是 | 时长 |
| keyFrame | image.PixelMap | 否 | 关键帧 |
| width | number | 是 | 宽度 |
| height | number | 是 | 高度 |
| offsetX | number | 是 | X 偏移 |
| offsetY | number | 是 | Y 偏移 |
| radiusX | number | 是 | X 半径 |
| radiusY | number | 是 | Y 半径 |
| srcWidth | number | 是 | 源宽度 |
| srcHeight | number | 是 | 源高度 |

#### exportSubTitle 对象说明

字幕数据模型。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| url | string | 是 | 字幕 URL |
| text | string | 是 | 字幕文本 |
| width | number | 是 | 宽度 |
| height | number | 是 | 高度 |
| offsetX | number | 是 | X 偏移 |
| offsetY | number | 是 | Y 偏移 |

#### VideoEditDetailVM 对象说明

视频编辑详情视图模型，提供以下主要属性和方法：

**属性：**

| 属性名 | 类型 | 说明 |
| :--- | :--- | :--- |
| allBasicList | DisplayBasicVideoData[] | 基础视频数据列表 |
| basicDuration | number | 基础视频总时长 |
| pipDuration | number | 画中画视频时长 |
| isVip | boolean | 是否 VIP 用户 |

**方法：**

| 方法名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| instance | 无 | VideoEditDetailVM | 获取单例实例 |

### 事件

无

### 示例代码

#### 示例 1（视频编辑页面）

```ets
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@Entry
@ComponentV2
struct Index {
  private navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('开始编辑视频')
          .onClick(() => {
             let selectedVideoUri: string = ''
             let photoSelectOptions: photoAccessHelper.PhotoSelectOptions =
                new photoAccessHelper.PhotoSelectOptions();
             photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE;
             photoSelectOptions.maxSelectNumber = 1;
             let photoViewPicker = new photoAccessHelper.PhotoViewPicker();
             photoViewPicker.select(photoSelectOptions)
                .then(async (photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                   selectedVideoUri = photoSelectResult.photoUris[0]
                   if (selectedVideoUri !== '' && selectedVideoUri &&
                      photoSelectResult.photoUris.length > 0) {
                      let str = JSON.stringify({ url: selectedVideoUri, isVip: true })
                      this.navPathStack.pushPath({ name: 'VideoEditDetailPage', param: str });
                   }
                })
          })
      }
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }
}
```

## 更新记录

### 1.0.0 (2026-02-03)

- Created with Pixso.

## 权限与隐私

### 基本信息

- **权限名称**：ohos.permission.INTERNET
- **权限说明**：允许使用 Internet 网络
- **使用目的**：允许使用 Internet 网络
- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1
- 6.0.2

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1
- DevEco Studio 6.0.2

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ebb94f7f81f445a2a0c411311a8ab9e7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%A7%86%E9%A2%91%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/video_edit1.0.0.zip