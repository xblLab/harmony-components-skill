# Jack 基础组件

## 简介

Jack 基础组件库是基于 ArkTS 开发的 HarmonyOS UI 组件库，含滑块、胶囊按钮、日期选择器等常用组件。支持高度自定义样式、响应式适配多屏幕，具备性能优化、按需引入、完整类型定义等优势，文档完善且示例丰富。OHPM 一键安装即可开箱即用，帮你跳过重复开发，高效搭建高质量鸿蒙应用。

## 详细介绍

### 功能介绍

Jack 基础组件库（@jack_dev/basiccomponetlib）是一个基于 ArkTS 开发的 HarmonyOS UI 组件库，旨在为开发者提供开箱即用、高度可定制的常用 UI 组件，帮助开发者快速构建美观、流畅的鸿蒙应用界面。

### 全量功能清单

**核心组件：**

*   **JackSlider（滑块组件）**
    *   支持自定义最小值、最大值和步长
    *   支持自定义轨道颜色、选中颜色和滑块颜色
    *   支持显示/隐藏步长刻度
    *   支持显示/隐藏当前值提示
    *   双向数据绑定（@Link 装饰器）
    *   实时值变化回调
*   **JackCapsuleButton（胶囊按钮组件）**
    *   6 种预设按钮类型（Primary、Secondary、Success、Warning、Danger、Info）
    *   3 种按钮尺寸（Small、Medium、Large）
    *   朴素按钮样式（空心按钮）
    *   禁用状态支持
    *   加载状态支持（带加载动画）
    *   自定义图标支持
    *   完全自定义颜色（背景色、文字颜色、边框颜色）
    *   智能点击事件处理
*   **JackDatePicker（日期选择器组件）**
    *   3 种选择模式（日期、时间、日期时间）
    *   农历显示支持
    *   自定义日期范围
    *   自定义占位符
    *   日期变化回调
    *   美观的弹窗动画效果

**技术特性：**

*   完整的 TypeScript 类型定义
*   响应式设计，适配不同屏幕尺寸
*   高性能渲染
*   无外部依赖
*   组件导出统一管理
*   详细的文档和示例

### 环境要求

#### 开发环境

*   **DevEco Studio**: 5.0 及以上版本
*   **HarmonyOS SDK**: API 12 及以上
*   **语言**: ArkTS 支持 ArkTS 语言特性
*   **包管理**: OHPM 最新版本

#### 运行环境

*   **HarmonyOS 系统**: API 12 及以上
*   **设备类型**: 手机、平板等 HarmonyOS 设备

### 依赖说明

本组件库为纯 ArkTS 实现，无第三方依赖，可直接集成使用。

## 快速入门

### 方式一：通过 OHPM 安装（推荐）

**安装组件库**

```bash
ohpm install @jack_dev/basiccomponetlib
```

**在页面中导入组件**

```typescript
import {
  JackSlider,
  JackCapsuleButton,
  JackDatePicker,
  JackButtonType,
  JackButtonSize,
  JackDatePickerType
} from '@jack_dev/basiccomponetlib';
```

### 方式二：本地集成

**下载源码**

将 JackBasicComponents 目录复制到你的项目中。

**配置依赖**

在项目根目录的 `oh-package.json5` 中添加：

```json5
{
  "dependencies": {
    "@jack_dev/basiccomponetlib": "file:./JackBasicComponents"
  }
}
```

**同步依赖**

```bash
ohpm install
```

**导入使用**

```typescript
import { JackSlider } from '@jack_dev/basiccomponetlib';
```

## 使用样例

### 示例 1：滑块组件

```typescript
import { JackSlider } from '@jack_dev/basiccomponetlib';

@Entry
@Component
struct SliderDemo {
  @State volume: number = 50;

  build() {
    Column({ space: 20 }) {
      Text(`音量：${this.volume}`)
        .fontSize(18)
      
      JackSlider({
        value: $volume,
        min: 0,
        max: 100,
        step: 1,
        selectedColor: '#007DFF',
        showSteps: false,
        showTips: true,
        onChange: (value: number) => {
          console.log('音量变化:', value);
        }
      })
    }
    .padding(20)
    .width('100%')
  }
}
```

### 示例 2：胶囊按钮组件

```typescript
import { 
  JackCapsuleButton, 
  JackButtonType, 
  JackButtonSize 
} from '@jack_dev/basiccomponetlib';

@Entry
@Component
struct ButtonDemo {
  @State loading: boolean = false;

  build() {
    Column({ space: 16 }) {
      // 基础按钮
      JackCapsuleButton({
        text: '确认',
        type: JackButtonType.Primary,
        buttonSize: JackButtonSize.Medium,
        onButtonClick: () => {
          console.log('确认按钮被点击');
        }
      })

      // 加载状态按钮
      JackCapsuleButton({
        text: '提交',
        type: JackButtonType.Success,
        loading: this.loading,
        onButtonClick: () => {
          this.loading = true;
          setTimeout(() => {
            this.loading = false;
          }, 2000);
        }
      })

      // 朴素按钮
      JackCapsuleButton({
        text: '取消',
        type: JackButtonType.Primary,
        plain: true,
        onButtonClick: () => {
          console.log('取消操作');
        }
      })
    }
    .padding(20)
    .width('100%')
  }
}
```

### 示例 3：日期选择器组件

```typescript
import { 
  JackDatePicker, 
  JackDatePickerType 
} from '@jack_dev/basiccomponetlib';

@Entry
@Component
struct DatePickerDemo {
  @State selectedDate: Date = new Date();

  build() {
    Column({ space: 20 }) {
      Text(`选中日期：${this.selectedDate.toLocaleDateString()}`)
        .fontSize(16)

      // 日期选择
      JackDatePicker({
        selected: this.selectedDate,
        type: JackDatePickerType.Date,
        placeholder: '请选择日期',
        onChange: (date: Date) => {
          this.selectedDate = date;
          console.log('选择的日期:', date);
        }
      })

      // 日期时间选择（带农历）
      JackDatePicker({
        selected: this.selectedDate,
        type: JackDatePickerType.DateTime,
        lunar: true,
        start: new Date(2020, 0, 1),
        end: new Date(2030, 11, 31),
        onChange: (date: Date) => {
          console.log('选择的日期时间:', date);
        }
      })
    }
    .padding(20)
    .width('100%')
  }
}
```

## 示例效果

### JackSlider 滑块组件

**功能展示：**

*   实时显示当前值
*   平滑的滑动动画
*   支持步长设置
*   自定义颜色主题

### JackCapsuleButton 胶囊按钮

**功能展示：**

*   多种按钮类型和颜色
*   不同尺寸适配
*   加载状态动画
*   禁用状态显示

### JackDatePicker 日期选择器

**功能展示：**

*   弹窗式选择界面
*   日期、时间、日期时间三种模式
*   农历显示
*   流畅的动画效果

> 注意：实际效果图请查看项目中的 DemoPage.ets 运行示例。

## API 说明

### JackSlider API

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| value | number | 是 | - | 当前值（使用 `$value` 双向绑定） |
| min | number | 否 | 0 | 最小值 |
| max | number | 否 | 100 | 最大值 |
| step | number | 否 | 1 | 步长 |
| trackColor | ResourceColor | 否 | '#E5E5E5' | 轨道颜色 |
| selectedColor | ResourceColor | 否 | '#007DFF' | 已选择部分颜色 |
| blockColor | ResourceColor | 否 | '#FFFFFF' | 滑块颜色 |
| showSteps | boolean | 否 | false | 是否显示步长刻度 |
| showTips | boolean | 否 | true | 是否显示当前值提示 |
| onChange(value: number) => void | function | 否 | - | 值变化回调函数 |

**使用示例：**

```typescript
JackSlider({
  value: $sliderValue,
  min: 0,
  max: 100,
  step: 5,
  selectedColor: '#FF6B6B'
})
```

### JackCapsuleButton API

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| text | string | 否 | 'Button' | 按钮文字 |
| type | JackButtonType | 否 | Primary | 按钮类型 |
| buttonSize | JackButtonSize | 否 | Medium | 按钮尺寸 |
| disabled | boolean | 否 | false | 是否禁用 |
| loading | boolean | 否 | false | 是否显示加载状态 |
| icon | ResourceStr | 否 | - | 按钮图标 |
| bgColor | ResourceColor | 否 | - | 自定义背景色 |
| txtColor | ResourceColor | 否 | - | 自定义文字颜色 |
| bdColor | ResourceColor | 否 | - | 自定义边框颜色 |
| plain | boolean | 否 | false | 是否为朴素按钮 |
| onButtonClick() => void | function | 否 | - | 点击回调函数 |

**枚举类型说明：**

```typescript
// 按钮类型
enum JackButtonType {
  Primary = 'primary',      // 主要按钮（蓝色）
  Secondary = 'secondary',  // 次要按钮（灰色）
  Success = 'success',      // 成功按钮（绿色）
  Warning = 'warning',      // 警告按钮（橙色）
  Danger = 'danger',        // 危险按钮（红色）
  Info = 'info'            // 信息按钮（灰色）
}

// 按钮尺寸
enum JackButtonSize {
  Small = 'small',    // 小尺寸（高度 32px）
  Medium = 'medium',  // 中等尺寸（高度 40px）
  Large = 'large'     // 大尺寸（高度 48px）
}
```

**使用示例：**

```typescript
JackCapsuleButton({
  text: '提交',
  type: JackButtonType.Success,
  buttonSize: JackButtonSize.Large,
  onButtonClick: () => {
    // 处理点击事件
  }
})
```

### JackDatePicker API

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| selected | Date | 否 | new Date() | 当前选中日期 |
| type | JackDatePickerType | 否 | Date | 选择器类型 |
| lunar | boolean | 否 | false | 是否显示农历 |
| startDate | Date | 否 | 1970-1-1 | 起始日期 |
| endDate | Date | 否 | 2100-12-31 | 结束日期 |
| placeholder | string | 否 | '请选择日期' | 占位符文本 |
| onChange(value: Date) => void | function | 否 | - | 日期变化回调函数 |

**枚举类型说明：**

```typescript
// 选择器类型
enum JackDatePickerType {
  Date = 'date',         // 仅日期选择
  Time = 'time',         // 仅时间选择
  DateTime = 'datetime'  // 日期时间选择
}
```

**使用示例：**

```typescript
JackDatePicker({
  selected: this.selectedDate,
  type: JackDatePickerType.DateTime,
  lunar: true,
  start: new Date(2020, 0, 1),
  end: new Date(2030, 11, 31),
  onChange: (date: Date) => {
    // 处理日期变化
  }
})
```

## 配置说明

### 主题配置

所有组件都支持自定义颜色配置，可以根据应用主题进行统一调整。

**示例：自定义主题色**

```typescript
// 定义主题色
const THEME = {
  primary: '#FF6B6B',
  success: '#51CF66',
  warning: '#FFD43B',
  danger: '#FF6B6B'
}

// 使用主题色
JackSlider({
  value: $sliderValue,
  selectedColor: THEME.primary
})

JackCapsuleButton({
  text: '确认',
  bgColor: THEME.primary,
  txtColor: '#FFFFFF'
})
```

### 全局样式配置

如需统一修改组件样式，可以创建组件封装：

```typescript
// MyButton.ets
import { JackCapsuleButton, JackButtonType, JackButtonSize } from '@jack_dev/basiccomponetlib';

@Component
export struct MyButton {
  text: string = '';
  type: JackButtonType = JackButtonType.Primary;
  onButtonClick?: () => void;

  build() {
    JackCapsuleButton({
      text: this.text,
      type: this.type,
      buttonSize: JackButtonSize.Medium,
      bgColor: '#FF6B6B', // 统一配置背景色
      onButtonClick: this.onButtonClick
    })
  }
}
```

## 权限要求

本组件库为纯 UI 组件库，不涉及系统权限调用，无需申请任何系统权限。如果你在使用组件时需要访问系统功能（如保存日期到日历等），请根据具体业务场景申请相应权限。

## 技术支持

### 问题反馈

如果你在使用过程中遇到任何问题，可以通过以下方式获取帮助：

**联系我们：**

*   邮箱：support@classcloud.com.cn
*   技术支持：工作日 9:00-18:00

### 常见问题（FAQ）

**Q1: 组件导入失败怎么办？**
A: 请检查：
*   OHPM 是否正确安装依赖
*   导入路径是否正确
*   DevEco Studio 是否支持该版本

**Q2: 组件样式无法自定义？**
A: 所有组件都支持颜色自定义，请查看 API 文档中的颜色参数。

**Q3: 组件在某些设备上显示异常？**
A: 请确保设备运行 HarmonyOS API 12 及以上版本。

**Q4: 如何参与组件库开发？**
A: 欢迎贡献代码！请查看项目贡献指南。

## 获取方式

### OHPM 安装

```bash
ohpm install @jack_dev/basiccomponetlib
```

## 更新记录

### 1.0.0 (2025-11-20)

1.0.0 版本正式发布！新增滑块、胶囊按钮、日期选择器三大核心 UI 组件，覆盖自定义样式、多状态切换、双向绑定等实用功能。组件支持响应式适配与按需引入，配置灵活且易用性强，助力快速搭建高质量 HarmonyOS 应用。

## 兼容性

| 项目 | 版本/信息 |
| :--- | :--- |
| **HarmonyOS 版本** | 6.0.0 / 6.0.1 |
| **应用类型** | 应用 / 元服务 |
| **设备类型** | 手机 / 平板 / PC |
| **DevEco Studio 版本** | DevEco Studio 6.0.0 / 6.0.1 |

## 安装方式

```bash
ohpm install @jack_dev/basiccomponetlib
```

## 来源

*   原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8331d1ad243c4645a31ecf4195dd19a6/ee79e73299724b3daef1ddc95ace42fc?origin=template