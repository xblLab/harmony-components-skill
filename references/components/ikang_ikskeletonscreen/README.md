# 骨架屏组件

## 简介

一个功能强大、易用性高的鸿蒙骨架屏组件，支持丰富的预设模板和自定义配置。

## 详细介绍

IkSkeletonScreen 骨架屏组件
一个功能强大、易用性高的鸿蒙骨架屏组件，支持丰富的预设模板和自定义配置。

### 特性

- 🚀 **易用性高** - 提供统一的组件入口，配置驱动开发
- 📦 **预设丰富** - 内置多种常用场景的模板（列表项、卡片、详情页等）
- 🎨 **高度可定制** - 支持自定义样式、动画、颜色和布局
- ⚡ **动画丰富** - 支持 6 种动画类型（渐变、闪烁、脉冲、往返等）
- 🎯 **精细控制** - 支持动画速度、亮度、颜色等细节调整
- 💪 **性能优化** - 支持多项渲染、虚拟滚动和配置缓存优化
- 🔧 **类型安全** - 完整的 TypeScript 类型定义

## 安装

深色代码主题复制
```bash
ohpm install @ikang/ikskeletonscreen
```

## 软件架构

该项目基于 HarmonyOS 的 ETS 架构开发，主要包含以下模块：

- **配置模块** (Types.ets、Constants.ets、Presets.ets) 用于管理骨架屏组件的类型定义、常量配置和预设模板生成。
- **动画管理模块** (AnimationManager.ets) 提供动画的统一管理和优化，采用单例模式管理动画状态，支持页面可见性控制和动画暂停/恢复。
- **基础组件模块** (SkeletonBase.ets) 实现基础骨架元素的渲染和动画效果，支持多种动画类型（渐变、闪烁、脉冲等）。
- **主组件模块** (Skeleton.ets) 提供骨架屏的主入口组件，实现配置规范化、多项渲染和内容插槽功能。
- **虚拟滚动模块** (VirtualSkeleton.ets) 提供虚拟滚动支持，用于处理大量数据的骨架屏渲染优化。

## 快速开始

### 最简单的使用

深色代码主题复制
```typescript
import { Skeleton, SkeletonType } from '@ikang/ikskeletonscreen';

@Component
struct MyPage {
  @State loading: boolean = true;

  build() {
    Skeleton({
      loading: this.loading,
      config: {
        type: SkeletonType.TEXT,
        lines: 3,
        lastLineWidth: '60%'
      }
    }) {
      Text('实际内容加载完成后显示')
    }
  }
}
```

### 使用预设模板

可根据自己的样式配置预置模板

深色代码主题复制
```typescript
import { Skeleton, SkeletonPresets } from '@ikang/ikskeletonscreen';

// 列表项
Skeleton({
  loading: this.loading,
  config: SkeletonPresets.listItem()
})

// 卡片
Skeleton({
  loading: this.loading,
  config: SkeletonPresets.card()
})

// 详情页
Skeleton({
  loading: this.loading,
  config: SkeletonPresets.detail()
})
```

## 核心功能

### 1. 基础元素类型

深色代码主题复制
```typescript
// 矩形 - 用于图片、按钮等
{ type: SkeletonType.RECT, width: '100%', height: 60, radius: 8 }

// 圆形 - 用于头像、图标等
{ type: SkeletonType.CIRCLE, size: 60 }

// 文本 - 用于标题、段落等
{ type: SkeletonType.TEXT, lines: 3, lastLineWidth: '60%' }
```

### 2. 动画类型控制

支持 6 种动画效果：

深色代码主题复制
```typescript
animate: AnimateType.NONE               // 无动画
animate: AnimateType.GRADIENT           // 从左到右渐变
animate: AnimateType.GRADIENT_RTL       // 从右到左渐变
animate: AnimateType.GRADIENT_ALTERNATE // 左右往返渐变
animate: AnimateType.FLASH              // 透明度闪烁
animate: AnimateType.PULSE              // 缩放脉冲
```

### 3. 动画参数控制

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  animate: AnimateType.GRADIENT,
  speed: 1.5,                    // 动画速度（0.5 慢速，1.0 正常，2.0 快速）
  shimmerBrightness: 0.8,        // 光影亮度（0-1 之间）
  shimmerColor: '0,150,255',     // 光影颜色（RGB 格式）
  duration: 1500,                // 动画时长 (ms)
  delay: 0,                      // 延迟时间 (ms)
  config: { /* ... */ }
})
```

### 4. 背景色控制

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  skeletonBackgroundColor: '#F5F5F5',        // 骨架元素背景色
  containerBackgroundColor: '#FFFFFF',       // 容器背景色
  itemContainerBackgroundColor: '#FAFAFA',   // 多项 item 背景色
  config: { /* ... */ }
})
```

### 5. 组合布局

深色代码主题复制
```typescript
// 头像 + 文本
{
  type: SkeletonType.AVATAR_TEXT,
  direction: 'row',
  space: 12,
  children: [
    { type: SkeletonType.CIRCLE, size: 48 },
    { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
  ]
}

// 图片 + 文本
{
  type: SkeletonType.IMAGE_TEXT,
  direction: 'row',
  space: 12,
  children: [
    { type: SkeletonType.RECT, width: 100, height: 80, radius: 8 },
    { type: SkeletonType.TEXT, lines: 3 }
  ]
}

// 段落文本
{
  type: SkeletonType.PARAGRAPH,
  lines: 4,
  lineHeight: 18,
  lastLineWidth: '60%',
  space: 8
}
```

### 6. 多项渲染

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  config: {
    type: SkeletonType.LIST_ITEM,
    itemCount: 5,  // 一次渲染 5 个列表项
    direction: 'row',
    space: 12,
    children: [
      { type: SkeletonType.CIRCLE, size: 40 },
      { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
    ]
  }
})
```

## API 参考

### 组件属性

| 属性名 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| loading | boolean | true | 控制骨架屏显示状态，true 显示骨架屏，false 显示实际内容 |
| animate | AnimateType | GRADIENT | 动画类型 |
| duration | number | 1500 | 动画时长 (ms) |
| delay | number | 0 | 动画延迟时间 (ms) |
| speed | number | 1.0 | 动画速度倍数（1.0 为正常，0.5 为慢速，2.0 为快速） |
| shimmerBrightness | number | 0.7 | 光影亮度（0-1 之间，0.7 表示 70% 亮度） |
| shimmerColor | string | '255,255,255' | 光影颜色（RGB 格式，如 '255,0,0' 为红色） |
| skeletonBackgroundColor | ResourceColor | undefined | 全局骨架元素背景色 |
| containerBackgroundColor | ResourceColor | undefined | 骨架屏容器背景色 |
| itemContainerBackgroundColor | ResourceColor | undefined | 多项模式下每个 item 的背景色 |
| config | SkeletonConfig | - | 骨架屏配置对象 |
| content | @BuilderParam | - | 子内容插槽（loading 为 false 时显示） |

### 动画类型 (AnimateType)

深色代码主题复制
```typescript
enum AnimateType {
  NONE = 0, // 无动画，静态展示
  GRADIENT = 1, // 渐变动画，从左到右的渐变效果（单向）
  FLASH = 2, // 闪烁动画，透明度变化效果
  PULSE = 3, // 脉冲动画，缩放效果
  GRADIENT_RTL = 4, // 渐变动画，从右到左的渐变效果（单向）
  GRADIENT_ALTERNATE = 5, // 渐变动画，从左到右再从右到左往返执行
}
```

#### 动画效果说明

- **GRADIENT**: 渐变动画，从左到右的渐变效果（单向）
- **GRADIENT_RTL**: 渐变动画，从右到左的渐变效果（单向）
- **GRADIENT_ALTERNATE**: 渐变动画，从左到右再从右到左往返执行
- **FLASH**: 闪烁动画，透明度变化效果
- **PULSE**: 脉冲动画，缩放效果
- **NONE**: 无动画，静态展示

### 元素类型 (SkeletonType)

深色代码主题复制
```typescript
enum SkeletonType {
  // 基础元素类型
  RECT = 'rect',              // 矩形骨架，用于图片、按钮等区块占位
  CIRCLE = 'circle',          // 圆形骨架，用于头像、图标等圆形元素占位
  TEXT = 'text',              // 文本骨架，用于标题、段落等文本内容占位
  
  // 组合布局类型
  AVATAR_TEXT = 'avatar-text', // 头像 + 文本组合，用于用户信息、评论等场景
  IMAGE_TEXT = 'image-text',   // 图片 + 文本组合，用于新闻列表、商品列表等场景
  PARAGRAPH = 'paragraph',     // 段落文本，用于文章内容等多行文本场景
  
  // 预设模板类型
  LIST_ITEM = 'list-item',     // 列表项模板，用于各类列表场景
  CARD = 'card',               // 卡片模板，用于商品卡片、文章卡片等场景
  DETAIL = 'detail',           // 详情页模板，用于商品详情、文章详情等场景
  COMMENT = 'comment',         // 评论模板，用于评论列表场景
  ARTICLE = 'article',         // 文章模板，用于文章页面布局
  PROFILE = 'profile'          // 个人资料模板，用于个人中心页面
}
```

### 配置项 (SkeletonConfig)

深色代码主题复制
```typescript
class SkeletonConfig {
  // 基础配置
  type: SkeletonType;                      // 元素类型（必填）
  width?: Length;                          // 宽度（支持 number 和 string，如 100 或'100%'）
  height?: Length;                         // 高度
  size?: Length;                           // 尺寸（用于圆形，会自动同步 width 和 height）
  radius?: Length;                         // 圆角大小
  margin?: MarginConfig;                   // 外边距
  padding?: PaddingConfig;                 // 内边距
  skeletonBackgroundColor?: ResourceColor; // 骨架元素背景色（会传递给子元素）

  // 文本配置
  lines?: number;                          // 文本行数（多行时自动转换为 PARAGRAPH）
  lineHeight?: Length;                     // 行高
  lastLineWidth?: Length;                  // 最后一行宽度（常用于模拟不完整行）
  
  // 列表配置
  itemCount?: number;                      // 列表项数量（大于 1 时会渲染多个骨架）
  
  // 布局配置
  direction?: 'row' | 'column';            // 布局方向
  space?: number;                          // 子元素间距
  align?: HorizontalAlign;                 // 对齐方式
  
  // 子元素
  children?: Array<SkeletonConfig>;        // 子元素配置数组
}
```

## 预设模板

组件提供 3 个开箱即用的预设模板：

### SkeletonPresets.listItem()

列表项模板：头像 + 两行文本

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  config: SkeletonPresets.listItem()
})
```

### SkeletonPresets.card()

卡片模板：图片 + 三行文本

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  config: SkeletonPresets.card()
})
```

### SkeletonPresets.detail()

详情页模板：头像标题 + 大图 + 段落

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  config: SkeletonPresets.detail()
})
```

> 提示：可以参考 SkeletonPresets 类的实现，根据业务需求创建自定义预设配置。

## 常用场景示例

### 场景 1：列表加载

深色代码主题复制
```typescript
Skeleton({
  loading: this.isLoading,
  config: {
    type: SkeletonType.LIST_ITEM,
    itemCount: 5,
    direction: 'row',
    space: 12,
    children: [
      { type: SkeletonType.CIRCLE, size: 48 },
      { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
    ]
  }
}) {
  ForEach(this.dataList, (item) => {
    ListItem() {
      Row({ space: 12 }) {
        Image(item.avatar).width(48).height(48).borderRadius(24)
        Column({ space: 4 }) {
          Text(item.name)
          Text(item.desc)
        }
      }
    }
  })
}
```

### 场景 2：文章详情页

深色代码主题复制
```typescript
Skeleton({
  loading: this.isLoading,
  config: SkeletonPresets.detail()
}) {
  Column({ space: 24 }) {
    // 文章头部
    Row({ space: 16 }) {
      Image(this.avatar).width(64).height(64).borderRadius(32)
      Column({ space: 6 }) {
        Text(this.title)
        Text(this.author)
      }
    }
    // 文章图片
    Image(this.image).width('100%').height(200)
    // 文章内容
    Text(this.content)
  }
}
```

### 场景 3：商品卡片

深色代码主题复制
```typescript
Skeleton({
  loading: this.isLoading,
  config: SkeletonPresets.card()
}) {
  Column({ space: 12 }) {
    Image(this.product.image).width('100%').height(180).borderRadius(8)
    Text(this.product.title).fontSize(16)
    Text(this.product.desc).fontSize(14)
    Text(`¥ ${this.product.price}`).fontSize(18).fontColor('#FF6B00')
  }
}
```

## VirtualSkeleton vs Skeleton 的 itemCount 区别

### 核心区别

| 特性 | Skeleton (itemCount) | VirtualSkeleton (itemCount) |
| :--- | :--- | :--- |
| 渲染方式 | 一次性渲染所有项 | 虚拟化渲染，只渲染可见区域 |
| 适用场景 | 少量数据（< 20 项） | 大量数据（> 50 项） |
| 性能影响 | 数据量大时性能下降 | 始终保持高性能 |
| 滚动支持 | 需要外层容器提供滚动 | 内置滚动容器 |
| DOM 节点数 | 等于 itemCount | 约 10-20 个（可见区域） |
| 必填参数 | 无 | 必须指定 height |

### Skeleton + itemCount（少量数据）

**适用场景：** 数据量 < 20 项

深色代码主题复制
```typescript
Skeleton({
  loading: true,
  config: {
    type: SkeletonType.LIST_ITEM,
    itemCount: 5,  // 会一次性渲染 5 个骨架
    direction: 'row',
    space: 12,
    children: [
      { type: SkeletonType.CIRCLE, size: 40 },
      { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
    ]
  }
})
```

**特点：**

- ✅ 简单直接，无需额外配置
- ✅ 可以嵌套在任何容器中
- ✅ 适合固定数量的列表项
- ❌ itemCount 过大会导致性能问题
- ❌ 一次性渲染所有 DOM 节点

**推荐场景：** 商品推荐（3-5 个）、评论预览（前 3 条）、热门文章（5-10 篇）

### VirtualSkeleton + itemCount（大量数据）

**适用场景：** 数据量 > 50 项

深色代码主题复制
```typescript
VirtualSkeleton({
  loading: true,
  config: {
    type: SkeletonType.LIST_ITEM,
    itemCount: 100,  // 总数据量，但只渲染可见部分
    height: 72,      // ⚠️ 必须：每项的固定高度
    direction: 'row',
    space: 12,
    padding: { left: 16, right: 16 },
    children: [
      { type: SkeletonType.CIRCLE, size: 40 },
      { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
    ]
  }
})
```

**特点：**

- ✅ 支持大量数据，性能始终稳定
- ✅ 内置滚动容器，自动处理滚动
- ✅ 只渲染可见区域（约 10-20 个节点）
- ✅ 自动回收和复用节点
- ⚠️ 必须指定固定的 height
- ⚠️ 必须占据明确的容器高度

**推荐场景：** 用户列表、商品列表、新闻列表、无限滚动

### 性能对比示例

深色代码主题复制
```typescript
// ❌ 不推荐：Skeleton 渲染 100 项
Skeleton({
  config: { itemCount: 100, ... }
})
// 结果：创建 100 个 DOM 节点，页面卡顿

// ✅ 推荐：VirtualSkeleton 渲染 100 项
VirtualSkeleton({
  config: { itemCount: 100, height: 72, ... }
})
// 结果：只创建约 15 个 DOM 节点，流畅
```

### 选择建议

| 数据量 | 推荐组件 | 原因 |
| :--- | :--- | :--- |
| < 10 项 | Skeleton | 简单直接，性能足够 |
| 10-20 项 | Skeleton | 可接受的性能 |
| 20-50 项 | Skeleton 或 VirtualSkeleton | 根据实际性能测试决定 |
| > 50 项 | VirtualSkeleton | 必须使用，保证性能 |

## 完整配置示例

### 自定义复杂布局

深色代码主题复制
```typescript
Skeleton({
  loading: this.loading,
  animate: AnimateType.GRADIENT,
  speed: 1.5,
  shimmerBrightness: 0.8,
  config: {
    type: SkeletonType.DETAIL,
    direction: 'column',
    space: 16,
    children: [
      {
        type: SkeletonType.AVATAR_TEXT,
        direction: 'row',
        space: 12,
        children: [
          { type: SkeletonType.CIRCLE, size: 60 },
          { type: SkeletonType.TEXT, lines: 2, lastLineWidth: '60%' }
        ]
      },
      {
        type: SkeletonType.RECT,
        width: '100%',
        height: 200,
        radius: 8
      },
      {
        type: SkeletonType.PARAGRAPH,
        lines: 4,
        lineHeight: 18,
        lastLineWidth: '60%'
      }
    ]
  }
})
```

## 性能优化

### 1. 配置缓存

- 组件内部使用 WeakMap 缓存规范化后的配置，避免重复计算
- 索引数组缓存，减少数组频繁分配

### 2. 多项渲染优化（Skeleton）

- 支持通过 itemCount 一次性渲染多个骨架项
- 每个 item 可独立设置背景色
- 建议 itemCount ≤ 20

### 3. 虚拟滚动优化（VirtualSkeleton）

- 使用 LazyForEach 实现虚拟滚动
- 只渲染可见区域的骨架项（约 10-20 个）
- 自动回收和复用 DOM 节点
- 支持数百甚至上千条数据
- 必须指定固定的 height

### 4. 动画优化建议

- 根据场景选择合适的动画类型，NONE 性能最优
- 复杂场景建议使用 GRADIENT 或 FLASH
- 避免在大量元素上使用 PULSE 动画
- 通过 speed 参数调整动画速度以优化性能

## 注意事项

### 1. 圆形元素

使用 CIRCLE 类型时，建议使用 size 属性而不是分别设置 width 和 height，组件会自动处理圆角。

深色代码主题复制
```typescript
// ✅ 推荐
{ type: SkeletonType.CIRCLE, size: 60 }

// ❌ 不推荐
{ type: SkeletonType.CIRCLE, width: 60, height: 60, radius: 30 }
```

### 2. 多行文本

TEXT 类型设置 lines > 1 时，组件会自动转换为 PARAGRAPH 类型。

深色代码主题复制
```typescript
// 这两种写法等效
{ type: SkeletonType.TEXT, lines: 3 }
{ type: SkeletonType.PARAGRAPH, lines: 3 }
```

### 3. 多项渲染

当 itemCount > 1 时，组件会渲染多个骨架项，每个 item 会使用 itemContainerBackgroundColor 作为背景色。

### 4. 背景色继承

子元素的 skeletonBackgroundColor 会继承父元素的设置，如果子元素未设置则使用父元素的值。

### 5. 虚拟滚动要求

使用 VirtualSkeleton 时：

- 必须指定 config.height（每项固定高度）
- 组件本身需要有明确的高度（通过 .height() 或 .layoutWeight(1) 设置）
- 使用 margin 设置项目间距，使用 padding 设置项目内边距

### 6. 子内容插槽

使用尾随 lambda 传入实际内容，当 loading 为 false 时会自动切换显示实际内容。

深色代码主题复制
```typescript
Skeleton({
  loading: this.loading,
  config: { /* ... */ }
}) {
  // 这里是实际内容
  Text('加载完成后显示的内容')
}
```

## 常见问题

**Q1: 如何自定义骨架屏的颜色？**
A: 有三种背景色可以设置：
- skeletonBackgroundColor - 骨架元素本身的颜色
- containerBackgroundColor - 整个容器的背景色
- itemContainerBackgroundColor - 多项渲染时每个 item 的背景色

**Q2: 如何控制动画效果？**
A: 通过以下属性控制：
- animate - 选择动画类型（6 种可选）
- speed - 控制速度（0.5 慢速，1.0 正常，2.0 快速）
- shimmerBrightness - 控制亮度（0-1 之间）
- shimmerColor - 控制光影颜色（RGB 格式）

**Q3: 使用最新版本的组件**
A: 正确设置 size 属性而不是 width 和 height

**Q4: 如何实现多个骨架项？**
A: 在配置中设置 itemCount 属性：
- 少量数据（< 20 项）：使用 Skeleton + itemCount
- 大量数据（> 50 项）：使用 VirtualSkeleton + itemCount

**Q5: VirtualSkeleton 为什么不滚动？**
A: 检查以下几点：
- 是否设置了 config.height（必填）
- VirtualSkeleton 组件本身是否有明确高度
- 是否有嵌套滚动冲突（建议在独立页面使用）

**Q6: 圆形骨架如何设置？**
A: 使用 SkeletonType.CIRCLE 类型，并通过 size 属性设置尺寸：

深色代码主题复制
```typescript
{ type: SkeletonType.CIRCLE, size: 60 }
```

组件会自动设置为正圆形（width = height = size，radius = size/2）。

## 更新日志

### v1.0.0

- ✅ 初始版本发布
- ✅ 支持 6 种动画类型
- ✅ 提供 3 个预设模板
- ✅ 支持虚拟滚动（基于 LazyForEach）
- ✅ 完整的类型定义

## 贡献

欢迎提交 Issue 和 Pull Request。

## 许可证

Apache-2.0 License

## 元数据与兼容性

### 更新记录

- **1.0.2** (2025-12-08) 基础版本发布

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 网络访问权限 | 进行网络访问 | 将网络请求后数据绘制到 UI 上 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 |
| SDK 合规使用指南 | 不涉及 | |

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |

### 应用类型

| 类型 | 信息 |
| :--- | :--- |
| 应用 | 应用 |
| 元服务 | 元服务 |

### 设备类型

| 类型 | 信息 |
| :--- | :--- |
| 手机 | 手机 |
| 平板 | 平板 |
| PC | PC |

### DevEcoStudio 版本

| 版本 | 信息 |
| :--- | :--- |
| DevEco Studio | 5.0.0 |

> Created with Pixso.

## 安装方式

```bash
ohpm install @ikang/ikskeletonscreen
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5647157b966c4e5b9300e7173ac93fc9/c5ef800e4cc6476ab179493aa30dff52?origin=template