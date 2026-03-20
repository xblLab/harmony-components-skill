# ColorPicker 颜色选择器组件

## 简介

ColorPicker 是一款简洁的颜色选择器组件，基于 HSB 色彩模型设计。使用 @ComponentV2 开发。

## 详细介绍

### 简介

ColorPicker 是一款简洁的颜色选择器组件，基于 HSB 色彩模型设计。使用 @ComponentV2 开发，V1 用户请参考自定义组件混用场景指导。

### 安装

深色代码主题复制

```bash
ohpm i @keke/color-picker
```

### 用法

#### 引入组件

深色代码主题复制

```arkts
import { HSBColorPicker } from '@keke/color-picker'
```

#### 基础用法

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
})
.height(170)
```

#### 选择透明度

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
  showAlpha: true,
})
.height(200)
```

#### 设置间距

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
  gutter: 0,
  showAlpha: true,
})
.height(200)
```

#### 设置圆角

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
  radius: 8,
  showAlpha: true,
})
.height(200)
```

#### 纵向布局

深色代码主题复制

```arkts
import { HSBColorPicker, HSBColorPickerLayout } from '@keke/color-picker'

HSBColorPicker({
  layout: HSBColorPickerLayout.COLUMN,
  color: '#8b27f4',
  radius: 8,
  showAlpha: true,
})
.height(200)
```

#### 指定亮度范围

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
  radius: 8,
  b: [70, 100],
  showAlpha: true,
})
.height(200)
```

#### 预定义颜色

深色代码主题复制

```arkts
HSBColorPicker({
  color: '#8b27f4',
  radius: 8,
  showAlpha: true,
  predefine: ['#8b27f4', '#73f9fc', '#fffe55', '#f5cee3', '#eb4827', '#e93bf4', '#3e68f4', '#c5e6d3', '#e4e4e4', '#fa7105'],
})
.height(270)
```

## APIs

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| color | string | 否 | 初始颜色值，默认 #ffffff |
| gutter | number | 否 | 设置滑块之间的间距，默认 8 |
| radius | number | 否 | 圆角大小，默认无圆角 |
| showAlpha | boolean | 否 | 是否显示透明度滑块，默认 false |
| layout | HSBColorPickerLayout | 否 | 布局样式，DEFAULT、COLUMN，默认为 DEFAULT |
| predefine | string[] | 否 | 预定义的颜色 |
| s | [number, number] | 否 | 饱合度 [0-100] |
| b | [number, number] | 否 | 亮度 [0-100] |
| onChange | (value: string) => void | 否 | 选择颜色回调 |

## 其他

### Slider2 组件

Slider2 组件，支持横竖向拖拽，设置背景渐变等，具体用法如下：

深色代码主题复制

```arkts
Slider2({
  x: number, // 0-1
  y: number, // 0-1
  radius: number,
  blockSize: number,
  slideDirection: SlideDirection,
  track: () => void, // @BuilderParam
  trackLinearGradient: LinearGradient,
  trackBackgroundColor: ResourceColor,
  dragStart: (x: number, y: number) => void,
  dragMove: (x: number, y: number) => void,
  dragEnd: (x: number, y: number) => void,
  onChange: (x: number, y: number) => void,
})
```

### 颜色工具方法

深色代码主题复制

```arkts
hsv2rgb: hsv 转 rgb
rgb2hex: rgb 转 hex
rgb2hsv: rgb 转 hsv
hex2rgb: hex 转 rgb
hex2rgba: hex 转 rgba
hex2hsv: hex 转 hsv
hex2hexa: hex 转 hexa
hsva2hex: hsva 转 hex
hex2hsva: hex 转 hsva
formatHex: 格式化 hex 颜色值，返回 [6 位 hex 颜色值，透明度]。支持 3、4、6、8 位颜色解析。
```

## License

The repository is based on MIT

## 更新记录

1.0.4 (2025-10-13) 升级 deveco5.0.1 后，组件无法使用问题（crash）。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 兼容性

| 兼容性 | HarmonyOS 版本 |
| :--- | :--- |
| 5.0.0 | |

## 项目信息

| 字段 | 值 |
| :--- | :--- |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @keke/color-picker
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/48b5ce4b372c4722a8f18075678d0bed/PLATFORM?origin=template