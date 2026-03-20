# 面包屑组件 UIBreadcrumb

## 简介

UIBreadcrumb 是基于 open harmony 基础组件开发的面包屑组件，支持显示当前的页面路径、自定义显示样式、响应点击事件等功能。

## 详细介绍

### 简介

UIBreadcrumb 是基于 open harmony 基础组件开发的面包屑组件，支持显示当前的页面路径、自定义显示样式、响应点击事件等功能。

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
   ohpm install @hw-agconnect/ui-breadcrumb;
   ```

2. **引入组件**
   ```typescript
   import { UIBreadcrumb } from '@hw-agconnect/ui-breadcrumb';
   ```

3. **调用组件**，详细参数配置说明参见 API 参考。
   ```typescript
   UIBreadcrumb({
     items: [
       { text: '我的文件' },
       { text: 'Documents' },
     ]
   })
   ```

## API 参考

### 子组件

无

### 接口

**UIBreadcrumb(options: UIBreadcrumbOptions)**

面包屑组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIBreadcrumbOptions | 否 | 配置面包屑组件的参数。 |

#### UIBreadcrumbOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| items | BreadcrumbItemOptions[] | 是 | 面包屑导航项的数组，用于定义每个导航项的配置。 |
| itemStyle | BreadcrumbItemStyle | 否 | 面包屑导航项的样式配置。 |
| separatorText | string | 否 | 面包屑导航项之间的分隔符文本，默认为“/”。 |
| separatorColor | ResourceColor | 否 | 分隔符的颜色，默认使用系统预定义颜色 `$r('sys.color.font_secondary')`。 |
| enableClick | boolean | 否 | 是否允许点击面包屑导航项，默认为 true。 |
| customSeparator | CustomBuilder | 否 | 自定义分隔符的插槽，用于实现自定义的分隔符样式。 |
| onChange(index: number) => void | function | 否 | 点击面包屑导航项时触发的事件，返回当前点击项的索引。 |

#### BreadcrumbItemOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| checkedIcon | ResourceStr | 否 | 导航项选中状态下的图标。 |
| uncheckedIcon | ResourceStr | 否 | 导航项未选中状态下的图标。 |
| text | ResourceStr | 否 | 导航项的文本内容。 |

#### BreadcrumbItemStyle 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| iconWidth | Length | 否 | 图标的宽度，默认为 16vp。 |
| iconHeight | Length | 否 | 图标的高度，默认为 16vp。 |
| fontSize | number \| string \| Resource | 否 | 文本的字体大小，默认为 14fp。 |
| checkedFontWeight | number \| FontWeight \| ResourceStr | 否 | 选中状态下文本的字体粗细，默认为 FontWeight.Medium。 |
| checkedFontColor | ResourceColor | 否 | 选中状态下文本的颜色，默认为 `$r('sys.color.font_primary')`。 |
| uncheckedFontWeight | FontWeight | 否 | 未选中状态下文本的字体粗细，默认为 FontWeight.Regular。 |
| uncheckedFontColor | ResourceColor | 否 | 未选中状态下文本的颜色，默认为 `$r('sys.color.font_secondary')`。 |

## 示例代码

### 示例 1（UI 效果示例）

```typescript
import { UIBreadcrumb } from '@hw-agconnect/ui-breadcrumb'

@Entry
@ComponentV2
export struct UIBreadcrumbDemo1 {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 16 }) {
          Column() {
            Text('一般用法').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  { text: '我的文件' },
                  { text: 'Documents' },
                ],
                enableClick: false,
              })
            }
            .containerStyle()
          }

          Column() {
            Text('超长省略').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  { text: '我的文件' },
                  { text: '测试测试测试测试测试测试测试测试' },
                ],
                enableClick: false,
              })
            }
            .containerStyle()
          }

          Column() {
            Text('超限左右滑动').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  { text: '我的文件' },
                  { text: 'Documents' },
                  { text: '测试测试测试测试测试测试测试测试' },
                  { text: '测试测试测试测试测试测试测试测试' },
                ],
                enableClick: false,
              })
                .constraintSize({ maxWidth: 480 })
            }
            .containerStyle()
          }

          Column() {
            Text('自定义分隔符 - 修改文字').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  { text: '我的文件' },
                  { text: 'Documents' },
                ],
                separatorText: '>',
                enableClick: false,
              })
                .constraintSize({ maxWidth: 480 })
            }
            .containerStyle()
          }

          Column() {
            Text('自定义分隔符 - 传入自定义 Builder').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  { text: '我的文件' },
                  { text: 'Documents' },
                ],
                enableClick: false,
                customSeparator,
              })
                .constraintSize({ maxWidth: 480 })
            }
            .containerStyle()
          }

          Column() {
            Text('自定义 icon').titleStyle()
            Row() {
              UIBreadcrumb({
                items: [
                  {
                    text: '我的文件',
                    uncheckedIcon: $r('app.media.startIcon'),
                    checkedIcon: $r('app.media.startIcon'),
                  },
                  {
                    text: 'Documents',
                    uncheckedIcon: $r('app.media.startIcon'),
                    checkedIcon: $r('app.media.startIcon'),
                  },
                ],
                itemStyle: {
                  checkedFontColor: $r('sys.color.font_emphasize'),
                },
                enableClick: false,
              })
                .constraintSize({ maxWidth: 480 })
            }
            .containerStyle()
          }
        }
      }
      .padding({ left: 16, right: 16 })
    }
    .title('面包屑 - UI 效果示例')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}

@Builder
function customSeparator() {
  SymbolGlyph($r('sys.symbol.chevron_right_circle'))
    .fontColor([$r('sys.color.multi_color_07')])
    .margin({ left: 4, right: 4 })
}

@Extend(Text)
function titleStyle() {
  .fontSize(14)
  .fontWeight(FontWeight.Bold)
  .textAlign(TextAlign.Start)
  .margin({ bottom: 8 })
  .width('100%')
}

@Extend(Row)
function containerStyle() {
  .borderRadius(8)
  .backgroundColor($r('sys.color.background_primary'))
  .padding(12)
}
```

### 示例 2（使用场景示例）

```typescript
import { BreadcrumbItemOptions, UIBreadcrumb } from '@hw-agconnect/ui-breadcrumb'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
export struct UIBreadcrumbDemo1 {
  @Local items: BreadcrumbItemOptions[] = [
    { text: '我的文件' },
  ]
  @Local separator: string = '/'
  @Local idx: number = 0

  @Computed
  get displayList(): string[] {
    if (this.idx === 0) {
      return [
        'Documents',
        'Download',
        '图库',
      ]
    }
    if (this.idx === 1) {
      return [
        '测试 1',
        '测试 2',
        '测试 3',
      ]
    }
    return []
  }

  build() {
    NavDestination() {
      Column() {
        UIBreadcrumb({
          items: this.items,
          separatorText: this.separator,
          onChange: (idx) => {
            this.idx = idx;
            this.items = this.items.slice(0, idx + 1)
            try {
              this.getUIContext().getPromptAction().showToast({ message: `回到第${idx + 1}层文件夹` })
            } catch (error) {
              console.error('show toast failed.')
            }
          },
        })

        List({ space: 24 }) {
          ForEach(this.displayList, (item: string) => {
            ListItem() {
              Text(item).width('100%')
            }
            .onClick(() => {
              this.items.push({
                text: item,
              })
              this.idx++;
            })
          })
          if (!this.displayList.length) {
            ListItem() {
              Column() {
                Text('没有文件').fontColor($r('sys.color.font_secondary'))
              }
              .height(200)
              .width('100%')
              .justifyContent(FlexAlign.Center)
            }
          }
        }
        .backgroundColor($r('sys.color.background_primary'))
        .padding(12)
        .borderRadius(16)
        .layoutWeight(1)
        .divider({ strokeWidth: 1 })
        .margin({ top: 16 })
      }
      .padding({ left: 16, right: 16 })
    }
    .title('面包屑 - 使用场景示例')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}
```

## 更新记录

### 1.0.0 (2026-01-27)

- 初始版本

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-breadcrumb
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c70c668521cb456f8feef19c25b6703e/2adce9bbd4cb42d58a87e6add45594b3?origin=template