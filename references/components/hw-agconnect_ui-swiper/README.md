# 多级轮播图 UISwiper

## 简介

UISwiper 是基于 OpenHarmony 基础组件开发的缩放轮播图组件，支持滑动过程中缩放图片、自动轮播等功能。

## 详细介绍

### 集成方式

我们提供两种方式：OHPM 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式。下面以 OHPM 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-base
ohpm install @hw-agconnect/ui-swiper
```

#### 使用

```typescript
// 引入组件
import {UISwiper} from '@hw-agconnect/ui-swiper';
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

- **HarmonyOS 系统**：HarmonyOS 5.0.0 Release 及以上。
- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上。
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

#### UISwiper(options: UISwiperOptions)

##### UISwiper 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imgListSrc | [] | 是 | 传入图片资源数组，Src 类型参照 Image 组件，至少传入 3 张图片。 |
| imgWidth | number | 否 | 单位为 vp，在 360vp 容器宽度下，默认值为 264。<br>覆盖模式下，建议最大宽度：296vp（上传图片超过最大宽度时，保持原宽高比缩放至 296vp 宽，以适应容器边界）；建议最小宽度：164vp（上传图片低于最小宽度时，保持原宽高比放大至 164vp 宽，以适应容器边界）。<br>平铺模式下，建议最大宽度：264vp（上传图片超过最大宽度时，保持原宽高比缩放至 264vp 宽，以适应容器边界）；建议最小宽度：136vp（上传图片低于最小宽度时，保持原宽高比放大至 136vp 宽，以适应容器边界）。<br>当容器宽度不为 360vp，默认值、最小宽度、最大宽度参照当前容器宽度与 360vp 的比值等比例变化。 |
| imgHeight | number | 否 | 单位为 vp，默认值为 190。若宽度不在推荐范围内，保持宽高比跟随宽度缩放。 |
| interval | number | 否 | 单位为 ms，默认值为 5000，轮播间隔。 |
| isLoop | boolean | 否 | 默认值 true，是否循环轮播。 |
| isCovered | boolean | 否 | 默认值 false，是否为覆盖模式，false 为平铺模式。建议覆盖模式下，传入 4 张及以上图片。 |

##### Src 参数说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| Src | PixelMap \| ResourceStr \| DrawableDescriptor | 是 | 图片的数据源，支持本地图片和网络图片，引用方式请参考加载图片资源。<br>1. PixelMap 格式为像素图，常用于图片编辑的场景。<br>2. ResourceStr 包含 Resource 和 string 格式。<br>3. 当传入资源 id 或 name 为普通图片时，生成 DrawableDescriptor 对象。 |

### 使用限制

无

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onImageClick(index: number): void | 点击中间图片时触发，回调值为图片对应索引。 |

### 示例

#### 示例 1

```typescript
import {UISwiper} from '@hw-agconnect/ui-swiper'

@ComponentV2
export struct UISwiperDemo {
  @Local imgList: Resource[] = new Array(4).fill('').map((item: string, index) => {
    return $r(`app.media.image${index + 1}`)
  })
  @Local imgHeight: number = 190
  @Local imgWidth: number = 264

  build() {
    Column() {
      UISwiper({
        imgWidth: this.imgWidth,
        imgHeight: this.imgHeight,
        imgList: this.imgList,
        isLoop: true,
        isCovered: true,
        onImageClick: (index: number) => {
          console.log(`点击中间图片项索引为${index}`)
        }
      })
    }
  }
}
```

### 更新记录

#### 1.0.0 (2025-09-29)

- 初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 / 5.0.1 / 5.0.2 / 5.0.3 / 5.0.4 / 5.0.5 |
| **应用类型** | 应用 / 元服务 |
| **设备类型** | 手机 / 平板 / PC |
| **DevEco Studio 版本** | 5.0.0 / 5.0.1 / 5.0.2 / 5.0.3 / 5.0.4 / 5.0.5 / 5.1.0 / 5.1.1 / 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-swiper
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/162a0f7cae24464187193f0bf5c4207a/2adce9bbd4cb42d58a87e6add45594b3?origin=template