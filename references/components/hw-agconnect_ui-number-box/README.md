# 数字输入框 UINumberBox

## 简介

UINumberBox 是基于 open harmony 基础组件开发的带加减按钮的数字输入框组件，支持设置最大值、最小值、步长等。

## 详细介绍

### 简介

UINumberBox 是基于 open harmony 基础组件开发的带加减按钮的数字输入框组件，支持设置最大值、最小值、步长等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-number-box
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.2 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install  @hw-agconnect/ui-number-box@1.0.2
```

#### 引入组件

```typescript
import { UINumberBox } from '@hw-agconnect/ui-number-box';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UINumberBox({
   value: '1',
   min: 0,
   max: 1000,
   isEnabled: true,
   step: 1,
})
```

## API 参考

### 子组件

无

### 接口

`UINumberBox(options: UINumberBoxOptions)`

数字输入框组件。

#### options 参数说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UINumberBoxOptions | 否 | 配置数字输入框组件的参数。 |

#### UINumberBoxOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | string | 否 | 输入框当前值，默认值是 1，不支持负数 |
| min | number | 否 | 最小值，默认值是 0，不支持负数 |
| max | number | 否 | 最大值，默认值是 10000，不支持负数 |
| isEnabled | boolean | 否 | 是否为启用状态，默认值是 true |
| step | number | 否 | 步长：每次点击改变的间隔大小，默认值是 1，不支持负数 |
| isBorder | boolean | 否 | 边框是否展示，默认值是 true |
| onChange | `(value: ResourceStr) => void` | 否 | 输入值变化时触发 |

#### 异常情形说明

| 异常情形 | 对应结果 |
| :--- | :--- |
| value 值传入非法，如非数字字符或者负值 | value 取默认值'1' |
| value 值传入小于 min | value 取 min 值 |
| value 值传入大于 max | value 取 max 值 |
| min 值传入为负值 | min 取初始值 0 |
| max 值传入为负值 | max 取初始值 10000 |
| step 值传入为负值 | step 取初始值 1 |
| min 值大于等于 max | min 取初始值 0，max 取初始值 10000 |
| value、min、max、step 传入值为多位小数 | value、min、max、step 均保留一位小数 |

## 示例代码

```typescript
import { UINumberBox } from '@hw-agconnect/ui-number-box';
import { router } from '@kit.ArkUI';

@Extend(Text)
function titleStyle() {
  .fontSize(16)
  .margin({ top: 16, bottom: 8 })
  .fontWeight(FontWeight.Bold)
  .width('100%')
}

@Entry
@ComponentV2
struct UINumberBoxSample {
  @Builder
  buildTitleBar() {
    Row({ space: 10 }) {
      Image($r('app.media.ic_public_back'))
        .width(26)
        .height(20)
        .fillColor($r('sys.color.ohos_id_color_primary'))
        .onClick(() => {
          router.back();
        })
      Text('NumberBox').fontSize(24).fontWeight(FontWeight.Medium)
    }
    .height(56)
    .width('100%')
    .padding({ left: 16, right: 16 })
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Text('一般用法').titleStyle()
          UINumberBox({ value: 'hahh' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('输入框传入""：').titleStyle()
          UINumberBox({ value: '' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('输入框传入 0：').titleStyle()
          UINumberBox({ value: '0' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('输入框传入负值：').titleStyle()
          UINumberBox({ value: '-2' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('最大值和最小值：最大值 100，最小值 0').titleStyle()
          UINumberBox({ max: 100, min: 0 })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('min 大于 max：').titleStyle()
          UINumberBox({ max: 1, min: 10 })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('隐藏边框：').titleStyle()
          UINumberBox({ isBorder: false })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('value 值小于最小值：').titleStyle()
          UINumberBox({ max: 100, min: 10, value: '5' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('步长：0.1').titleStyle()
          UINumberBox({
            step: 0.1,
            min: 10,
            max: 20,
            value: '11'
          }).backgroundColor($r('sys.color.ohos_id_color_card_bg')).width('100%').padding(14).borderRadius(10)
          Text('只读状态').titleStyle()
          UINumberBox({ isEnabled: false })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('min、max 为负数').titleStyle()
          UINumberBox({ max: -20, min: -10, value: '-1' })
            .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
            .width('100%')
            .padding(14)
            .borderRadius(10)
          Text('超长处理').titleStyle()
          UINumberBox({
            min: 1.29999,
            max: 10,
            value: "0.00002",
            step: 1.3,
            isEnabled: true
          }).backgroundColor($r('sys.color.ohos_id_color_card_bg')).width('100%').padding(14).borderRadius(10)
          Text('获取输入框的值').titleStyle()
          UINumberBox({
            onChange: (value) => {
              console.log('输入框的值是：', value)
            }
          }).backgroundColor($r('sys.color.ohos_id_color_card_bg')).width('100%').padding(14).borderRadius(10)
        }
        .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(12)
      }
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title(this.buildTitleBar)
  }
}
```

## 更新记录

### 2.0.0 (2025-11-04)

下载该版本从 V2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.2 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

### 1.0.2 (2025-09-29)

下载该版本修复小数展示问题

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规

不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-number-box
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4ff92cb7200740bf9f7a6d0bc2fc2b2e/2adce9bbd4cb42d58a87e6add45594b3?origin=template