# 卡尺组件 UICaliper

## 简介

UICaliper 是基于 open harmony 开发的卡尺组件。用于在屏幕中展示一个卡尺，支持左右滑动改变选择刻度值，支持自定义刻度样式、起始末尾值、对齐方式等。

## 详细介绍

### 简介

UICaliper 是基于 open harmony 开发的卡尺组件。用于在屏幕中展示一个卡尺，支持左右滑动改变选择刻度值，支持自定义刻度样式、起始末尾值、对齐方式等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）和 华为平板
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-caliper
```

#### 引入组件

```typescript
import { UICaliper } from '@hw-agconnect/ui-caliper';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UICaliper({
  value: this.value1!!,
})
```

## API 参考

### 子组件

无

### 接口

`UICaliper(options: UICaliperOptions)`

卡尺组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICaliperOptions | 是 | 配置卡尺组件的参数。 |

#### UICaliperOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | number | 是 | 选择刻度的绑定值，支持双向绑定。 |
| scales | number | 否 | 相邻大刻度线之间刻度的数量，默认值为 10。 |
| scaleSize | number | 否 | 单个刻度代表的刻度值，通常为大于 0 的整数，默认值为 1，当小于等于 0 时，会重置为默认值。 |
| startNum | number | 否 | 起始刻度值，默认值为 0。 |
| endNum | number | 否 | 末尾刻度值，需大于起始刻度值，默认值为 100。 |
| bgColor | ResourceColor | 否 | 背景色，默认值为'#FFFFFF'。 |
| scaleAlign | VerticalAlign | 否 | 刻度线对齐方式，默认值为 VerticalAlign.Top。 |
| fontSize | number | 否 | 刻度值字体大小，推荐范围 12vp-16vp，默认值为 14vp。 |
| fontColor | ResourceColor | 否 | 刻度值字体颜色，默认值为'#0A59F7'。 |
| fontWeight | FontWeight | 否 | 刻度值字重，默认值为 FontWeight.Medium。 |
| bigScaleWidth | number | 否 | 大刻度线的宽度，推荐不超过 2vp，默认值为 2vp。 |
| bigScaleHeight | number | 否 | 大刻度线的高度，默认值为 30vp。 |
| bigScaleColor | ResourceColor | 否 | 大刻度线的颜色，默认值为'#66000000'。 |
| smallScaleWidth | number | 否 | 小刻度线的宽度，推荐不超过 2vp，默认值为 2vp。 |
| smallScaleHeight | number | 否 | 小刻度线的高度，通常情况下不超过大刻度线高度，默认值为 20vp。 |
| smallScaleColor | ResourceColor | 否 | 小刻度线的颜色，默认值为'#66000000'。 |
| activeScaleWidth | number | 否 | 选择刻度线的宽度，需不低于大小刻度线宽度，默认值为 3vp。 |
| activeScaleColor | ResourceColor | 否 | 选择刻度线的颜色，默认值为'#0A59F7'。 |
| scaleSpace | number | 否 | 相邻刻度线之间的间距，默认值为 10，当小于等于 0 时，会重置为默认值。 |
| onChange | (index: number) => void | 否 | 选择刻度值变化的回调。 |

## 示例代码

```typescript
import { UICaliper } from '@hw-agconnect/ui-caliper';

@Extend(Text)
function textStyle(isOne: boolean = false) {
  .fontSize(18)
  .fontWeight(FontWeight.Medium)
  .width('100%')
  .padding({ top: isOne ? 10 : 30, bottom: 10, left: 12 })
}

@Entry
@ComponentV2
struct DemoDrawerPage {
  @Local value1: number = 20;
  @Local value2: number = 50;
  @Local value3: number = 0;
  @Local value4: number = 0;
  @Local value5: number = 0;
  @Local value6: number = 50;

  build() {
    Navigation() {
      Scroll() {
        Column() {
          Text('基础用法')
            .textStyle()
          Text(this.value1.toString())
          UICaliper({
            value: this.value1!!,
          })
          Text('自定义起始末尾值')
            .textStyle()
          Text(this.value2.toString())
          UICaliper({
            value: this.value2!!,
            startNum: -50,
            endNum: 200,
          })
          Text('自定义刻度')
            .textStyle()
          Text(this.value3.toString())
          UICaliper({
            value: this.value3!!,
            scaleSpace: 15,
            scales: 5,
            scaleSize: 2,
          })
          Text('自定义刻度线对齐方式')
            .textStyle()
          Text(this.value4.toString())
          UICaliper({
            value: this.value4!!,
            scaleAlign: VerticalAlign.Center,
          })
          Text(this.value5.toString())
          UICaliper({
            value: this.value5!!,
            scaleAlign: VerticalAlign.Bottom,
          })
          Text('自定义样式')
            .textStyle()
          Text(this.value6.toString())
          UICaliper({
            value: this.value6!!,
            startNum: 23,
            endNum: 200,
            scaleSpace: 20,
            bigScaleHeight: 40,
            smallScaleHeight: 15,
            bgColor: '#B8FFEF',
            activeScaleColor: '#FF0000',
            bigScaleColor: '#ED6F21',
            smallScaleColor: '#80EBC400',
          })
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .title('卡尺')
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
  }
}
```

## 更新记录

### 1.0.0 (2026-01-28)

初始版本

## 下载该版本

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3 <br> 5.0.4 <br> 5.0.5 <br> 5.1.0 <br> 5.1.1 <br> 6.0.0 <br> 6.0.1 <br> 6.0.2 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 <br> DevEco Studio 6.0.1 <br> DevEco Studio 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-caliper
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a2da797abbe245349e4fd9383cff01e4/2adce9bbd4cb42d58a87e6add45594b3?origin=template