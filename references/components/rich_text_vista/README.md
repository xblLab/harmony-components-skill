# RichTextVista 文本编辑器组件

## 简介

RichTextVista 是一款高性能、可扩展的富文本组件，专为 HarmonyOS 应用设计，支持丰富的文本样式功能。

## 详细介绍

### 简介
RichTextVista 是一款高性能、可扩展的富文本组件，专为 HarmonyOS 应用设计，支持丰富的文本样式功能。它以能够清晰呈现全景内容而得名，确保文本的每一个细节都能和谐地展现（HarmonyOS）。

### 功能
**Core Text Formatting**
*   **Basic Styles**: 支持基本的文本样式，包括加粗、斜体、下划线和删除线格式，并具备段落分隔功能。
*   **Advanced Styles**: 支持内联代码块、自定义文本/背景颜色，以及精确控制行距和字符间距。

**Layout Capabilities**
通过有序/无序列表、超链接嵌入以及图文混排布局，提供结构化的内容展示。支持嵌入用户自定义组件以显示时效性内容，允许将 RichTextVista 集成到第三方元素中。

**Performance & Adaptation**
通过优化的渲染管线，在列表中提供高性能的渲染效果。支持可折叠屏幕和 PC 设备，同时保持 UI 组件的复用效率。

**Extensibility**
符合 CommonMark 标准。

### 项目结构
项目结构在根文件夹中组织成几个关键目录，每个目录都有特定的用途：

*   `commonmark`: 包含 Markdown 标准化定义，确保符合 CommonMark 标准。
*   `entry`: 一个利用 RichTextVista 的演示项目，用于展示其功能并提供示例实现。
*   `rich_text_core`: 包含 RichTextVista 的核心逻辑，包括主要功能和特性。

完整的特性集和代码结构如下图所示：

## 安装

### Install via ohpm:

```bash
# Using ohpm install
ohpm install rich_text_vista

# Or using the shortcut (ohpm i)
ohpm i rich_text_vista
```

## 使用

RichTextVista 支持多种标准格式（原始字符串、HTML、Markdown），同时公开其基于 Markdown 的抽象语法树（AST）规范，使用户能够独立地将自定义数据结构转换为这种标准表示形式——从而通过统一的处理方式，实现跨灵活场景的无缝集成。

### RichTextVista 的工作原理
RichTextVista 的灵活性使您能够处理各种输入格式，从而轻松地与不同的内容源进行集成。无论您是直接从零开始构建抽象语法树（AST），还是通过 HTML 或 Markdown 字符串来填充组件，解析过程都会将输入转换为统一的 AST（节点）表示形式。然后，该 AST 被用于渲染富文本用户界面，确保内容的一致性和准确显示。此外，支持自定义样式的功能进一步增强了组件的适应性，使您能够根据具体的设计需求定制文本展示效果。

### Start with AST Input / Start from Scratch
你可以通过构建抽象语法树（AST）节点来直接生成富文本。这种方法让你能够完全控制文本的结构和样式。当你没有标准化的初始输入格式时，这种方法尤其有用，因此最好直接从这种标准化的 AST 开始构建。你首先需要创建节点对象，并将它们组装成一棵树，这棵树就代表了富文本。

```typescript
@Param content: Node  

build() {
  RichTextVista({      
    richText: this.createRichTextFromAST(),
    fontSize: 16,      
  })  
} 

private createRichTextFromAST() {
  const richTextRepresentation = new RichTextRepresentation()
  richTextRepresentation.ast = this.content
  return richTextRepresentation
}
```

### Start with String Input
对于最基本的用法，你可以从一个纯字符串输入开始，而不需要任何高级样式。只需将原始字符串提供给组件，它就会将其转换为 AST（节点）。这种方法非常适合那些想要将纯文本内容显示为富文本的场景。

```typescript
// Assuming ComponentV2 

@Param content: string

build() {
  RichTextVista({      
    richText: this.createRichTextFromAST(),
    fontSize: 16,      
  })   
}

private parsePureTextToAST(content: string): RichTextRepresentation {
  const richTextRepresentation = new RichTextRepresentation()
  richTextRepresentation.plainText = content
  return richTextRepresentation
}
```

### Start with HTML String Input
如果你有一个 HTML 字符串，你可以直接将其传递给组件。该组件会解析 HTML 字符串并将其转换为 AST（节点），然后用于渲染富文本 UI。当你有现有的 HTML 内容并希望将其显示为富文本时，这种方法非常方便。

```typescript
// Assuming ComponentV1  

@Prop content: string

build() {
  RichTextVista({      
    richText: this.parseHTMLStringToAST(this.content),
    fontSize: 16,      
  })   
}

private parseHtmlStringToAST(htmlContent: string): RichTextRepresentation {
  const richTextRepresentation = new RichTextRepresentation()
  richTextRepresentation.htmlString = htmlContent
  return richTextRepresentation
}
```

### Start with Markdown String Input
对于 Markdown 输入，只需将 Markdown 字符串提供给组件。该组件将负责解析 Markdown 语法并将其转换为 AST（节点）。这种方法非常适合那些拥有以 Markdown 格式编写的内容，并希望将其显示为富文本的场景。

```typescript
// Assuming ComponentV1  

@Prop content: string

build() {
  RichTextVista({      
    richText: this.parseHTMLStringToAST(this.content),
    fontSize: 16,      
  })   
}

private parseMarkdownStringToAST(markdownContent: string): RichTextRepresentation {
  const richTextRepresentation = new RichTextRepresentation()
  richTextRepresentation.markdownString = markdownContent
  return richTextRepresentation
}
```

### Implement Custom Styles
RichTextVista 不仅支持预置的常见样式，还允许用户实现自定义样式。如果你想展示那些不在预置选项中的文本样式，那么实现自定义样式是最佳选择。这种灵活性尤其有价值，因为在富文本组件中支持自定义样式通常具有挑战性。

## 开源协议
MIT License

## 更新记录
**Version 1.0.0 (Initial Release)**
*   **Added**: RichTextVista 初始版本发布。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3 |
| 应用类型 | 应用 |
| 元服务 | 元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install rich_text_vista
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5c859919e0ae4721aeaf4b49dd3f4d7d/PLATFORM?origin=template