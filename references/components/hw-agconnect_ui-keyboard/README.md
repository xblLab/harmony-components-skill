# 车牌号输入组件 UIKeyboard

## 简介

UIKeyboard 是基于 open harmony 基础组件开发的车牌号输入组件，支持车牌号输入，支持通过回调事件获取所输入车牌号等功能。

## 详细介绍

### 简介

UIKeyboard 是基于 open harmony 基础组件开发的车牌号输入组件，支持车牌号输入，支持通过回调事件获取所输入车牌号等功能。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-keyboard
```

#### 使用

```typescript
// 引入组件
import { UILicensePlate } from '@hw-agconnect/ui-keyboard'
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。
- HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

**UILicensePlate(options: UILicensePlateOptions)**

**UILicensePlate 对象说明**

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| intFocus | boolean | 否 | 默认值为 false，初始化是否为输入框聚焦状态 |
| plateNumber | string | 否 | 默认值为''，传入的车牌号，当该车牌号格式不合法时，不回显该车牌号。 |
| controller | TextInputController | 否 | 设置 TextInput 控制器，可控制键盘收起。 |
| containerWidth | Length | 否 | 输入框整体宽度，默认值为'100%'。最大值为 800vp，最小值为 270vp。当传入值大于最大值时，宽度取最大值；当传入值小于最小值时，宽度取最小值。 |

### 使用限制

无

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onChange(carNumber: string[], isComplete: boolean) => void | 输入车牌号发生变化时触发，carNumber 为输入车牌号，isComplete 标志当前车牌号是否输入完成 |
| onFormatError(plateNumber: string) => void | 传入的车牌号格式不正确时触发，plateNumber 为格式不正确的车牌号 |

### 示例

#### 示例 1

```typescript
import { UILicensePlate } from '@hw-agconnect/ui-keyboard';

@Entry
@ComponentV2
export struct UILicensePlateDemo {
  @Local plateNumber: string = '';

  build() {
    Column() {
      UILicensePlate({
        //  传入的车牌号
        plateNumber: this.plateNumber,
        //  是否默认激活键盘，选中输入框
        intFocus: false,
        //  输入完整车牌后触发回调，获取车牌号
        onChange: (carNumber: string[], isComplete: boolean) => {
          console.log('当前输入车牌号', carNumber, '是否为完整车牌号', isComplete);
        },
        //  传入车牌号格式错误时触发
        onFormatError: (plateNumber: string) => {
          console.log('格式错误的车牌号', plateNumber);
        },
      });
    }.backgroundColor('#FFFFFF').padding({ top: 16 });
  }
}
```

## 更新记录

### 1.0.3 (2025-12-12)

- 下载该版本内部资源

### 1.0.2 (2025-09-30)

- 开放设置 TextInput 控制器，可控制键盘收起。
- 优化输入框宽度适配，支持根据外层容器宽度自适应，支持设置组件宽度，支持外层容器宽度小于输入框整体宽度时输入框可滚动。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 <br> 5.0.1 <br> 5.0.2 <br> 5.0.3 <br> 5.0.4 <br> 5.0.5 <br> 5.1.0 <br> 5.1.1 <br> 6.0.0 <br> 6.0.1 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0 <br> DevEco Studio 5.0.1 <br> DevEco Studio 5.0.2 <br> DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 <br> DevEco Studio 6.0.1 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-keyboard
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8eca183a8c4c471a84d155e32dc93739/2adce9bbd4cb42d58a87e6add45594b3?origin=template