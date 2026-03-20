# 折叠面板 UICollapse

## 简介

UICollapse 是基于 open harmony 基础组件开发的折叠面板组件，支持显示过长文本，支持修改图标、手风琴效果等功能。

## 详细介绍

### 简介

UICollapse 是基于 open harmony 基础组件开发的折叠面板组件，支持显示过长文本，支持修改图标、手风琴效果等功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、平板
- 系统版本：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 使用

**安装组件。**

深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-collapse;
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

深色代码主题复制
```bash
ohpm install  @hw-agconnect/ui-collapse@1.0.0;
```

**引入组件。**

深色代码主题复制
```typescript
import { UICollapse, UICollapseItem, TitleBorder } from '@hw-agconnect/ui-collapse';
```

**调用组件，详细参数配置说明参见 API 参考。**

深色代码主题复制
```typescript
@Builder
CollapseItemBuilder() {
   UICollapseItem({
      name: '0',
      value: this.value,
      headerBuilderParam: () => {
         this.headerBuilder('example')
     },
     contentBuilderParam: () => {
         this.contextBuilder('context')
     },
     onchange: (val) => {
         this.changedValue = val;
     }
   })
}

@Builder
headerBuilder(title){
   Text(title)
}

@Builder
contextBuilder(context){
   Text(context)
}

UICollapse({
   collapseItemBuilderParam: () => {
      this.CollapseItemBuilder()
   },
})
```

## API 参考

### 子组件

**UICollapseItem(options: UICollapseItemOptions)**
折叠面板单元组件。

### 接口

**UICollapse(options: UICollapseOptions)**
折叠面板组件。

#### UICollapseOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| collapseItemBuilderParam | 自定义构建函数 | 是 | 放置折叠面板内容 |

#### UICollapseItemOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| value | string \| string[] | 是 | 是当前激活面板改变时触发 (如果是手风琴模式，参数类型为 string，否则为 Array)，同一个折叠面板的 value 值须得一致。需要通过!!双向绑定 |
| name | string | 是 | 是每个面板的唯一标识 |
| contentBuilderParam | 自定义构建函数 | 是 | 是面板内容，通过自定义构建函数形式搭建面板内容 |
| headerBuilderParam | 自定义构建函数 | 是 | 是面板标题，通过自定义构建函数形式搭建面板内容 |
| disabled | boolean | 否 | 是否禁用，默认：false |
| showAnimations | boolean | 否 | 开启动画，默认：false |
| titleBorder | TitleBorder | 否 | 折叠面板标题分隔线 |
| showArrow | boolean | 否 | 是否显示右侧箭头 |
| accordion | boolean | 否 | 是否开启手风琴效果，默认：false。同组折叠面板单元组件的 value 需要保持一致。开启手风琴效果时，accordion 属性需要同时设置为 true。 |
| onchange(value:string \| string[]) => void | function | 否 | 切换面板时触发，如果是手风琴模式，返回类型为 string，否则为 string[] |

#### TitleBorder 对象说明

| 名称 | 说明 |
| :--- | :--- |
| AUTO | 分隔线自动显示 |
| SHOW | 一直显示分隔线 |
| NONE | 不显示分隔线 |

## 示例代码

### 示例 1

深色代码主题复制
```typescript
import { UICollapse, UICollapseItem } from '@hw-agconnect/ui-collapse';

@Entry
@ComponentV2
export struct CollapseCommon {
  @Local value: string | string[] = ['0'];
  @Local changedValue: string | string[] = '';

  @Builder
  CollapseItemBuilder() {
    Column() {
      UICollapseItem({
        name: '0',
        value: this.value!!,// 通过!!实现双向绑定。具体语法参见：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-binding
        headerBuilderParam: () => {
          this.headerBuilder('默认开启')
        },
        contentBuilderParam: () => {
          this.contextBuilder('折叠面板默认显示内容由 value 控制，如果是手风琴模式，参数类型为 string，否则为 Array，同一个折叠面板的 value 值须得一致')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '1',
        value: this.value!!,
        disabled: true,
        headerBuilderParam: () => {
          this.headerBuilder('禁用', '')
        },
        contentBuilderParam: () => {
          this.contextBuilder('disabled 属性控制面板禁用状态')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '2',
        showAnimation: true,
        value: this.value!!,
        headerBuilderParam: () => {
          this.headerBuilder('使用动画')
        },
        contentBuilderParam: () => {
          this.contextBuilder('通过 showAnimation 属性可以控制面板是否使用动画，但因机制问题需要将内容设置固定宽度')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '3',
        value: this.value!!,
        headerBuilderParam: () => {
          this.headerBuilder('缩略图', $r('app.media.highlight'))
        },
        contentBuilderParam: () => {
          this.contextBuilder('通过 headerBuilderParam 函数设置头部样式')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '4',
        value: this.value!!,
        showArrow: false,
        headerBuilderParam: () => {
          this.headerBuilder('无箭头图标')
        },
        contentBuilderParam: () => {
          this.contextBuilder('无箭头图标由 showArrow 字段控制')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

    }
  }

  @Builder
  headerBuilder(title: string, thumb: ResourceStr = '') {
    Row() {
      if (thumb) {
        Image(thumb).width(24).height(24)
      }
      Text(title)
        .fontSize(16)
        .lineHeight(24)
        .fontWeight(500)
        .margin({ left: thumb ? 12 : 0 })
    }
  }

  @Builder
  contextBuilder(context: string) {
    Text(context)
      .fontSize(16)
      .lineHeight(24)
      .padding({ top: 16, bottom: 16 })
      .fontWeight(400)
      .width('100%')
  }

  build() {
    Column() {
      Text('基础用法').fontSize(20).margin({ bottom: 10, top: 10 })
      UICollapse({
        collapseItemBuilderParam: () => {
          this.CollapseItemBuilder()
        },
      }).margin({ left: 16, right: 16 })
    }
  }
}
```

### 示例 2

深色代码主题复制
```typescript
import { UICollapse, UICollapseItem, TitleBorder } from '@hw-agconnect/ui-collapse';

@ObservedV2
class contextInfo {
  @Trace context: string = '';
  titleBorder: string = '';
  header: string = '';

  constructor(titleBorder: string, context: string, header: string) {
    this.context = context;
    this.titleBorder = titleBorder;
    this.header = header;
  }
}

@Entry
@ComponentV2
export struct CollapseAccordion {
  @Local value: string | string[] = '';
  @Local accordion: boolean = true
  @Local changedValue: string | string[] = '';
  contextInfos: contextInfo[] = [
    new contextInfo(TitleBorder.NONE, '折叠面板标题分隔线：none', '折叠面板标题分隔线：none'),
    new contextInfo(TitleBorder.SHOW, '折叠面板标题分隔线：show', '折叠面板标题分隔线：show'),
    new contextInfo(TitleBorder.AUTO, '折叠面板标题分隔线：auto', '折叠面板标题分隔线：auto'),
  ];

  @Builder
  CollapseItemBuilder() {
    Column() {
      ForEach(this.contextInfos, (item: contextInfo, index: number) => {
        UICollapseItem({
          name: index.toString(),
          value: this.value!!,// 通过!!实现双向绑定。具体语法参见：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-binding
          accordion: this.accordion,
          titleBorder: item.titleBorder,
          headerBuilderParam: () => {
            this.headerBuilder(item.header)
          },
          contentBuilderParam: () => {
            this.contextBuilder(item)
          },
          onchange: (val) => {
            this.changedValue = val;
          },
        })
      })
    }
  }

  @Builder
  headerBuilder(title: string, thumb: ResourceStr = '') {
    Row() {
      if (thumb) {
        Image(thumb).width(24).height(24)
      }
      Text(title)
        .fontSize(16)
        .lineHeight(24)
        .fontWeight(500)
        .margin({ left: thumb ? 12 : 0 })
    }
  }

  @Builder
  contextBuilder($$: contextInfo) {
    Text($$.context)
      .fontSize(16)
      .lineHeight(24)
      .padding({ top: 16, bottom: 16 })
      .fontWeight(400)
      .width('100%')
  }

  build() {
    Column() {
      Text('手风琴效果').fontSize(20).margin({ bottom: 10, top: 10 })
      UICollapse({
        collapseItemBuilderParam: () => {
          this.CollapseItemBuilder()
        },
      })
        .padding({ top: 16, bottom: 16 })
      Button('动态修改内容').onClick(() => {
        this.contextInfos[0].context =
          this.contextInfos[0].context.length <= 14 ? '折叠面板已经动态修改为新数据，再次点击按钮恢复之前的内容' :
            '折叠面板标题分隔线：none'
      }).margin({ top: 40 })
    }.margin({ left: 16, right: 16 })
  }
}
```

## 更新记录

### 2.0.0 (2025-11-04)

Created with Pixso.

下载该版本从 V2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.0 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

### 1.0.0 (2025-09-30)

Created with Pixso.

下载该版本初始版本

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
  Created with Pixso.
- 5.0.1
  Created with Pixso.
- 5.0.2
  Created with Pixso.
- 5.0.3
  Created with Pixso.
- 5.0.4
  Created with Pixso.
- 5.0.5
  Created with Pixso.

### 应用类型

- 应用
  Created with Pixso.
- 元服务
  Created with Pixso.

### 设备类型

- 手机
  Created with Pixso.
- 平板
  Created with Pixso.
- PC
  Created with Pixso.

### DevEcoStudio 版本

- DevEco Studio 5.0.0
  Created with Pixso.
- DevEco Studio 5.0.1
  Created with Pixso.
- DevEco Studio 5.0.2
  Created with Pixso.
- DevEco Studio 5.0.3
  Created with Pixso.
- DevEco Studio 5.0.4
  Created with Pixso.
- DevEco Studio 5.0.5
  Created with Pixso.
- DevEco Studio 5.1.0
  Created with Pixso.
- DevEco Studio 5.1.1
  Created with Pixso.
- DevEco Studio 6.0.0
  Created with Pixso.

## 安装方式

```bash
ohpm install @hw-agconnect/ui-collapse
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c3096d5479c14dcb85b338d504bc867b/2adce9bbd4cb42d58a87e6add45594b3?origin=template