# ohos/adaptivecards 卡片 UI 组件

## 简介

自适应卡片是一种开放式的卡片格式，让开发人员能够使用 JSON 生成 UI 内容。

## 详细介绍

### 简介

自适应卡片是一种开放式的卡片格式，让开发人员能够使用 JSON 生成 UI 内容。

### 下载安装

深色代码主题复制
```bash
ohpm install @ohos/adaptivecards
```

### 使用说明

#### 快速使用

使用系统组件 `NodeContainer` 作为自定义节点的占位节点，通过 `NodeController` 提供的一系列生命周期回调，将 AdaptiveCards 处理后生成的 `FrameNode` 节点树挂载到对应的 `NodeContainer` 下。

1. **创建 Node 类**

```typescript
class DynamicsNodeController extends NodeController {
  public rootNode: FrameNode | null = null;

  makeNode(uiContext: UIContext): FrameNode | null {
    if (this.rootNode == null) {
      this.rootNode = new FrameNode(uiContext);
      this.rootNode.commonAttribute
        .width("100%")
    }
    return this.rootNode;
  }
}
```

2. **通过 NodeContainer 渲染自定义节点**

```typescript
@Entry
@Component
struct Index {
  controller: DynamicsNodeController = new DynamicsNodeController(); //构建节点

  build() {
    Column() {
      Column(){
        Scroll() {
          Column() {
            NodeContainer(this.controller)  //卡片渲染位置
          }.width('100%')
        }
        .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
        .scrollBar(BarState.On) // 滚动条常驻显示
        .scrollBarColor(Color.Gray) // 滚动条颜色
      }.height("50%")

      Button('生成卡片')
        .id('adaptivecards')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })
        .onClick(async () => {
          let node = await this.renderHello(); //创建卡片
          this.controller.rootNode?.appendChild(node) //将卡片添加到 NodeContainer 位置
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Gray)
  }

  async renderHello(): Promise<FrameNode | undefined> {
    let adaptiveCard = new AdaptiveCards.AdaptiveCard(); // 创建 adaptiveCard

    adaptiveCard.onExecuteAction = (action) => {
      console.dir(action)
    } //用于处理点击事件回调 action 里为对应信息
    
    let card = await getContext(this).resourceManager.getRawFileContent('test.json') //读取 resources/rawfile 下的 json 文件
    
    const json = buffer.from(card).toString(); 
    
    adaptiveCard.parse(JSON.parse(json));
    
    return adaptiveCard.render(this.getUIContext()); //传入 UIContext 构建节点
  }
}
```

### 注意事项

- 组件支持 API 14 及以上版本。
- 当 TextRun 中的文字超出一行时，后续的 TextRun 内容将自动换行显示。

### ColumnSet

ColumnSet 将区域划分为列，允许元素并排放置。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "ColumnSet" | 是 | 必须是'ColumnSet' |
| columns | Column[] | 否 | Column 数组 |
| selectAction | ISelectAction | 否 | 当点击或选择 ColumnSet 时将调用的 Action。 |
| style | ContainerStyle? | 否 | ColumnSet 的样式提示 |
| bleed | boolean | 否 | 元素是否应该溢出其父元素的填充 |
| minHeight | string | 否 | 以像素为单位指定列集的最小高度，如"80px"。 |
| horizontalAlignment | HorizontalAlignment? | 否 | 控制 ColumnSet 的水平对齐方式。默认为左对齐。 |

### Column

定义一个容器，它是 Column 的一部分。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| items | Element[] | 否 | 要在列内呈现的卡片元素。 |
| backgroundImage | BackgroundImage, uri | 否 | 指定背景图像。可接受的格式是 PNG、JPEG 和 GIF |
| bleed | boolean | 否 | 确定列是否应该溢出其父列的填充。 |
| fallbackColumn, FallbackOption | FallbackOption | 否 | 描述当遇到未知项目或无法满足此或任何子项目的要求时该如何做。 |
| minHeight | string | 否 | 以像素为单位指定列的最小高度，如"80px"。 |
| rtl | boolean? | 否 | 控制本 column 内的排列，为 true 时从右往左，为 false 时从左往右，undefined 时从父组件继承 |
| separator | boolean | 否 | 当为 true 时，在这一列和前一列之间画一条分隔线。 |
| spacing | Spacing | 否 | 控制此列与前一列之间的间距量。 |
| selectAction | ISelectAction | 否 | 当点击或选择列时将调用的操作。 |
| style | ContainerStyle? | 否 | Column 的样式提示 |
| verticalContentAlignment | VerticalContentAlignment? | 否 | 定义内容如何在列内垂直对齐。当未指定时，verticalContentAlignment 的值从父容器继承，默认为 Top。 |
| width | string, number | 否 | "auto"，"stretch"，表示列组中列的相对宽度的数字，或者像素宽度，如"50px"。 |

### AdaptiveCard

自适应卡片，包含自由格式的卡片元素主体，以及一组可选的操作。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| type | "AdaptiveCard" | 是 | AdaptiveCard 类型 |
| version | string | 是 | 此卡片所需的架构版本。 |
| body | Element[] | 是 | 是要在主卡片区域中显示的卡片元素。 |
| backgroundColor | string | 否 | 为透明图像应用背景。此属性将遵循图像的样式。 |
| lang | string | 否 | 卡片中使用的两字母 ISO-639-1 语言代码。用于对任何日期 / 时间函数进行本地化。 |
| backgroundImage | string | 否 | 指定卡片的背景图像。 |
| rtl | boolean? | 否 | 如果为"true"，此自适应卡片中的内容应从右向左显示。如果为"false"，此自适应卡片中的内容应从左向右显示。如果未设置，则应用平台的默认行为。 |

### Container

容器将 items 分组在一起。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| type | "Container" | 是 | Container 类型 |
| verticalContentAlignment | VerticalContentAlignment? | 否 | 定义内容在容器内的垂直对齐方式。如果未指定，verticalContentAlignment（垂直内容对齐）的值将从父容器继承。如果没有父容器设置了 verticalContentAlignment，则默认为"顶部（Top）"。 |
| spacing | Spacing | 否 | 控制此元素与前一个元素之间的间距大小。 |
| separator | boolean | 否 | 如果为"true"，则在元素顶部绘制一条分隔线。 |
| height | CardElementHeight | 否 | 指定元素的高度。 |
| style | ContainerStyle | 否 | 容器的样式 |
| isVisible | boolean | 否 | 如果为"false"，此项目将从可视化树中移除。 |
| id | string | 否 | 关联的唯一标识符。 |
| requiresDictionary | Dictionary | 否 | 一系列键值对，指示该项目所需的功能以及相应的最低版本。当某个功能缺失或版本不足时，将触发回退机制。 |
| bleed | boolean | 否 | 确定元素是否应穿透其父元素的内边距显示。 |
| minHeight | string | 否 | 以像素为单位指定容器的最小高度，例如"80px"。 |
| rtl | boolean? | 否 | 如果为"true"，此容器中的内容应从右向左显示。如果为"false"，此容器中的内容应从左向右显示。如果未设置，布局方向将从父容器或列继承。如果所有祖先元素都未设置，则应用平台的默认行为。 |
| selectAction | ISelectAction | 否 | 当容器被点击或选中时将调用的操作。不支持"Action.ShowCard"操作。 |

### Image

显示图像。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| type | "Image" | 是 | Image 类型 |
| url | string | 是 | 图像的地址。 |
| altText | string | 否 | 异常加载后的图像的替代文本。 |
| backgroundColor | string | 否 | 为透明图像应用背景。此属性将遵循图像的样式。 |
| size | ImageSize | 否 | 控制图像的大致大小。实际尺寸会因宿主环境而异。 |
| style | ImageStyle | 否 | 控制此图像的显示方式。 |
| width | string | 否 | 图像宽度。 |
| height | string | 否 | 图像高度。 |
| selectAction | ISelectAction | 否 | 当图像被点击或选中时将调用的操作。不支持"Action.ShowCard"操作。 |

### TextBlock

显示文本，允许控制字体大小、粗细和颜色。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| wrap | boolean | 否 | 控制文本是否换行。 |
| maxLines | number | 否 | 要显示的最大行数。 |
| style | "TextBlockStyle" | 否 | 文本的样式。 |

### TextRun

定义格式化文本的单次运行。未设置属性的 TextRun 可以在 json 中表示为字符串，其中包含作为 json 对象的简写的文本。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| italic | boolean | 否 | 控制文本是否应为斜体。 |
| strikethrough | boolean | 否 | 控制是否应删除文本。 |
| highlight | boolean | 否 | 控制是否应突出显示文本。 |
| underline | boolean | 否 | 控制文本是否应加下划线。 |

### Input.Text

允许用户输入文本。

| 属性 | 类型 | 是否必填 | 相关描述 |
| :--- | :--- | :--- | :--- |
| defaultValue | string | 否 | 输入的默认值。 |
| maxLength | boolean | 否 | 输入中文本的最大长度。 |
| isMultiline | boolean | 否 | 控制输入是否允许多行文本。 |
| placeholder | string | 否 | 当用户未输入值时显示为占位符的文本。 |
| style | "InputTextStyle" | 是 | 类型，支持 Text, Tel, Url, Email, Password |
| inlineAction | boolean | 否 | 应以按钮形式显示在输入旁边的操作。不支持 Action.ShowCard。 |
| regex | string | 否 | 用于验证输入的正则表达式。 |

### Action.ToggleVisibility

切换相关卡片元素可见性的操作。相关 json 参考 `/entry/src/main/resources/rawfile/ToggleVisibility.json`。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "Action.ToggleVisibility" | 是 | 必须是"Action.ToggleVisibility" |
| targetElements | TargetElement[] | 是 | TargetElements 的数组。切换显隐的目标 |

### FactSet

FactSet 元素以表格形式显示（即名称/值对）。相关 json 参考 `/entry/src/main/resources/rawfile/FactSet.json`。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "FactSet" | 是 | 必须是"FactSet" |
| targetElements | Fact[] | 是 | Fact 的数组 |

### Fact

FactSet 中的键/值对。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| title | string | 是 | 键 |
| value | string | 是 | 对应键的值 |

### Action.ShowCard

控制某块区域元素的显示。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "Action.ShowCard" | 是 | "Action.ShowCard"类型 |
| card | AdaptiveCard | 否 | 要显示的自适应卡片 |

### Action.Execute

收集输入字段。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "Action.Execute" | 是 | "Action.Execute"类型 |
| verb | string | 否 | 与此作关联的卡片作者定义的动词 |
| data | string | 否 | 输入字段将与之合并的初始数据 |

### Carousel

轮播。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "Carousel" | 是 | "Carousel"类型 |
| initialPage | number | 否 | 初始化显示第几页 |
| loop | boolean | 否 | 是否循环播放 |
| orientation | string | 否 | 横竖显示 |
| heightInPixels | string | 否 | 高度 |
| timer | number | 否 | 轮播切换间隔时长 |

### Table

以表格形式显示数据。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "Table" | 是 | "Table"类型 |
| columns | TableColumnDefinition[] | 否 | 定义表中的列数、列大小等。 |
| rows | TableRow[] | 否 | 定义表的行。 |
| firstRowAsHeader | boolean | 否 | 指定是否应将表格的第一行视为标题行，并由辅助功能软件宣布标题行。 |
| showGridLines | boolean | 否 | 指定是否应显示轴网线。 |
| gridStyle | ContainerStyle? | 否 | 定义网格的样式。此属性当前仅控制网格的颜色。 |
| horizontalCellContentAlignment | HorizontalAlignment? | 否 | 控制默认情况下所有单元格的内容水平对齐方式。如果未指定，则基于每个单元格定义水平对齐。 |
| verticalCellContentAlignment | VerticalAlignment? | 否 | 控制默认情况下所有单元格的内容如何垂直对齐。如果未指定，则基于每个单元格定义垂直对齐。 |

### TableRow

Table 元素中控制行的元素。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "TableRow" | 是 | "TableRow"类型 |
| cells | TableCell[] | 否 | 单元格元素 |
| rowHeight | string | 否 | 行的高度 |

### TableCell

Table 元素的行中的单元格。

| 属性 | 类型 | 是否必填 | 描述 |
| :--- | :--- | :--- | :--- |
| type | "TableCell" | 是 | "TableCell"类型 |
| items | Element[] | 否 | 单元格元素 |

## 接口说明

| 组件 | 类型 | 是否支持 | 相关描述 |
| :--- | :--- | :--- | :--- |
| AdaptiveCard | 组件 | 支持 | 自适应卡片，包含自由格式的卡片元素主体，以及一组可选的操作。 |
| Column | 组件 | 支持 | 定义作为 ColumnSet 一部分的容器。 |
| ColumnSet | 组件 | 支持 | ColumnSet 将一个区域划分为 Columns，允许元素并排放置。 |
| Container | 组件 | 支持 | 容器将 items 分组在一起 |
| TextBlock | 组件 | 支持 | 显示文本，允许控制字体大小、粗细和颜色。 |
| Image | 组件 | 支持 | 显示图像。可接受的格式为 PNG、JPEG 和 GIF。 |
| RichTextBlock | 组件 | 支持 | 定义内联数组，允许内联文本格式。 |
| Input.Text | 组件 | 支持 | 允许用户输入文本。 |
| TextRun | 组件 | 支持 | 定义格式化文本的单次运行。未设置属性的 TextRun 可以在 json 中表示为字符串，其中包含作为 json 对象的简写的文本。 |
| ActionSet | 组件 | 支持 | 显示一组动作，可以放置在卡片中的任何位置。 |
| Action.Submit | 组件 | 支持 | 收集输入值 |
| Action.OpenUrl | 组件 | 支持 | 打开提供的 URL。 |
| Action.ToggleVisibility | 组件 | 支持 | 切换一组元素的可见性。 |
| ImageSet | 组件 | 支持 | 显示类似于画廊的 Images 集合 |
| Media | 组件 | 不支持 | 媒体播放器 |
| FactSet | 组件 | 支持 | 以表格形式显示一系列事实（即名称/值对） |
| Input.Date | 组件 | 不支持 | 选择日期 |
| Input.Time | 组件 | 不支持 | 选择时间 |
| Input.Number | 组件 | 支持 | 输入数字 |
| Input.ChoiceSet | 组件 | 不支持 | 单选框 |
| Input.Toggle | 组件 | 不支持 | 复选框 |
| Action.ShowCard | 方法 | 支持 | 控制某块区域元素的显示 |
| Action.Execute | 方法 | 支持 | 收集输入字段 |
| Carousel | 方法 | 支持 | 轮播展示 |
| Table | 方法 | 支持 | 以表格形式展示 |

## 9.关于混淆

代码混淆，请查看代码混淆简介。

如果希望 adapivecards 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/adapivecards
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: DevEco Studio 5.0.2 Release (5.0.7.210)
- SDK: API14 (5.0.2.123)

## 目录结构

```text
/adapivecards  # 项目根目录
├── entry      # 示例代码文件夹
├── library    # adaptivecards 库文件夹                  
├── README.md  # 安装使用方法                    
```

## 开源协议

MIT LICENSE

## 更新记录

- **1.0.0** (2025-12-03)

## 权限与隐私

- **权限名称**: 暂无
- **权限说明**: 暂无
- **使用目的**: 暂无
- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及

## 兼容性

- **HarmonyOS 版本**: 5.0.2
- **应用类型**: 应用
- **元服务**: 支持
- **设备类型**: 手机、平板、PC
- **DevEco Studio 版本**: DevEco Studio 5.0.2

## 安装方式

```bash
ohpm install @ohos/adaptivecards
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7cc4915601434babb5fbcacfc9e5f862/PLATFORM?origin=template