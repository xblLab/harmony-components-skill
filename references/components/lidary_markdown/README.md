# HMarkdown 文本解析组件

## 简介

HMarkdown 基于 marked 的 HarmonyOS 端 markdown 渲染库。

## 详细介绍

### 简介

基于 marked 的 HarmonyOS 端 markdown 渲染库

### v3.0.0 特性

- 支持公式本地渲染
- 支持子线程渲染
- 完全重构

### Tips

本次更新支持 Api 变动较大，如需旧版本请查看→
v2.0.8 因为没有考虑到子线程内存隔离问题会导致设置的插件不生效

### 效果图



### 参数

| 名称 | 是否必传 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| content | 否 | "" | markdown 文本内容 |
| token | 否 | [] | markdown 文本内容解析后 Tokens |
| options | 否 | undefined | 属性，主题等相关配置 |
| onLoading, onSuccess, onError | 否 | undefined | 加载状态回调 (方面设置 Loading 等) |

### MarkdownOptions 参数

| 名称 | 是否必传 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| theme | 否 | defaultTheme(参考 Jetbrains 的 ui) | 亮色主题相关配置 |
| darkTheme | 否 | defaultDarkTheme(参考 Jetbrains 的 ui) | 暗色主题相关配置 |
| darkMode | 否 | false | 是否亮色/暗色 |
| lineSpace | 否 | 12 | item 之间的间距 |
| textLineSpace | 否 | LengthMetrics.vp(12) | item 中 text 的行间距 |
| options | 否 | undefined | marked 相关配置 |
| extensions | 否 | undefined | marked 插件，可参考数学公式 |
| imageClick | 否 | undefined | 图片点击事件 |
| linkClick | 否 | undefined | 超链接点击事件 |
| customBlockBuilder | 否 | undefined | 自定义块元素渲染 |
| customInlineBuilder | 否 | undefined | 自定义行内元素渲染 |
| maxLines | 否 | undefined | 如果是行内元素则显示最大行数 (多为 List 列表内 item 都是 Markdown 时使用) |

### 下载安装

深色代码主题复制

```bash
ohpm install @lidary/markdown
```

### 导包

深色代码主题复制

```typescript
// V2 状态管理 不支持 V1
import { Markdown } from '@lidary/markdown';
```

### 使用方式

深色代码主题复制

```typescript
Markdown({
  content: this.text,
  options: {
    darkMode: this.isDark,
    options: {
      gfm: true
    },
    darkTheme: {
      themeColor: Color.Orange
    },
    imageClick: (url?: string) => {
      promptAction.showToast({
        message: `图片被点击:${url}`,
        duration: 1500,
        bottom: "center",
      })
    },
    linkClick: (url?: string) => {
      promptAction.showToast({
        message: `超链接被点击----url:${url}`,
        duration: 1500,
        bottom: "center",
      })
    }
  },
  onLoading: () => {
    this.isLoading = true
  },
  onError: () => {
    this.isLoading = false
  },
  onSuccess: () => {
    this.isLoading = false
  },
  contentStartOffset: AppUtils.WindowUtil.getBottomHeight(),
  contentEndOffset: AppUtils.WindowUtil.getBottomHeight(),
  paddings: {left: 16, right: 16},
  scrollBar: BarState.Off,
  nestedScroll: {
    scrollForward: NestedScrollMode.PARENT_FIRST,
    scrollBackward: NestedScrollMode.SELF_FIRST
  },
  cachedCount: 3,
  cachedShow: true
}).height("100%")
```

### 特性

- 支持标题语法
- 支持段落语法
- 支持分割线语法
- 支持代码语法
- 支持加粗语法
- 支持斜体语法
- 支持删除线语法
- 支持链接语法
- 支持表格语法
- 支持有序列表语法
- 支持无序列表语法
- 支持块引用语法
- 支持数学公式语法
- 支持图片语法
- 支持单独代码块功能
- 支持列表嵌套功能
- 支持文本样式设置
- 支持深浅主题色设置
- 支持部分 html 语法
- 支持任务列表语法

### 开源协议

本项目基于 MIT License，请自由地享受和参与开源

### 更新记录

#### v3.0.5 #38

- 沉浸式案例、组件增加 contentStartOffset、contentEndOffset、paddings、scrollBar、nestedScroll、cachedCount、cachedShow 等属性
- 优化代码块 copy 图标显示，增加自定义 copy 图标、copy 图标颜色

#### v3.0.4 #34

- 对外暴露 latexResPath

#### v3.0.3

1. 修复 options 参数为空时程序崩溃 bug #32

#### v3.0.2

- 修复数据首次传入未加载 bug #32

#### v3.0.1

- 优化公式解析规则
- 新增行间 html 解析，渲染

#### v3.0.0

- tokens 解析放入子线程，性能更佳
- 支持公式本地解析

#### v2.0.8

- 优化 #31:  
  - 数据解析改为子线程实现
  - UI 渲染改为 List + Repeat 实现

#### v2.0.7

- fix: 修复 Heading 组件 fontWeight 属性无效问题

#### v2.0.6

- fix: 修复列表样式同一标题可能会出现多次的 bug #24

#### v2.0.5

- 对外暴露 markConfig.apply(options: MarkedOptions) 方法自定义 options
- 对外暴露/core/marked.ts 文件以支持完全自定义

#### v2.0.4

- fix: 修复 v1 版本内容为超链接且样式为加粗时渲染异常 bug #19
- fix: 修复有序列表超过 10 个，序号显示异常 bug #20

#### v2.0.3

- fix: 修复内容为超链接且样式为加粗时渲染异常 bug #19

#### v2.0.2

- fix: 修复 v2 版本内容可能无法正常显示 bug #16

#### v2.0.1

- fix: 修复主题无法合并的 bug

#### v2.0.0

- 适配 v2 状态管理

#### v1.0.16

- fix: 修复 MarkdownLite 崩溃 bug

#### v1.0.15

- 对外暴露 Inline 的 AttributeModifier(mdInlineModifier) 属性来实现自定义样式

#### v1.0.14

- 修复列表解析可能会崩溃的 bug
- 修复未定义 customBuilder 时崩溃的 bug

#### v1.0.13

- enable useNormalizedOHMUrl
- 移除对 html 的解析

#### v1.0.12

- fix: 修复~~装饰的文字删除效果未解析 bug

#### v1.0.11

- tokenList 支持外部传递 #6

#### v1.0.10 #5

- 无序列表，有序列表优化

#### v1.0.9

- 修复图片可能超过最大宽度 bug
- 图片渲染优化

#### v1.0.8

- 修复插件可能加载失败的 bug

#### v1.0.7 #4

- 修复有序列表被渲染成无序列表 bug
- 修复列表中文字溢出 bug

#### v1.0.6

- 更改无序列表对其方式 #2
- 对实体字符进行清理 #3

#### v1.0.5

- 修复纯文本不显示 bug
- 修复内容无法动态更新 bug #1

#### v1.0.4

- 支持 html 解析
- 文档优化

#### v1.0.3

- Image 渲染宽高改为图片宽高

#### v1.0.2

1. Table 滚动优化 (现在可以整体横向滚动了)

#### v1.0.1

- 修复 theme,fontStyle 等属性无法动态更新 bug
- 修复 Markdown 的点击事件被内部子组件拦截 bug
- 修复标题含有斜体样式时未被正确渲染的 bug
- 自定义组件暴露 that 参数
- 优化传参方式

#### v1.0.0

- 基本解析，渲染功能实现

## 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 权限与隐私基本信息 | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本：5.0.0 |

应用类型 应用 

Created with Pixso.


元服务 

Created with Pixso.


设备类型 手机 

Created with Pixso.


平板 

Created with Pixso.


PC 

Created with Pixso.


DevEcoStudio 版本 DevEco Studio 5.0.0 

Created with Pixso.

## 安装方式

```bash
ohpm install @lidary/markdown
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/96b42b28dcb74d1882a8272dd83298e1/PLATFORM?origin=template