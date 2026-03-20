# 图片预览-ImagePreview

## 简介

使用 Swiper，无需复杂配置，即写即用。方便的预览图片等不同组件，支持缩放和平移，提供一些自定义属性和事件监听。

## 详细介绍

### ImagePreview

#### 简介

image-preview 提供图片预览组件，可以使用 Swiper 一样，无需复杂配置，即写即用。方便的预览图片等不同组件，支持缩放和平移，提供一些自定义属性和事件监听。

#### 下载安装

```bash
ohpm install @rv/image-preview
```

#### 兼容性

支持 Api15 以上版本

如需兼容低版本，修改源码，删除 ImagePreviewConfig.ets 中的 LayoutPolicy 类型即可。

#### 权限

无需权限，若使用网络资源图片，需要互联网访问权限。

#### 子组件

支持任何子组件

#### 接口

**ImagePreview**

```typescript
ImagePreview({ imageBuilder: CustomBuilder, config: ImagePreviewConfig })
```

imageBuilder 属性可写成尾随闭包的方式，因组件使用 V2 版本状态管理，内部使用 V1 组件可能会出现不可预知的兼容性问题。如果遇到问题，可以尝试使用 V2 版本子组件，或者下载源码更改为 V1 版本。

预览一张图片

| 参数 | 说明 | 类型 | 默认值 |
|------|------|------|--------|
| imageBuilder | 构建图片组件 | CustomBuilder | - |
| config | 配置 | ImagePreviewConfig | - |

#### ImagePreviewConfig 说明

| 属性 | 参数 | 说明 | 类型 | 默认值 |
|------|------|------|------|--------|
| doubleClickDefaultScale | | 双击缩放图片的默认比例 | number | 5 |
| maxScale | | 最大缩放比例 | number | 5 |
| minScale | | 最小缩放比例 | number | 1 |
| onLongPress | | 长按图片的回调，若设置了该属性，子组件将不支持长按事件 | (event: GestureEvent) => void | - |
| onClick | | 点击图片的回调，若设置了该属性，子组件将不支持单击事件 | (event: GestureEvent) => void | - |
| width | | 预览器宽 | Length \| LayoutPolicy | "100%" |
| height | | 预览器高 | Length \| LayoutPolicy | "100%" |
| autoReset | | 隐藏时是否自动重置缩放比例 | boolean | true |
| direction | | （推荐设置该值）滚动轴方向，推荐设置指定方向，优化预览体验 | PreviewDirection | PreviewDirection.Both |

#### PreviewDirection 说明

推荐设置该值

| 字段名 | 说明 |
|--------|------|
| Both | （默认值，不建议）自由滚动方向，预览时不可操出边界，以应对不同不同方向的滚动 |
| Vertical | 垂直滚动，预览时允许水平手势操出边界 |
| Horizontal | 水平滚动，预览时允许垂直手势操出边界 |
| None | 不滚动，单独使用且不在滚动场景设置 |

#### 快速使用

```typescript
import { ImagePreview } from '@rv/image-preview';

@Entry
@ComponentV2
struct Index {
  @Local private imageList: Array<string> = [
    "https://tc.alcy.cc/i/2024/04/21/6624167024283.webp",
    "https://api.xsot.cn/bing?jump=true",
    "https://tc.alcy.cc/i/2024/04/21/6624167024283.webp",
    "https://api.xsot.cn/bing?jump=true",
    "https://tc.alcy.cc/i/2024/04/21/6624167024283.webp",
    "https://api.xsot.cn/bing?jump=true",
    "https://tc.alcy.cc/i/2024/04/21/6624167024283.webp",
  ]
  private readonly controller = new SwiperController()

  build() {
    Column() {
      Flex() {
        Button("上一页").onClick(() => this.controller.showPrevious())
        Button("下一页").onClick(() => this.controller.showNext())
        Button("跳转到 3 页").onClick(() => this.controller.changeIndex(2, true))
        Button("添加一页").onClick(() => {
          this.imageList.push("https://tc.alcy.cc/i/2024/04/21/6624167024283.webp")
        })
        Button("删除一页").onClick(() => {
          this.imageList.pop()
        })
      }

      Stack() {
        // 无需复杂配置，即写即用，可用于 Swiper 子组件，也可单独使用，内置长按属性
        Swiper(this.controller) {
          Repeat(this.imageList).each(repeat => {
            // 直接使用 ImagePreview 组件，需要开发者自行处理子组件大小，让组件经可能的显示在容器内，
            // 推荐使用类似 Image 组件的 ImageFit.Contain 效果，在 Api20 以后将会支持任意大小子组件
            ImagePreview({
              config: {
                // 如果设置了 onLongPress 或 onClick 属性，内部组件将不支持单击与长按手势的设置
                onLongPress: () => this.getUIContext().getPromptAction().showToast({ message: "长按了预览器" }),
                onClick: () => this.getUIContext().getPromptAction().showToast({ message: "点击了预览器" })
              }
            }) {
              Image(repeat.item).width("100%")
                .draggable(false)
                .onClick(() => {
                  // 如果父组件 ImagePreview 设置了 onClick 属性，该事件无法触发
                  this.getUIContext().getPromptAction().showToast({ message: "点击了图片" })
                })
                .priorityGesture(LongPressGesture().onAction(() => {
                  // 如果父组件 ImagePreview 设置了 onLongPress 属性，该事件无法触发
                  this.getUIContext().getPromptAction().showToast({ message: "长按了图片" })
                }))
            }
          })
        }
      }
      .layoutWeight(1)
      .width("100%")
    }
    .backgroundColor(Color.Pink)
    .height('100%')
    .width('100%')
  }
}
```

#### 更改源码为 V1 版本

修改 ImagePreview.ets 文件，将 `@ComponentV2` 替换为 `@Component`，`@Param` 替换为 `@Prop`

### 更新记录

#### 2.1.2（2025-09-25）

- 优化拖拽逻辑
- 精简优化代码逻辑
- 降低使用成本与难度，具体见文档

#### 2.0.1（2025-07-17）

解决自定义 builder 的 this 指向问题

#### 2.0.0（2025-07-11）

重构代码，优化操作，具体见文档

#### 1.0.14（2025-03-18）

fix: 修复 PixelMap 数据不显示的问题

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| 网络权限（可选） | 使用网络图片时需要 | 显示网络图片 |

#### 隐私政策

不涉及

#### SDK合规使用指南

不涉及

### 兼容性

| HarmonyOS版本 | 5.0.0 |
|---------------|-------|
| 应用类型 | 应用 |
| | 元服务 |
| 设备类型 | 手机 |
| | 平板 |
| | PC |
| DevEcoStudio版本 | DevEco Studio 5.0.5 |
| | DevEco Studio 5.1.0 |
| | DevEco Studio 5.1.1 |
| | DevEco Studio 6.0.0 |

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bec427bda272462080136eecdba55f02/cf5ea69e298e403a80a01678deee7a74?origin=template