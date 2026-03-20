# 验证码输入组件 UICodeInput

## 简介

UICodeInput 基于 open harmony 开发的验证码输入组件。支持自定义位数。支持输入跳转下一位。支持盒状/线状、填充/描边切换。支持自定义尺寸、间距、边框、文字等样式。提供输入变化和完整时的回调事件。

## 详细介绍

### 简介

UICodeInput 基于 open harmony 开发的验证码输入组件。支持自定义位数。支持输入跳转下一位。
支持盒状/线状、填充/描边切换。支持自定义尺寸、间距、边框、文字等样式。提供输入变化和完整时的回调事件。

### 约束与限制

#### 环境

DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
设备类型：华为手机（包括双折叠和阔折叠）和 华为平板
系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

#### 使用

安装组件。
深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-code-input;
```

引入组件。
深色代码主题复制
```typescript
import { UICodeInput, ShapeEnum, SelectEnum } from '@hw-agconnect/ui-code-input';
```

调用组件，详细参数配置说明参见 API 参考。
深色代码主题复制
```typescript
UICodeInput({
   count:4,
   shape:ShapeEnum.BOX,
   onChange: (code: string[]) => {
   },
   onComplete: () => {
   },
})
```

## API 参考

### 子组件

无

### 接口

`UICodeInput(options?: UICodeInputOptions)`
验证码输入组件。

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICodeInputOptions | 否 | 配置验证码输入组件的参数。 |

#### UICodeInputOptions 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| shape | ShapeEnum | 否 | 形状，默认：ShapeEnum.BOX |
| select | SelectEnum | 否 | 选中状态，只在 ShapeEnum.BOX 时生效。默认：描边 |
| count | number | 否 | 输入列数，取值范围 1-6，传参大于 6 时取 6，小于 1 时取 1。默认：6 |
| space | number \| string | 否 | 列间距，默认：12vp |
| caretColor | ResourceColor | 否 | 光标颜色，默认光标颜色：#E84026 |
| itemSize | Length | 否 | 单元尺寸，宽高比固定为 1，默认：40vp×40vp |
| fontSize | Length | 否 | 文字大小，默认：$r('sys.float.Body_M') |
| fontWeight | FontWeight | 否 | 文字粗细，默认：FontWeight.Medium |
| fontColor | ResourceColor | 否 | 文字颜色，默认：$r('sys.color.font_primary') |
| boxRadius | Length | 否 | 盒状时的圆角，默认：8vp |
| boxBgColor | ResourceColor | 否 | 盒状时的默认背景色，默认：Color.Transparent |
| boxBorderColor | ResourceColor | 否 | 盒状时的默认边框颜色，默认：#C7C7CC |
| boxBorderWidth | Length | 否 | 盒状时的默认边框粗细，默认：1vp |
| fillColor | ResourceColor | 否 | 盒状选中填充时的背景颜色，默认：$r('sys.color.multi_color_09') |
| fillOpacity | number | 否 | 盒状选中填充时的背景透明度，默认：0.2 |
| strokeColor | ResourceColor | 否 | 盒状选中描边时的线框颜色，默认：#E84026 |
| strokeWidth | Length | 否 | 盒状选中描边时的线框粗细，默认：1vp |
| lineHeight | Length | 否 | 线状时的线条高度，默认：2vp |
| lineRadius | Length | 否 | 线状时的线条圆角，默认：50% |
| lineColor | ResourceColor | 否 | 线状时的线条颜色，默认：#C4C4C4 |
| onChange | (code: string[]) => void | 否 | 变化时回调，参数为对应列数的验证码数组 |
| onComplete | onComplete: () => void | 否 | 完整时回调 |

#### ShapeEnum 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| BOX | 盒状 |
| LINE | 线状 |

#### SelectEnum 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| FILL | 填充底色 |
| STROKE | 边框描边 |
| ALL | 填充底色 + 边框描边 |

## 示例代码

本示例展示了验证码输入组件的基本用法。
深色代码主题复制
```typescript
import { promptAction } from '@kit.ArkUI';
import { UICodeInput, SelectEnum, ShapeEnum } from '@hw-agconnect/ui-code-input';

@Entry
@ComponentV2
struct CodeInputSample {
  build() {
    Navigation() {
      Scroll() {
        Column({ space: 40 }) {
          Container({ title: 'Box 盒状' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.BOX,
            })
          }

          Container({ title: 'Line 线状' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.LINE,
            })
          }

          Container({ title: '自定义个数' }) {
            UICodeInput({
              count: 6,
            })
          }

          Container({ title: '自定义间距' }) {
            UICodeInput({
              count: 4,
              space: 30,
            })
          }

          Container({ title: '自定义尺寸' }) {
            UICodeInput({
              count: 4,
              itemSize: 50,
            })
          }

          Container({ title: '自定义圆角' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.BOX,
              boxRadius: 0,
            })
          }

          Container({ title: '自定义背景色' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.BOX,
              boxBgColor: '#ffebecee',
              boxBorderWidth: 0,
            })
          }

          Container({ title: '填充底色' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.BOX,
              select: SelectEnum.FILL,
            })
          }

          Container({ title: '边框描边' }) {
            UICodeInput({
              count: 4,
              shape: ShapeEnum.BOX,
              select: SelectEnum.STROKE,
            })
          }

          Container({ title: '变化时回调' }) {
            UICodeInput({
              count: 4,
              onChange: (code: string[]) => {
                this.toast('当前验证码数组：' + code.toString())
              },
            })
          }

          Container({ title: '完整时回调' }) {
            UICodeInput({
              count: 4,
              onComplete: () => {
                this.toast('当前验证码数组：已补充完整')
              },
            })
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .padding(16)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('验证码输入')
    .hideToolBar(true)
  }

  toast(message: string) {
    try {
      this.getUIContext().getPromptAction().showToast({ message, alignment: Alignment.Center })
    } catch (error) {
      console.error('show toast failed.')
    }
  }
}

@ComponentV2
export struct Container {
  @Param title: string = '';
  @BuilderParam child: () => void;

  build() {
    Column({ space: 16 }) {
      Text(this.title)
        .fontSize($r('sys.float.Subtitle_L'))
        .fontWeight(FontWeight.Bold)

      this.child?.()
    }
    .alignItems(HorizontalAlign.Start)
  }
}
```

## 更新记录

### 1.0.0 (2026-01-28)

Created with Pixso.

### 下载该版本

### 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |
| 6.0.2 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |
| DevEco Studio 6.0.2 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-code-input
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e8cdcc4fe9e342d0bee5558d99ad5024/2adce9bbd4cb42d58a87e6add45594b3?origin=template