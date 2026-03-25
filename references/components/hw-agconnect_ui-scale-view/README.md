# 可横竖滑动缩放容器 UIScaleView

## 简介

UIScaleView 是基于 open harmony 基础组件开发的可横竖滑动缩放容器组件，支持传入内容水平、垂直方向的滑动及缩小、放大等功能。

## 详细介绍

### 简介

UIScaleView 是基于 open harmony 基础组件开发的可横竖滑动缩放容器组件，支持传入内容水平、垂直方向的滑动及缩小、放大等功能。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-scale-view
```

#### 使用

```typescript
// 引入组件
import { UIScaleView } from '@hw-agconnect/ui-scale-view'
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。
- HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

**UIScaleView(options: UIScaleViewOptions)**

**UIScaleViewOptions 对象说明**

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| customDirection | PanDirection | 否 | 可滑动的方向，默认值为 PanDirection.All |
| outContainer | boolean | 否 | 滑动过程中是否可出界，默认值为 false |
| sensitivity | number | 否 | 平移手势灵敏度，默认值为 1，数值越大滑动距离受手势影响越灵敏。若设置值小于等于 0，设置不生效取默认值。 |
| customMinScale | number | 否 | 最小缩放比例，默认值为 0.5，若设置值小于 0.5，或大于 1，设置不生效取默认值。 |
| customMaxScale | number | 否 | 最大缩放比例，默认值为 10，若设置值大于 10，或小于 1，设置不生效取默认值。 |
| moveViewBuilderParam | CustomBuilder | 否 | 自定义内容 |
| moveViewKey | string | 否 | 传入视图唯一 id 标识，同时使用多个该组件，需传入不同值以保证唯一性，否则组件之间会产生干扰影响正常使用。 |

### 使用限制

无

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onPositionChange(callback: (x: number, y: number) => void) | 传入视图左上角，相对父容器的坐标改变时触发。视图左上角相对父组件，以竖直向下为 x 轴正方向，水平向右为 y 轴正方向，x,y 分别为 x,y 轴的坐标值，单位 vp |
| onPanning(callback: (x: number, y: number) => void) | 滑动时触发。视图左上角相对父组件，以竖直向下为 x 轴正方向，水平向右为 y 轴正方向，x,y 分别为 x,y 轴的坐标值，单位 vp |
| onScaling(callback: (scaleValue: number) => void) | 缩放时触发。scaleValue 为传入视图缩放后相对初始视图的缩放倍率 |

### 示例

#### 示例 1

```typescript
import { UIScaleView } from '@hw-agconnect/ui-scale-view'

@Entry
@ComponentV2
struct ScaleViewDemo1 {
  @Builder
  moveViewBuilder() {
    Image($r('app.media.view_map')).width('100%').height('100%')
  }

  build() {
    Navigation() {
      Column() {
        Row() {
          Text('基本用法').fontSize(20).textIndent(20)
        }.width('100%').margin({ top: 16, bottom: 16 })

        Column() {
          UIScaleView({
            // 自定义可移动方向
            customDirection: PanDirection.All,
            // 平移时是否可越界
            outContainer: false,
            // 缩放倍率范围默认取值，最小 0.5，最大 10，超出该范围取默认值
            customMinScale: 0.5,
            customMaxScale: 10,
            // 传入内容
            moveViewBuilderParam: () => {
              this.moveViewBuilder()
            },
            // 传入内容左上角相对父容器坐标改变时触发（平移、缩放、越界回弹等情况）
            onPositionChange: (x: number, y: number) => {
              console.log(`当前位置坐标为(x:${x},y:${y})`)
            },
            // 平移时触发
            onPanning: (x: number, y: number) => {
              console.log(`平移时坐标为(x:${x},y:${y})`)
            },
            // 缩放时触发
            onScaling: (scaleValue: number) => {
              console.log('当前缩放倍率为', scaleValue)
            }
          })
        }.backgroundColor('#ccc').height(260)
      }
    }
    .title('ScaleViewDemo1')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 2

```typescript
import { UIScaleView } from '@hw-agconnect/ui-scale-view'

@Entry
@ComponentV2
struct ScaleViewDemo2 {
  @Builder
  moveViewBuilder() {
    Image($r('app.media.view_map')).width(152).height(114)
  }

  build() {
    Navigation() {
      Column() {
        Row() {
          Text('视图区域小于容器，可越界').fontSize(20).textIndent(20)
        }.width('100%').margin({ top: 16, bottom: 16 })

        Column() {
          UIScaleView({
            // 自定义可移动方向
            customDirection: PanDirection.All,
            // 平移时是否可越界
            outContainer: true,
            // 传入内容
            moveViewBuilderParam: () => {
              this.moveViewBuilder()
            }
          })
        }.backgroundColor('#ccc').height(260)
      }
    }
    .title('ScaleViewDemo2')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 3

```typescript
import { UIScaleView } from '@hw-agconnect/ui-scale-view'

@Entry
@ComponentV2
struct ScaleViewDemo3 {
  @Builder
  moveViewBuilder() {
    Image($r('app.media.view_map')).width(500).height(400)
  }

  build() {
    Navigation() {
      Column() {
        Row() {
          Text('视图区域大于容器').fontSize(20).textIndent(20)
        }.width('100%').margin({ top: 16, bottom: 16 })

        Column() {
          UIScaleView({
            // 自定义可移动方向
            customDirection: PanDirection.All,
            // 平移时是否可越界
            outContainer: true,
            // 传入内容
            moveViewBuilderParam: () => {
              this.moveViewBuilder()
            }
          })
        }.backgroundColor('#ccc').height(260)
      }
    }
    .title('ScaleViewDemo3')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 4

```typescript
import { UIScaleView } from '@hw-agconnect/ui-scale-view'

@Entry
@ComponentV2
struct ScaleViewDemo4 {
  @Builder
  moveViewBuilder() {
    Image($r('app.media.view_map')).width(152).height(114)
  }

  build() {
    Navigation() {
      Column() {
        Row() {
          Text('限制可移动方向').fontSize(20).textIndent(20)
        }.width('100%').margin({ top: 16, bottom: 16 })

        Column() {
          UIScaleView({
            // 自定义可移动方向，水平移动
            customDirection: PanDirection.Horizontal,
            // 平移时是否可越界
            outContainer: true,
            // 传入内容
            moveViewBuilderParam: () => {
              this.moveViewBuilder()
            }
          })
        }.backgroundColor('#ccc').height(260)
      }
    }
    .title('ScaleViewDemo4')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

#### 示例 5

```typescript
import { UIScaleView } from '@hw-agconnect/ui-scale-view'

@Entry
@ComponentV2
struct ScaleViewDemo5 {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  // 图片路径需放在 ets 目录下，才能直接读取
  private img: ImageBitmap = new ImageBitmap('common/images/lineMap.jpg')

  @Builder
  moveViewBuilder() {
    Canvas(this.context)
      .width('100%')
      .height(490)
      .onReady(() => {
        this.context.drawImage(this.img, 0, 0, 360, 490)
        this.img.close()
      })
  }

  build() {
    Navigation() {
      Column() {
        Row() {
          Text('canvas 画布').fontSize(20).textIndent(20)
        }.width('100%').margin({ top: 16, bottom: 16 })
        Column() {
          UIScaleView({
            //自定义可移动方向，水平移动
            customDirection: PanDirection.All,
            //平移时是否可越界
            outContainer: true,
            //传入内容
            moveViewBuilderParam: () => {
              this.moveViewBuilder()
            }
          })
        }.height('490')
      }
    }
    .title('ScaleViewDemo5')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

## 更新记录

### 1.0.0 (2025-09-29)

- 初始版本

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

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-scale-view
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4e396c5b8f11463bb9c4621212d7fc08/2adce9bbd4cb42d58a87e6add45594b3?origin=template