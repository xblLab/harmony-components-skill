# 搜索组件 search

## 简介

search 是一个搜索页面组件，使用它可以很快速的实现一个带有历史搜索和热门搜索的搜索页面，通过属性可以实现我们常见的搜索样式，而且，历史搜索支持流式布局样式，自带存储功能，搜索组件左右也支持自定义组件形式。

## 详细介绍

### 功能介绍

search 是一个搜索页面模版，使用它可以很快速的实现一个带有历史搜索和热门搜索的搜索页面，通过属性可以实现我们常见的搜索样式。

### 环境要求

- DevEco Studio Build Version: >=5.0.7.200
- Api 版本：>=12
- modelVersion：>=5.0.0

### 快速入门

#### 远程依赖方式使用【推荐】

**方式一**：在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/search
```

**方式二**：在工程的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": {
  "@abner/search": "^1.0.0"
}
```

### 使用样例

```typescript
import { HotBean, SearchLayout } from '@abner/search';

@Entry
@Component
struct Index {
  @State hotList: HotBean[] = []

  aboutToAppear(): void {
    this.hotList.push(new HotBean("程序员一鸣", { bgColor: Color.Red }))
    this.hotList.push(new HotBean("AbnerMing", { bgColor: Color.Orange }))
    this.hotList.push(new HotBean("鸿蒙干货铺", { bgColor: Color.Pink }))
    this.hotList.push(new HotBean("程序员一哥", { bgColor: Color.Gray }))
  }

  build() {
    RelativeContainer() {
      SearchLayout({
        hotList: this.hotList,
        onItemClick: (text: string) => {
          console.log("===条目点击：" + text)
        },
        onSearchAttribute: (attr) => {
          attr.onSubmit = (text) => {
            console.log("===点击搜索：" + text)
          }
        }
      })
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}
```

## 属性介绍

### SearchLayout 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| hotList | HotBean[] | 热门搜索数据 |
| onHistoryItemAttribute | (attribute: HistoryItemAttribute) => void | 历史条目属性，在回调函数中设置 |
| onHotItemAttribute | (attribute: HotItemAttribute) => void | 热门条目属性，在回调函数中设置 |
| onHistoryTagAttribute | (attribute: HistoryTagAttribute) => void | 历史标签属性，在回调函数中设置 |
| onHotTagAttribute | (attribute: HotTagAttribute) => void | 热门标签属性，在回调函数中设置 |
| onSearchAttribute | (attribute: SearchViewAttribute) => void | 搜索属性，在回调函数中设置 |
| historyViewMarginTop | Length | 搜索组件距离顶部的边距 |
| historyViewMarginBottom | Length | 搜索组件距离底部的边距 |
| hotViewMarginTop | Length | 热门组件距离顶部的边距 |
| rootMargin | Padding / Length / LocalizedPadding | 整体的边距 |
| searchLeftView | BuilderParam | 自定义搜索左边的视图 |
| searchRightView | BuilderParam | 自定义搜索右边的视图 |
| onItemClick | (text: string) => void | 历史和热门点击条目回调 |
| searchResultController | SearchResultController | 执行搜索控制 |

### HistoryItemAttribute 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| fontColor | ResourceColor | 字体颜色 |
| fontSize | number / string / Resource | 字体大小 |
| backgroundColor | ResourceColor | 背景颜色 |
| padding | Padding / Length / LocalizedPadding | 内边距 |
| borderRadius | Length / BorderRadiuses / LocalizedBorderRadiuses | 圆角度数 |
| fontWeight | number / FontWeight / string | 字重 |

### HotItemAttribute 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| fontColor | ResourceColor | 字体颜色 |
| fontSize | number / string / Resource | 字体大小 |
| backgroundColor | ResourceColor | 背景颜色 |
| fontWeight | number / FontWeight / string | 字重 |
| labelSize | Length | 标签大小 |
| labelMarginRight | Length | 标签距离右边 |
| columnsTemplate | string | 热门网格列数 |
| rowsGap | Length | 横向间距 |
| labelFontColor | ResourceColor | 标签字体颜色 |
| labelFontSize | number / string / Resource | 标签字体大小 |
| labelFontWeight | number / FontWeight / string | 标签字重 |
| labelPadding | Padding / Length / LocalizedPadding | 标签内边距 |

### HistoryTagAttribute 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| title | string / Resource | 历史 tag 标题 |
| fontColor | ResourceColor | 字体颜色 |
| fontSize | number / string / Resource | 字体大小 |
| fontWeight | number / FontWeight / string | 字重 |
| margin | Margin / Length / LocalizedMargin | 外边距 |
| deleteSrc | PixelMap / ResourceStr / DrawableDescriptor | 删除 icon |
| imageWidth | Length | 图片宽度 |
| imageHeight | Length | 图片高度 |
| height | Length | 整体的高度 |

### HotTagAttribute 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| title | string / Resource | 历史 tag 标题 |
| fontColor | ResourceColor | 字体颜色 |
| fontSize | number / string / Resource | 字体大小 |
| fontWeight | number / FontWeight / string | 字重 |
| margin | Margin / Length / LocalizedMargin | 外边距 |

### SearchViewAttribute 属性

| 属性 | 类型 | 概述 |
|:---|:---|:---|
| placeholder | ResourceStr | 占位字符 |
| placeholderColor | ResourceColor | 设置 placeholder 文本颜色 |
| placeholderFont | Font | 设置 placeholder 文本样式，包括字体大小，字体粗细，字体族，字体风格 |
| value | string | 设置当前显示的搜索文本内容 |
| textFont | Font | 设置搜索框内输入文本样式，包括字体大小，字体粗细，字体族，字体风格 |
| fontColor | ResourceColor | 设置输入文本的字体颜色 |
| textAlign | TextAlign | 设置文本在搜索框中的对齐方式 |
| icon | string | 设置搜索图标路径，默认使用系统搜索图标 |
| copyOption | CopyOptions | 设置输入的文本是否可复制 |
| height | Length | 搜索组件高度 |
| margin | Margin / Length / LocalizedMargin | 搜索组件外边距 |
| searchIcon | IconOptions / SymbolGlyphModifier | 设置左侧搜索图标样式 |
| cancelButton | CancelButtonOptions / CancelButtonSymbolOptions | 设置右侧清除按钮样式 |
| caretStyle | CaretStyle | 设置光标样式 |
| enableKeyboardOnFocus | boolean | 设置 Search 通过点击以外的方式获焦时，是否主动拉起软键盘 |
| selectionMenuHidden | boolean | 设置是否不弹出系统文本选择菜单 |
| type | SearchType | 设置输入框类型 |
| maxLength | number | 设置文本的最大输入字符数 |
| enterKeyType | EnterKeyType | 设置输入法回车键类型 |
| onSubmit | (value: string) => void | 点击搜索 |

## 常见案例

### 单独调用搜索

```typescript
// 声明控制器
searchResultController: SearchResultController = new SearchResultController()

// 设置属性
SearchLayout({
  hotList: this.hotList,
  searchResultController: this.searchResultController,
  onItemClick: (text: string) => {
    console.log("===条目点击：" + text)
  },
  onSearchAttribute: (attr) => {
    // 搜索属性
    attr.onSubmit = (text) => {
      console.log("===点击搜索：" + text)
    }
  }
})

// 调用
this.searchResultController.submit()
```

### 设置数字标签

主要还是设置数据源：

```typescript
this.hotList.push(new HotBean("程序员一鸣", { name: "1" }))
this.hotList.push(new HotBean("AbnerMing", { name: "2" }))
this.hotList.push(new HotBean("鸿蒙干货铺", { name: "3" }))
this.hotList.push(new HotBean("程序员一哥", { name: "4" }))
```

## 示例效果

## API 说明

- Api 版本：>=12

## 配置说明

无配置说明

## 权限要求

无权限要求

## 技术支持

在 Github 中的 Issues 中提问题，定期解答。

## 开源许可协议

```
Copyright (C) AbnerMing, search Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## 更新记录

### 1.0.0 (2025-11-17)

1. 搜索模版组件首次提交
2. 支持历史搜索和热门搜索

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|:---|:---|:---|
| 无权限要求 | 无权限要求 | 无权限要求 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 支持 |
|:---|:---|
| 5.0.0 | ✓ |
| 5.0.1 | ✓ |
| 5.0.2 | ✓ |
| 5.0.3 | ✓ |
| 5.0.4 | ✓ |
| 5.0.5 | ✓ |
| 5.1.0 | ✓ |
| 5.1.1 | ✓ |
| 6.0.0 | ✓ |

### 应用类型

| 类型 | 支持 |
|:---|:---|
| 应用 | ✓ |
| 元服务 | ✓ |

### 设备类型

| 设备 | 支持 |
|:---|:---|
| 手机 | ✓ |
| 平板 | ✓ |
| PC | ✓ |

### DevEco Studio 版本

| 版本 | 支持 |
|:---|:---|
| DevEco Studio 5.0.5 | ✓ |
| DevEco Studio 5.1.0 | ✓ |
| DevEco Studio 5.1.1 | ✓ |
| DevEco Studio 6.0.0 | ✓ |

## 安装方式

```bash
ohpm install @abner/search
```

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b6476ce655fe487dafcdcc56cb2a5c01/b6a17875746941e0b5606c9b1eb174f8?origin=template