# 音频调速组件

## 简介

本组件提供了音频调速功能，支持选择音频文件，进行音频调速。

## 详细介绍

### 简介

本组件提供了音频调速功能，支持选择音频文件，进行音频调速。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

#### 调试

本组件不支持使用模拟器调试，请使用真机进行调试

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `audio_worker`、`audio_common`、`audio_adjust_speed` 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 audio_adjust_speed、audio_worker、audio_common 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "audio_common",
    "srcPath": "./XXX/audio_common"
  },
  {
    "name": "audio_adjust_speed",
    "srcPath": "./XXX/audio_adjust_speed"
  },
  {
    "name": "audio_worker",
    "srcPath": "./XXX/audio_worker",
    "targets": [
      {
        "name": "default",
        "applyToProducts": [
          "default"
        ]
      }
    ]
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
{
  "dependencies": {
      "audio_adjust_speed": "file:./XXX/audio_adjust_speed",
      "audio_common": "file:./XXX/audio_common"
  }
}
```

在项目 `entry` 模块的 `src/main/ets/entryability/EntryAbility.ets` 文件中，初始化 Context。

深色代码主题复制
```typescript
import { CommonContext } from 'audio_common';

// 初始化上下文
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   CommonContext.setContext(this.context)
}
```

引入组件。

深色代码主题复制
```typescript
import { AudioAdjustSpeed } from 'audio_adjust_speed'
```

调用组件，详细参数配置说明参见 API 参考。

### API 参考

#### 接口

**AudioAdjustSpeed(params: AudioAdjustSpeedParams): void**
音频调速组件，提供音频播放、调速、保存等功能。

**AudioAdjustSpeedParams**
AudioAdjustSpeed 组件的参数结构体。

| 字段名 | 类型 | 是否必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| musicTitle | string | 是 | '' | 音频文件名称 |
| pcmPath | string | 是 | '' | PCM 文件输出的沙箱路径 |
| sourcePath | string | 是 | '' | 源音频文件沙箱路径 |
| channelLayout | number | 是 | 0 | 声道数量（1=单声道，2=立体声） |
| sampleRate | number | 是 | 0 | 采样率（如 44100） |
| format | string | 是 | '' | 源音频文件格式 |
| duration | number | 是 | 0 | 音频时长（毫秒） |
| sampleFormat | number | 是 | 0 | 音频采样格式（如 SAMPLE_FORMAT_F32LE） |
| backHandle() => void | function | 否 | () => {} | 返回按钮回调函数 |
| resultCallBack(outPath: string) => void | function | 否 | (outPath: string) => {} | 音频调速完成后的回调函数，返回输出文件路径 |
| pageParams | TValueType | 否 | null | 页面参数（可选） |

**TValueType**
页面参数类型定义。

深色代码主题复制
```typescript
type TValueType = string | boolean | number | null | Array<TValueType> | Object | Object[] | (() => void)
```

### 示例代码

深色代码主题复制
```typescript
import { AudioAdjustSpeed } from 'audio_adjust_speed'
import { audio } from '@kit.AudioKit'
import { common } from '@kit.AbilityKit'
import { promptAction } from '@kit.ArkUI'
import { FileUtil,ICallBack, MP4Parser } from 'audio_common'
import { picker } from '@kit.CoreFileKit'

interface AudioFileMetadata {
 streams: AudioStream[]
 format: AudioFormatInfo
}

interface AudioStream {
 codec_type: 'audio' | 'video' | 'subtitle'
 sample_rate: string
 channel_layout: string
}

interface AudioFormatInfo {
 duration: string
 format_name: string
}

interface StringCallBack {
 callBackResult: (code: string) => void
}

function getChannelLayout(ac: string): number {
 switch (ac) {
   case 'mono':
     return 1
   case 'stereo':
     return 2
   case '5.1':
     return 6
   case '7.1':
     return 8
   default:
     return 1
 }
}

function getMetaData(path: string, callBack: StringCallBack): void {
 MP4Parser.getMetaData(path, callBack)
}

function changeToPcm(
 context: Context,
 path: string,
 callBackPCM: (pcmPath: string, channelLayout: number, sampleRate: number) => void,
 error: () => void
): void {
 getMetaData(path, {
   callBackResult: (res: string) => {
     if (!res) {
       error()
       return
     }
     const tempData = JSON.parse(res) as AudioFileMetadata
     const streams = tempData.streams

     let sampleRate = ''
     let channelLayout = 0

     for (let index = 0; index < streams.length; index++) {
       const stream = streams[index]
       if (stream.codec_type === 'audio') {
         sampleRate = stream.sample_rate
         channelLayout = getChannelLayout(stream.channel_layout)
         break
       }
     }

     if (!sampleRate || channelLayout === 0) {
       error()
       return
     }

     const fileUtil = new FileUtil(context as common.UIAbilityContext)
     const pcmDir = fileUtil.getAudioPcmDir()
     const prefixName = fileUtil.splitFilePath(path)[1]
     const pcmPath = pcmDir + prefixName + '.pcm'
     const logPath = pcmDir + prefixName + '.log'
     fileUtil.deleteFileByPath(pcmPath)
     fileUtil.deleteFileByPath(logPath)

     const callBack: ICallBack = {
       callBackResult(code: number) {
         if (code === 0) {
           callBackPCM(pcmPath, channelLayout, Number(sampleRate))
         } else {
           error()
         }
       }
     }
     const ffmpegCmd = `ffmpeg -i ${path} -ar ${sampleRate} -ac ${channelLayout} -f f32le ${pcmPath} -progress ${logPath}`
     MP4Parser.ffmpegCmd(ffmpegCmd, callBack)
   }
 })
}

@Entry
@Component
struct AudioAdjustSpeedPage {
 @State pcmPath: string = ''
 @State sourcePath: string = ''
 @State channelLayout: number = 0
 @State sampleRate: number = 0
 @State duration: number = 0
 @State musicTitle: string = ''
 @State format: string = ''
 @State sampleFormat: number = audio.AudioSampleFormat.SAMPLE_FORMAT_F32LE
 @State isLoading: boolean = true
 @State isReady: boolean = false
 private dialogController: CustomDialogController | null = null
 private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext

 aboutToAppear(): void {
   this.selectAudioFile()
 }

 selectAudioFile(): void {
   let audioSelectOptions = new picker.AudioSelectOptions();
   let audioPicker = new picker.AudioViewPicker(this.context);
   // 配置单选参数（关键步骤）
   audioSelectOptions.maxSelectNumber = 1; // 单选限制为 1 个文件
   audioPicker.select(audioSelectOptions).then(async (audioSelectResult: Array<string>) => {
     if (!audioSelectResult || audioSelectResult.length === 0) {
       promptAction.showToast({ message: '未选择音频文件' })
       return
     }
     const uri = audioSelectResult[0]
     try {
       const fileUtil = new FileUtil(this.context)
       const format = fileUtil.splitFilePath(uri)[2]
       const fileName = decodeURIComponent(fileUtil.splitFilePath(uri)[1]).replace(/\s+/g, '')
       const cacheDir = fileUtil.getAudioCacheDir()
       const targetPath = cacheDir + fileName + '.' + format
       await FileUtil.copyFileToDestPath(uri, targetPath)
       this.getAudioMetadata(targetPath, fileName + '.' + format, format)
     } catch (err) {
       promptAction.showToast({ message: '处理音频文件失败' })
     }
   })
 }

 getAudioMetadata(filePath: string, fileName: string, format: string): void {
   getMetaData(filePath, {
     callBackResult: (res: string) => {
       if (!res) {
         promptAction.showToast({ message: '获取音频信息失败' })
         return
       }

       try {
         const tempData = JSON.parse(res) as AudioFileMetadata
         const formatInfo = tempData.format
         const duration = formatInfo.duration ? Math.floor(parseFloat(formatInfo.duration) * 1000) : 0
         this.convertToPcm(filePath, fileName, duration, format)
       } catch (err) {
         promptAction.showToast({ message: '解析音频信息失败' })
       }
     }
   })
 }

 convertToPcm(filePath: string, fileName: string, duration: number, format: string): void {
   const callBack = (pcmPath: string, channelLayout: number, sampleRate: number) => {
     this.pcmPath = pcmPath
     this.sourcePath = filePath
     this.channelLayout = channelLayout
     this.sampleRate = sampleRate
     this.duration = duration
     this.musicTitle = fileName
     this.format = format
     this.isLoading = false
     this.isReady = true
   }

   const errorBack = () => {
     promptAction.showToast({ message: '音频转换失败' })
   }

   changeToPcm(this.context, filePath, callBack, errorBack)
 }

 showSaveSuccessDialog(filePath: string): void {
   const fileName = filePath.substring(filePath.lastIndexOf('/') + 1)
   const displayPath = `文件已保存\n路径：${filePath}\n文件名：${fileName}`
   
   this.dialogController = new CustomDialogController({
     builder: SaveSuccessDialog({
       filePath: displayPath,
       onConfirm: () => {
         this.dialogController?.close()
       }
     }),
     autoCancel: true,
     alignment: DialogAlignment.Center,
     customStyle: true
   })
   this.dialogController.open()
 }

 build() {
   Column() {
     if (this.isLoading) {
       Column() {
         LoadingProgress()
           .width(50)
           .height(50)
           .color('#01FCEA')

         Text('正在处理音频文件...')
           .fontSize(14)
           .fontColor('#666666')
           .margin({ top: 16 })
       }
       .width('100%')
       .height('100%')
       .justifyContent(FlexAlign.Center)
       .backgroundColor('#0A0D1E')
     } else if (this.isReady) {
       AudioAdjustSpeed({
         musicTitle: this.musicTitle,
         pcmPath: this.pcmPath,
         sourcePath: this.sourcePath,
         channelLayout: this.channelLayout,
         sampleRate: this.sampleRate,
         duration: this.duration,
         sampleFormat: this.sampleFormat,
         format: this.format,
         backHandle: () => {
         },
         resultCallBack: (outPath: string) => {
           this.showSaveSuccessDialog(outPath)
          new FileUtil(this.context)?.deleteFileByPath(outPath)

         }
       })
     }
   }
   .width('100%')
   .height('100%')
 }
}

@CustomDialog
struct SaveSuccessDialog {
 controller?: CustomDialogController
 filePath: string = ''
 onConfirm: () => void = () => {}

 build() {
   Column() {
     Image($r('sys.media.ohos_ic_public_ok'))
       .width(48)
       .height(48)
       .fillColor('#00C853')
       .margin({ bottom: 16 })

     Text('保存成功')
       .fontSize(20)
       .fontWeight(FontWeight.Bold)
       .margin({ bottom: 12 })

     Text(this.filePath)
       .fontSize(12)
       .fontColor('#666666')
       .textAlign(TextAlign.Center)
       .margin({ bottom: 24 })
       .width('100%')
       .maxLines(5)

     Button('确定')
       .width('100%')
       .height(40)
       .backgroundColor('#01FCEA')
       .fontColor('#000000')
       .onClick(() => {
         this.onConfirm()
       })
   }
   .padding(24)
   .backgroundColor(Color.White)
   .borderRadius(16)
   .width('85%')
 }
}
```

## 更新记录

### 1.0.0 (2026-02-04)

Created with Pixso.

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.2 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.2 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f57daaa3bcdb4bbd8d208f79105974ae/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%9F%B3%E9%A2%91%E8%B0%83%E9%80%9F%E7%BB%84%E4%BB%B6/audio_adjust_speed1.0.0.zip