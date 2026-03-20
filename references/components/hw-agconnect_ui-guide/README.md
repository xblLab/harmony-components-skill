# 引导组件 UIGuide

## 简介

UIGuide 是基于 open harmony 的 Popup 开发的引导组件。蒙版遮罩、气泡聚焦，分步引导用户了解描述信息。支持自定义蒙版颜色、透明度。支持自定义气泡宽度、圆角、颜色等样式。支持自定义描述、索引及按钮内容的样式。

## 详细介绍

### 简介
UIGuide 是基于 open harmony 的 Popup 开发的引导组件。蒙版遮罩、气泡聚焦，分步引导用户了解描述信息。
支持自定义蒙版颜色、透明度。支持自定义气泡宽度、圆角、颜色等样式。支持自定义描述、索引及按钮内容的样式。

### 约束与限制

#### 环境

*   **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
*   **HarmonyOS SDK 版本**：HarmonyOS 5.0.1 Release SDK 及以上
*   **设备类型**：华为手机（包括双折叠和阔折叠）和 华为平板
*   **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限
无

#### 使用限制
由于遮罩要求，组件需占满全屏：

1.  本组件需作为当前页面除根容器外的唯一根组件使用
2.  根容器为 Navigation、Navdestination 时，不可使用 title 属性设置标题
3.  根容器不可设置 padding 属性

```typescript
// 反例 - UIGuide 不是根容器内唯一组件，存在并列组件 Text
@ComponentV2
export struct Demo{
  build(){
    Navdestination(){
      Text('标题')
      UIGuide() 
    } 
  }
}

// 反例 - Navdestination 设置了 title 属性
@ComponentV2
export struct Demo{
  build(){
    Navdestination(){
      UIGuide() 
    }
     .title('标题')
  }
}

// 反例 - Navdestination 设置了 padding
@ComponentV2
export struct Demo{
  build(){
    Navdestination(){
      UIGuide() 
    }
     .padding(16)
  }
}

// 正例
@ComponentV2
export struct Demo{
  build(){
    Navdestination(){
      UIGuide() 
    }
  }
}
```

### 使用

#### 安装组件
```bash
ohpm install @hw-agconnect/ui-guide
```

#### 引入组件
```typescript
import { GuideController, GuideDataItem, UIGuide } from '@hw-agconnect/ui-guide';
```

#### 调用组件
详细参数配置说明参见 API 参考。
```typescript
UIGuide({
   controller: this.controller,
   data: this.data,
   child: () => {
      this.child()
   },
})
```

## API 参考

### 子组件
无

### 接口

#### UIGuide(options?: UIGuideOptions)
引导组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIGuideOptions | 是 | 配置引导组件的参数。 |

#### UIGuideOptions 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| data | GuideDataItem | 是 | 引导数据 |
| controller | GuideController | 是 | 引导控制器 |
| child | CustomBuilder | 是 | 引导步骤对应子组件，组件 id 需要与 data 项 id 保持一致性与唯一性。 |
| customPop | CustomBuilder | 否 | 自定义气泡布局。 |
| maskColor | ResourceColor | 否 | 遮罩颜色，默认为：“#99000000” |
| holeRadius | number | 否 | 挖孔圆角，默认为：4 |
| holeScale | number | 否 | 挖孔放大倍数，默认为：1.1 |
| popColor | ResourceColor | 否 | 气泡颜色 |
| popRadius | number | 否 | 气泡圆角，默认为：16 |
| popWidth | number | 否 | 气泡宽度，默认为：300 |
| contentFontSize | Length | 否 | 引导内容字体大小，默认为：14vp |
| contentLineHeight | Length | 否 | 引导内容字体行高，默认为：19vp |
| contentFontColor | ResourceColor | 否 | 引导内容字体颜色 |
| indexFontSize | Length | 否 | 索引页签字体大小，默认为：14vp |
| indexFontColor | ResourceColor | 否 | 索引页签字体颜色 |
| btnFontSize | Length | 否 | 按钮文字大小，默认为：14vp |
| btnFontStyle | FontStyle | 否 | 按钮文字样式，默认为：FontStyle.Normal |
| btnFontColor | ResourceColor | 否 | 按钮文字颜色 |
| btnPreText | ResourceStr | 否 | 上一步按钮文字内容，默认为：“上一步” |
| btnNextText | ResourceStr | 否 | 下一步按钮文字内容，默认为：“上一步” |
| btnEndText | ResourceStr | 否 | 结束引导按钮文字内容，默认为：“结束引导” |

#### GuideDataItem 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 引导项对应组件 id，需要保持唯一性。 |
| desc | string | 是 | 引导项对应描述内容。 |
| placement | Placement | 否 | 引导气泡相对组件对齐方式。缺省时为：Placement.BottomLeft |

#### GuideController 对象说明
UIGuide 组件的控制器，用于控制 UIGuide 组件进行引导步骤切换。

| 名称 | 描述 |
| :--- | :--- |
| index | number 类型，当前引导步骤索引。可以用于自定义气泡布局，详情参见示例 3。 |
| open() | void 开启气泡引导。 |
| close() | void 关闭气泡引导。 |
| prev() | void 切换至上一步引导步骤。当前为首项时不生效。 |
| next() | void 切换至下一步引导步骤。当前为尾项时不生效。 |
| change(index:number) | void 切换至指定索引对应的引导步骤。 |

## 示例代码

### 示例 1
本示例展示了引导组件的基本用法。

```typescript
import { GuideController, GuideDataItem, UIGuide } from '@hw-agconnect/ui-guide';

@Entry
@ComponentV2
struct BasicGuide {
  @Local controller: GuideController = new GuideController();
  @Local data: GuideDataItem[] = [
    {
      id: 'op1',
      desc: '步骤 1 的引导内容',
    },
    {
      id: 'op2',
      desc: '步骤 2 的引导内容',
    },
    {
      id: 'op3',
      desc: '步骤 3 的引导内容',
    },
    {
      id: 'op4',
      desc: '确定按钮的引导内容',
      placement: Placement.Top,
    },
  ]

  build() {
    NavDestination() {
      UIGuide({
        controller: this.controller,
        data: this.data,
        holeScale: 1.06,
        child: () => {
          this.child()
        },
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.comp_background_tertiary'))

  }

  @Builder
  title() {
    Text('引导组件的基本用法')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: 16 })
  }

  @Builder
  child() {
    this.title()
    Column() {
      Row() {
        Text('开启引导>').fontSize($r('sys.float.Body_M'))
        SymbolGlyph($r('sys.symbol.square_grid_2x2'))
          .fontSize(30)
          .onClick(() => {
            this.controller.open();
          })
      }
      .margin({ top: 40 })

      Blank().layoutWeight(1)
      List() {
        this.item('步骤 1', 'op1')
        this.item('步骤 2', 'op2')
        this.item('步骤 3', 'op3')
      }
      .padding(16)
      .divider({ strokeWidth: 2 })
      .backgroundColor($r('sys.color.background_primary'))

      Blank().layoutWeight(1)
      Button('确定').width('calc(100% - 32vp)').id('op4')
    }
  }

  @Builder
  item(title: string, id: string) {
    ListItem() {
      Row({ space: 30 }) {
        Text(title + ':').fontColor($r('sys.color.font_primary')).width('20%')

        TextInput({ placeholder: '空白' })
          .padding(0)
          .backgroundColor(Color.Transparent)
          .fontColor($r('sys.color.font_primary'))
      }
      .height(40)
      .width('100%')
    }
    .id(id)
  }
}
```

### 示例 2
本示例通过展示了引导组件的样式调整。

```typescript
import { GuideController, GuideDataItem, UIGuide } from '@hw-agconnect/ui-guide';

@Entry
@ComponentV2
struct StyleGuide {
  @Local controller: GuideController = new GuideController();
  @Local data: GuideDataItem[] = [
    {
      id: 'btn_open',
      desc: '开启按钮的引导内容',
      placement: Placement.BottomLeft,
    },
    {
      id: 'btn_mid',
      desc: '中间按钮的引导内容',
      placement: Placement.Bottom,
    },
    {
      id: 'btn_close',
      desc: '结束按钮的引导内容',
      placement: Placement.BottomRight,
    },
  ]

  build() {
    NavDestination() {
      UIGuide({
        controller: this.controller,
        data: this.data,
        maskColor: '#a8000000',
        holeRadius: 16,
        holeScale: 1.4,
        popColor: '#0A59F7',
        popRadius: 0,
        popWidth: 200,
        contentFontColor: '#FFFFFF',
        indexFontColor: '#FFFFFF',
        btnFontColor: '#FFFFFF',
        btnFontStyle: FontStyle.Italic,
        btnPreText: '回退',
        btnNextText: '继续',
        btnEndText: '结束',
        child: () => {
          this.child()
        },
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  title(){
    Text('引导组件的样式调整')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({left:16})
  }

  @Builder
  child() {
    this.title()
    Row() {
      Button('开启引导').id('btn_open').onClick(() => {
        this.controller.open();
      })

      Button('中间步骤').id('btn_mid')

      Button('结束引导').id('btn_close')
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}
```

### 示例 3
本示例展示了引导组件的自定义气泡布局。

```typescript
import { GuideController, GuideDataItem, UIGuide } from '@hw-agconnect/ui-guide';

@Entry
@ComponentV2
struct CustomGuide {
  @Local controller: GuideController = new GuideController();
  @Local data: GuideDataItem[] = [
    {
      id: 'btn_open',
      desc: '开启按钮的引导内容',
      placement: Placement.BottomLeft,
    },
    {
      id: 'btn_mid',
      desc: '中间按钮的引导内容',
      placement: Placement.Bottom,
    },
    {
      id: 'btn_close',
      desc: '结束按钮的引导内容',
      placement: Placement.BottomRight,
    },
  ]

  build() {
    NavDestination() {
      UIGuide({
        controller: this.controller,
        holeScale: 1.4,
        data: this.data,
        child: () => {
          this.child()
        },
        customPop: () => {
          this.customPop();
        },
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  title() {
    Text('引导组件的自定义气泡布局')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: 16 })
  }

  @Builder
  child() {
    this.title()

    Row() {
      Button('开启引导').id('btn_open').onClick(() => {
        this.controller.open();
      })

      Button('中间步骤').id('btn_mid')

      Button('结束引导').id('btn_close')
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  customPop() {
    Column({ space: 20 }) {
      Text(this.data[this.controller.index].desc)

      Row() {
        SymbolGlyph($r('sys.symbol.chevron_up'))
          .fontSize(26)
          .rotate({ angle: -90 })
          .visibility(this.controller.index ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            this.controller.prev();
          })

        Text(`${this.controller.index + 1} / ${this.data.length}`).layoutWeight(1).textAlign(TextAlign.Center)

        SymbolGlyph(this.controller.index === this.data.length - 1 ? $r('sys.symbol.nosign') :
          $r('sys.symbol.chevron_up'))
          .fontSize(26)
          .rotate({ angle: 90 })
          .onClick(() => {
            if (this.controller.index === this.data.length - 1) {
              this.controller.close();
            } else {
              this.controller.next();
            }
          })
      }
    }
    .width('100%')
    .padding(12)
    .alignItems(HorizontalAlign.Center)
  }
}
```

## 更新记录

### 1.0.0 (2026-01-27)
Created with Pixso.

## 下载该版本

初始版本

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策
不涉及

### SDK 合规使用指南
不涉及

### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |
| 6.0.2 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEcoStudio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.1 |
| DevEco Studio 5.0.2 |
| DevEco Studio 5.0.3 |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |
| DevEco Studio 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-guide
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fb8fdd2f45ba4acfa1dd659f9585e451/2adce9bbd4cb42d58a87e6add45594b3?origin=template