# ohos/image-edit 图片编辑组件

## 简介

一个功能完整、可扩展的 HarmonyOS ArkTS 图片编辑组件，提供画板、马赛克、裁剪、文字四大核心功能，支持灵活的配置和自定义。

## 详细介绍

### 项目简介

一个功能完整、可扩展的 HarmonyOS ArkTS 图片编辑组件，提供画板、马赛克、裁剪、文字四大核心功能，支持灵活的配置和自定义。

### 下载安装

```bash
ohpm install @ohos/image-edit
```

### 功能特性

#### 核心功能

- **画板功能**：自由绘画，支持多种颜色和笔刷大小
- **马赛克功能**：区域模糊处理，保护隐私内容
- **裁剪功能**：图片裁剪、旋转、比例锁定
- **文字功能**：添加文字水印，支持拖拽、旋转、样式调整

#### 高级特性

- **撤销/重做系统**：完整的操作历史管理
- **实时预览**：所有编辑操作实时可见
- **灵活的配置**：支持功能自定义

### 使用说明

#### 首页入口

```ets
@Entry
@Component
struct Index {
  @Provide stack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.stack) {
      Column({ space: 16 }) {
        Button('图片编辑')
          .id('imageEdit')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.stack.pushPath({ name: 'ImageEditTestPage' });
          });
      };
    }.height('100%')
     .width('100%');
  }
}
```

#### 图片编辑组件

```ets
export struct ImageEditTestPage {
  @Local sourcePixelMap: image.PixelMap | undefined = undefined;
  @Local pathStack: NavPathStack = new NavPathStack();
  private context?: NavDestinationContext;
  private imagePickerCallback: AsyncCallback<PixelMap> = async (err, pixelMap) => {
    Logger.i(MODULE, TAG, 'AsyncCallback err ' + JSON.stringify(err) + ',pixelMap:' + JSON.stringify(pixelMap));
    this.sourcePixelMap = pixelMap;
    this.option = {
      pixelMap: this.sourcePixelMap,
      enableFunctions: [
        { type: ImageEditFunctionType.CROP },
        { type: ImageEditFunctionType.TEXT },
        { type: ImageEditFunctionType.PALETTE },
        { type: ImageEditFunctionType.MOSAIC }
      ],
      callback: this.imageEditCallback,
      finishButtonText: '保存'
    };
  };
  private imageEditCallback: ImageEditAsyncCallback = {
    onSuccess: (result: ImageEditResult): void => {
      Logger.i(MODULE, TAG, 'imageEditCallback onSuccess ');
      SaveToPhotoUtils.save({ pixelMap: result.pixelMap, path: getContext().cacheDir + '/imageEdit/' }).then((res: boolean) => {
        if(res) {
          this.pathStack.pop();
        }
      });
    },
    onFailure: (err: ImageEditError): void => {
      Logger.e(MODULE, TAG, 'imageEditCallback onFailure ' + JSON.stringify(this.sourcePixelMap?.getImageInfoSync()));
    },
    onCancel: (): void => {
      this.pathStack.pop();
      Logger.e(MODULE, TAG, 'imageEditCallback onCancel ');
    }
  };
  @Local option?: ImageEditOption;

  build() {
    NavDestination() {
      this.pageBuilder();
    }.onReady((data: NavDestinationContext) => {
      this.context = data;
      this.pathStack = data.pathStack;
      PhotoImagePickerUtils.selectImage(this.pathStack, this.imagePickerCallback);
    }).hideTitleBar(true);
  }

  @Builder
  pageBuilder() {
    if (this.sourcePixelMap) {
      ImageEditComponent({ option: this.option });
    }
  }
}
```

#### 图片马赛克接口

通过 `imageToMosaic` 接口传入像素图，输出马赛克后的像素图。

```ts
import { imageToMosaic } from '@ohos/image-edit';

imageToMosaic(pixelMap).then((result: PixelMap | undefined) => {
  if (result) {
    // this.context.drawImage(result, 0, 0)
  }
})
```

### 接口说明

#### ImageEditComponent 组件

| 组件名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| ImageEditComponent | ImageEditOption | 图片编辑组件 |

#### ImageEditOption 参数列表

| 参数名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| pixelMap | PixelMap | 像素图 |
| callback | ImageEditAsyncCallback | 编辑结果回调 |
| original | boolean | 是否原图，如果传入原图，则对编辑后最终生成的图片尺寸产生差异化处理（可选） |
| enableFunctions | Array | 使能的功能列表，只取前 4 个配置，不配置或者配置全部无效则按照全部使能处理（可选） |
| finishButtonText | ResourceStr | 完成按钮文案，不配置默认为：完成（可选） |
| finishButtonDisableWhenUnModified | boolean | 编辑页面未修改场景下完成按钮是否置灰不使能，默认值:false（可选） |
| outputImageSizePolicy | ImageEditSizePolicy | 输出图像尺寸策略（可选） |

#### ImageEditAsyncCallback 回调接口说明

| 回调接口 | 回调字段 | 回调描述 |
| :--- | :--- | :--- |
| onSuccess | result: ImageEditResult | 成功回调，result: 压缩结果 |
| onFailure | error: ImageEditError | 失败回调，error：错误信息 |
| onCancel | 无 | 用户取消操作 |

#### ImageEditFunctionItemOption 编辑功能项选项

| 参数名 | 相关描述 |
| :--- | :--- |
| type | 功能类型（画板、马赛克、裁剪、文字） |
| title | 功能标题 |
| iconRes | 功能按钮图标资源名称 |

#### imageToMosaic 接口参数列表

| 参数名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| pixelMap | PixelMap | 像素图 |

**返回值**

| 类型 | 说明 |
| :--- | :--- |
| Promise | Promise 对象，返回 PixelMap |

### 具体实现

- **画板功能**：通过 Canvas 捕获触摸路径实时绘制矢量线条并记录操作历史。
- **马赛克功能**：对触摸区域的像素进行分块平均色值计算实现模糊效果。
- **裁剪功能**：通过矩阵变换调整图片显示区域并使用选择框确定裁剪范围。
- **文字功能**：在 NodeContainer 中动态创建可交互的文本节点并支持样式调整。
- **图片马赛克**：传入像素图输出马赛克后的像素图。

### 约束与限制

在下述版本验证通过：
- DevEco Studio 5.1.0 Release(5.1.0.849)
- SDK: API17(5.0.5)

### 工程目录

```text
├── ets
│   ├── components                   
│   │   ├── iconfont                   // 图标字体 - 自定义图标资源
│   │   ├── textInput                  // 文字输入 - 文本编辑相关组件
│   │   ├── widget                     // 通用部件 - 可复用 UI 组件
│   │   ├── CropComponent.ets          // 裁剪组件 - 图片裁剪和旋转功能
│   │   ├── MosaicComponent.ets        // 马赛克组件 - 区域模糊处理功能
│   │   └── PaletteComponent.ets       // 画板组件 - 自由绘画功能
│   ├── controller                    
│   │   └── EditController.ets         // 编辑控制器 - 操作记录和撤销管理
│   ├── log                          
│   │   └── Logger.ets                 // 日志工具 - 统一日志输出
│   ├── model                        
│   │   ├── ImageEditModel.ets         // 图片编辑数据模型 - 定义数据结构
│   ├── util                         
│   │   ├── MosaicPixelMapHelper.ets   // 马赛克像素处理 - 马赛克算法实现
│   │   ├── MosaicTaskUtil.ets         // 马赛克任务工具 - 异步处理任务
│   │   ├── PixelMapResizer.ets        // 像素图缩放工具 - 图片尺寸调整
│   │   ├── StringUtils.ets            // 字符串工具 - 文本处理工具
│   │   ├── TextInputUtils.ets         // 文字输入工具 - 文本相关工具
│   ├── ImageEditComponent.ets        // 主组件 - 图片编辑入口组件
│   ├── ImageEditInterface.ets        // 接口定义 - 组件接口和枚举定义
│   ├── ImageMosaicMethod.ets         // 图片马赛克接口
```

### 开源协议

Apache License 2.0

### 更新记录

- **1.0.0** (2025-12-04)

### 基本信息

#### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

#### 隐私政策

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.4 |
| 应用类型 | 应用 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 |

## 安装方式

```bash
ohpm install @ohos/image-edit
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f120a4172efe4e1cb7b6e6a736cbd331/PLATFORM?origin=template