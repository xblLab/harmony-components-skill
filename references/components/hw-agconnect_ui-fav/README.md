# 收藏按钮 UIFavButton

## 简介

UIFavButton，是一个基于 open harmony 基础组件开发的收藏按钮，包含常规、无图标、彩色实底、边框描边、图标描边、纯图标等类型的样式，支持自定义主题色、按钮文字，同时支持 3 种按钮大小可以选择。

## 详细介绍

### 简介

UIFavButton，是一个基于 open harmony 基础组件开发的收藏按钮，包含常规、无图标、彩色实底、边框描边、图标描边、纯图标等类型的样式，支持自定义主题色、按钮文字，同时支持 3 种按钮大小可以选择。我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-fav
```

#### 使用

深色代码主题复制
```typescript
// 在业务页面使用组件，比如 xxx.ets
import { UIFavButton, FavBtnType } from '@hw-agconnect/ui-fav';

UIFavButton({ btnType: FavBtnType.NORMAL })
```

### 相关权限

无

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
3. DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
4. HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

`UIFavButton(option: UIFavButtonOptions)`

#### UIFavButtonOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| themeColor | ResourceColor | 否 | 主题色 |
| hasStar | boolean | 否 | 是否显示星星图标，默认显示，注：在 FavBtnType.ICON_PLAIN 和 FavBtnType.ICON 不生效 |
| isCapsule | boolean | 否 | 是否胶囊按钮，默认值否 |
| btnType | FavBtnType | 否 | 按钮类型，提供常规、彩色实底、边框描边、图标描边、图标等类型，默认常规 |
| size | FavSizeFav | 否 | 按钮大小，提供大、常规、小等 3 种选择，默认是常规 |
| isChecked | boolean | 否 | 是否已收藏，默认否 |
| contentText | ContentText | 否 | 文字自定义，默认是{ unFav: '收藏', fav: '已收藏' } |

#### FavBtnType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| NORMAL | 常规 |
| COLOR | 彩色实底 |
| PLAIN | 边框描边 |
| ICON_PLAIN | 图标描边 |
| ICON | 无文字 |

#### SizeFav 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| BIG | 大 |
| NORMAL | 常规 |
| SMALL | 小 |

#### ContentText 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| unFav | ResourceStr | 否 | 未收藏时的文字 |
| fav | ResourceStr | 否 | 已收藏时的文字 |

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| change(callback: (isChecked: boolean) => void) | 点击按钮触发事件 |

### 示例

#### 示例 1

深色代码主题复制
```typescript
import { UIFavButton, FavBtnType } from '@hw-agconnect/ui-fav';

@ComponentV2
struct Card {
  @Param title: string = '';
  @BuilderParam content: () => void;

  build() {
    Column({ space: 6 }) {
      Text(this.title).fontSize(12).width(60).height(24)
      if (this.content) {
        this.content();
      }
    }
    .width('100%')
    .padding(12)
    .borderRadius(12)
    .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@ComponentV2
struct UIFavButtonSample1 {
  @Local isChecked: boolean = true;

  build() {
    Column() {
      NavDestination() {
        Scroll() {
          Column({ space: 10 }) {
            Card({
              title: '常规',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.NORMAL })
                UIFavButton({ btnType: FavBtnType.NORMAL, isCapsule: true })
              }
            }

            Card({
              title: '无图标',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.NORMAL, hasStar: false })
                UIFavButton({ btnType: FavBtnType.NORMAL, isCapsule: true, hasStar: false })
              }
            }

            Card({
              title: '彩色实底',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.COLOR })
                UIFavButton({ btnType: FavBtnType.COLOR, isCapsule: true })
              }
            }

            Card({
              title: '边框描边',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.PLAIN })
                UIFavButton({ btnType: FavBtnType.PLAIN, isCapsule: true })
              }
            }

            Card({
              title: '图标描边',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.ICON_PLAIN })
              }
            }

            Card({
              title: '图标',
            }) {
              Row({ space: 10 }) {
                UIFavButton({ btnType: FavBtnType.ICON })
              }
            }
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .padding(16)
        .height('100%')
        .edgeEffect(EdgeEffect.Spring)
        .align(Alignment.TopStart)
      }
      .title('基础用法')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    }
  }
}
```

#### 示例 2

深色代码主题复制
```typescript
import { UIFavButton, FavBtnType, SizeFav, ContentText } from '@hw-agconnect/ui-fav';

@ComponentV2
struct Card {
  @Param title: string = '';
  @BuilderParam content: () => void;

  build() {
    Column({ space: 6 }) {
      Text(this.title).fontSize(12).width(60).height(24)
      if (this.content) {
        this.content();
      }
    }
    .width('100%')
    .padding(12)
    .borderRadius(12)
    .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@ComponentV2
struct UIFavButtonSample2 {
  @Local isChecked: boolean = true;

  build() {
    Column() {
      NavDestination() {
        Scroll() {
          Column({ space: 10 }) {
            Card({
              title: '设置文字'
            }) {
              Column({ space: 10 }) {
                Row({ space: 10 }) {
                  UIFavButton({
                    contentText: new ContentText('追番', '已追番'),
                    change: (isChecked: boolean) => {
                      console.log('fav 按钮被点击，值为=' + this.isChecked);
                      this.isChecked = isChecked;
                    }
                  })

                  UIFavButton({
                    contentText: new ContentText('我要收藏', '我已收藏'),
                  })

                  UIFavButton({
                    contentText: new ContentText('收藏', '已收藏'),
                    hasStar: false,
                  })

                  UIFavButton({
                    contentText: new ContentText('收藏', '我已收藏'),
                    hasStar: false,
                  })
                }
              }

              Row({ space: 10 }) {
                UIFavButton({
                  contentText: new ContentText('超长文字超长文字超长文字超长文字超长文字超长文字 1',
                    '超长文字超长文字超长文字超长文字超长文字超长文字 2'),
                })
              }
            }

            Card({ title: '设置尺寸' }) {
              Row({ space: 10 }) {
                UIFavButton({ sizeFav: SizeFav.BIG })
                UIFavButton({ sizeFav: SizeFav.NORMAL })
                UIFavButton({ sizeFav: SizeFav.SMALL })
              }
            }

            Card({ title: '设置主题色' }) {
              Column({ space: 10 }) {
                Row({ space: 10 }) {
                  UIFavButton({ btnType: FavBtnType.NORMAL, themeColor: Color.Pink })
                  UIFavButton({ btnType: FavBtnType.NORMAL, themeColor: Color.Pink, hasStar: false })
                  UIFavButton({ btnType: FavBtnType.COLOR, themeColor: Color.Pink })
                }

                Row({ space: 10 }) {
                  UIFavButton({ btnType: FavBtnType.PLAIN, themeColor: Color.Pink })
                  UIFavButton({ btnType: FavBtnType.ICON_PLAIN, themeColor: Color.Pink })
                  UIFavButton({ btnType: FavBtnType.ICON, themeColor: Color.Pink })
                }
              }.alignItems(HorizontalAlign.Start)
            }
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .padding(16)
        .height('100%')
        .edgeEffect(EdgeEffect.Spring)
        .align(Alignment.TopStart)
      }
      .title('自定义参数')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    }
  }
}
```

## 更新记录

| 版本 | 日期 | 描述 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-12-12 | 下载该版本内部资源更新 Created with Pixso. |
| 1.0.0 | 2025-09-30 | 下载该版本初始版本 Created with Pixso. |

## 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 基本信息 | 权限名称：无，权限说明：无，使用目的：无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 Created with Pixso. <br> 5.0.1 Created with Pixso. <br> 5.0.2 Created with Pixso. <br> 5.0.3 Created with Pixso. <br> 5.0.4 Created with Pixso. <br> 5.0.5 Created with Pixso. <br> 5.1.0 Created with Pixso. <br> 5.1.1 Created with Pixso. <br> 6.0.0 Created with Pixso. <br> 6.0.1 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso. <br> 元服务 Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. <br> 平板 Created with Pixso. <br> PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 Created with Pixso. <br> DevEco Studio 5.0.1 Created with Pixso. <br> DevEco Studio 5.0.2 Created with Pixso. <br> DevEco Studio 5.0.3 Created with Pixso. <br> DevEco Studio 5.0.4 Created with Pixso. <br> DevEco Studio 5.0.5 Created with Pixso. <br> DevEco Studio 5.1.0 Created with Pixso. <br> DevEco Studio 5.1.1 Created with Pixso. <br> DevEco Studio 6.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-fav
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b9859dfb393d47178fcfa324c6e8ff05/2adce9bbd4cb42d58a87e6add45594b3?origin=template