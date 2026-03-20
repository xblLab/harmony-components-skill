# 多媒体预览组件 UIMediaPreview

## 简介

UIMediaPreview 是一个基于 OpenHarmony 基础组件开发的多媒体预览组件。支持传入 url 数组，展示网络图片、视频，并提供默认与宫格两种样式。支持全屏预览、缩放。视频支持播放、暂停、静音与进度切换。支持下载并保存到相册。

## 详细介绍

### 简介

UIMediaPreview 是一个基于 OpenHarmony 基础组件开发的多媒体预览组件。支持传入 url 数组，展示网络图片、视频，并提供默认与宫格两种样式。支持全屏预览、缩放。视频支持播放、暂停、静音与进度切换。支持下载并保存到相册。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）和华为平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-media-preview
```

#### 工程配置

**Entry 模块下 src/main/ets/entryability/EntryAbility.ets 设置监听。**

```typescript
onBackground(): void {
  // 退入后台时，视频播放暂停
  this.context.eventHub.emit('PlayPauseOnBackground');
}
```

**Entry 模块下 src/main/module.json5 确保配置了应用的 label 和 icon 项。详细参见 showAssetsCreationDialog。**

```json5
"abilities": [
   {
      // 拉起弹窗的样式设置，label 为应用名称
      "icon": "$media:layered_image",
      "label": "$string:EntryAbility_label",
   }
 ],
```

#### 引入组件

```typescript
import { LayoutType, UIMediaPreview } from '@hw-agconnect/ui-media-preview';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UIMediaPreview({
     type: LayoutType.GRID,
     list: [
       { url: 'image-url' },
       { url: 'video-url', isVideo: true },
     ],
   })
```

## API 参考

### 子组件

无

### 接口

`UIMediaPreview(options: UIMediaPreviewOptions)`

多媒体预览组件组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIMediaPreviewOptions | 是 | 配置多媒体预览组件组件的参数。 |

#### UIMediaPreviewOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| list | MediaType[] | 是 | 传入的网络 url 数组，支持图片和视频两种格式。 |
| type | LayoutType | 否 | 多媒体预览的展示形式，分默认和宫格两种类型。 |
| muted | boolean | 否 | 视频时是否静音，默认为 true。 |
| autoPlay | boolean | 否 | 视频时是否自动播放，默认为 true。 |
| loop | boolean | 否 | 视频时是否循环播放，默认为 true。 |
| maxRows | [number, number, number, number] | 否 | 宫格类型时，不同设备类型支持展开收起的行数限制。详细配置参见断点说明。 |
| maxCols | [number, number, number, number] | 否 | 宫格类型时，不同设备类型支持展开收起的列数限制。详细配置参见断点说明。 |

#### MediaType 类型说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| url | string | 是 | 网络 url，支持图片和视频两种格式。 |
| isVideo | boolean | 否 | 默认为 false，视频时需要设置为 true。 |

#### LayoutType 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| DEFAULT | 多媒体预览默认展示形式。详细效果参见示例 1 |
| GRID | 多媒体预览宫格展示形式。详细效果参见示例 2 |

#### 断点说明

maxRows 默认：`[2, 3, 3, 4]`。maxCols 默认：`[2, 3, 6, 8]`。对应 `[SM, MD, LG, XL]` 宽度下的行/列数默认限制。

| 名称 | 说明 |
| :--- | :--- |
| SM | 设备宽度小于 600vp。 |
| MD | 设备宽度在 600~840vp。 |
| LG | 设备宽度在 840~1440vp。 |
| XL | 设备宽度大于 1440vp。 |

## 示例代码

### 示例 1

本示例展示多媒体预览的默认形式。

```typescript
import { LayoutType, UIMediaPreview } from '@hw-agconnect/ui-media-preview';

@Entry
@ComponentV2
struct DefaultType {
   build() {
      Column() {
         UIMediaPreview({
            type: LayoutType.DEFAULT,
            list: [
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo1.mp4?token=704b4cf3-79c2-4935-b951-a2744d91f2de',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo2.mp4?token=6c769b11-9cdd-4da1-acd8-0284e9f2fcdb',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo3.mp4?token=170a4645-9051-4fdf-8017-d26e3a18cc9b',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park0.jpg?token=a7fb227d-3a1b-44b6-9f8a-51a804a8fffa',
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park2.jpg?token=6a616aa4-edbc-417b-8b3f-48053cdaf9ee',
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f',
               },
            ],
         })
      }
      .width('100%')
         .height('100%')
   }
}
```

### 示例 2

本示例展示多媒体预览的宫格形式。

```typescript
import { LayoutType, UIMediaPreview } from '@hw-agconnect/ui-media-preview';

@Entry
@ComponentV2
struct GirdType {
   build() {
      Column() {
         UIMediaPreview({
            type: LayoutType.GRID,
            list: [
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo1.mp4?token=704b4cf3-79c2-4935-b951-a2744d91f2de',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo2.mp4?token=6c769b11-9cdd-4da1-acd8-0284e9f2fcdb',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/upload1030%2Fvideo3.mp4?token=170a4645-9051-4fdf-8017-d26e3a18cc9b',
                  isVideo: true,
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park0.jpg?token=a7fb227d-3a1b-44b6-9f8a-51a804a8fffa',
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park2.jpg?token=6a616aa4-edbc-417b-8b3f-48053cdaf9ee',
               },
               {
                  url: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f',
               },
            ],
         })
      }
      .width('100%')
         .height('100%')
   }
}
```

## 更新记录

### 1.0.0 (2025-12-02)

- Created with Pixso.

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-media-preview
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e63b969c463747f68cdbc8ba983d1406/2adce9bbd4cb42d58a87e6add45594b3?origin=template