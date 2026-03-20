# 超链接组件 UILink

## 简介

UILink 是基于 open harmony 基础组件开发的超链接组件，支持对网络链接的应用内打开、跳转浏览器打开和复制链接内容等功能。

## 详细介绍

### 简介

UILink 是基于 open harmony 基础组件开发的超链接组件，支持对网络链接的应用内打开、跳转浏览器打开和复制链接内容等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- 网络权限 `ohos.permission.INTERNET`

#### 限制

- **模拟器**：跳转浏览器能力需使用 HarmonyOS 6.0.1(21) 及以上版本调试
- 本组件使用 ArkWeb 能力，不适用于元服务

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-link
```

#### 引入组件

```typescript
import { UILink } from '@hw-agconnect/ui-link';
```

#### 调用组件

详细参数配置说明参见 [API 参考](#api-参考)。

```typescript
UILink({
  href: 'https://example.com',
})
```

## API 参考

### 子组件

无

### 接口

`UILink(options: UILinkOptions)`

超链接组件。

### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UILinkOptions | 否 | 配置超链接组件的参数。 |

#### UILinkOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| linkMode | LinkMode | 否 | 链接的打开模式，默认为 `LinkMode.OPEN_IN_APP`。 |
| href | string | 否 | 链接的 URL 地址。 |
| navStack | NavPathStack | 否 | 导航路由栈，用于定义链接的导航路径。若使用 `LinkMode.OPEN_IN_APP` 时不传入该值可能会导致链接显示异常。 |
| textColor | ResourceColor | 否 | 链接文字的颜色，默认为 `$r('sys.color.font_emphasize')`。 |
| textFont | Font | 否 | 链接文字的字体配置，包括大小、粗细和样式，默认为 `{ size: $r('sys.float.Body_L'), weight: FontWeight.Normal, style: FontStyle.Normal }`。 |
| text | string | 否 | 链接显示的文本内容，默认为 `''`，不传入时显示为 `href` 参数传入的 URL 地址。 |
| underline | boolean | 否 | 是否显示下划线，默认为 `false`。 |
| underlineColor | ResourceColor | 否 | 下划线的颜色，不传入时默认与 `textColor` 保持一致。 |
| customText | CustomBuilder | 否 | 自定义链接文本的插槽，用于实现自定义的文本显示样式。 |
| onWillOpen | () => boolean | 否 | 链接将要跳转时触发该回调，返回 `false` 时不触发后续跳转操作。 |
| callback | () => void | 否 | 点击链接后触发的回调函数。 |

### LinkMode 枚举说明

| 参数名 | 说明 |
| :--- | :--- |
| OPEN_IN_APP | 使用应用内 webview 打开 |
| OPEN_WITH_BROWSER | 使用系统浏览器打开 |
| COPY_LINK | 复制链接 |

### 示例代码

```typescript
import { LinkMode, UILink } from '@hw-agconnect/ui-link';
import { promptAction } from '@kit.ArkUI';

const href: string = 'https://developer.huawei.com'

@Entry
@ComponentV2
struct UILinkDemo {
  @Local stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Scroll() {
        Column({ space: 24 }) {
          Column({ space: 12 }) {
            Text('基础示例 - 应用内打开').labelStyle()
            UILink({
              href,
              navStack: this.stack,
            })
          }

          Column({ space: 12 }) {
            Text('基础示例 - 跳转浏览器打开').labelStyle()
            UILink({
              href,
              linkMode: LinkMode.OPEN_WITH_BROWSER,
            })
          }

          Column({ space: 12 }) {
            Text('基础示例 - 复制链接').labelStyle()
            UILink({
              href,
              linkMode: LinkMode.COPY_LINK,
              callback: () => {
                try {
                  this.getUIContext().getPromptAction().showToast({ message: '复制成功' })
                } catch {
                  console.error('show toast failed.')
                }
              },
            })
          }

          Column({ space: 12 }) {
            Text('基础示例 - 触发拦截事件').labelStyle()
            UILink({
              href,
              linkMode: LinkMode.OPEN_WITH_BROWSER,
              onWillOpen:()=>{
                this.getUIContext().getPromptAction().showToast({ message: '链接不正确，无法打开' })
                return false
              },
            })
          }

          Column({ space: 12 }) {
            Text('自定义下划线').labelStyle()
            UILink({
              href,
              navStack: this.stack,
              underline: true,
            })
          }

          Column({ space: 12 }) {
            Text('自定义下划线颜色').labelStyle()
            UILink({
              href,
              navStack: this.stack,
              underline: true,
              underlineColor: $r('sys.color.font_secondary'),
            })
          }

          Column({ space: 12 }) {
            Text('自定义文本样式').labelStyle()
            UILink({
              href,
              navStack: this.stack,
              textFont: {
                size: 18,
                weight: FontWeight.Medium,
              },
            })
          }

          Column({ space: 12 }) {
            Text('自定义文本颜色').labelStyle()
            UILink({
              href,
              navStack: this.stack,
              textColor: $r('sys.color.font_primary'),
            })
          }

          Column({ space: 12 }) {
            Text('自定义文本文案').labelStyle()
            UILink({
              href,
              text: '点击进入华为开发者官网',
              navStack: this.stack,
              textColor: $r('sys.color.font_primary'),
              textFont: {
                size: 18,
                weight: FontWeight.Medium,
              },
              underline: true,
            })
          }

          Column({ space: 12 }) {
            Text('自定义文本-builder').labelStyle()
            UILink({
              href,
              text: '点击进入华为开发者官网',
              navStack: this.stack,
              customText,
            })
          }
        }
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .padding(16)
    }
    .title('超链接')
    .mode(NavigationMode.Stack)
  }
}

@Builder
function customText() {
  Column({ space: 4 }) {
    SymbolGlyph($r('sys.symbol.paperclip'))
      .fontColor([$r('sys.color.font_emphasize')])
      .fontSize(20)
    Text('这是一个自定义超链接').fontColor($r('sys.color.font_emphasize'))
  }
  .padding(8)
  .borderWidth(1)
}

@Extend(Text)
function labelStyle() {
  .fontWeight(FontWeight.Bold)
  .fontSize(18)
  .width('100%')
  .textAlign(TextAlign.Start)
}
```

## 更新记录

- **1.0.0** (2026-01-27) 初始版本

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.2 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.2 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-link
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8406ab98b2084f28a6e487506f4253af/2adce9bbd4cb42d58a87e6add45594b3?origin=template