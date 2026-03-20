# 星级评分组件

## 简介

rating 是一个简单的星级评分组件，和系统的区别是，不用设置资源，纯组件绘制，只需传递颜色即可，支持五角星、矩形、爱心等多种效果。

## 详细介绍

### 功能介绍

rating 是一个简单的星级评分组件，和系统的区别是，不用设置资源，纯组件绘制，只需传递颜色即可，支持五角星、矩形、爱心等多种效果。

### 环境要求

Api 适用版本：>=12

### 示例效果

### 目前功能

1. 支持大小动态设置。
2. 支持颜色动态修改。
3. 支持数量动态修改。
4. 支持小数步长设置。
5. 支持爱心形状评分。
6. 支持正方形、菱形、圆形、六边形效果。
7. 支持点击和手势滑动评分。

### 快速入门

#### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/rating
```

#### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/rating": "^1.0.0"}
```

### 使用样例

#### 简单使用

```typescript
StarRating({
  onRatingChange: (star: number) => {
    this.starNumber = star
  }
})
```

#### 设置默认数量

```typescript
StarRating({
  ratingQuantity: 1
})
```

#### 设置星星数量

```typescript
StarRating({
  maxRating: 8
})
```

#### 设置大小

```typescript
StarRating({
  ratingSize: 28
})
```

#### 设置颜色

```typescript
StarRating({
  fillColor: Color.Red
})
```

#### 设置边框

```typescript
StarRating({
  fillColor: Color.Red,
  strokeColor: Color.Blue,
  strokeWidth: 1,
  ratingSize: 25
})
```

#### 未选中空心

```typescript
StarRating({
  emptyColor: Color.Transparent,
  strokeColor: Color.Gray,
  strokeWidth: 0.5,
  ratingSize: 25
})
```

#### 设置小数

```typescript
StarRating({
  ratingStep: 0.5,
  ratingSize: 25,
  onRatingChange: (star: number) => {
    this.starNumber2 = star
  }
})
```

#### 正方形

```typescript
StarRating({
  ratingType: RatingType.square
})
```

#### 菱形

```typescript
StarRating({
  ratingType: RatingType.diamond
})
```

#### 六边形

```typescript
StarRating({
  ratingType: RatingType.hexagon
})
```

#### 圆形

```typescript
StarRating({
  ratingType: RatingType.circle,
  ratingStep: 0.5,
  ratingSize: 25,
})
```

#### 爱心

```typescript
StarRating({
  ratingType: RatingType.love,
  fillColor: Color.Red,
  ratingSize: 25
})
```

## API 说明

### Api 适用版本

>=12

### 配置说明

常见属性配置如下：

### 属性类型概述

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| maxRating | number | 最大数量 |
| ratingSize | number | 组件每个元素大小 |
| ratingSpacing | number | 组件元素之间的间距 |
| emptyColor | string / number / CanvasGradient / CanvasPattern | 未选中时的空颜色 |
| fillColor | string / number / CanvasGradient / CanvasPattern | 选中之后的填充颜色 |
| strokeColor | string / number / CanvasGradient / CanvasPattern | 组件元素边框颜色 |
| strokeWidth | number | 组件元素边框大小 |
| ratingStep | number | 星星步长 |
| ratingQuantity | number | 星星填充比例：0-1 之间 |
| onRatingChange | (num: number) => void | 评级回调 |
| ratingType | RatingType | 组件类型，pentagram：五角星，hexagon：六边形，circle：圆，diamond：菱形，square：正方形，love：爱心 |
| isGesture | boolean | 是否允许手势，默认 false 不允许 |

### 权限要求

无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

#### 1.0.0 (2026-01-08)

1. 星级评分组件首次上传
2. 支持自定义样式，包含颜色边框
3. 支持数量动态控制
4. 支持小数配置
5. 支持多种效果，比如爱心，矩形等

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### 合规使用指南

不涉及

## 兼容性

### 系统与应用

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 安装方式

```bash
ohpm install @abner/rating
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1a5e0d1778ee41739f8071ac11e77faf/b6a17875746941e0b5606c9b1eb174f8?origin=template