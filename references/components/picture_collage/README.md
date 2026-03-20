# 图片拼接组件

## 简介

图片拼接组件，支持图片按网格直接拼接、海报拼接、模板拼接。

## 详细介绍

### 简介

图片拼接组件，支持图片按网格直接拼接、海报拼接、模板拼接。

### 功能列表

- 直接拼接
- 海报拼接
- 模板拼接

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `picture_collage` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 picture_collage 路径。其中 XXX 为组件存放的目录名。
"modules": [
  {
    "name": "picture_collage",
    "srcPath": "./XXX/picture_collage"
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "picture_collage" : "file:./XXX/picture_collage"
}
```

### 引入组件

```typescript
import { PictureCollage } from 'picture_collage';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
// 引入组件
import { PictureCollage } from 'picture_collage';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
   @State imageUris:string[] = []

   aboutToAppear(): void {
      // 设置图片选择器选项
      const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 3;
      // 创建并实例化图片选择器
      const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
      // 选择图片并获取图片 URI
      photoViewPicker.select(photoSelectOptions).then((result: photoAccessHelper.PhotoSelectResult) => {
         this.imageUris = result.photoUris
      }).catch((err: BusinessError) => {
         console.error(`PhotoViewPicker.select failed with err: ${err.code}, ${err.message}`);
      });
   }
   
   build() {
      Column() {
         PictureCollage({
            imageUris: this.imageUris,
         });
      }
   }
}
```

## API 参考

### 子组件

无

### 接口

`PictureCollage(options?: PictureCollageOptions)`

图片拼接组件，支持图片按网格直接拼接、海报拼接、模板拼接。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PictureCollageOptions | 否 | 图片拼接组件的参数。 |

#### PictureCollageOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imageUris | string[] | 是 | 传入待拼接图片 uri 列表 |
| directTemplates | DirectTemplate[] | 否 | 按网格拼接的网格样式列表 |
| posterList | PosterInfo | 否 | 海报拼接的海报样式列表 |
| templateList | PosterInfo | 否 | 模板拼接的海报样式列表 |

#### DirectTemplate 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imageResource | ResourceStr | 是 | 网格模板图片 resource |
| rowsTemplate | string | 是 | 网格行数量和占比 |
| columnsTemplate | string | 是 | 网格列数量和占比 |
| areas | AreaConfig[] | 是 | 网格各空间配置对象列表 |

#### AreaConfig 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 网格空间 id |
| rowStart | number | 是 | 起始行 |
| rowEnd | number | 是 | 结束行 |
| colStart | number | 是 | 起始列 |
| colEnd | number | 是 | 结束列 |

#### PosterInfo 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| showImage | ResourceStr | 是 | 样例图片 resource |
| collageParts | PosterCollagePart[] | 是 | 海报可拼接区域信息 |
| isVip | boolean | 否 | 是否 vip |
| posterImage | ResourceStr | 否 | 背景图片 resource |

#### PosterCollagePart 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| collagePositionX | Length | 是 | 区域起始 x 坐标 |
| collagePositionY | Length | 是 | 区域起始 Y 坐标 |
| collageWidth | Length | 是 | 区域宽度 |
| collageHeight | Length | 是 | 区域长度 |
| borderRadius | Length | 是 | 区域圆角 |

## 示例代码

### 示例 1（传入不同模板拼接）

本示例通过传入多个模板实现图片直接拼接，根据选择图片数量展示不同的模板，切换模板实现不同拼接。

```typescript
// 引入组件
import { PictureCollage } from 'picture_collage';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
   @State imageUris:string[] = []

   aboutToAppear(): void {
      // 设置图片选择器选项
      const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 3;
      // 创建并实例化图片选择器
      const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
      // 选择图片并获取图片 URI
      photoViewPicker.select(photoSelectOptions).then((result: photoAccessHelper.PhotoSelectResult) => {
         this.imageUris = result.photoUris
      }).catch((err: BusinessError) => {
         console.error(`PhotoViewPicker.select failed with err: ${err.code}, ${err.message}`);
      });
   }
   
   build() {
      Column() {
         PictureCollage({
            imageUris: this.imageUris,
            directTemplates: [
               {
                  rowsTemplate: '1fr 1fr',
                  columnsTemplate: '1fr 1fr',
                  imageResource: $r('app.media.direct4'),
                  areas: [
                     {
                        id: 'left',
                        rowStart: 0,
                        rowEnd: 1,
                        colStart: 0,
                        colEnd: 0
                     }, // 跨两行
                     {
                        id: 'right',
                        rowStart: 0,
                        rowEnd: 1,
                        colStart: 1,
                        colEnd: 1
                     }
                  ]
               },
               {
                  rowsTemplate: '1fr 1fr',
                  columnsTemplate: '1fr 1fr',
                  imageResource: $r('app.media.direct5'),
                  areas: [
                     {
                        id: 'top',
                        rowStart: 0,
                        rowEnd: 0,
                        colStart: 0,
                        colEnd: 1
                     },
                     {
                        id: 'bottom',
                        rowStart: 1,
                        rowEnd: 1,
                        colStart: 0,
                        colEnd: 1
                     }
                  ]
               },
               {
                  rowsTemplate: '1fr 1fr',
                  columnsTemplate: '1fr 1fr',
                  imageResource: $r('app.media.direct1'),
                  areas: [
                     {
                        id: 'top',
                        rowStart: 0,
                        rowEnd: 0,
                        colStart: 0,
                        colEnd: 1
                     }, // 跨两列
                     {
                        id: 'leftBottom',
                        rowStart: 1,
                        rowEnd: 1,
                        colStart: 0,
                        colEnd: 0
                     },
                     {
                        id: 'rightBottom',
                        rowStart: 1,
                        rowEnd: 1,
                        colStart: 1,
                        colEnd: 1
                     }
                  ]
               },
               {
                  rowsTemplate: '1fr 1fr',
                  columnsTemplate: '1fr 1fr',
                  imageResource: $r('app.media.direct2'),
                  areas: [
                     {
                        id: 'leftTop',
                        rowStart: 0,
                        rowEnd: 0,
                        colStart: 0,
                        colEnd: 0
                     },
                     {
                        id: 'rightTop',
                        rowStart: 0,
                        rowEnd: 0,
                        colStart: 1,
                        colEnd: 1
                     },
                     {
                        id: 'bottom',
                        rowStart: 1,
                        rowEnd: 1,
                        colStart: 0,
                        colEnd: 1
                     }
                  ]
               },
               {
                  rowsTemplate: '1fr 1fr',
                  columnsTemplate: '1fr 1fr',
                  imageResource: $r('app.media.direct3'),
                  areas: [
                     {
                        id: 'left',
                        rowStart: 0,
                        rowEnd: 1,
                        colStart: 0,
                        colEnd: 0
                     },
                     {
                        id: 'rightTop',
                        rowStart: 0,
                        rowEnd: 0,
                        colStart: 1,
                        colEnd: 1
                     },
                     {
                        id: 'rightBottom',
                        rowStart: 1,
                        rowEnd: 1,
                        colStart: 1,
                        colEnd: 1
                     }
                  ]
               }
            ]
         });
      }
   }
}
```

## 更新记录

### 1.0.0 (2025-10-31)

下载该版本图片拼接组件，支持图片按网格直接拼接、海报拼接、模板拼接。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

**SDK 合规使用指南：** 不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f85eaf3a52d54be0bea65b4add9d98fc/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9B%BE%E7%89%87%E6%8B%BC%E6%8E%A5%E7%BB%84%E4%BB%B6/picture_collage1.0.0.zip