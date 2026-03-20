# 签名组件 UISignature

## 简介

UISignature 是基于 open harmony 基础组件和 Canvas 开发的签名组件，支持触屏签字并获取签字图像的 pixelMap 等功能。

## 详细介绍

### 简介

UISignature 是基于 open harmony 基础组件和 Canvas 开发的签名组件，支持触屏签字并获取签字图像的 pixelMap 等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

1. **安装组件**
```bash
ohpm install @hw-agconnect/ui-signature
```

2. **引入组件**
```typescript
import { UISignature } from '@hw-agconnect/ui-signature';
```

3. **调用组件**，详细参数配置说明参见 API 参考。
```typescript
UISignature({
  boardHeight: '40%'
})
```

## API 参考

### 子组件

无

### 接口

`UISignature(options: UISignatureOptions)`

签名组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UISignatureOptions | 否 | 配置签名组件的参数。 |

#### UISignatureOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| boardWidth | Length | 否 | 签名画板的宽度，默认为 `'100%'`。 |
| boardHeight | Length | 否 | 签名画板的高度，默认为 `'80%'`。 |
| lineColor | ResourceColor | 否 | 签名线条的颜色，默认为 `$r('sys.color.font_primary')`。 |
| lineWidth | number | 否 | 签名线条的宽度，默认为 `3vp`。 |
| boardColor | ResourceColor | 否 | 签名画板的背景颜色，默认为 `'#FFFFFF'`。 |
| showOperation | boolean | 否 | 是否显示操作按钮，默认为 `true`。 |
| operationAlign | FlexAlign | 否 | 操作按钮的对齐方式，默认为 `FlexAlign.End`。 |
| controller | SignatureController | 否 | 签名组件的控制器，用于控制签名组件的行为。 |
| confirmText | ResourceStr | 否 | 确定按钮的文本，默认为 `'确定'`。 |
| clearText | ResourceStr | 否 | 清除按钮的文本，默认为 `'清除'`。 |
| confirm | `(sign: PixelMap) => void` | 否 | 用户点击“确定”按钮时触发的回调事件，返回签名结果的 PixelMap。 |
| clear | `() => void` | 否 | 用户点击“清除”按钮时触发的回调事件。 |

#### SignatureController 对象说明

| 名称 | 描述 |
| :--- | :--- |
| confirm() | 完成签名的确认事件，相当于点击确认按钮 |
| clear() | 清空签名画板当前图像的事件，相当于点击清空按钮 |

## 示例代码

### 示例 1

```typescript
import { UISignature } from '@hw-agconnect/ui-signature';

@Entry
@ComponentV2
struct UISignatureDemo1 {
  @Local sign?: PixelMap

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 16 }) {
          UISignature({
            boardHeight: '40%',
            confirm: (sign) => {
              this.sign = sign
            },
            clear: () => {
              this.sign = undefined
              this.getUIContext().getPromptAction().showToast({ message: '画板已清空' })
            },
          })
          if (this.sign) {
            Image(this.sign)
              .constraintSize({ maxHeight: 200 })
              .objectFit(ImageFit.Contain)
              .backgroundColor($r('sys.color.background_tertiary'))
          }
        }
      }
      .edgeEffect(EdgeEffect.Spring)
      .scrollBar(BarState.Off)
    }
    .title('示例 1-基础用法')
  }
}
```

### 示例 2

```typescript
import { UISignature, SignatureController } from '@hw-agconnect/ui-signature';

@Entry
@ComponentV2
struct UISignatureDemo2 {
  @Local sign?: PixelMap
  @Local controller: SignatureController = new SignatureController()

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 16 }) {
          UISignature({
            boardHeight: '40%',
            controller: this.controller,
            showOperation: false,
            confirm: (sign) => {
              this.sign = sign
            },
          })

          Row({ space: 16 }) {
            Button('完成签名')
              .backgroundColor($r('sys.color.background_tertiary'))
              .controlSize(ControlSize.SMALL)
              .fontColor($r('sys.color.multi_color_09'))
              .onClick(() => {
                this.controller.confirm()
                this.getUIContext().getPromptAction().showToast({ message: '已获取签名图片' })
              })
            Button('取消签名')
              .backgroundColor($r('sys.color.multi_color_09'))
              .controlSize(ControlSize.SMALL)
              .onClick(() => {
                this.controller.clear();
                this.sign = undefined
                this.getUIContext().getPromptAction().showToast({ message: '已清空签名' })
              })
          }

          if (this.sign) {
            Image(this.sign)
              .objectFit(ImageFit.Contain)
              .constraintSize({ maxHeight: 200 })
              .backgroundColor($r('sys.color.background_tertiary'))
          }
        }
      }
    }
    .title('示例 2-自定义控制栏')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

### 示例 3

```typescript
import { UISignature, SignatureController } from '@hw-agconnect/ui-signature';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@ComponentV2
struct UISignatureDemo3 {
  @Local
  boardWidth: Length = '100%'
  @Local
  boardHeight: Length = 300
  @Local
  lineColor: ResourceColor = '#e6000000'
  @Local
  lineWidth: number = 3
  @Local
  boardColor: ResourceColor = '#ffffff'
  @Local
  showOperation: boolean = true
  @Local
  controller: SignatureController = new SignatureController()
  @Local
  sign: PixelMap | undefined
  @Local
  flag: boolean = true

  reset(callback: () => void) {
    this.flag = false
    this.sign = undefined
    setTimeout(() => {
      callback()
      this.flag = true
    }, 300)

  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(12) } }) {
            Button('切换画板宽度').onClick(() => {
              this.reset(() => {
                this.boardWidth = this.boardWidth === '100%' ? '50%' : '100%'
              })
            })
            Button('切换画板高度').onClick(() => {
              this.reset(() => {
                this.boardHeight = this.boardHeight === 300 ? 200 : 300
              })
            })
            Button('切换线条颜色').onClick(() => {
              this.reset(() => {
                this.lineColor = this.lineColor === '#e6000000' ? '#007dff' : '#e6000000'
              })
            })
            Button('切换线条粗细').onClick(() => {
              this.reset(() => {
                this.lineWidth = this.lineWidth === 3 ? 8 : 3
              })
            })
            Button('切换画板背景色').onClick(() => {
              this.reset(() => {
                this.boardColor = this.boardColor === '#ffffff' ? '#30000000' : '#ffffff'
              })
            })
            Button('切换操作按钮展示').onClick(() => {
              this.reset(() => {
                this.showOperation = !this.showOperation;
              })
            })
          }
          .padding(16)

          if (this.flag) {
            Column() {
              UISignature({
                boardWidth: this.boardWidth,
                boardHeight: this.boardHeight,
                lineColor: this.lineColor,
                lineWidth: this.lineWidth,
                boardColor: this.boardColor,
                showOperation: this.showOperation,
                controller: this.controller,
                confirm: (sign) => {
                  this.sign = sign
                },
                clear: () => {
                  this.sign = undefined
                },
              })
              if (this.showOperation === false) {
                Column({ space: 12 }) {
                  Button('这是一个自定义清除按钮')
                    .onClick(() => {
                      this.controller.clear()
                    })
                  Button('这是一个自定义确认按钮')
                    .onClick(() => {
                      this.controller.confirm()
                    })
                }
              }
            }
            .padding({ top: 12, bottom: 12 })
            .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
          }

          if (this.sign) {
            Image(this.sign)
              .objectFit(ImageFit.Contain)
              .backgroundColor($r('sys.color.background_tertiary'))
          }
        }
      }
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .height('100%')
    }
    .title('示例 3-自定义属性切换')
  }
}
```

## 更新记录

### 1.0.0 (2026-01-27)

- 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-signature
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/09d1e3f78a7c4b93b9f05cf22ebba377/2adce9bbd4cb42d58a87e6add45594b3?origin=template