# svg 矢量图形处理组件

## 简介

ohos-svg 是一个 SVG 图片的解析器和渲染器，可以解析 SVG 图片并渲染到页面上，还可以动态改变 SVG 的样式。

## 详细介绍

### 简介

ohos-svg 是一个 SVG 图片的解析器和渲染器，解析 SVG 图片并渲染到页面上。它支持大部分 SVG 1.1 规范，包括基本形状、路径、文本、样式和渐变，它能够渲染大多数标准的 SVG 图像。ohos-svg 的优点是性能好、内存占用低。

### 效果展示

SVG 图片解析并绘制：

### 下载安装

```bash
ohpm install @ohos/svg
```

### 接口使用方式变更

1. 需要在 EntryAbility.ts 引入 `this.context`

```ets
import { GlobalContext } from '@ohos/svg/src/main/ets/components/GlobalContext';
...        
GlobalContext.getContext().setObject("context", this.context);
```

2. 在需要的时候通过 getObject 获取 context 对象

```ets
import { GlobalContext } from '@ohos/svg/src/main/ets/components/GlobalContext';
import { Context } from '@ohos.abilityAccessCtrl';
let context: Context = GlobalContext.getContext().getObject("context") as Context;
let value = context.resourceManager.getRawFileContentSync('ic_launcher_round.svg')
if (value) {
   ...
}
```

### 使用说明

```ets
import { SVGImageView } from '@ohos/svg'

model: SVGImageView.SVGImageViewModel = new SVGImageView.SVGImageViewModel();

build() {
  SVGImageView({ model: this.model })
}
```

### 接口说明

```ets
model: SVGImageView.SVGImageViewModel = new SVGImageView.SVGImageViewModel();
```

- **设置 svg 资源文件**
  `this.model.setImageRawfile(filename: string, context?:common.UIAbilityContext)`
- **设置 svg 对象**
  `this.model.setSVG(svg: SVG, css?: string, context?:common.UIAbilityContext)`
- **设置 svg 资源图片**
  `this.model.setImageResource(resource: Resource, context?:common.UIAbilityContext)`
- **设置 svg 图片的源文件字符串**
  `this.model.setFromString(url: string, context?:common.UIAbilityContext)`

### 约束与限制

在下述版本验证通过：

- DevEco Studio NEXT Developer Beta3: 5.0(5.0.3.530)
- SDK: API12 (5.0.0.35(SP3))

**HSP 场景适配：**
SVGImageViewModel 配置类部分对外接口新增可选参数 context，在 HSP 场景下需要传入正确的 context，才能保证三方库后续正确获取 Resource 资源。
非 HSP 场景不影响原功能，context 可以不传。

### 目录结构

```text
|---- ohos-svg  
|     |---- entry  # 示例代码文件夹
|     |---- library  # ohos_svg 库文件夹
|           |---- index.ets  # 对外接口
|           |---- components  # 组件代码目录
|                 |---- CSS.ts
|                 |---- GlobalContext.ts
|                 |---- PreserveAspectRatio.ts
|                 |---- RenderOptions.ts
|                 |---- SimpleAssetResolver.ts
|                 |---- SVG.ts
|                 |---- SVGExternalFileResolver.ts
|                 |---- SVGImageView.ets
|                 |---- SVGParseException.ts   
|                       |---- utils  
|                             |---- Character  
|                             |---- CSSBase  
|                             |---- CSSFontFeatureSettings  
|                             |---- CSSFontVariationSettings  
|                             |---- CSSTextScanner  
|                             |---- IntegerParser  
|                             |---- Matrix  
|                             |---- mini_canvas  
|                             |---- NumberParser  
|                             |---- Rect  
|                             |---- RenderOptionsBase  
|                             |---- Style  
|                             |---- SVGBase  
|                             |---- SVGParser  
|                             |---- SVGParserImpl  
|                             |---- SVGRenderer  
|                             |---- SVGXMLChecker  
|                             |---- SVGXMLConstants  
|                             |---- TextScanner  

|     |---- README.md  # 安装使用方法                    
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 遗留问题

1. 目前 mask 标签绘制有问题
2. svg 图片含有 image 标签时需要将 svg 图片和 image 标签引用的图片共同放在 rawfile 文件夹下

## 更新记录

### v2.2.2

Release the official version 2.2.2

#### v2.2.2-rc.0

- Fix issues with text display font, position, and size
- Fix the issue of parsing errors in the transform matrix
- Fix the serious issue with CodeCheck scanning and refactor this redundant 'await' on non promise surfaces
- Fixed the issue of overlapping content twice after replacing image resources

### v2.2.1

- 修复设置透明度不为 1 时渲染错位的问题

### v2.2.0

- 发布 2.2.0 正式版

#### v2.2.0-rc.1

- 修复 svg 标签中没有 ViewBox 属性，图片无法显示的问题

#### v2.2.0-rc.0

- 适配新版状态管理装饰器

### v2.1.1

- 发布正式版，修复已知问题

#### v2.1.1-rc.6

- 修复宽高单位为百分比情况下，长宽比异常的问题
- 修复 svg 标签中有宽高属性时，图片缩放异常的问题

#### v2.1.1-rc.5

- 修复带 Polygon 的 svg 图片不显示的问题

#### v2.1.1-rc.4

- 修复屏幕的大小发生变化时 svg 图片显示尺寸不对的问题

#### v2.1.1-rc.3

为了适配 HSP 场景，SVGImageViewModel 类部分接口新增当前场景上下文 context 可选参数传入，在 HSP 场景下需要传正确的 context，非 HSP 场景不影响，context 可以不传
1. `setCSS(css: string, context?:common.UIAbilityContext)`
2. `setImageResource(resource: Resource, context?:common.UIAbilityContext)`
3. `setImageRawfile(filename: string, context?:common.UIAbilityContext)`
4. `setFromString(url: string, context?:common.UIAbilityContext)`

#### v2.1.1-rc.2

- 修复屏幕的大小发生变化时 svg 图片消失问题

#### v2.1.1-rc.1

- 修复获取资源文件失败的问题

#### v2.1.1-rc.0

- 修复不兼容 API9 问题

### v2.1.0

- ArkTS 语法整改
- 接口使用方式变更：GlobalContext 替代 globalThis

### v2.0.3

- 修复 svg 图片大小显示不对的问题

### v2.0.2

- 修改 getSVGPixelMap 方法

### v2.0.1

- 修改 entry 的逻辑结构
- 删除废弃的接口

### v2.0.0

- 包管理工具由 npm 切换为 ohpm
- 适配 DevEco Studio: 3.1Beta2(3.1.0.400)
- 适配 SDK: API9 Release(3.2.11.9)

### v1.1.1

- 适配 DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）

### v1.1.0

- 重构 canvas 解析绘制逻辑，并增加 renderDocument 接口
- 目前除 mask 以外，其他的 svg 组件基本支持
- 注：当 svg 里有 image 标签使用时必须将此 svg 和 image 标签引用的 image 放入 rawfile 下才能正常绘制

### v1.0.2

- 调整 getfromstring 方法名
- 解决 watch 监听 abouttoappear 不会重新走
- svg 类型拆分
- 补充了 canvas 绘制逻辑
- 补充了 text、switch 以及 use 标签解析绘制

### v1.0.1

- api8 升级到 api9，并转换为 stage 模型

### v1.0.0

ohos-svg 是一个解析渲染 SVGLibrary，支持了以下功能：

- 解析 SVG
- 渲染 SVG
- 改变 SVG 样式

不支持以下功能：

- svg 字体解析绘制

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机 |
| 设备类型 | 平板 |
| 设备类型 | PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/svg
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/68576d29a8454dfcb2d999986d47b06f/PLATFORM?origin=template