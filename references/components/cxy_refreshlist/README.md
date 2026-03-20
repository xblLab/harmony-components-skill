# RefreshList-上拉下拉刷新组件

## 简介

简单易用的上拉下拉刷新组件，支持自定义刷新头部和底部，自定义加载中和空页面组件，全局自定义各种组件。

## 详细介绍

RefreshList 简单易用的上拉下拉刷新组件，支持自定义样式和多种使用场景。

### 特性

- 支持下拉刷新和上拉加载更多
- 支持自定义刷新头部和底部组件
- 支持自定义加载中和空页面组件
- 支持自定义 HeaderView 组件
- 支持分组列表
- 支持全局自定义各种组件
- 完善的 demo 示例

### 安装

#### 通过 ohpm 安装

```bash
ohpm install @cxy/refreshlist
```

#### 通过依赖安装

在项目的 `oh-package.json5` 文件中添加依赖，然后执行同步操作：

```json5
{
  "dependencies": {
    "@cxy/refreshlist": "^1.0.4"
  }
}
```

### Demo - 前往查看示例代码

- [Demo 页面分组示例](#)
- [全局配置示例](#)
- [自定义HeaderView 示例](#)
- [各种自定义示例](#)
- [聊天示例](#)

### 快速开始

```typescript
import { RefreshController, RefreshDataSource, RefreshList } from "@cxy/refreshlist"

// 1 创建数据模型
class ItemModel {
  id: string = ''
  title: string = ''

  constructor(id: string = '', title: string = '') {
    this.id = id
    this.title = title
  }
}

// 2 创建 ViewModel
class SimpleViewModel {
  @Track dataSource: RefreshDataSource = new RefreshDataSource()
  @Track controller: RefreshController = new RefreshController()
  private currentPage: number = 1
  private pageSize: number = 20

  refresh(): void {
    this.requestData(1)
  }

  loadMore(): void {
    this.requestData(this.currentPage + 1)
  }

  private async requestData(page: number): Promise<void> {
    // 模拟网络请求延迟
    setTimeout(() => {
      this.currentPage = page
      const data = this.generateSimpleData(this.pageSize)
      if (page === 1) {
        this.dataSource.deleteAll()
      }
      this.dataSource.pushDataArray(data)

      // 模拟最多 5 页数据
      const hasMore = page < 5
      this.controller.setHasmore(hasMore)
      this.controller.finishRefresh()
    }, 500)
  }

  private generateSimpleData(count: number): ItemModel[] {
    const result: ItemModel[] = []
    for (let i = 0; i < count; i++) {
      const globalIndex = (this.currentPage - 1) * this.pageSize + i
      const item = new ItemModel(`simple_${globalIndex}`, `Title - ${globalIndex + 1}`)
      result.push(item)
    }
    return result
  }
}


// 3 使用组件
@Entry
@Component
struct Index {
  @State viewModel: SimpleViewModel = new SimpleViewModel()

  aboutToAppear() {
    this.viewModel.refresh()
  }

  build() {
    Column() {
      RefreshList({
        dataSource: this.viewModel.dataSource,
        controller: this.viewModel.controller,
        onRefresh: () => this.viewModel.refresh(),
        onLoadMore: () => this.viewModel.loadMore(),
        itemLayout: (item: Object, index: number) => this.itemLayout(item as ItemModel),
        divider: { strokeWidth: 0.5, color: '#f0f0f0' },
        keyGenerator: (item: ItemModel) => item.id
      })
    }
  }

  @Builder
  itemLayout(item: ItemModel): void {
    ListItem() {
      Row() {
        Text(item.title)
          .fontSize(16)
          .fontColor('#333')
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(16)
          .height(16)
          .fillColor('#ccc')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#fff')
    }
    .onClick(()=> {
      console.log(`点击项目：${ item.title}`)
    })
  }
}
```

就是这么简单！三步即可拥有一个功能完整的刷新列表。

### API 文档

#### RefreshList 组件属性

##### 必需属性

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| dataSource | RefreshDataSource \| RefreshGroupDataSource | 数据源，管理列表数据 |
| controller | RefreshController | 控制器，用于控制刷新状态和列表操作 |

##### 布局属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| itemLayout | `(item: Object, index: number) => void` | - | 列表项布局 |
| customLayout | `() => void` | - | 自定义布局，完全自定义 LazyForEach 部分 |
| headerLayout | `() => void` | - | 列表头部布局，类似 iOS 的 tableHeaderView |
| loadingLayout | `() => void` | 默认 | 加载中状态的布局 |
| emptyLayout | `() => void` | 默认 | 空数据状态的布局 |
| refreshHeaderLayout | `() => void` | 默认 | 自定义下拉刷新头部布局 |
| refreshFooterLayout | `() => void` | 默认 | 自定义上拉加载底部布局 |

##### 数据状态属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| refreshHeaderData | RefreshHeaderData | - | 下拉刷新头部数据，用于自定义刷新头部状态 |
| refreshFooterData | RefreshFooterData | - | 上拉加载底部数据，用于自定义加载底部状态 |
| showLoading | boolean | true | 是否显示加载状态 |
| showEmpty | boolean | true | 是否显示空数据状态 |

##### 列表配置属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| cachedCount | number | 4 | 缓存的列表项数量，用于性能优化 |
| showLoadMoreGreaterCount | number | 5 | 当 item 大于多少时，才显示加载更多组件，通常为一屏能显示的 item 数量 |
| contentStartOffset | number | - | 设置内容区域起始偏移量 |
| contentEndOffset | number | - | 设置内容区末尾偏移量 |
| sticky | StickyStyle | StickyStyle.Header \| Footer | 吸顶样式 |
| itemSpace | number | - | 列表项间距 |
| barState | BarState | BarState.On | 滚动条状态 |
| scrollBarColor | Color \| number \| string | - | 滚动条颜色 |
| nestedScroll | NestedScrollOptions | - | 设置前后两个方向的嵌套滚动模式，实现与父组件的滚动联动 |
| enableScrollInteraction | boolean | - | 设置是否支持滚动手势 |
| pullDownRatio | number | - | 设置下拉跟手系数，禁止下拉设置 0 |
| refreshOffset | number | - | 设置触发刷新的下拉偏移量 |
| divider | RefreshListDivider | null | 分割线样式 |
| lanes | number | - | 设置 List 组件的布局列数或行数（网格布局） |
| gutter | Dimension | - | 列间距（网格布局时使用） |
| maintainVisibleContentPosition | boolean | false | 插入或删除数据时是否保持可见内容位置不变 |
| backToTop | boolean | true | 设置滚动组件是否支持点击状态栏回到顶部（API version 15+） |
| edgeEffect | EdgeEffect | - | List 的 EdgeEffect 效果 |
| listAttrModifier | RefreshListAttrModifier | - | 用于自定义更多 List 属性 |

##### 回调函数

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| onRefresh | `() => void` | 下拉刷新时的回调函数 |
| onLoadMore | `() => void` | 上拉加载更多时的回调函数 |
| keyGenerator | `(item: ESObject, index: number) => string` | 列表项唯一标识生成器 |
| onDidScroll | OnScrollCallback | 滚动时的回调函数 |
| onReachEnd | `() => void` | 滚动到底部时的回调函数 |
| onScrollIndex | `(start: number, end: number) => void` | 滚动到索引时的回调函数，可用于实现无感知预加载 |

##### 滚动控制器

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| scroller | ListScroller | 列表滚动控制器，可用于获取滚动位置等信息和控制滚动 |

#### RefreshController 控制器

RefreshController 提供了控制刷新列表的各种方法：

##### 属性

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| scroller | ListScroller | 列表滚动控制器，可用于获取滚动位置等信息和控制滚动 |

##### 方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| finishRefresh | - | void | 结束刷新状态，必须在刷新完成后调用 |
| setHasmore | `(hasmore: boolean)` | void | 设置是否还有更多数据可加载 |
| hideLoadMore | `(hide: boolean)` | void | 隐藏或显示加载更多组件 |
| onRefresh | - | void | 手动触发下拉刷新 |
| scrollToIndex | `(index: number, smooth?: boolean, align?: ScrollAlign, options?: ScrollToIndexOptions)` | void | 滚动到指定索引位置 |

##### 内部回调属性（由组件自动设置）

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| setHasmore | `(hasmore: boolean) => void` | 设置是否还有更多数据 |
| onRefresh | `() => void` | 刷新回调 |
| finishRefresh | `() => void` | 完成刷新回调 |
| hideLoadMore | `(hide: boolean) => void` | 隐藏加载更多回调 |
| scrollToIndex | `(value: number, smooth?: boolean, align?: ScrollAlign, options?: ScrollToIndexOptions) => void` | 滚动到指定索引回调 |

#### 使用示例

```typescript
export class SimpleViewModel {
  controller: RefreshController = new RefreshController()

  refresh(): void {
    // 模拟网络请求
    setTimeout(() => {
      // 处理数据...

      // 设置是否还有更多数据
      this.controller.setHasmore(hasMore)

      // 必须调用 finishRefresh 结束刷新状态
      this.controller.finishRefresh()

    }, 1000)
  }

  // 手动触发刷新
  manualRefresh(): void {
    this.controller.onRefresh()
  }

  // 滚动到顶部
  scrollToTop(): void {
    this.controller.scrollToIndex(0, true)
  }

  // 获取当前滚动位置
  getCurrentOffset(): number {
    return this.controller.scroller.currentOffset().yOffset
  }
}
```

#### RefreshDataSource 数据源

RefreshDataSource 是管理列表数据的核心类，实现了 IDataSource 接口：

##### 基础方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| isEmpty | - | boolean | 判断数据源是否为空 |
| totalCount | - | number | 获取数据总数 (分组时，为分组数量) |
| totalItemCount | - | number | 获取数据项总数（分组时，为分组下 item 总数） |
| getData | `(index: number)` | Object \| undefined | 获取指定索引的数据 |
| getLastData | - | Object \| undefined | 获取最后一项数据 |
| getDataAll | - | Object[] | 获取所有数据的副本 |

##### 数据操作方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| insertData | `(index: number, data: Object)` | void | 在指定位置插入单个数据 |
| insertDataArray | `(index: number, arr: Object[])` | void | 在指定位置插入数据数组 |
| pushData | `(data: Object)` | void | 在末尾添加单个数据 |
| pushDataArray | `(arr: Object[])` | void | 在末尾添加数据数组 |
| deleteIndex | `(index: number)` | void | 删除指定索引的数据 |
| deleteData | `(data: Object)` | void | 删除指定数据对象 |
| deleteAll | - | void | 删除所有数据 |
| deleteIndexCount | `(index: number, count: number)` | void | 从指定索引开始删除指定数量的数据 |
| repalceIndex | `(index: number, data: Object, key?: string)` | void | 替换指定索引的数据 |
| reloadIndex | `(index: number, key?: string)` | void | 重新加载指定索引的数据 |
| reloadData | `(data: Object, key?: string)` | void | 重新加载指定数据对象 |
| reloadDataAll | - | void | 重新加载所有数据 |
| moveDataIndex | `(from: number, to: number)` | void | 移动数据从一个位置到另一个位置 |

##### 监听器方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| registerDataChangeListener | `(listener: DataChangeListener)` | void | 注册数据变化监听器 |
| unregisterDataChangeListener | `(listener: DataChangeListener)` | void | 取消注册数据变化监听器 |

##### 回调属性

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| onDataCountChange | `(count: number) => void` | 数据数量变化时的回调 |

#### RefreshGroupDataSource 分组数据源

RefreshGroupDataSource 继承自 RefreshDataSource，专门用于管理分组列表数据：

##### 重写方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| isEmpty | - | boolean | 判断分组数据源是否为空 |
| totalItemCount | - | number | 计算所有分组中的数据项总数 |
| getGroupDataAll | - | Object[] | 获取所有分组中的数据项 |

##### 分组特有方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| addListToGroup | `(list: Object[], getTitle: (e: Object) => string)` | void | 将数据列表按标题分组添加 |

##### 使用示例

```typescript
// 基础数据源使用
export class SimpleViewModel {
  dataSource: RefreshDataSource = new RefreshDataSource()

  refresh(): void {
    // 清空现有数据
    this.dataSource.deleteAll()

    // 添加新数据
    const newData = this.generateData()
    this.dataSource.pushDataArray(newData)
  }

  addItem(item: ItemModel): void {
    this.dataSource.pushData(item)
  }

  removeItem(item: ItemModel): void {
    this.dataSource.deleteData(item)
  }

  updateItem(index: number, newItem: ItemModel): void {
    this.dataSource.repalceIndex(index, newItem)
  }
}

// 分组数据源使用
export class GroupViewModel {
  dataSource: RefreshGroupDataSource = new RefreshGroupDataSource()

  refresh(): void {
    this.dataSource.deleteAll()

    const allItems = this.generateData()
    // 按 category 字段自动分组
    this.dataSource.addListToGroup(allItems, (item) => item.category)
  }
}
```

#### RefreshGroupModel 分组模型

分组数据的模型类：

##### 属性

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| title | string | 分组标题 |
| dataSource | RefreshDataSource | 分组内的数据源 |
| data | Object | 可选的附加数据 |

##### 构造函数

```typescript
constructor(title:string, dataSource:RefreshDataSource)
```

#### RefreshHeaderData 刷新头部数据

下拉刷新头部的状态数据：

##### 属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| state | RefreshStatus | RefreshStatus.Inactive | 刷新状态（Inactive、Drag、OverDrag、Refresh、Done） |
| offset | number | 0 | 下拉偏移量 |
| dragTextResourceStr | ResourceStr | '下拉刷新' | 下拉时显示的文本 |
| overDragTextResourceStr | ResourceStr | '释放刷新' | 超过阈值时显示的文本 |
| refreshTextResourceStr | ResourceStr | '刷新中...' | 刷新中显示的文本 |
| doneTextResourceStr | ResourceStr | '刷新完成' | 刷新完成显示的文本 |
| textColorResource | Color | '#bbb' | 文本颜色 |
| font | Font | { size: 13 } | 文本字体 |
| loadingColorResource | Color \| LinearGradient | - | loading 颜色 |
| loadingSize | SizeOptions | { width: 20, height: 20 } | loading 大小 |

##### 方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getText | - | ResourceStr | 根据当前状态返回对应的文本 |

#### RefreshFooterData 刷新底部数据

上拉加载更多底部的状态数据：

##### 属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| isShow | boolean | true | 是否显示底部组件 |
| state | RefreshFooterState | RefreshFooterState.None | 加载状态 |
| noneTextResourceStr | ResourceStr | '上拉加载更多' | 默认状态显示的文本 |
| loadingTextResourceStr | ResourceStr | '加载中...' | 加载中显示的文本 |
| noMoreTextResourceStr | ResourceStr | '没有更多了' | 没有更多数据时显示的文本 |
| textColorResource | Color | '#bbb' | 文本颜色 |
| font | Font | { size: 13 } | 文本字体 |
| loadingColorResource | Color | '#bbb' | loading 颜色 |
| loadingSize | SizeOptions | { width: 20, height: 20 } | loading 大小 |

##### 方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getText | - | ResourceStr | 根据当前状态返回对应的文本 |

#### RefreshFooterState 枚举

加载更多的状态枚举：

| 值 | 数值 | 说明 |
| :--- | :--- | :--- |
| None | 0 | 默认状态 |
| Loading | 1 | 正在加载中 |
| NoMore | 2 | 没有更多数据 |

#### RefreshGlobalConfig 全局配置

全局配置类，用于设置所有 RefreshList 组件的默认样式和行为：

##### 静态属性

| 属性 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| headerBuilder | WrappedBuilder<[IRefreshHeaderData]> | - | 全局自定义刷新头部构建器 |
| footerBuilder | WrappedBuilder<[IRefreshFooterData]> | - | 全局自定义刷新底部构建器 |
| loadingBuilder | WrappedBuilder<[]> | - | 全局自定义加载构建器 |
| emptyBuilder | WrappedBuilder<[]> | - | 全局自定义空状态构建器 |
| headerInactiveTextResourceStr | ResourceStr | '刷新' | 头部非活动状态文本 |
| headerDragTextResourceStr | ResourceStr | '下拉刷新' | 头部下拉状态文本 |
| headerOverDragTextResourceStr | ResourceStr | '释放刷新' | 头部超过阈值状态文本 |
| headerRefreshTextResourceStr | ResourceStr | '刷新中...' | 头部刷新中状态文本 |
| headerDoneTextResourceStr | ResourceStr | '刷新完成' | 头部刷新完成状态文本 |
| footerNoneTextResourceStr | ResourceStr | '上拉加载更多' | 底部默认状态文本 |
| footerLoadingTextResourceStr | ResourceStr | '加载中...' | 底部加载中状态文本 |
| footerNoMoreTextResourceStr | ResourceStr | '没有更多了' | 底部没有更多数据状态文本 |
| headerTextColorResource | Color | '#bbb' | 头部文本颜色 |
| footerTextColorResource | Color | '#bbb' | 底部文本颜色 |
| headerTextFont | Font | { size: 13 } | 头部文本字体 |
| footerTextFont | Font | { size: 13 } | 底部文本字体 |
| headerLoadingColorResource | Color \| LinearGradient | - | 头部 loading 颜色 |
| footerLoadingColorResource | Color | '#bbb' | 底部 loading 颜色 |
| headerLoadingSize | SizeOptions | { width: 20, height: 20 } | 头部 loading 大小 |
| footerLoadingSize | SizeOptions | { width: 20, height: 20 } | 底部 loading 大小 |
| refreshOffset | number | - | 设置触发刷新的下拉偏移量 |
| pullDownRatio | number | - | 设置下拉跟手系数，有效值为 0-1 之间的值 |

##### 使用示例

```typescript
import { RefreshGlobalConfig, IRefreshHeaderData, RefreshStatus } from '@cxy/refreshlist'

// 全局自定义刷新头部
@Builder
function globalHeaderBuilder(item: IRefreshHeaderData) {
  GlobalHeader({ data: item.data })
}

// 配置全局设置
function setupGlobalConfig() {
  RefreshGlobalConfig.headerBuilder = wrapBuilder(globalHeaderBuilder)
  RefreshGlobalConfig.headerDragText = '下拉刷新数据'
  RefreshGlobalConfig.headerOverDragText = '释放立即刷新'
  RefreshGlobalConfig.headerRefreshText = '正在刷新数据...'
  RefreshGlobalConfig.headerDoneText = '刷新成功'
  RefreshGlobalConfig.footerNoneText = '上拉加载更多'
  RefreshGlobalConfig.footerLoadingText = '数据加载中...'
  RefreshGlobalConfig.footerNoMoreText = '亲，没有更多了'
  RefreshGlobalConfig.headerTextColor = '#333'
  RefreshGlobalConfig.footerTextColor = '#666'
}

// 在应用启动时调用
setupGlobalConfig()
```

#### IRefreshHeaderData 接口

刷新头部数据接口：

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| data | RefreshHeaderData | 刷新头部状态数据 |

#### IRefreshFooterData 接口

刷新底部数据接口：

| 属性 | 类型 | 说明 |
| :--- | :--- | :--- |
| data | RefreshFooterData | 刷新底部状态数据 |

#### RefreshListDivider 分割线接口

自定义分割线样式的接口：

| 属性 | 类型 | 必需 | 说明 |
| :--- | :--- | :--- | :--- |
| strokeWidth | Length | 是 | 分割线宽度 |
| color | ResourceColor | 否 | 分割线颜色 |
| startMargin | Length | 否 | 起始边距 |
| endMargin | Length | 否 | 结束边距 |

#### RefreshListAttrModifier 属性修饰器

用于自定义更多 List 属性的修饰器类：

```typescript
export class RefreshListAttrModifier implements AttributeModifier<ListAttribute> {
  applyNormalAttribute(instance: ListAttribute): void {
    // 在这里可以自定义更多 List 属性
    // 例如：背景色、边框、阴影等
  }
}

// 使用示例
class CustomAttrModifier extends RefreshListAttrModifier {
  applyNormalAttribute(instance: ListAttribute): void {
    instance.backgroundColor('#f5f5f5')
    instance.borderRadius(10)
    instance.padding(10)
  }
}
```

## 常见问题

### Q: 如何禁用下拉刷新？

```typescript
// 方法 1：不传 onRefresh 回调
RefreshList({
  // ... 其他属性
})

// 方法 2：设置 pullDownRatio 为 0
RefreshList({
  pullDownRatio: 0,
  // ... 其他属性
})
```

### Q: 如何禁用上拉加载更多？

```typescript
// 方法 1：不传 onLoadMore 回调（推荐）
RefreshList({
  onRefresh: () => this.refresh(),
  // 不传 onLoadMore 即可禁用上拉加载
})

// 方法 2：动态控制显示/隐藏
this.controller.hideLoadMore(true) // 隐藏加载更多
this.controller.setHasmore(false) // 设置没有更多数据
```

### Q: 如何监听列表滚动事件？

```typescript
RefreshList({
  onDidScroll: (scrollOffset: number, scrollState: ScrollState) => {
    console.log(`滚动偏移：${scrollOffset}`)
    // 可以根据滚动位置实现悬浮按钮显示/隐藏等功能
  },
  onScrollIndex: (start: number, end: number) => {
    console.log(`当前可见范围：${start} - ${end}`)
    // 可以用于埋点统计、预加载等
  },
  onReachEnd: () => {
    console.log('滚动到底部')
    // 可以用于触发加载更多数据
  }
})
```

## 更新记录

### 1.0.4 (2025-11-24)

- 优化使用文档权限与隐私基本信息

#### 权限名称

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

- 不涉及 SDK 合规使用指南
- 不涉及

#### 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

#### 应用类型

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

#### 设备类型

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

#### DevEcoStudio 版本

| DevEco Studio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @cxy/refreshlist
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c3f5dea8c981409e87a410a3a8ccb946/b729f6f7599f4f11ba126e875b209273?origin=template