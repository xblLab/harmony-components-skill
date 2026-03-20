# 滑块 UISlider

## 简介

UISlider 是基于 open harmony 基础组件开发的滑块组件。包括单滑块、双滑块和没有滑块三种显示效果，支持跟随系统语言或特定语言类型。

## 详细介绍

### 简介

UISlider 是基于 open harmony 基础组件开发的滑块组件。包括单滑块、双滑块和没有滑块三种显示效果，支持跟随系统语言或特定语言类型。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-slider
```

#### 使用

```typescript
// 引入组件
import { UISlider } from '@hw-agconnect/ui-slider';
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。
*   HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
*   DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
*   HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

`UISlider(options: UISliderOptions)`

#### UISliderOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | UISliderValue | 否 | 当前进度值 |
| sliderId | string | 否 | 设置滑块 ID，当有多个滑块时使用 |
| max | number | 否 | 最大值 |
| min | number | 否 | 最小值 |
| style | SliderStyle | 否 | 滑块显示样式 |
| step | number | 否 | 步长 |
| stepSize | number | 否 | 刻度大小 |
| stepColor | ResourceColor | 否 | 刻度颜色 |
| trackThickness | number | 否 | 滑轨的粗细 |
| trackColor | ResourceColor | 否 | 滑轨的背景颜色 |
| selectedColor | ResourceColor | 否 | 滑轨的已滑动部分颜色 |
| blockSize | number | 否 | 滑块大小 |
| nonValueIcon | ResourceStr | 否 | 最小值 icon 图标 |
| fullValueIcon | ResourceStr | 否 | 最大值 icon 图标 |
| isVertical | boolean | 否 | 是否垂直展示 |
| isReverse | boolean | 否 | 是否反向展示 |
| showValue | boolean | 否 | 是否显示数值 |
| showScale | boolean | 否 | 是否显示刻度值 |
| showStep | boolean | 否 | 是否显示步长刻度值 |
| showTip | boolean | 否 | 滑动时是否显示气泡提示 |
| disabled | boolean | 否 | 是否禁止 |

#### SliderStyle 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| OutSet | 滑块在滑轨上 |
| InSet | 滑块在滑轨内 |
| NONE | 无滑块 |

#### UISliderValue 联合类型说明

| 名称 | 描述 |
| :--- | :--- |
| number | 单个数值 |
| [number,number] | 长度为 2 的数值数组 |

### 使用限制

无

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onChange: (value: UISliderValue) => void = () => {} | 滑动后触发 |

### 异常处理

| 参数 | 处理方式 |
| :--- | :--- |
| value | value 小于 0 时取默认值 |
| min | min 小于 0 时取默认值 |
| max | max 小于 0 时取默认值 |
| step | step 小于 0 时取默认值 |

### 示例

#### 示例 1

```arkts
//UIEasySliderSample1
import { UISlider, UISliderValue } from '@hw-agconnect/ui-slider'

@Entry
@ComponentV2
struct Index {
  @Local value1: UISliderValue = 70
  @Local value2: UISliderValue = 50
  @Local value3: UISliderValue = 80
  @Local value4: UISliderValue = 70
  @Local value5: UISliderValue = 50
  @Local value6: UISliderValue = 80
  @Local value7: UISliderValue = 70
  @Local value8: UISliderValue = 60
  @Local value9: UISliderValue = 750

  @Local value11: UISliderValue = [40,70]
  @Local value12: UISliderValue = [20,80]
  @Local value13: UISliderValue = [50,70]
  @Local value14: UISliderValue = [90,70]
  @Local value15: UISliderValue = [20,60]
  @Local value16: UISliderValue = [30,50]
  @Local value17: UISliderValue = [40,70]
  @Local value18: UISliderValue = [50,90]
  @Local value19: UISliderValue = [650,900]

  @Local min:number = 500
  @Local max:number = 1000

  build() {
    Scroll() {
      Column() {
        UISlider({
          sliderId: '1',
          value: this.value1,
          style: SliderStyle.NONE,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '2',
          value: this.value2,
          style: SliderStyle.NONE,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '3',
          value: this.value3,
          style: SliderStyle.NONE,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '4',
          value: this.value4,
          style: SliderStyle.NONE,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '5',
          value: this.value5,
          style: SliderStyle.NONE,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '6',
          value: this.value6,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '7',
          value: this.value7,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '8',
          value: this.value8,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '9',
          value: this.value9,
          style: SliderStyle.NONE,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })

        UISlider({
          sliderId: '11',
          value: this.value11,
          style: SliderStyle.NONE,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '12',
          value: this.value12,
          style: SliderStyle.NONE,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '13',
          value: this.value13,
          style: SliderStyle.NONE,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '14',
          value: this.value14,
          style: SliderStyle.NONE,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '15',
          value: this.value15,
          style: SliderStyle.NONE,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '16',
          value: this.value16,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '17',
          value: this.value17,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '18',
          value: this.value18,
          style: SliderStyle.NONE,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '19',
          value: this.value19,
          style: SliderStyle.NONE,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        Flex({ justifyContent: FlexAlign.Center,wrap: FlexWrap.Wrap }) {
          UISlider({
            sliderId: '111',
            value: this.value1,
            style: SliderStyle.NONE,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '112',
            value: this.value2,
            style: SliderStyle.NONE,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '113',
            value: this.value3,
            style: SliderStyle.NONE,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '114',
            value: this.value4,
            style: SliderStyle.NONE,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '115',
            value: this.value5,
            style: SliderStyle.NONE,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '116',
            value: this.value6,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '117',
            value: this.value7,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '118',
            value: this.value8,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '119',
            value: this.value9,
            style: SliderStyle.NONE,
            step: 50,
            showScale: true,
            showStep: true,
            min: this.min,
            max: this.max,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1111',
            value: this.value11,
            style: SliderStyle.NONE,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1112',
            value: this.value12,
            style: SliderStyle.NONE,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1113',
            value: this.value13,
            style: SliderStyle.NONE,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1114',
            value: this.value14,
            style: SliderStyle.NONE,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1115',
            value: this.value15,
            style: SliderStyle.NONE,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1116',
            value: this.value16,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1117',
            value: this.value17,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1118',
            value: this.value18,
            style: SliderStyle.NONE,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1119',
            value: this.value19,
            style: SliderStyle.NONE,
            step: 50,
            showScale: true,
            showStep: true,
            isVertical:true,
            min: this.min,
            max: this.max,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
        }
      }
      .margin({left:20,right:20})
    }
    .width('100%')
  }
}
```

#### 示例 2

```arkts
//UIEasySliderSample2
import { UISlider, UISliderValue } from '@hw-agconnect/ui-slider'

@Entry
@ComponentV2
struct Index {
  @Local value1: UISliderValue = 70
  @Local value2: UISliderValue = 50
  @Local value3: UISliderValue = 80
  @Local value4: UISliderValue = 70
  @Local value5: UISliderValue = 50
  @Local value6: UISliderValue = 80
  @Local value7: UISliderValue = 70
  @Local value8: UISliderValue = 60
  @Local value9: UISliderValue = 750

  @Local value11: UISliderValue = [40,70]
  @Local value12: UISliderValue = [20,80]
  @Local value13: UISliderValue = [50,70]
  @Local value14: UISliderValue = [90,70]
  @Local value15: UISliderValue = [20,60]
  @Local value16: UISliderValue = [30,50]
  @Local value17: UISliderValue = [40,70]
  @Local value18: UISliderValue = [50,90]
  @Local value19: UISliderValue = [650,900]

  @Local min:number = 500
  @Local max:number = 1000

  build() {
    Scroll() {
      Column() {
        UISlider({
          sliderId: '1',
          value: this.value1,
          style: SliderStyle.OutSet,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '2',
          value: this.value2,
          style: SliderStyle.OutSet,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '3',
          value: this.value3,
          style: SliderStyle.OutSet,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '4',
          value: this.value4,
          style: SliderStyle.OutSet,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '5',
          value: this.value5,
          style: SliderStyle.OutSet,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '6',
          value: this.value6,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '7',
          value: this.value7,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '8',
          value: this.value8,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '9',
          value: this.value9,
          style: SliderStyle.OutSet,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })

        UISlider({
          sliderId: '11',
          value: this.value11,
          style: SliderStyle.OutSet,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '12',
          value: this.value12,
          style: SliderStyle.OutSet,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '13',
          value: this.value13,
          style: SliderStyle.OutSet,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '14',
          value: this.value14,
          style: SliderStyle.OutSet,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '15',
          value: this.value15,
          style: SliderStyle.OutSet,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '16',
          value: this.value16,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '17',
          value: this.value17,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '18',
          value: this.value18,
          style: SliderStyle.OutSet,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '19',
          value: this.value19,
          style: SliderStyle.OutSet,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        Flex({ justifyContent: FlexAlign.SpaceBetween,wrap: FlexWrap.Wrap }) {
          UISlider({
            sliderId: '111',
            value: this.value1,
            style: SliderStyle.OutSet,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '112',
            value: this.value2,
            style: SliderStyle.OutSet,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '113',
            value: this.value3,
            style: SliderStyle.OutSet,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '114',
            value: this.value4,
            style: SliderStyle.OutSet,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '115',
            value: this.value5,
            style: SliderStyle.OutSet,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '116',
            value: this.value6,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '117',
            value: this.value7,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '118',
            value: this.value8,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '119',
            value: this.value9,
            style: SliderStyle.OutSet,
            step: 50,
            showScale: true,
            showStep: true,
            min: this.min,
            max: this.max,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})

          UISlider({
            sliderId: '1111',
            value: this.value11,
            style: SliderStyle.OutSet,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1112',
            value: this.value12,
            style: SliderStyle.OutSet,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1113',
            value: this.value13,
            style: SliderStyle.OutSet,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1114',
            value: this.value14,
            style: SliderStyle.OutSet,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1115',
            value: this.value15,
            style: SliderStyle.OutSet,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1116',
            value: this.value16,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1117',
            value: this.value17,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1118',
            value: this.value18,
            style: SliderStyle.OutSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1119',
            value: this.value19,
            style: SliderStyle.OutSet,
            step: 50,
            showScale: true,
            showStep: true,
            isVertical:true,
            min: this.min,
            max: this.max,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
        }
      }
      .margin({left:20,right:20})
    }
    .width('100%')
  }
}
```

#### 示例 3

```arkts
//UIEasySliderSample3
import { UISlider, UISliderValue } from '@hw-agconnect/ui-slider'

@Entry
@ComponentV2
struct Index {
  @Local value1: UISliderValue = 70
  @Local value2: UISliderValue = 50
  @Local value3: UISliderValue = 80
  @Local value4: UISliderValue = 70
  @Local value5: UISliderValue = 50
  @Local value6: UISliderValue = 80
  @Local value7: UISliderValue = 70
  @Local value8: UISliderValue = 60
  @Local value9: UISliderValue = 750

  @Local value11: UISliderValue = [40,70]
  @Local value12: UISliderValue = [20,80]
  @Local value13: UISliderValue = [50,70]
  @Local value14: UISliderValue = [90,70]
  @Local value15: UISliderValue = [20,60]
  @Local value16: UISliderValue = [30,50]
  @Local value17: UISliderValue = [40,70]
  @Local value18: UISliderValue = [50,90]
  @Local value19: UISliderValue = [650,900]

  @Local min:number = 500
  @Local max:number = 1000

  build() {
    Scroll() {
      Column() {
        UISlider({
          sliderId: '1',
          value: this.value1,
          style: SliderStyle.InSet,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '2',
          value: this.value2,
          style: SliderStyle.InSet,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '3',
          value: this.value3,
          style: SliderStyle.InSet,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '4',
          value: this.value4,
          style: SliderStyle.InSet,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '5',
          value: this.value5,
          style: SliderStyle.InSet,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '6',
          value: this.value6,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '7',
          value: this.value7,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '8',
          value: this.value8,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '9',
          value: this.value9,
          style: SliderStyle.InSet,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })

        UISlider({
          sliderId: '11',
          value: this.value11,
          style: SliderStyle.InSet,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '12',
          value: this.value12,
          style: SliderStyle.InSet,
          isReverse: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '13',
          value: this.value13,
          style: SliderStyle.InSet,
          showValue: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '14',
          value: this.value14,
          style: SliderStyle.InSet,
          showTip: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '15',
          value: this.value15,
          style: SliderStyle.InSet,
          step: 10,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '16',
          value: this.value16,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '17',
          value: this.value17,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
          showStep: true,
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '18',
          value: this.value18,
          style: SliderStyle.InSet,
          step: 10,
          showScale: true,
          showStep: true,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        UISlider({
          sliderId: '19',
          value: this.value19,
          style: SliderStyle.InSet,
          step: 50,
          showScale: true,
          showStep: true,
          min: this.min,
          max: this.max,
          nonValueIcon: $r('app.media.ic_circle_sun'),
          fullValueIcon: $r('app.media.ic_circle_active_sun')
        })
          .margin({ bottom: 20 })
        Flex({ justifyContent: FlexAlign.SpaceBetween,wrap: FlexWrap.Wrap }) {
          UISlider({
            sliderId: '111',
            value: this.value1,
            style: SliderStyle.InSet,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '112',
            value: this.value2,
            style: SliderStyle.InSet,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '113',
            value: this.value3,
            style: SliderStyle.InSet,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '114',
            value: this.value4,
            style: SliderStyle.InSet,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '115',
            value: this.value5,
            style: SliderStyle.InSet,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '116',
            value: this.value6,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '117',
            value: this.value7,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '118',
            value: this.value8,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '119',
            value: this.value9,
            style: SliderStyle.InSet,
            step: 50,
            showScale: true,
            showStep: true,
            min: this.min,
            max: this.max,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})

          UISlider({
            sliderId: '1111',
            value: this.value11,
            style: SliderStyle.InSet,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1112',
            value: this.value12,
            style: SliderStyle.InSet,
            isReverse: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1113',
            value: this.value13,
            style: SliderStyle.InSet,
            showValue: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1114',
            value: this.value14,
            style: SliderStyle.InSet,
            showTip: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1115',
            value: this.value15,
            style: SliderStyle.InSet,
            step: 10,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1116',
            value: this.value16,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1117',
            value: this.value17,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1118',
            value: this.value18,
            style: SliderStyle.InSet,
            step: 10,
            showScale: true,
            showStep: true,
            isVertical:true,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
          UISlider({
            sliderId: '1119',
            value: this.value19,
            style: SliderStyle.InSet,
            step: 50,
            showScale: true,
            showStep: true,
            isVertical:true,
            min: this.min,
            max: this.max,
            nonValueIcon: $r('app.media.ic_circle_sun'),
            fullValueIcon: $r('app.media.ic_circle_active_sun')
          })
            .width('30%')
            .height(300)
            .margin({bottom:20})
        }
      }
      .margin({left:20,right:20})
    }
    .width('100%')
  }
}
```

## 更新记录

### 1.0.2 (2025-09-29)

*   下载该版本更新页面滚动时纵向滑块滑动问题。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

隐私政策不涉及 SDK 合规使用指南 不涉及。

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| HarmonyOS 版本 | 5.0.1 |
| HarmonyOS 版本 | 5.0.2 |
| HarmonyOS 版本 | 5.0.3 |
| HarmonyOS 版本 | 5.0.4 |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用 |
| 应用类型 | 元服务 |
| 设备类型 | 手机 |
| 设备类型 | 平板 |
| 设备类型 | PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-slider
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d1eaf5b2b04b40d8bc124d97990aa944/2adce9bbd4cb42d58a87e6add45594b3?origin=template