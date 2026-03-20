# 即时反馈 UIToast 组件

## 简介

ui toast 是基于 open harmony 基础组件开发的组件，用于在屏幕中显示一个操作的轻量级即时反馈，支持显示图片 + 文字，刷新弹窗内容和修改弹窗样式。

## 详细介绍

### 简介

ui toast 是基于 open harmony 基础组件开发的组件，用于在屏幕中显示一个操作的轻量级即时反馈，支持显示图片 + 文字，刷新弹窗内容和修改弹窗样式。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、华为平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

1. **安装组件**
   ```bash
   ohpm install @hw-agconnect/ui-toast
   ```

2. **引入即时反馈组件句柄**
   ```typescript
   import { ToastDialog } from '@hw-agconnect/ui-toast'
   ```

3. **调用组件**
   详细参数配置说明参见 [API 参考](#api-参考)。

## API 参考

### ToastDialog

#### 即时反馈弹窗

```typescript
showToast(options: ToastUIOptions | IToastUIOptions)
```

创建并打开弹窗，支持动态刷新弹窗内容。可以通过修改对象的属性来更新弹窗显示。

**说明：**

`ToastUIOptions` 和 `IToastUIOptions` 的字段结构完全一致，但它们的使用场景和目的略有不同：

- `IToastUIOptions` 是一个接口（interface），用于定义弹窗配置的参数结构。开发者可以直接使用字面量对象的方式传入参数，适用于不需要动态更新弹窗内容的场景。
- `ToastUIOptions` 是一个类（class），继承自 `IToastUIOptions`，适用于支持弹窗内容的动态更新。当需要在弹窗显示后修改文本、图片、样式等参数时，建议使用 `new ToastUIOptions()` 的方式创建对象，以便组件能够感知到属性变化。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | `ToastUIOptions` \| `IToastUIOptions` | 是 | Toast 选项，弹窗配置参数对象，用于设置弹窗的文本、图片、样式、位置、持续时间等属性。 |

#### ToastUIOptions 和 IToastUIOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| message | string | 是 | 显示的文本信息。 |
| imgSrc | ResourceStr | 否 | 显示的图片资源。 |
| type | ToastType | 否 | 弹窗类型，默认为 TEXT。 |
| toastRatio | number | 否 | 弹窗内容的放大缩小比例。默认值：1，取值范围：[0.5, 3]，若小于 0.5 则取下限值 0.5，若大于 3 则取上限值 3。 |
| toastOffset | Offset | 否 | 在对齐方式上的偏移。默认值：{ dx: 0, dy: -108 }。 |
| toastAlignment | DialogAlignment | 否 | 对齐方式。Toast 的文本显示默认自左向右，不支持其他对齐方式。默认位置为底部（Bottom）。使用该参数时，请确认是否已将 `toastOffset` 设置为 `{ dx: 0, dy: 0 }`，以确保位置符合预期。 |
| imageParams | ImageParams | 否 | 当 type 为 `ToastType.CUSTOM` 时显示的图片参数。 |
| symbolSize | number | 否 | 当 type 为 `ToastType.SUCCESS`、`FAIL`、`LOADING` 时显示的 icon 大小，默认值：16vp，取值范围：[16, 64]，若小于 16 则取下限值 16，若大于 64 则取上限值 64，当设置 `toastRatio` 时，缩放后也控制在该范围内。 |
| fontType | FontType | 否 | 显示的文本参数。 |
| toastOption | ToastOption | 否 | 弹框的显示参数。 |
| duration | number | 否 | 设置 Toast 弹出的持续时间。默认值：2000ms，取值范围：[1000, 10000] 和 -1，若小于 1000ms 则取下限值 1000，若大于 10000ms 则取上限值 10000ms。若取值 -1，则弹窗不会自动关闭。 |
| handleCancel | boolean | 否 | 手动点击弹窗外部区域是否关闭弹窗，是否关闭弹窗，true 表示关闭弹窗。false 表示不关闭弹窗，默认为 false。 |
| imgPosition | ImgPosition | 否 | 显示的图片位置，默认为 LEFT，当 type 为 `ToastType.TEXT` 时不生效。 |

#### ToastType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| SUCCESS | 0 | 弹窗为文本加 icon 的形式，表示自动刷新成功，图片展示为预设的成功 icon |
| FAIL | 1 | 弹窗为文本加 icon 的形式，表示自动刷新失败，图片展示为预设的失败 icon |
| LOADING | 2 | 弹窗为文本加 icon 的形式，表示自动刷新中，图片展示为预设的刷新 icon |
| TEXT | 3 | 弹窗为纯文本的形式，不含图片 |
| CUSTOM | 4 | 弹窗为文本加图片的形式，图片可自定义上传 |

#### ImageParams 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imgWidth | number | 否 | 图片宽度，默认值：16vp，取值范围：[16, 160]，若小于 16 则取下限值 16，若大于 160 则取上限值 160，当设置 `toastRatio` 时，缩放后也控制在该范围内。 |
| imgHeight | number | 否 | 图片高度，默认值：16vp，取值范围：[16, 160]，若小于 16 则取下限值 16，若大于 160 则取上限值 160，当设置 `toastRatio` 时，缩放后也控制在该范围内。 |
| imgFit | ImageFit | 否 | 图片缩放和裁剪的方式，默认为 `ImageFit.Contain`。其中设置为 `ImageFit.MATRIX` 不生效，实际表现与 `ImageFit.TOP_START` 一致。 |
| imgBorder | BorderOptions | 否 | 图片边框属性集合，默认边框宽度为 0。 |
| imgMargin | number | 否 | 图片与文字的边距，当 `imgPosition` 为 LEFT 时，为图片右边距，当 `imgPosition` 为 RIGHT 时，为图片左边距，当 `imgPosition` 为 TOP 或 BOTTOM 时，该参数不生效。 |

#### FontType 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fontSize | number | 否 | 字体大小，默认值：14vp，取值范围：[12, 16]，若小于 12 则取下限值 12，若大于 16 则取上限值 16，当设置 `toastRatio` 时，缩放后字体大小取值范围为 [10, 26]，若小于 10 则取下限值 10，若大于 26 则取上限值 26。开发者可以在代码中根据需求修改缩放后的上下限。 |
| fontColor | ResourceColor | 否 | 字体颜色，默认为 `$r('sys.color.font_primary')`。 |
| fontStyle | FontStyle | 否 | 字体样式，默认为 `FontStyle.Normal`。 |
| fontWeight | number \| FontWeight \| string | 否 | 字体粗细，默认为 `FontWeight.Regular`。 |
| textAlign | TextAlign | 否 | 字体对齐方式，默认为 `TextAlign.Center`。 |

#### ToastOption 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| toastBorderRadios | Length \| BorderRadiuses | 否 | 弹窗边框的圆角半径，默认为 `$r('sys.float.corner_radius_level9')`。 |
| toastBorderStyle | BorderStyle \| EdgeStyles | 否 | 弹窗的边框线条样式，默认为 `BorderStyle.Solid`。 |
| toastBorderWidth | Length \| EdgeWidths \| LocalizedEdgeWidths | 否 | 弹窗的边框宽度，默认为 0。 |
| toastBorderColor | ResourceColor \| EdgeColors \| LocalizedEdgeColors | 否 | 弹窗的边框颜色，默认为黑色。 |
| toastBackgroundColor | ResourceColor | 否 | 弹窗的背景颜色，默认为 `$r('sys.color.comp_background_primary')`。 |
| toastBackgroundBlur | BlurStyle | 否 | 弹窗的背景材质模糊样式，默认为 `BlurStyle.COMPONENT_ULTRA_THICK` |
| toastShadow | ShadowOptions \| ShadowStyle | 否 | 弹窗的阴影效果，默认为 `ShadowStyle.OUTER_DEFAULT_MD`。 |
| toastPadding | Padding \| Length \| LocalizedPadding | 否 | 弹窗的内边距属性，参数为 Length 类型时，四个方向内边距同时生效，默认值为 `{top:8, bottom:8, right:16, left:16}`，单位为 vp。 |

#### ImgPosition 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| LEFT | 0 | 图片在文字左侧 |
| RIGHT | 1 | 图片在文字右侧 |
| TOP | 2 | 图片在文字上方 |
| BOTTOM | 3 | 图片在文字下方 |

## 示例代码

```typescript
import { ImgPosition, ToastType, ToastDialog, ToastUIOptions } from '@hw-agconnect/ui-toast'

@Entry
@ComponentV2
struct Index {
  @Local type: ToastType = ToastType.LOADING
  @Local message: string = '文案加载中...'
  @Local param1: ToastUIOptions = new ToastUIOptions({
    message: this.message,
    type: this.type,
  })
  @Local param2: ToastUIOptions = new ToastUIOptions({
    message: this.message,
    type: this.type,
  })
  @Local param3: ToastUIOptions = new ToastUIOptions({
    message: this.message,
    type: ToastType.TEXT,
  })
  @Local param4: ToastUIOptions = new ToastUIOptions({
    message: this.message,
    type: this.type,
  })
  @Local param5: ToastUIOptions = new ToastUIOptions({
    message: this.message,
    type: this.type,
  })

  build() {
    Scroll() {
      Column() {
        Button('打开弹窗 1：显示信息刷新成功')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast(this.param1);
            setTimeout(() => {
              this.param1.message = '文案提示成功'
              this.param1.type = ToastType.SUCCESS
            }, 500)
          })
        Button('打开弹窗 2：显示信息刷新失败')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast(this.param2);
            setTimeout(() => {
              this.param2.message = '文案提示失败'
              this.param2.type = ToastType.FAIL
            }, 500)
          })
        Button('打开弹窗 3：显示为纯文本')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: ToastType.TEXT,
            });
          })
        Button('打开弹窗 4：显示为纯文本，刷新为自定义图片和文本')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast(this.param3);
            setTimeout(() => {
              this.param3.message = '自定义文案图片提示成功'
              this.param3.imgSrc = $r('app.media.startIcon')  // todo 需要替换为开发者需要的资源
              this.param3.type = ToastType.CUSTOM
            }, 500)
          })
        Button('打开弹窗 5：文字图片按比例放大')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast(this.param4);
            setTimeout(() => {
              this.param4.toastRatio = 1.5
            }, 500)
          })
        Button('打开弹窗 6：文字图片按比例缩小')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast(this.param5);
            setTimeout(() => {
              this.param5.toastRatio = 0.5
            }, 500)
          })
        Button('打开弹窗 7：改变弹窗位置')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              toastAlignment: DialogAlignment.Center,
              toastOffset: { dx: 40, dy: 100 }
            });
          })
        Button('打开弹窗 8：改变图片属性')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              imageParams: {
                imgWidth: 40,
                imgHeight: 40,
                imgBorder: { width: 2 }
              }
            });
          })
        Button('打开弹窗 9：改变文本字体')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              fontType: {
                fontSize: 16,
                fontColor: Color.Blue,
                fontWeight: FontWeight.Bold
              }
            });
          })
        Button('打开弹窗 10：改变弹窗样式')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              toastOption: {
                toastBorderRadios: 10,
                toastBorderWidth: 2,
                toastBorderColor: Color.Red,
                toastBackgroundColor: Color.Red
              },
              fontType: {
                fontColor: Color.Red,
              }
            });
          })
        Button('打开弹窗 11：改变弹窗持续时间')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: '持续时间为 5000ms',
              type: this.type,
              duration: 5000
            });
          })
        Button('打开弹窗 12：支持手动关闭弹窗')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              handleCancel: true,
            });
          })
        Button('打开弹窗 13：改变图片文本布局，图片在文本右侧')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              imgPosition: ImgPosition.RIGHT
            });
          })
        Button('打开弹窗 14：改变图片文本布局，图片在文本上方')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: this.message,
              type: this.type,
              imgPosition: ImgPosition.TOP
            });
          })
        Button('打开弹窗 15：显示超长文本则会截断，最多显示 30 字符')
          .margin({ top: 16 })
          .onClick(() => {
            ToastDialog.showToast({
              message: '最长极限长文本样式最长极限长文本样式最长极限长文本样式最长极限长文本样式',
              type: this.type,
              imgPosition: ImgPosition.LEFT
            });
          })
      }
      .width('100%')
    }
    .layoutWeight(1)
  }
}
```

## 更新记录

### 1.0.0 (2025-12-02)

下载该版本提供在屏幕中显示一个操作的轻量级即时反馈的功能，支持显示图片 + 文字，刷新弹窗内容和修改即时反馈的样式。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.0
- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 安装方式

```bash
ohpm install @hw-agconnect/ui-toast
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9c3aa5f6696d42ffa807d5fc875eeef3/2adce9bbd4cb42d58a87e6add45594b3?origin=template