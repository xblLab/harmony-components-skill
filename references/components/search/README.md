# 通用搜索组件

## 简介

本组件提供了搜索功能，包括搜索历史，可选的猜你想搜和热搜榜，搜索联想，搜索结果，支持一多适配，平板提供可选的浅层窗口模式。

## 详细介绍

### 简介

本组件提供了搜索功能，包括搜索历史，可选的猜你想搜和热搜榜，搜索联想，搜索结果，支持一多适配，平板提供可选的浅层窗口模式。

### 界面展示

- 直板机折叠屏平板（浅层窗口）
- 搜索入口
- 搜索首页
- 搜索联想
- 搜索结果

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、华为平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- 无

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `search` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 search 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "search",
    "srcPath": "./XXX/search",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "search": "file:./XXX/search"
}
```

### 引入搜索组件句柄

```typescript
import { PresentationType, SearchItem, SearchView, SearchViewController } from 'search';
```

### 调用组件

详细参数配置说明参见 [API 参考](#api-参考)。

## API 参考

### 接口

#### SearchView(options?: SearchOptions)

搜索组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SearchOptions | 是 | 搜索组件参数 |

#### SearchOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| routerStack | NavPathStack | 是 | 当前组件所在路由栈，用于管理导航路径 |
| controller | SearchViewController | 是 | 搜索视图控制器 |
| presentationType | PresentationType | 否 | 非浅层窗口模式下入口页的搜索入口展示形态，默认值为 `PresentationType.SEARCH_ICON` |
| entranceText | string[] | 否 | 非浅层窗口模式下入口页的搜索框的提示文本，将循环展示参数的内容，默认值为 `['Search']`，浅层窗口模式下搜索框的提示文本即为 placeholder 的值 |
| placeholder | string[] | 否 | 搜索框的提示文本，将循环展示参数的内容，默认值为 `['Search']` |
| themeColor | ResourceColor | 否 | 设置主题颜色，默认值为 `'#0A59F7'` |
| showFilterTag | boolean | 否 | 是否显示过滤标签，默认为 `true` |
| showGuessLike | boolean | 否 | 是否显示猜你喜欢，默认为 `true` |
| showHotSearch | boolean | 否 | 是否显示热门搜索，默认为 `true` |
| isShallowWindow | boolean | 否 | 平板设备时是否设置为浅层窗口模式，默认为 `false` |
| tabBarScroller | Scroller | 否 | 搜索标签滚动控制器 |
| searchResultScroller | Scroller | 否 | 搜索结果内容滚动控制器 |
| suggestionItemBuilder | ParamWrappedBuilder<[string, number]> | 否 | 搜索联想项的构建函数，注：wrapBuilder 方法只能传入全局@Builder 方法 |
| guessItemBuilder | ParamWrappedBuilder<[string]> | 否 | 猜你喜欢项的构建函数，注：wrapBuilder 方法只能传入全局@Builder 方法 |
| hotItemBuilder | ParamWrappedBuilder<[SearchItem, number]> | 否 | 热搜榜的构建函数，注：wrapBuilder 方法只能传入全局@Builder 方法 |
| resultItemBuilder | ParamWrappedBuilder<[SearchItem]> | 否 | 搜索结果项的构建函数，注：wrapBuilder 方法只能传入全局@Builder 方法 |
| handleSearch | `(keyWord: string | SearchWordItem | SearchItem, searchSource: SearchSource) => Promise<FilterTagAndList[]>` | 否 | 获取搜索结果，默认值为 `SearchApis.getSearchResultsList` |
| searchSuggestion | `(keyWord: string) => Promise<[SearchWordItem[], string[]]>` | 否 | 获取搜索联想，默认值为 `SearchApis.getSearchSuggestion` |
| onClickGetMore | `() => void` | 否 | 获取热搜榜更多内容 |
| onClickResultItem | `(listItem: SearchItem) => void` | 否 | 处理点击搜索结果项 |
| queryHistoryList | `() => Promise<SearchWordItem[]>` | 否 | 获取历史搜索列表，默认值为 `SearchApis.getHistoryList` |
| deleteHistoryList | `() => Promise<SearchWordItem[]>` | 否 | 获取点击删除后的历史搜索列表，默认值为 `SearchApis.deleteHistoryList` |
| queryGuessList | `() => Promise<SearchWordItem[]>` | 否 | 获取猜你想搜列表，默认值为 `SearchApis.getGuessLikeList` |
| queryHotSearchList | `() => Promise<SearchItem[]>` | 否 | 获取热搜榜列表，默认值为 `SearchApis.getHotSearchList` |

#### SearchViewController 类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| onBackPressed | `() => boolean` | 否 | 返回逻辑函数，侧滑返回触发清空搜索框内容 |
| closePop | `() => void` | 否 | 关闭弹窗函数，在父组件绑定函数可关闭弹窗 |

#### PresentationType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| SEARCH_BOX | 0 | 有提示文本的搜索框 |
| SEARCH_ICON | 1 | 圆形搜索图标，此时 entranceText 参数无效 |

#### SearchWordItem 类型说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| content | string | 是 | 词条内容 |
| id | number \| string | 是 | 词条 id |

#### SearchItem 类型说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| title | string | 是 | 标题 |
| index | string | 否 | 索引 |
| id | number \| string | 否 | id |
| imageResource | Str | 否 | 图片资源 |
| hotRate | number | 否 | 热度评分 |
| intro | string | 否 | 简介 |
| subTitle | string | 否 | 子标题 |
| price | number | 否 | 价格 |
| vipPrice | number | 否 | 会员价 |
| soldNum | number | 否 | 售出数量 |
| type | string | 否 | 类型 |
| classId | string | 否 | 分类 ID |
| subIndex | number | 否 | 辅助标记索引 |

#### SearchSource 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| USER_INPUT | 0 | 用户输入 |
| HISTORY | 1 | 历史搜索 |
| RECOMMEND | 2 | 猜你想搜 |
| HOT_SEARCH | 3 | 热搜榜 |
| SUGGESTION | 4 | 联想词条 |

#### FilterTagAndList 类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| label | string | 是 | 过滤标签 |
| id | string | 是 | id |
| itemList | SearchItem[] | 是 | 是该标签下的搜索结果项列表 |

### SearchApis

搜索功能相关的 API 服务，获取纯端 mock 数据。

- `static getHistoryList(): Promise<SearchWordItem[]>`
  获取搜索历史记录列表。
- `static addHistoryList(historyWord: string, searchId?: number | string): Promise`
  添加搜索记录到历史记录列表中。
- `static deleteHistoryList(): Promise<SearchWordItem[]>`
  清空搜索历史记录列表。
- `static getGuessLikeList(): Promise<SearchWordItem[]>`
  获取推荐搜索列表，列表内容会根据刷新次数交替变化。
- `static getHotSearchList(): Promise<SearchItem[]>`
  获取热门搜索列表。
- `static getSearchResultsList(value: string | SearchWordItem | SearchItem, searchSource: SearchSource): Promise<FilterTagAndList[]>`
  根据搜索内容获取搜索结果列表，仅在搜索关键词为'搜索'时有搜索结果内容。
- `static getSearchSuggestion(value: string): Promise<[SearchWordItem[], string[]]>`
  根据输入内容获取搜索联想列表。
- `static _simulateDelay(data: T, delay: number = 200): Promise`
  模拟网络延迟，返回一个延迟的 Promise。

## 示例代码

```typescript
import { PresentationType, SearchItem, SearchView, SearchViewController } from 'search';

@Entry
@ComponentV2
struct Index {
  @Local navPathStack: NavPathStack = new NavPathStack();
  @Local breakpoint: string = '';
  controller: SearchViewController = new SearchViewController();

  onBackPress(): boolean | void {
    return this.controller.onBackPressed();
  }

  build() {
    Navigation(this.navPathStack) {
      GridRow({ columns: 1 }) {
        GridCol({ span: 1 }) {
          Row() {
            Text('首页').fontSize(26).fontWeight(700).height(40)
            Blank().layoutWeight(1)
            Row({ space: 10 }) {
              SearchView({
                presentationType: this.breakpoint === 'sm' ? PresentationType.SEARCH_ICON : PresentationType.SEARCH_BOX,
                entranceText: ['搜索推荐 1', '搜索推荐 2', '搜索推荐 3'],
                routerStack: this.navPathStack,
                controller: this.controller,
                isShallowWindow: true,
                onClickGetMore: () => {
                  this.getUIContext().getPromptAction().showToast({ message: '前往更多页，暂未开发' })
                },
                onClickResultItem: (listItem: SearchItem) => {
                  this.getUIContext().getPromptAction().showToast({ message: '前往详情页，暂未开发' })
                },
              })
              Button({ type: ButtonType.Circle }) {
                SymbolGlyph($r('sys.symbol.dot_grid_2x2')).fontSize(24)
              }
              .width(40).height(40).backgroundColor($r('sys.color.comp_background_tertiary'))
            }
          }
          .height('100%')
          .width('100%')
          .padding(16)
          .alignItems(VerticalAlign.Top)
          .onClick(() => {
            this.controller.closePop();
          })
        }
      }
      .onBreakpointChange((bp) => {
        this.breakpoint = bp;
      })
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

## 更新记录

| 版本 | 日期 | 备注 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-12-19 | 初始版本 |
| 5.1.0 | - | - |
| 5.1.1 | - | - |
| 6.0.0 | - | - |
| 6.0.1 | - | - |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

- 不涉及

### SDK 合规

- 不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEco Studio 版本 | DevEco Studio 5.0.5、5.1.0、5.1.1、6.0.0、6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e0b7e7068db244baa0304b2ddfcad5d9/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/search1.0.0.zip