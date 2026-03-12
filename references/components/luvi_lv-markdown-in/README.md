# Markdown组件

## 简介

一款专为 HarmonyOS 设计的平台定制化 Markdown 渲染组件，让 Markdown 内容在界面中拥有更平滑的性能表现与更统一的视觉体验。

## 详细介绍

鸿蒙 Markdown 解析与渲染三方库，一款专为 HarmonyOS 系统设计的系统级 Markdown 渲染解决方案。让 Markdown 内容在界面中拥有更平滑的性能表现与更统一的视觉体验。

该库以高性能与系统级体验为核心，支持数学公式本地渲染，流式数据渲染，提供 50+ 可定制样式 API，助力开发者灵活定义 Markdown 内容的视觉风格与交互体验。从基础文本排版到复杂组件布局，都能精确适配系统特性。

充分结合鸿蒙资源机制，支持三种内容加载模式：

- 纯文本加载：适用于动态内容；
- 资源文件加载：便于内置模板与预设内容展示；
- 沙箱文件加载：保障用户内容安全与私有化存储。

适配 `$rawfile` 系统级资源图片加载能力，并支持 HTML 常用标签解析与图片加载代理，兼顾 Markdown 与富文本场景的灵活性。

### lv-markdown-in 目前支持

**基本语法**

| 功能 | 说明 |
|:---|:---|
| 标题 | 支持多级标题 |
| 段落 | 文本段落渲染 |
| 换行 | 自动换行处理 |
| 强调 | 粗体、斜体、粗斜体 |
| 引用块 | 引用内容展示 |
| 列表 | 有序列表、无序列表 |
| 代码 | 行内代码与代码块 |
| 分割线 | 水平分割线 |
| 链接 | 超链接跳转 |
| 图片 | 图片展示 |

**拓展语法**

| 功能 | 说明 |
|:---|:---|
| 表格 | 数据表格渲染 |
| 代码块 | 带语法高亮的代码块 |
| 脚注 | 文章脚注 |
| 任务列表 | 待办事项列表 |
| 删除线 | 删除线文本 |
| HTML 常用标签解析 | 支持部分 HTML 标签 |
| 数学公式 | LaTeX 数学公式渲染 |

## 立即使用

### 1. 运行命令

```bash
ohpm install @luvi/lv-markdown-in
```

### 2. 在项目中引入插件

```typescript
import { Markdown } from '@luvi/lv-markdown-in'
```

### 3. 在代码中使用

```typescript
Markdown({ text: "让文字在鸿蒙世界里呼吸，就得从**渲染**开始" })
```

## 多种内容加载模式（纯文本、资源文件、沙箱文件）

### 1. 纯文本模式（text）

```typescript
Markdown({
    text: "想让文字像在原生世界里呼吸，就得从**渲染**开始",
    mode: "text",               // 默认 text 可省略
    callback: {                 // callback 可省略
      complete: () => {
        console.log("Markdown component load success.")
      },
      fail: (code: number, message: string) => {
        console.error("Markdown component load error. code: " + code + ", message: " + message)
      }
    }
})
```

### 2. 资源文件模式（rawfile）

使用资源文件模式，需要将 `mode` 字段设置为 `rawfile`，`rawfilePath` 需要填写模块中 `rawfile` 目录的文件路径，同时需要传递应用上下文 `context`，`callback` 为可选参数，用于资源加载时的回调检查。

```typescript
Markdown({
    mode: "rawfile",
    context: getContext(),      // 资源文件模式必填参数
    rawfilePath: "t/text.md",   // 资源文件地址
    callback: {                 // callback 可省略
      complete: () => {
        console.log("Markdown component load success.")
      },
      fail: (code: number, message: string) => {
        console.error("Markdown component load error. code: " + code + ", message: " + message)
      }
    }
})
```

### 3. 沙箱文件模式（sandbox）

使用沙箱文件模式，需要将 `mode` 字段设置为 `sandbox`，`callback` 为可选参数，用于资源加载时的回调检查。

```typescript
Markdown({
    mode: "sandbox",
    sandboxPath: getContext().getApplicationContext().filesDir + "/t2/text.md",
    callback: {                 // callback 可省略
      complete: () => {
        console.log("Markdown component load success.")
      },
      fail: (code: number, message: string) => {
        console.error("Markdown component load error. code: " + code + ", message: " + message)
      }
    }
})
```

## 超链接、图片点击，自定义控制跳转行为

需要注意的是，使用拦截行为后，`return true` 才可拦截正常拦截库中默认打开行为，`return false` 则不拦截，但会进入该逻辑。

```typescript
// 导入 MarkdownController
import { MarkdownController } from '@luvi/lv-markdown-in'

// 注册超链接点击回调，return true 则表示拦截，自行处理超链接跳转逻辑
this.markdownController.setHyperlinkClickListener((title, src, anchorInfo) => {
    console.log("拦截跳转 title: " + title) // 标题
    console.log("拦截跳转 src: " + src) // 网页地址
    console.log("锚点信息 anchorInfo: " + JSON.stringify(anchorInfo)) // 锚点位置信息
    promptAction.showToast({ message: title + "\n" + src })
    return true
})

// 注册图像点击回调，return true 则表示拦截，自行处理图像展示逻辑
this.markdownController.setImageClickListener((src: string) => {
    console.log("拦截跳转 src: " + src) // 图片地址
    promptAction.showToast({ message: src })
    return true
})
```

## 动态样式改变

需在 Markdown 渲染完成后动态改变样式，可以绑定 `MarkdownController` 至对应 Markdown 组件后直接调用 `MarkdownController` 的多样化接口设置样式。

## $rawfile 原生资源图片加载

`$rawfile` 加载本地图片资源，语法示例：

```markdown
![]($rawfile("images/raw-pic.png"))
```

## 锚点跳转（new 3.2.6+）

通过标题的自动锚点实现（标题包含特殊字符时可能失效）。

```markdown
[跳转到二级标题](#二级标题)  <!-- 需与标题完全一致 -->
## 二级标题

[跳转到三级标题](#三级标题)  <!-- 需与标题完全一致 -->
### 三级标题
```

拦截锚点超链接，获取锚点在屏幕上的位置信息，页面滚动容器绑定 `Scroller`，滚动至页面指定位置。

```typescript
this.markdownController.setHyperlinkClickListener((title, src, anchorInfo) => {
  console.log("锚点信息 anchorInfo: " + JSON.stringify(anchorInfo)) // 锚点位置信息
  if (anchorInfo) {
    // 页面滚动容器绑定 Scroller，滚动至页面指定位置
    this.scroll.scrollTo({
      yOffset: px2vp(anchorInfo?.screenOffset.y),
      xOffset: 0,
      animation: { duration: 200 }
    })
    return true
  }
  return false
})
```

## 自定义图片尺寸（new 3.2.6+）

通过直接在图片链接后添加尺寸参数（如 `=600x400`），该值优先级高于通用图片尺寸设置。

- 格式：`![Alt text](image_url =widthxheight)`
- 示例：`![我的图片](https://example.com/image.png =600x400)`

**等比例缩放：**

- 只指定宽度：`![我的图片](https://example.com/image.png =600x)`
- 只指定高度：`![我的图片](https://example.com/image.png =x400)`

> 注意：`=` 号前通常需要一个空格。

## 深色模式

在代码中引用自定义的颜色资源值，使用 `$r` 加载自定义颜色资源，系统将自动在应用深浅色变化时，加载对应限定词目录下的资源文件，从而改变 Markdown 元素的颜色完成深浅色适配。详细可参阅文章：[ArkUI 深色模式适配指南](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-dark-mode-V5)

```typescript
import { Markdown, MarkdownController } from '@luvi/lv-markdown-in';

@Entry
@Component
struct Dark {
    controller: MarkdownController = new MarkdownController()
    @State content: string = `
      ## 鸿蒙原生应用开发笔记
      *鸿蒙原生*，意味着**纯净**与**性能**的平衡。
      > 想让文字像在原生世界里呼吸，就得从渲染开始。
    `

    aboutToAppear(): void {
        // 深色模式适配
        this.controller
            .setTitleColor($r("app.color.title"))
            .setTextColor($r("app.color.primary_text"))
            .setQuoteBackgroundColor($r("app.color.quote_bgc"))
    }

    build() {
        Scroll() {
            Markdown({
                controller: this.controller,
                text: this.content
            })
        }
        .padding({
            left: 15,
            right: 15,
            top: 60,
        })
    }
}
```

## Markdown

承载 Markdown 内容渲染的组件。项目采用 v1 + v2 装饰器混合开发，可同时在 v1 或 v2 项目中使用。

- **装饰器类型**：`@Component`

### 参数

| 名称 | 类型 | 必填 | 装饰器类型 | 说明 |
|:---|:---|:---|:---|:---|
| controller | `string \| undefined` | 否 | `@Prop` | 通过 `MarkdownController` 可以控制 Markdown 组件各种行为，如：自定义样式、设置图片点击拦截、设置超链接点击拦截等。 |
| text | `string \| undefined` | 否 | `@Prop` | Markdown 文本内容。 |
| mode | `"text" \| "rawfile" \| "sandbox" \| undefined` | 否 | `@Prop` | Markdown 组件加载模式，支持纯文本加载、沙箱文件加载、资源文件加载，不填默认为 `"text"`。 |
| context | `Context \| undefined` | 否 | - | `mode` 字段设置为 `rawfile` 时，`context` 为必填项。 |
| rawfilePath | `string \| undefined` | 否 | `@Prop` | `mode` 字段设置为 `rawfile` 时，`rawfilePath` 为必填项，需传入 `resources/rawfile` 目录下对应的 rawfile 文件路径。 |
| sandboxPath | `string \| undefined` | 否 | `@Prop` | `mode` 字段设置为 `sandbox` 时，`sandboxPath` 为必填项，需传入沙箱 text/md 文件的完整沙箱路径。例：`getContext().getApplicationContext().filesDir + "/t2/text.md"`。 |
| callback | `MdCallback \| undefined` | 否 | - | Markdown 组件加载状态结果告知。用于组件加载完成时，组件加载失败时回调，并返回错误码 `code`，错误信息 `message`，可用于问题分析。 |

## MarkdownController

Markdown 组件的控制器。可以将此对象绑定至 Markdown 组件，然后通过它控制 Markdown 组件的自定义样式及线程加载控制。同一个控制器可以控制多个 Markdown 组件，多个 API 支持链式调用语法。

- v1 版本开发中不支持使用 `@State` 装饰器进行修饰，无需使用装饰器修饰。
- v2 版本开发中可支持 v2 装饰器使用。
- 当然，您也可以完全不选择使用装饰器，这并不影响组件的正常渲染。

### 导入对象

```typescript
// 导入 MarkdownController
import { MarkdownController } from '@luvi/lv-markdown-in'
// 获取对象
markdownController: MarkdownController = new MarkdownController()
```

## 其他

详细接口使用文档请点击右侧"前往官网查看详情-主页"查看。

## 更新记录

### 3.2.6（2026-01-30）

1. 新增锚点超链接信息获取能力
2. 新增图片尺寸自定义能力

### 3.2.5（2026-01-26）

1. 新增设置剪贴板复制范围选项接口 `setCopyOption`
2. 新增标题自定义字体接口 `setTitleFontFamily`
3. 新增普通文本自定义字体接口 `setTextFontFamily`

### 3.2.3（2026-01-12）

1. 新增子线程加载控制接口 `setThreadRenderEnable`，支持禁用子线程加载。
2. 优化组件销毁时及时释放创建的线程
3. 修复表格项中无数据时单元格没渲染的问题

### 3.2.2（2026-01-08）

1. 优化标题字体颜色接口 `setTitleColor`，支持给指定级别的标题设置字体颜色
2. 新增 15 项自定义样式接口

### 3.2.0（2026-01-06）

1. 增加线程动态保活机制，避免线程超限
2. 修复公式显示模糊问题

### 3.1.8（2026-01-06）

1. 新增 Worker 线程解析资源，优化解析效率
2. 修复公式解析与金额解析冲突的问题
3. 修复其他已知问题

### 3.1.6（2025-12-24）

1. 修复把"纯 Markdown"当"HTML"去做了 `htmlToMarkdown()` 转换的问题，感谢开源贡献者：jimmy54 提交的 issue
2. 段落模块增加文本复制

### 3.1.4（2025-11-21）

1. 完善数学公式渲染
2. 修复已知问题

### 3.1.3（2025-11-20）

1. 解决 C2 通道回传敏感行为权限与隐私基本信息

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
|:---|:---|:---|
| `ohos.permission.INTERNET` | 获取网络权限 | 用于加载图片 URL、超链接 |

- [隐私政策立即查看](https://developer.huawei.com/consumer/cn/)
- [SDK 合规使用指南](https://developer.huawei.com/consumer/cn/)

## 兼容性

### HarmonyOS 版本

| 版本 | 支持状态 |
|:---|:---|
| 5.0.0 | ✅ |
| 5.0.1 | ✅ |
| 5.0.2 | ✅ |
| 5.0.3 | ✅ |
| 5.0.4 | ✅ |
| 5.0.5 | ✅ |
| 5.1.0 | ✅ |
| 5.1.1 | ✅ |
| 6.0.0 | ✅ |
| 6.0.1 | ✅ |
| 6.0.2 | ✅ |

### 应用类型

| 类型 | 支持状态 |
|:---|:---|
| 应用 | ✅ |
| 元服务 | ✅ |

### 设备类型

| 设备 | 支持状态 |
|:---|:---|
| 手机 | ✅ |
| 平板 | ✅ |
| PC | ✅ |

### DevEco Studio 版本

| 版本 | 支持状态 |
|:---|:---|
| DevEco Studio 5.0.0 | ✅ |
| DevEco Studio 5.0.1 | ✅ |
| DevEco Studio 5.0.2 | ✅ |
| DevEco Studio 5.0.3 | ✅ |
| DevEco Studio 5.0.4 | ✅ |
| DevEco Studio 5.0.5 | ✅ |
| DevEco Studio 5.1.0 | ✅ |
| DevEco Studio 5.1.1 | ✅ |
| DevEco Studio 6.0.0 | ✅ |
| DevEco Studio 6.0.1 | ✅ |
| DevEco Studio 6.0.2 | ✅ |

## 安装方式

```bash
ohpm install @luvi/lv-markdown-in
```

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e7575c576b744d2c9fc281dfac00deba/0107801bf5444e979ceb8157b0a33987?origin=template