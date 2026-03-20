# 文件选择 UIFilePicker

## 简介

UIFilePicker，是一个基于 open harmony 基础 picker 开发的文件选择上传组件，包含图片、视频、音频、压缩包等所有文件类型的选取，以及支持启动自动上传到云存储。其中图片支持栅格模式选取展示、支持大图预览，其他文件类型仅支持列表模式展示。

## 详细介绍

### 简介

UIFilePicker，是一个基于 open harmony 基础 picker 开发的文件选择上传组件，包含图片、视频、音频、压缩包等所有文件类型的选取，以及支持启动自动上传到云存储。其中图片支持栅格模式选取展示、支持大图预览，其他文件类型仅支持列表模式展示。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

深色代码主题复制

```bash
ohpm install @hw-agconnect/ui-file-picker
```

#### 使用

深色代码主题复制

```typescript
// 在业务页面使用组件，比如 xxx.ets
import { UIFilePicker } from '@hw-agconnect/ui-file-picker';

UIFilePicker()
```

### 相关权限

如果启动自动上传云存储的能力，涉及申请权限：ohos.permission.INTERNET 和 ohos.permission.GET_NETWORK_INFO

使用上传到云存储，前提条件：
开通云存储服务，参考开通云存储服务。

为了快速体验云存储的功能，您可以配置云存储的安全策略为始终可读写（无需获取用户凭据），具体操作如下：

a. 登录 AppGallery Connect，点击“我的项目”。
b. 在项目列表中点击您的项目。
c. 在左侧导航栏选择“云开发（Serverless） > 云存储”，进入云存储页面。
d. 选择“安全”页签，在“配置策略”页面修改默认安全策略为始终可读写后，点击“发布”。

深色代码主题复制

```json5
agc.cloud.storage[
    match: /{bucket}/{path=**} {
        allow read, write: if true;
    }
]
```

e. 组件使用可参考示例 5

> [说明]
> 云存储的默认安全策略是允许经过身份验证的用户执行读写操作，需要对 cloudStorageOption
> 中的 cloudOptions 参数进行配置，
> 主要是需要配置认证提供方，
> 可参考示例 4。

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。

DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。

HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

#### UIFilePicker(option: UIFilePickerOptions)

#### UIFilePickerOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| initFiles | IFileModel[] | 否 | 初始传入的数据 |
| readonly | boolean | 否 | 组件是否只读，默认值 false。只读状态下不支持预览、不显示选择、进度、删除按钮、文件大小等 |
| disablePreview | boolean | 否 | 是否禁止大图预览，在栅格展示方式下生效。默认值 false |
| showDelIcon | boolean | 否 | 是否展示删除按钮，默认值 true |
| fileNumLimit | number | 否 | 文件数量限制，默认值 9 |
| mode | FileLayoutMode | 否 | 显示模式，支持列表和栅格，默认值是栅格，注：栅格模式仅在 fileMediaType 为 FileMediaType.IMAGE 时生效 |
| fileMediaType | FileMediaType | 否 | 文件媒体类型，支持仅图片、仅视频、图片和视频、音频和其他文件类型。默认值为仅图片 |
| showLimit | boolean | 否 | 设置是否显示当前选择的数量和上限值，默认值：true |
| customSelectTip | ResourceStr | 否 | 设置引导选择文件的提示语 |
| cloudStorageOption | ICloudStorageOption | 否 | 设置云存储选项 |
| btnOption | IBtnOption | 否 | 按钮选项 |
| listOption | IListOption | 否 | 列表选项，仅在 mode 取值 FileLayoutMode.LIST 时生效 |
| packingOption | IPackingOption | 否 | 打包选项 |

#### IFileModel 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 否 | 文件 id，唯一索引，自动生成 |
| uri | string | 否 | 系统 picker 获取的 uri |
| name | string | 是 | 文件名 |
| buffer | ArrayBuffer\|undefined | 是 | 文件 buffer |
| pixelMap | PixelMap\| undefined | 否 | 图片的 pixelMap |
| type | FileMediaType | 否 | 文件类型 |
| processed | number | 否 | 上传进度 |
| uploadStatus | request.agent.State | 否 | 上传状态 |
| sizes | number | 否 | 上传文件总大小 |
| url | string | 否 | 云端的地址 |

#### ICloudStorageOption 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| autoUpload | boolean | 是 | 是否开启自动上传到云存储，默认值 false |
| bucketName | string | 否 | 存储实例名称。格式受云侧约束，只允许输入小写字母、数字、'-'，以字母或数字开头和结尾，长度为 9-63 个字符，且不能连续输入两个及以上'-'。缺省时，将启动异步任务查询云侧默认实例。非缺省时，请确保当前云侧存在该存储实例，否则后续操作将出现查询存储实例错误。 |
| dirName | string | 否 | 存储目录名称，默认值为/ |
| cloudOptions | cloudCommon.CloudOptions | 否 | 云开发初始化选项 |

#### IPackingOption 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | FileSizeType | 是 | 文件质量，支持原图、重新打包，默认值为原图。注：重新打包仅在 fileMediaType 为 FileMediaType.IMAGE 时生效 |
| format | string | 否 | 图片打包的格式，默认值 image/jpeg。当前只支持"image/jpeg"、"image/webp"、"image/png"和"image/heif"。注：仅在 sizeType 设置 FileSizeType.COMPRESSED 生效 |
| quality | number | 否 | 图片打包的质量，取值 0-100，默认值 50。注：仅在 sizeType 设置 FileSizeType.COMPRESSED 生效 |

#### IBtnOption 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | SelectBtnType | 是 | 设置按钮类型，默认值：SelectBtnType.SIMPLE |
| label | ResourceStr | 否 | 按钮主文字 |
| subLabel | ResourceStr | 否 | 按钮辅助文字，仅在 type 取值 SelectBtnType.RICH 时生效 |

#### IListOption 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| processBarColor | ResourceColor | 否 | 设置上传进度条颜色，仅在 cloudStorageOption.autoUpload 为 true 时生效 |
| showFileIcon | boolean | 否 | 设置是否展示文件类型图标 |
| listHeight | Length | 否 | 列表高度 |

#### FileLayoutMode 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| LIST | 列表模式 |
| GRID | 栅格模式 |

#### FileMediaType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| IMAGE | 仅图片 |
| VIDEO | 仅视频 |
| IMAGE_VIDEO | 图片和视频 |
| AUDIO | 仅音频 |
| ALL | 所有文件类型 |

#### FileSizeType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| ORIGINAL | 原图 |
| PACKING | 重新打包 |

#### SelectBtnType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| SIMPLE | 简单按钮 |
| RICH | 复杂按钮 |

### 事件

| 名称 | 功能 | 描述 |
| :--- | :--- | :--- |
| onSelect: (files: IFileModel[]) => void | 选择文件后的回调 | 选择文件后的回调 |
| onDelete: (file: IFileModel) => void | 删除文件后的回调 | 删除文件后的回调 |
| onChange(callback: (files: IFileModel[]) => void) | 文件列表数据发生变化的回调 | 文件列表数据发生变化的回调 |
| onProcess(callback: (file: IFileModel, progress: request.agent.Progress) => void) | 开启自动上传后，上传过程的回调 | 开启自动上传后，上传过程的回调 |
| onSuccess(callback: (file: IFileModel, progress: request.agent.Progress) => void) | 开启自动上传后，上传成功的回调 | 开启自动上传后，上传成功的回调 |
| onFail(callback: (file: IFileModel, progress: request.agent.Progress) => void) | 开启自动上传后，上传失败的回调 | 开启自动上传后，上传失败的回调 |

### 示例

#### 示例 1（栅格模式）

深色代码主题复制

```typescript
import { IFileModel, UIFilePicker } from '@hw-agconnect/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample1 {
 build() {
   Column() {
     NavDestination() {
       Column() {
         UIFilePicker({
           onSelect: (files: IFileModel[]) => {
             console.log('onSelect, count of files: ' + files.length);
           }
         })
       }
       .width('100%')
       .padding(16)
     }
     .title('栅格模式')
     .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
   }
 }
}
```

#### 示例 2（列表模式）

深色代码主题复制

```typescript
import { FileLayoutMode, UIFilePicker } from '@hw-agconnect/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample2 {
 build() {
   Column() {
     NavDestination() {
       Column() {
         UIFilePicker({ mode: FileLayoutMode.LIST })
       }
       .width('100%')
       .padding(16)
     }
     .title('列表模式')
     .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
   }
 }
}
```

#### 示例 3（复杂按钮）

深色代码主题复制

```typescript
import { FileLayoutMode, FileMediaType, SelectBtnType, UIFilePicker } from '@hw-agconnect/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample3 {
 build() {
   Column() {
     NavDestination() {
       Column() {
         UIFilePicker({
           mode: FileLayoutMode.LIST,
           btnOption: {
             type: SelectBtnType.RICH,
           },
           fileMediaType: FileMediaType.ALL,
         })
       }
       .width('100%')
       .padding(16)
     }
     .title('复杂按钮')
     .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
   }
 }
}
```

#### 示例 4（开启自动上云 - 云存储安全策略为需鉴权）

深色代码主题复制

```typescript
import { cloudCommon } from '@kit.CloudFoundationKit';
import auth from '@hw-agconnect/auth';
import { FileLayoutMode, FileMediaType, IFileModel, SelectBtnType, UIFilePicker } from '@hw-agconnect/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample4 {
 authProvider: cloudCommon.AuthProvider = auth.getAuthProvider();

 async aboutToAppear(): Promise<void> {
   const user = await auth.getCurrentUser();
   if (!user) {
     await auth.signIn({
       autoCreateUser: true,
       credentialInfo: {
         kind: 'hwid',
       },
     });
     this.authProvider = auth.getAuthProvider();
   }
 }

 build() {
   Column() {
     NavDestination() {
       Column() {
         UIFilePicker({
           mode: FileLayoutMode.LIST,
           fileMediaType: FileMediaType.ALL,
           btnOption: {
             type: SelectBtnType.RICH,
           },
           cloudStorageOption: {
             autoUpload: true,
             dirName: 'ui_component_screenshots/',
             cloudOptions: {
               authProvider: this.authProvider,
             },
           },
           onSuccess: (file: IFileModel) => {
             console.log('file url: ' + file.url);
           },
         })
       }
       .width('100%')
       .padding(16)
     }
     .title('开启自动上云 - 云存储安全策略为需鉴权')
     .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
   }
 }
}
```

#### 示例 5（开启自动上传 - 云存储安全策略为始终可读写）

深色代码主题复制

```typescript
import { FileLayoutMode, FileMediaType, SelectBtnType, UIFilePicker } from '@hw-agconnect/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample5 {
 build() {
   Column() {
     NavDestination() {
       Column() {
         UIFilePicker({
           mode: FileLayoutMode.LIST,
           fileMediaType: FileMediaType.ALL,
           btnOption: {
             type: SelectBtnType.RICH,
           },
           cloudStorageOption: {
             autoUpload: true,
           },
         })
       }
       .width('100%')
       .padding(16)
     }
     .title('开启自动上传 - 云存储安全策略为始终可读写')
     .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
   }
 }
}
```

## 更新记录

### 1.0.2 (2025-12-15)

Created with Pixso.

下载该版本内部资源

### 1.0.1 (2025-09-30)

Created with Pixso.

下载该版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 状态 |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

### 应用类型

| 类型 | 状态 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 状态 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEco Studio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-file-picker
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b6c26a9805964442adaee878e36c5fa0/2adce9bbd4cb42d58a87e6add45594b3?origin=template