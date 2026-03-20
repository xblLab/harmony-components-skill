# 音频提取组件

## 简介

本组件提供了从视频文件中提取音频的功能，支持视频预览播放、自定义输出格式、实时进度显示等功能。

## 详细介绍

### 简介

本组件提供了从视频文件中提取音频的功能，支持视频预览播放、自定义输出格式、实时进度显示等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

无

#### 调试

本组件不支持使用模拟器调试，请使用真机进行调试。

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `audio_worker`、`audio_common`、`audio_extraction` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 audio_worker、audio_common、audio_extraction 路径。其中 xxx 为组件存放的目录名
"modules": [
  {
    "name": "audio_extraction",
    "srcPath": "./xxx/audio_extraction"
  },
  {
    "name": "audio_common",
    "srcPath": "./xxx/audio_common"
  },
  {
    "name": "audio_worker",
    "srcPath": "./xxx/audio_worker",
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

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
{
  "dependencies": {
    "audio_extraction": "file:./xxx/audio_extraction",
    "audio_common": "file:./XXX/audio_common"
  }
}
```

4. 在项目 `entry` 模块的 `src/main/ets/entryability/EntryAbility.ets` 文件中，给吸色功能初始化 Context（必须）。

```typescript
import { CommonContext } from 'audio_common';

// 初始化上下文
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   CommonContext.setContext(this.context)
}
```

#### 引入组件

```typescript
import { AudioExtractionPage } from 'audio_extraction';
```

#### 调用组件

详细参数配置说明参见 API 参考。

### API 参考

#### 接口

**AudioExtractionPage**

`AudioExtractionPage(options?: AudioExtractionPageOptions)`

音频提取页面组件，包含完整的视频选择、预览和音频提取功能界面。

**AudioExtractionPageOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| resultCallBack(outPath: string) => void | Function | 否 | 提取完成回调，返回输出文件路径。可在此回调中获取输出文件信息、显示提示、保存到作品列表等操作。如不传入，组件将使用默认处理逻辑。 |
| backHandle() => void | Function | 否 | 返回按钮回调。点击页面左上角返回按钮时触发。如不传入，返回按钮将不执行任何操作。 |
| vipLevel | number | 否 | 提取次数限制。0：不可提取，1：10 次提取，2：不限次数 |

#### 示例代码

```typescript
import { AudioExtractionPage } from 'audio_extraction';
import { promptAction, router } from '@kit.ArkUI';
import { fileIo, picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@ComponentV2
struct Index {
   @Local resultCallBack: ((outPath: string) => void) | undefined = undefined;
   @Local backHandle: (() => void) | undefined = undefined;
   
   defaultResultCallBack = async (outPath: string) => {
      try {
         const documentSaveOptions = new picker.DocumentSaveOptions();
         let fileName = 'extracted_audio.mp3';
         const lastSeparator = outPath.lastIndexOf('/');
         if (lastSeparator != -1) {
            fileName = outPath.substring(lastSeparator + 1);
         }
         documentSaveOptions.newFileNames = [fileName];

         const documentViewPicker = new picker.DocumentViewPicker();
         documentViewPicker.save(documentSaveOptions).then(async (documentSaveResult: Array<string>) => {
            if (documentSaveResult && documentSaveResult.length > 0) {
               let uri = documentSaveResult[0];
               try {
                  let file = await fileIo.open(outPath, fileIo.OpenMode.READ_ONLY);
                  let destFile = await fileIo.open(uri, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
                  await fileIo.copyFile(file.fd, destFile.fd);
                  fileIo.closeSync(file.fd);
                  fileIo.closeSync(destFile.fd);
                  promptAction.showToast({ message: '保存成功' });
                  AlertDialog.show({
                     title: '保存成功',
                     message: '文件已保存到本地。\n源文件沙箱路径：' + outPath,
                     confirm: {
                        value: '确定',
                        action: () => {
                        }
                     }
                  })
               } catch (e) {
                  console.error('保存文件失败', JSON.stringify(e));
                  promptAction.showToast({ message: '保存失败' });
               }
            }
         }).catch((err: BusinessError) => {
            console.error('DocumentViewPicker save failed', JSON.stringify(err));
         });
      } catch (err) {
         console.error('defaultResultCallBack failed', JSON.stringify(err));
      }
   }
   
   handleBack = () => {
      if (this.backHandle) {
         this.backHandle();
      } else {
         router.back();
      }
   }

   build() {
      NavDestination() {
         Column() {
            AudioExtractionPage({
               resultCallBack: this.defaultResultCallBack,
               backHandle: this.handleBack,
               vipLevel: 2
            })
         }
         .width('100%')
            .height('100%')
            .backgroundColor('#0A0D1E')
      }
      .hideTitleBar(true)

         .onReady((context: NavDestinationContext) => {
         })
   }
}
```

### 更新记录

- **1.0.0** (2026-02-04)
  - 初始版本

### 下载该版本

- **版本**：初始版本
- **权限与隐私基本信息**
  - 权限名称：无
  - 权限说明：无
  - 使用目的：无
  - 隐私政策：不涉及
  - SDK 合规使用指南：不涉及
- **兼容性**
  - HarmonyOS 版本：
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
- **应用类型**
  - 应用
  - 元服务
- **设备类型**
  - 手机
  - 平板
  - PC
- **DevEco Studio 版本**
  - DevEco Studio 5.0.5
  - DevEco Studio 5.1.0
  - DevEco Studio 5.1.1
  - DevEco Studio 6.0.0
  - DevEco Studio 6.0.1
  - DevEco Studio 6.0.2

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9d7d9aefd6d3476b8c2faa80df68695c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%9F%B3%E9%A2%91%E6%8F%90%E5%8F%96%E7%BB%84%E4%BB%B6/audio_extraction1.0.0.zip