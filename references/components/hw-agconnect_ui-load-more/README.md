# 加载更多 UILoadMore

## 简介

UILoadMore 是基于 open harmony 基础组件开发的加载更多组件。包括加载前、加载中和没有数据三种状态，支持跟随系统语言或特定语言类型。

## 详细介绍

### 简介

UILoadMore 是基于 open harmony 基础组件开发的加载更多组件。包括加载前、加载中和没有数据三种状态，支持跟随系统语言或特定语言类型。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-load-more
```

#### 使用

```typescript
// 引入组件
import { LoadMore } from '@hw-agconnect/ui-load-more';
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

*   HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
*   DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
*   HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

**UILoadMore(options: UILoadMoreOptions)**

#### UILoadMoreOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| contentGroup | ContentGroup | 否 | 所有状态的数据对象，可以在不同的状态下分别控制各种属性等。 |
| status | Status | 否 | loading 的状态 |
| iconPosition | IconPosition | 否 | 指定图标位置 |

#### ContentGroup 数据结构说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| moreContentValue | Value | 否 | more 状态的属性等 |
| loadingContentValue | Value | 否 | loading 状态的属性等 |
| noMoreContentValue | Value | 否 | noMore 状态的属性等 |

#### ContentValue 数据结构说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| text | string | 否 | 文字说明 |
| fontColor | ResourceStr | 否 | 文字颜色 |
| fontSize | ResourceColor | 否 | 文字大小 |
| showText | boolean | 否 | 是否显示文本 |
| iconResourceStr | ResourceStr | 否 | 自定义图标 |
| iconColor | ResourceStr | 否 | 图标颜色 |
| showIcon | boolean | 否 | 是否显示 loading 图标 |

#### Status 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| MORE | 设置组件的状态为加载前。 |
| LOADING | 设置组件的状态为加载中。 |
| NOMORE | 设置组件的状态为没有数据。 |

#### IconPosition 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| TOP | 设置图标的位置为文字的上方。 |
| LEFT | 设置图标的位置为文字的左侧。 |

### 使用限制

无

### 示例

#### 示例 1

```typescript
import {LoadMore, ContentGroup, Status} from '@hw-agconnect/ui-load-more'

@Entry
@ComponentV2
struct Index {
  @Local contentGroup: ContentGroup = {
    loading: {
      text: '加载中...',
      fontSize: 16
    }
  }
  @Local status: Status = Status.LOADING
  @Builder
  TextTip() {
    Text()
      .width(5)
      .height(14)
      .backgroundColor('#1E90FF')
      .borderRadius(5)
      .margin({ right: 10 })
  }

  build() {
    Column() {
      Column() {
        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            Column({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.MORE,
                })
              }
              Column() {
                Row() {
                  this.TextTip()
                  Text('修改默认文字')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.MORE,
                  contentGroup: {
                    more: {
                      text: '上拉加载',
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('改变颜色')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.MORE,
                  contentGroup: {
                    more: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }
            }
          }
          .tabBar('加载前')
          .align(Alignment.Top)
          .margin(20)

          TabContent() {
            Column({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')
                LoadMore({
                  status: this.status,
                },)
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('修改默认文字')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: this.status,
                  contentGroup: {
                    loading: {
                      text: '加载中'
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('文本颜色自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                  contentGroup: {
                    loading: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('图标颜色自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                  contentGroup: {
                    loading: {
                      iconColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('自定义图标')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                })
              }
            }
          }
          .tabBar('加载中')
          .align(Alignment.Top)
          .margin(20)

          TabContent() {
            Column({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')
                LoadMore({
                  status: Status.NOMORE,
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('文本内容自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.NOMORE,
                  contentGroup: {
                    noMore: {
                      text: '我是有底线的'
                    }
                  }

                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('改变颜色')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.NOMORE,
                  contentGroup: {
                    noMore: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }
            }
          }
          .tabBar('没有更多')
          .align(Alignment.Top)
          .margin(20)
        }
      }
    }
  }
}
```

### 更新记录

*   **1.0.2** (2025-12-12)
    *   Created with Pixso.
*   **1.0.1** (2025-09-29)
    *   Created with Pixso.

加载更多组件提供包括加载前、加载中和没有数据三种状态，支持跟随系统语言或特定语言类型。

### 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-load-more
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/67b1ba3b413e4378b13bfb8d181958f9/2adce9bbd4cb42d58a87e6add45594b3?origin=template