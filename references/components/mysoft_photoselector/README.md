# photoselector 图片选择器组件

## 简介

图片选择器组件（与微信图片选择器相似度高达 98%），高度封装，易于集成，支持图片和视频的选择功能。

## 详细介绍

### 简介

图片选择器组件（与微信图片选择器相似度高达 98%），高度封装，易于集成，支持图片和视频的选择功能。

### 安装

```bash
ohpm i @mysoft/photoselector
```

### 效果

微信 PhotoSelector

### PhotoSelectorComponent

```typescript
PhotoSelectorComponent({
    options?: PhotoSelectorOptions,
    onCancel?: () => void,
    onDone: (result: photoAccessHelper.PhotoSelectResult) => void
})
```

应用可以在布局中嵌入 `PhotoSelectorComponent` 组件，通过此组件，应用无需申请权限，即可访问公共目录中的图片或视频文件。

装饰器类型：`@Component`

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PhotoSelectorOptions | 否 | Selector 配置选项。 |
| onCancel | () => void | 否 | 取消回调。 |
| onDone | (result: PhotoSelectResult) => void | 否 | 确定回调，result 参照 PhotoSelectResult 说明。 |

#### PhotoSelectorOptions

Selector 配置选项。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| MIMEType | PhotoViewMIMETypes | 否 | 参照 PhotoViewMIMETypes。 |
| maxSelectNumber | number | 否 | 选择媒体文件数量的最大值 (最大可设置的值为 500，若不设置则默认为 50)。 |
| maxPhotoSelectNumber | number | 否 | 图片最大的选择数量。最大值为 500，受到最大选择总数的限制。 |
| maxVideoSelectNumber | number | 否 | 视频最大的选择数量。最大值为 500，受到最大选择总数的限制。 |
| colorMode | PickerColorMode | 否 | 参照 PickerColorMode。默认为 DARK。 |
| actionColor | string | 否 | checkbox、button 等组件激活时的颜色。默认为 #1AB356。 |
| isPhotoTakingSupported | boolean | 否 | 是否支持拍照，true 表示支持，false 表示不支持，默认为 false。 |
| isOriginalSupported | boolean | 否 | 是否显示选择原图按钮，true 表示显示，false 表示不显示，默认为 false。 |
| isEditSupported | boolean | 否 | 是否支持编辑照片，true 表示支持，false 表示不支持，默认为 false。该功能暂不支持。 |

### 示例

```typescript
import { PhotoSelectorComponent } from '@mysoft/photoselector'
import { photoAccessHelper, PickerColorMode } from '@kit.MediaLibraryKit'

@Component
struct Test {
  build() {
    PhotoSelectorComponent({
      options: {
        MIMEType: photoAccessHelper.PhotoViewMIMETYPES.IMAGE_VIDEO_TYPE,
        maxSelectNumber: 10,
        maxPhotoSelectNumber: 5,
        maxVideoSelectNumber: 5,
        colorMode: PickerColorMode.AUTO,
        actionColor: '#1AB356',
        isPhotoTakingSupported: true,
        isOriginalSupported: true,
        isEditSupported: false
      },
      onCancel: () => {
        console.info('cancel')
      },
      onDone: (result) => {
        console.info(`done: ${JSON.stringify(result, null, 2)}`)
      }
    })
  }
}
```

## 开源协议

本项目基于 Apache License 2.0，在拷贝和借鉴代码时，请务必注明出处。

## 更新记录

- **1.0.5**
  - 修复 6.0.1 版本编辑错误的问题
- **1.0.4**
  - 大图预览时，画廊栏显示视频时长
  - 优化选中数量超出时提示
- **1.0.3**
  - 新增 `maxSelectNumber` 参数，用来配置 最大选择数量
  - 新增 `colorMode` 参数，用来配置 颜色模式
  - 新增 `actionColor` 参数，用来配置 checkbox、button 等组件激活时的颜色
- **1.0.2**
  - 新增 keywords
- **1.0.1**
  - 变更配置参数 `useNormalizedOHMUrl = false`
- **1.0.0**
  - 发布 1.0.0 初版

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.2 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 |

> Created with Pixso.

## 安装方式

```bash
ohpm install @mysoft/photoselector
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b1c704da213a4599866bed4e885074a6/PLATFORM?origin=template