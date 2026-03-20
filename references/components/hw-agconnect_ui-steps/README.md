# 步骤条 UISteps

## 简介

UISteps 是基于 open harmony 基础组件开发的步骤条组件，包括横向和纵向两种布局，同时支持修改图标、全屏显示等功能。

## 详细介绍

### 简介

UISteps 是基于 open harmony 基础组件开发的步骤条组件，包括横向和纵向两种布局，同时支持修改图标、全屏显示等功能。

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
ohpm install @hw-agconnect/ui-steps
```

> 当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。
>
> ```bash
> ohpm install @hw-agconnect/ui-steps@1.0.0
> ```

#### 引入组件

```typescript
import { UISteps } from '@hw-agconnect/ui-steps';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UISteps({
   active: this.active,
   options: this.options,
   activeIcon: $r('app.media.ic_public_highlights'),
   onStepClick: (event)=>{}
})
```

### API 参考

#### 子组件

无

#### 接口

**UISteps(options: UIStepsOptions)**

步骤条组件。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIStepsOptions | 是 | 配置步骤条的参数。 |

##### UIStepsOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | OptionsModel[] | 是 | 步骤条显示的数据 |
| active | number | - | 当前已完成步骤，默认为：0 |
| activeColor | ResourceColor | 否 | 已完成步骤和选中步骤的颜色 |
| direction | StepsDirection | 否 | 排列方向，默认值为：Direction.ROW |
| activeIcon | Resource | 否 | 自定义图标 |
| dividerSize | number \| string | 否 | 自定义分割器组件的尺寸。<br>说明：当 isFullShow 为 true 时不生效 |
| titleFontSize | Length | 否 | 自定义标题字体大小 |
| descFontSize | Length | 否 | 自定义标描述字体大小 |
| isFullShow | boolean | 否 | 是否占满所在组件，即根据所在组件的宽高自适应显示所有步骤，默认为:true |
| textWidth | number \| string | 否 | 标题和描述的宽度<br>说明：当 isFullShow 为 true 且横向时不生效 |
| onStepClick | (index: number) => void | 否 | 点击分类后触发该事件，参数为当前所选择的步骤条 |

##### Direction 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| ROW | 横向 |
| COLOUM | 纵向 |

##### OptionsModel 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | string | 是 | 步骤条标题 |
| desc | string / Resource | 否 | 步骤条描述 |

### 示例代码

#### 示例 1

```typescript
import { UISteps, OptionsModel, Direction } from '@hw-agconnect/ui-steps';

let optionsData: OptionsModel[] = [
  { title: '步骤 1', desc: '辅助文本' },
  { title: '步骤 2', desc: '辅助文本' },
  {
    title: '步骤 3',
    desc: '辅助文本辅助文本辅助文本辅助文本',
  },
  { title: '步骤 4', desc: '辅助文本' },
]

@Extend(Text)
function textStyle() {
  .fontWeight(600)
  .margin({ top: 20 })
}

@Entry
@ComponentV2
export struct StepsSample {
  scroller: Scroller = new Scroller()
  @Local options: OptionsModel[] = [new OptionsModel()]
  @Local directionSteps: string = Direction.COLOUM
  @Local active: number = 2
  @Local activeIcon: Resource = $r('app.media.ic_todo_filled')
  @Local dividerSize: number = 58
  @Local activeColor: ResourceColor = $r('sys.color.ohos_id_color_activated')

  @Builder
  buildTitleBar() {
    Text('Steps')
      .fontSize(24)
      .fontWeight(FontWeight.Medium)
      .height(56)
      .width('100%')
      .padding({ left: 16, right: 16 })
  }

  aboutToAppear(): void {
    this.options = optionsData
  }

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column() {
          Text('基本用法').textStyle()
          UISteps({ active: this.active, options: this.options, dividerSize: this.dividerSize })

          Text('自定义图标').textStyle()
          UISteps({
            active: this.active,
            options: this.options,
            activeIcon: $r('app.media.icon_collection'),
          })

          Text('纵向排列').textStyle()
          UISteps({
            active: this.active,
            options: this.options,
            directionSteps: Direction.COLOUM,
            textWidth: '80%',
          })
            .height('46%')

          Button('改变状态')
            .onClick(() => {
              if (this.active < this.options.length) {
                this.active++
              } else {
                this.active = 0
              }
            })
        }
      }
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .title(this.buildTitleBar())
  }
}
```

## 更新记录

### 2.0.0 (2025-11-04)

- 从 V2.0.* 版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.0 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

[下载该版本](https://developer.huawei.com/consumer/cn/market/prod-detail/248bf54266e1445794f3193ead4083b3/2adce9bbd4cb42d58a87e6add45594b3?origin=template)

### 1.0.0 (2025-09-29)

- 初始版本

[下载该版本](https://developer.huawei.com/consumer/cn/market/prod-detail/248bf54266e1445794f3193ead4083b3/2adce9bbd4cb42d58a87e6add45594b3?origin=template)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 其他信息

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 支持情况 |
| :--- | :--- |
| 5.0.0 | 支持 |
| 5.0.1 | 支持 |
| 5.0.2 | 支持 |
| 5.0.3 | 支持 |
| 5.0.4 | 支持 |
| 5.0.5 | 支持 |

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

| 版本 | 支持情况 |
| :--- | :--- |
| DevEco Studio 5.0.0 | 支持 |
| DevEco Studio 5.0.1 | 支持 |
| DevEco Studio 5.0.2 | 支持 |
| DevEco Studio 5.0.3 | 支持 |
| DevEco Studio 5.0.4 | 支持 |
| DevEco Studio 5.0.5 | 支持 |
| DevEco Studio 5.1.0 | 支持 |
| DevEco Studio 5.1.1 | 支持 |
| DevEco Studio 6.0.0 | 支持 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-steps
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/248bf54266e1445794f3193ead4083b3/2adce9bbd4cb42d58a87e6add45594b3?origin=template