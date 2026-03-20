# refresh v2 装饰器刷新组件

## 简介

refresh v2 是一款 V2 装饰器刷新组件，支持简单、高效的上拉下拉刷新组件，支持列表、网格、瀑布流，支持各种任意组件刷新，支持侧滑删除、条目吸顶、下滑二楼等功能。

## 详细介绍

介绍
refresh_v2，是一款支持 V2 装饰器，简单、高效的上拉下拉刷新组件，支持列表、网格、瀑布流，支持各种任意组件刷新，支持侧滑删除、条目吸顶、下滑二楼等功能。
v1 和 V2 使用方式完全一样，大家可无缝切换，只需修改下依赖和导包即可。
如果您只想简单的下拉刷新和上拉加载，并且耦合度低，建议您使用我的另一款轻盈的刷新组件。

主要功能点如下：

1. 支持 ListView 列表/下拉刷新/上拉加载
2. 支持 GridView 网格列表/下拉刷新/上拉加载
3. 支持 StaggeredGridView 瀑布流列表/下拉刷新/上拉加载
4. 支持自定义刷新头和加载尾
5. 支持列表 (ListView/GridView/StaggeredGridView) 添加头组件
6. 支持列表 (ListView) 侧滑展示按钮，左右均可
7. 支持下滑进入二楼/半楼功能（仿京东或淘宝）
8. 数据操作（增删改查）提供便捷方式，适应更多场景运用
9. 支持页面刷新加载吸顶效果 (ListView/GridView/StaggeredGridView)
10. 支持默认进入页面自动刷新/手动刷新
11. 支持内部缺省页设置（空布局/错误布局）
12. 支持 ListView 条目分组吸顶效果
13. 默认刷新头支持三个点旋转效果
14. ListView 支持滑动直接删除

## 效果

### 所有功能

### 刷新效果

### 列表自定义头部效果

### 列表侧滑展示按钮效果

### 吸顶效果

### 动态效果

## 开发环境

- DevEco Studio NEXT Developer Beta1, Build Version: 5.1.1.823
- Api 版本：**>=12**
- modelVersion：5.0.0

## 快速使用

有多种使用方式，比如远程依赖、本地静态共享包依赖，源码方式依赖，推荐使用远程依赖，方便快捷，有最新修改可以及时生效。

### 远程依赖方式使用

#### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/refresh_v2
```

#### 方式二

在工程的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/refresh_v2": "^1.0.4"}
```

### 查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个 oh_modules 文件，并创建源代码文件，有则成功，无则失败，如下：

## 代码使用

目前提供了多种种用法，一种是 ListView 形式，就是单列表形式，一种是 GridView 形式，也就是网格列表形式，一种是 StaggeredGridView 形式，也就是瀑布流形式，还有一种就是 RefreshLayout 形式，支持任何的组件形式，比如 Column，Row 等等。

需要注意，目前 ListView、GridView、StaggeredGridView 是自带刷新的，当然了您也可以当作普通的列表进行使用。
还有一点需要注意，目前默认情况下是懒加载数据模式。
需要注意：默认列表是没有高度的，如果你要实现定位或者获取滑动位置，必须要设置高度，100% 或者其它，目前上拉加载是带有缩回的，如果
你要直接加载数据，请设置 slideDisplayLoadData 为 true，关于禁止阻尼效果，isScrollSpring 为 false 即可。

### 1、ListView

#### 1、懒加载数据使用（LazyForEach）

默认情况下既是，目的是进行组件销毁回收以降低内存占用，提高性能，当然了也是推荐使用，相对于普通使用，需要使用 RefreshDataSource 进行数据的增删改查！

```typescript
controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量
dataSource: RefreshDataSource = new RefreshDataSource() //数据懒加载操作对象，执行数据增删改查

ListView({
  lazyDataSource: this.dataSource,
  itemLayout: (item, index) => this.itemLayout(item, index), //条目布局
  controller: this.controller, //控制器，负责关闭下拉和上拉
  onRefresh: () => {
    //下拉刷新
    //数据懒加载使用：
    //0、数据初始化，this.dataSource.initData()
    // 1、数组数据添加，this.dataSource.pushDataArray()，
    // 2、单个数据添加，this.dataSource.pushData()
    this.controller.finishRefresh() //关闭下拉刷新，在数据请求回后进行关闭
  },
  onLoadMore: () => {
    //上拉加载
    //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
    this.controller.finishLoadMore() //关闭上拉加载，在数据请求回后进行关闭
  }
})
/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 2、普通使用（ForEach）

普通使用正常的数据加载即可，只需关注数据源。

```typescript
controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量

ListView({
  items: this.array, //数据源 数组，任意类型
  itemLayout: (item, index) => this.itemLayout(item, index),
  controller: this.controller, //控制器，负责关闭下拉和上拉
  isLazyData: false, //禁止懒加载，也就是使用 ForEach 进行数据加载
  onRefresh: () => {
    //下拉刷新
    this.controller.finishRefresh();
  },
  onLoadMore: () => {
    //上拉加载
    this.controller.finishLoadMore();
  }
})

/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder 
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 3、相关属性介绍

##### 属性类型概述

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| items | Array<Object> | 数据源 |
| itemLayout | @BuilderParam (item: Object, index: number) | 传递的布局 |
| controller | RefreshController | 控制器，关闭下拉和上拉 |
| onRefresh | Callback | 回调刷新回调 |
| onLoadMore | Callback | 回调上拉加载 |
| listAttribute | ListAttr | ListView 的相关属性 |
| listItemAttribute | ListItemAttr | ListView 的 Item 相关属性 |
| isLazyData | boolean | 是否使用懒加载，默认是懒加载 |
| lazyCachedCount | number | 懒加载缓存数据量，默认为 1 |
| onLazyDataSource | Callback | 回调懒加载数据回调 |
| lazyDataSource | RefreshDataSource | 懒加载数据操作对象 |
| itemHeaderLayout | @BuilderParam | 传递的头部组件 |
| itemFooterLayout | @BuilderParam | 传递的尾部组件 |
| headerRefreshLayout | @BuilderParam | 自定义刷新头组件 |
| footerLoadLayout | @BuilderParam | 自定义加载尾组件 |
| refreshHeaderAttribute | RefreshHeaderAttr | 默认的刷新头属性 |
| loadMoreFooterAttribute | LoadMoreFooterAttr | 默认的加载尾属性 |
| slideRightMenuLayout | @BuilderParam (index: number) | 右侧侧滑展示的 View |
| slideMenuAttr | Callback (attribute: SlideMenuAttr) | 右侧侧滑属性 |
| enableRefresh | boolean | 是否禁止刷新，也可以通过 onRefresh 进行控制，onRefresh 有代表需要刷新 |
| enableLoadMore | boolean | 是否禁止上拉加载，也可以通过 onLoadMore 进行控制，onLoadMore 有代表需要上拉加载 |
| initialIndex | number | 设置当前 List 初次加载时视口起始位置显示的 item 的索引值。 |
| scroller | Scroller | 可滚动组件的控制器。用于与可滚动组件进行绑定。 |
| emptyLayout | @BuilderParam | 空布局 |
| errorLayout | @BuilderParam | 错误布局 |
| loadingLayout | @BuilderParam | 加载布局 |
| showEmptyLayout | boolean | 是否显示空 |
| showErrorLayout | boolean | 是否显示错误 |
| showLoadingLayout | boolean | 是否显示加载布局 |

##### RefreshController

| 参数 | 类型 | 概述 |
| :--- | :--- | :--- |
| finishRefresh | 无参 | 关闭下拉刷新 |
| finishLoadMore | Nothing: boolean | 关闭上拉加载，参数默认为 false，为 true 则为无数据展示 |
| autoRefresh | isAutoRefresh: boolean | 自动刷新，默认为 true |
| markStartLocation | start: boolean | 标记开始位置 |
| markEndLocation | isEnd: boolean | 标记结束位置 |
| getRefreshLayoutStatus | 无参 | 获取下拉刷新状态 |
| getLoadMoreLayoutStatus | 无参 | 获取上拉加载状态 |
| scrollToIndex | value: number | 滑动到某一个位置 |
| scrollEdge | value: Edge | 滚动到容器边缘 |

##### RefreshDataSource

数据懒加载操作对象，当使用数据懒加载时，必须通过此对象进行操作数据，否则无法生效！
懒加载数据的增删改查，必须实现属性：onLazyDataSource

```typescript
//第一种方式，直接设置
lazyDataSource: this.lazyDataSource
//第二种方式，需要设置 items 对象
onLazyDataSource: (dataSource: RefreshDataSource) => {
  this.dataSource = dataSource
}
```

###### 方法类型概述

| 方法 | 类型 | 概述 |
| :--- | :--- | :--- |
| initData | (items: Array) | 初始化数据 |
| pushData | (item: Object ) | 可传递任意类型，用于添加单条数据 |
| pushDataPosition | (position: number, item: Object) | 指定位置添加数据 |
| pushDataVariable | (...items: Object[]) | 添加可变参数数据 |
| pushDataArray | (items: Object[]) | 添加数组 |
| deleteFirst | 无参 | 删除第一条数据 |
| deleteLast | 无参 | 删除最后一条数据 |
| deleteData | (position: number) | 删除一条数据 |
| deleteAll | 回调接口参数可选 | 删除全部数据 |
| changeData | (position: number, item: Object) | 修改数据 |
| getDataAll | 无参 | 返回所有的数据 （返回值 Object[]） |
| getData | (index: number) | 返回某一条数据 |
| totalCount | 无参 | 返回数据数量（返回值 number） |
| reloadData | 无参 | 重置所有子组件的 index 索引 |
| moveData | (from: number, to: number) | 交换数据 |
| changeData | (index: number, data: Object) | 改变单个数据 |

##### ListAttr

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 宽度 |
| height | Length | 高度 |
| backgroundColor | ResourceColor | 背景颜色，默认透明 |
| listDirection | Axis | 设置 List 组件排列方向。默认值：Axis.Vertical |
| divider | 对象 | 设置 ListItem 分割线样式，默认无分割线。 |
| scrollBar | BarState | 设置滚动条状态 |
| cachedCount | number | 设置列表中 ListItem/ListItemGroup 的预加载数量 |
| edgeEffect | EdgeEffect | 设置组件的滑动效果，刷新加载效果下不支持 |
| scrollSpringHeight | number | 实现弹性物理动效，以设置最大高度为基准 |

##### ListItemAttr

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 宽度 |
| height | Length | 高度 |
| backgroundColor | ResourceColor | 背景颜色，默认透明 |
| onClick | Callback | 点击事件 |

##### RefreshHeaderAttr

默认的刷新头属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 刷新控件的宽度 |
| height | Length | 刷新头的高度 默认高度 80 |
| timeFormat | RefreshHeaderTimeFormat | 刷新头的时间格式，默认月日时分 |
| timeLabel | RefreshHeaderTimeLabel | 刷新头的标签格式 |
| hideTime | boolean | 是否隐藏刷新头时间，默认展示 |
| fontSize | number / string / Resource | 刷新头的文字大小 |
| fontColor | ResourceColor | 刷新头的文字颜色 |
| timeFontSize | number / string / Resource | 刷新头的时间文字大小 |
| timeFontColor | ResourceColor | 刷新头的时间文字颜色 |
| marginIconLeft | Length | 刷新文字距离左边的距离 |
| iconDown | PixelMap/ResourceStr/DrawableDescriptor | 刷新的下拉箭头 |
| iconUpLoad | PixelMap / ResourceStr/DrawableDescriptor | 下拉刷新 icon |
| pullingText | string /Resource | 下拉可以刷新文本 |
| releaseText | string /Resource | 释放立即刷新文本 |
| refreshingText | string /Resource | 正在刷新中文本 |
| finishText | string /Resource | 刷新结束文本 |
| backgroundColor | ResourceColor | 刷新头背景颜色 |
| headerType | RefreshHeaderType | 默认刷新头样式，默认是 RefreshHeaderType.DEFAULT |
| iconWidth | Length | 下拉和 Loading 的宽度 |
| iconHeight | Length | 下拉和 Loading 的高度 |

##### LoadMoreFooterAttr

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 控件的宽度 |
| height | Length | 高度 |
| backgroundColor | ResourceColor | 尾部背景颜色 |
| loadingSrc | PixelMap/ResourceStr/DrawableDescriptor | 加载资源 |
| loadingIconWidth | Length | Loading 的宽度 |
| loadingIconHeight | Length | Loading 的高度 |
| loadingMarginRight | Length | 距离右边文字的距离 |
| fontColor | ResourceColor | 文字颜色 |
| fontSize | number / string / Resource | 文字大小 |
| fontWeight | number / FontWeight/ string | 文字权重 |
| fontFamily | string / Resource | 字体 |
| footerPullingText | string / Resource | 下拉提示 |
| footerReleaseText | string / Resource | 释放提示 |
| footerLoadingText | string / Resource | 加载提示 |
| footerFinishText | string / Resource | 完成提示 |
| footerNothingText | string / Resource | 无数据 |

##### RefreshHeaderTimeFormat

```typescript
YMDHMS, //年月日时分秒 2024-04-08 08:08:08
MDHMS, //月日时分秒 04-08 08:08:08
MDHM, //月日时分秒 04-08 08:08
HMS //时分秒 08:08:08
```

##### RefreshHeaderTimeLabel

```typescript
BACKSLASH, //反斜杠 / 2024/04/08 08:08:08
SHORTLINE, //短线 -  2024-04-08 08:08:08
CHARACTERS //文字 年月日 2024 年 04 月 08 日 08 时 08 分 08 秒
```

### 2、GridView【网格】

#### 1、懒加载数据使用（LazyForEach）

默认情况下既是，目的是进行组件销毁回收以降低内存占用，提高性能，当然了也是推荐使用，相对于普通使用，需要使用 RefreshDataSource 进行数据的增删改查！

```typescript
controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量
dataSource: RefreshDataSource = new RefreshDataSource() //数据懒加载操作对象，执行数据增删改查

GridView({
  lazyDataSource: this.dataSource,
  itemLayout: (item, index) => this.itemLayout(item, index), //条目布局
  controller: this.controller, //控制器，负责关闭下拉和上拉
  onRefresh: () => {
    //下拉刷新
    //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
    this.controller.finishRefresh() //关闭下拉刷新，在数据请求回后进行关闭
  },
  onLoadMore: () => {
    //上拉加载
    //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
    this.controller.finishLoadMore() //关闭上拉加载，在数据请求回后进行关闭
  }
})
/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 2、普通使用（ForEach）

普通使用正常的数据加载即可，只需关注数据源。

```typescript
@Local controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量

GridView({
  items: this.array, //数据源 数组，任意类型
  itemLayout: (item, index) => this.itemLayout(item, index),
  controller: this.controller, //控制器，负责关闭下拉和上拉
  isLazyData: false, //禁止懒加载，也就是使用 ForEach 进行数据加载
  onRefresh: () => {
    //下拉刷新
    this.controller.finishRefresh();
  },
  onLoadMore: () => {
    //上拉加载
    this.controller.finishLoadMore();
  }
})

/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 3、相关属性介绍

##### 属性类型概述

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| items | Array<Object> | 数据源 |
| itemLayout | @BuilderParam (item: Object, index: number) | 传递的布局 |
| controller | RefreshController | 控制器，关闭下拉和上拉 |
| onRefresh | Callback | 回调刷新回调 |
| onLoadMore | Callback | 回调上拉加载 |
| gridAttribute | GridAttr | GridView 相关属性 |
| gridItemAttribute | GridItemAttr | GridView 的 Item 相关属性 |
| isLazyData | boolean | 是否使用懒加载，默认是懒加载 |
| lazyCachedCount | number | 懒加载缓存数据量，默认为 1 |
| onLazyDataSource | Callback | 回调懒加载数据回调 |
| lazyDataSource | RefreshDataSource | 懒加载数据操作对象 |
| itemHeaderLayout | @BuilderParam | 传递的头组件 |
| headerRefreshLayout | @BuilderParam | 自定义刷新头组件 |
| footerLoadLayout | @BuilderParam | 自定义加载尾组件 |
| refreshHeaderAttribute | RefreshHeaderAttr | 默认的刷新头属性 |
| loadMoreFooterAttribute | LoadMoreFooterAttr | 默认的加载尾属性 |
| enableRefresh | boolean | 是否禁止刷新，也可以通过 onRefresh 进行控制，onRefresh 有代表需要刷新 |
| enableLoadMore | boolean | 是否禁止上拉加载，也可以通过 onLoadMore 进行控制，onLoadMore 有代表需要上拉加载 |
| scroller | Scroller | 可滚动组件的控制器。用于与可滚动组件进行绑定。 |
| emptyLayout | @BuilderParam | 空布局 |
| errorLayout | @BuilderParam | 错误布局 |
| showEmptyLayout | boolean | 是否显示空 |
| showErrorLayout | boolean | 是否显示错误 |

##### RefreshController

| 参数 | 类型 | 概述 |
| :--- | :--- | :--- |
| finishRefresh | 无参 | 关闭下拉刷新 |
| finishLoadMore | Nothing: boolean | 关闭上拉加载，参数默认为 false，为 true 则为无数据展示 |
| autoRefresh | isAutoRefresh: boolean | 自动刷新，默认为 true |
| markStartLocation | start: boolean | 标记开始位置 |
| markEndLocation | isEnd: boolean | 标记结束位置 |
| getRefreshLayoutStatus | 无参 | 获取下拉刷新状态 |
| getLoadMoreLayoutStatus | 无参 | 获取上拉加载状态 |
| scrollToIndex | value: number | 滑动到某一个位置 |
| scrollEdge | value: Edge | 滚动到容器边缘 |

##### RefreshDataSource

数据懒加载操作对象，当使用数据懒加载时，必须通过此对象进行操作数据，否则无法生效！
懒加载数据的增删改查，必须实现属性：onLazyDataSource

```typescript
onLazyDataSource: (dataSource: RefreshDataSource) => {
  this.dataSource = dataSource
}
```

###### 方法类型概述

| 方法 | 类型 | 概述 |
| :--- | :--- | :--- |
| pushData | (item: Object ) | 可传递任意类型，用于添加单条数据 |
| pushDataPosition | (position: number, item: Object) | 指定位置添加数据 |
| pushDataVariable | (...items: Object[]) | 添加可变参数数据 |
| pushDataArray | (items: Object[]) | 添加数组 |
| deleteFirst | 无参 | 删除第一条数据 |
| deleteLast | 无参 | 删除最后一条数据 |
| deleteData | (position: number) | 删除一条数据 |
| deleteAll | 回调接口参数可选 | 删除全部数据 |
| changeData | (position: number, item: Object) | 修改数据 |
| getDataAll | 无参 | 返回所有的数据 （返回值 Object[]） |
| getData | (index: number) | 返回某一条数据 |
| totalCount | 无参 | 返回数据数量（返回值 number） |
| reloadData | 无参 | 重置所有子组件的 index 索引 |
| moveData | (from: number, to: number) | 交换数据 |
| changeData | (index: number, data: Object) | 改变单个数据 |

##### GridAttr

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 宽度 |
| height | Length | 高度 |
| backgroundColor | ResourceColor | 背景颜色，默认透明 |
| columnsTemplate | string | 设置当前网格布局列的数量，不设置时默认 2 列，例如：1fr 1fr |
| rowsTemplate | string | 设置当前网格布局行的数量，不设置时默认 1 行，例如：1fr 1fr |
| columnsGap | Length | 设置列与列的间距。默认值：0 |
| rowsGap | Length | 设置行与行的间距。默认值：0 |
| scrollBar | BarState | 设置滚动条状态。默认值：BarState.Off |
| scrollBarColor | string / number / Color | 设置滚动条的颜色。 |
| scrollBarWidth | string / number / | 设置滚动条的宽度。 |
| cachedCount | number | 设置预加载的 GridItem 的数量，只在 LazyForEach 中生效。 |
| scrollSpringHeight | number | 实现弹性物理动效，以设置最大高度为基准 |

##### GridItemAttr

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 宽度 |
| height | Length | 高度 |
| margin | Margin / Length | 边距 |
| padding | Padding / Length | 内边距 |
| backgroundColor | ResourceColor | 背景颜色，默认透明 |
| onClick | Callback | 点击事件 |

### 3、StaggeredGridView【瀑布流】

#### 1、懒加载数据使用（LazyForEach）

默认情况下既是，目的是进行组件销毁回收以降低内存占用，提高性能，当然了也是推荐使用，相对于普通使用，需要使用 RefreshDataSource 进行数据的增删改查！

```typescript
controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量
dataSource: RefreshDataSource = new RefreshDataSource() //数据懒加载操作对象，执行数据增删改查

StaggeredGridView({
  lazyDataSource: this.dataSource,
  itemLayout: (item, index) => this.itemLayout(item, index), //条目布局
  controller: this.controller, //控制器，负责关闭下拉和上拉
  onRefresh: () => {
    //下拉刷新
    //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
    this.controller.finishRefresh() //关闭下拉刷新，在数据请求回后进行关闭
  },
  onLoadMore: () => {
    //上拉加载
    //数据懒加载使用：1、数组数据添加，this.dataSource.pushDataArray()，2、单个数据添加，this.dataSource.pushData()
    this.controller.finishLoadMore() //关闭上拉加载，在数据请求回后进行关闭
  }
})
/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 2、普通使用（ForEach）

普通使用正常的数据加载即可，只需关注数据源。

```typescript
@Local controller: RefreshController = new RefreshController() //刷新控制器，声明全局变量

StaggeredGridView({
  items: this.array, //数据源 数组，任意类型
  itemLayout: (item, index) => this.itemLayout(item, index),
  controller: this.controller, //控制器，负责关闭下拉和上拉
  isLazyData: false, //禁止懒加载，也就是使用 ForEach 进行数据加载
  onRefresh: () => {
    //下拉刷新
    this.controller.finishRefresh();
  },
  onLoadMore: () => {
    //上拉加载
    this.controller.finishLoadMore();
  }
})

/**
 * Author:AbnerMing
 * Describe:条目布局
 * @param item  数据对象
 * @param index  数据索引
 */
@Builder
itemLayout(item:Object, index:number):void {
  //条目视图，任意组件
}
```

#### 3、相关属性介绍

##### 属性类型概述

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| columnsTemplate | string | 展示几列，默认是两列，例如：1fr 1fr |
| columnsGap | Length | 列与列的间距，默认为 0 |
| rowsGap | Length | 行与行的间距 |
| bgColor | ResourceColor | 整体的背景 |
| sWidth | Length | 宽度 |
| sHeight | Length | 高度 |
| items | Array<Object> | 数据源 |
| itemLayout | @BuilderParam (item: Object, index: number) | 传递的布局 |
| controller | RefreshController | 控制器，关闭下拉和上拉 |
| onRefresh | Callback | 回调刷新回调 |
| onLoadMore | Callback | 回调上拉加载 |
| isLazyData | boolean | 是否使用懒加载，默认是懒加载 |
| lazyCachedCount | number | 懒加载缓存数据量，默认为 1 |
| onLazyDataSource | Callback | 回调懒加载数据回调 |
| lazyDataSource | RefreshDataSource | 懒加载数据操作对象 |
| itemHeaderLayout | @BuilderParam | 传递的头组件 |
| headerRefreshLayout | @BuilderParam | 自定义刷新头组件 |
| footerLoadLayout | @BuilderParam | 自定义加载尾组件 |
| refreshHeaderAttribute | RefreshHeaderAttr | 默认的刷新头属性 |
| loadMoreFooterAttribute | LoadMoreFooterAttr | 默认的加载尾属性 |
| enableRefresh | boolean | 是否禁止刷新，也可以通过 onRefresh 进行控制，onRefresh 有代表需要刷新 |
| enableLoadMore | boolean | 是否禁止上拉加载，也可以通过 onLoadMore 进行控制，onLoadMore 有代表需要上拉加载 |
| scroller | Scroller | 可滚动组件的控制器。用于与可滚动组件进行绑定。 |
| emptyLayout | @BuilderParam | 空布局 |
| errorLayout | @BuilderParam | 错误布局 |
| showEmptyLayout | boolean | 是否显示空 |
| showErrorLayout | boolean | 是否显示错误 |
| scrollSpringHeight | number | 实现弹性物理动效，以设置最大高度为基准 |

##### RefreshController

| 参数 | 类型 | 概述 |
| :--- | :--- | :--- |
| finishRefresh | 无参 | 关闭下拉刷新 |
| finishLoadMore | Nothing: boolean | 关闭上拉加载，参数默认为 false，为 true 则为无数据展示 |
| autoRefresh | isAutoRefresh: boolean | 自动刷新，默认为 true |
| markStartLocation | start: boolean | 标记开始位置 |
| markEndLocation | isEnd: boolean | 标记结束位置 |
| getRefreshLayoutStatus | 无参 | 获取下拉刷新状态 |
| getLoadMoreLayoutStatus | 无参 | 获取上拉加载状态 |
| scrollToIndex | value: number | 滑动到某一个位置 |
| scrollEdge | value: Edge | 滚动到容器边缘 |

##### RefreshDataSource

数据懒加载操作对象，当使用数据懒加载时，必须通过此对象进行操作数据，否则无法生效！
懒加载数据的增删改查，必须实现属性：onLazyDataSource

```typescript
onLazyDataSource: (dataSource: RefreshDataSource) => {
  this.dataSource = dataSource
}
```

###### 方法类型概述

| 方法 | 类型 | 概述 |
| :--- | :--- | :--- |
| pushData | (item: Object ) | 可传递任意类型，用于添加单条数据 |
| pushDataPosition | (position: number, item: Object) | 指定位置添加数据 |
| pushDataVariable | (...items: Object[]) | 添加可变参数数据 |
| pushDataArray | (items: Object[]) | 添加数组 |
| deleteFirst | 无参 | 删除第一条数据 |
| deleteLast | 无参 | 删除最后一条数据 |
| deleteData | (position: number) | 删除一条数据 |
| deleteAll | 回调接口参数可选 | 删除全部数据 |
| changeData | (position: number, item: Object) | 修改数据 |
| getDataAll | 无参 | 返回所有的数据 （返回值 Object[]） |
| getData | (index: number) | 返回某一条数据 |
| totalCount | 无参 | 返回数据数量（返回值 number） |
| reloadData | 无参 | 重置所有子组件的 index 索引 |
| moveData | (from: number, to: number) | 交换数据 |
| changeData | (index: number, data: Object) | 改变单个数据 |

### 4、RefreshLayout

支持任何组件刷新和加载，前提在遇到滑动组件时，需要自己控制起始位置。

```typescript
RefreshLayout({
  controller: this.controller,
  itemLayout: () => this.itemLayout(), //条目布局
  onRefresh: () => {
    this.controller.finishRefresh()
  },
  onLoadMore: () => {
    this.controller.finishLoadMore()
  }
}
)
```

### 5、侧滑展示按钮

支持懒加载和普通模式，建议使用懒加载

#### 方式一：

```typescript
ListView({
  items: this.array, //数据源 数组
  controller: this.controller,
  dataController: this.dataController,
  itemLayout: (item, index) => this.itemLayout(item, index), //条目视图
  slideRightMenuLayout: this.slideRightMenuLayout, //侧滑视图
  slideMenuAttr: (attr) => {
    //设置侧滑属性
    attr.rightMenuWidth = 100
  }
})
```

#### 方式二：

```typescript
ListView({
  controller: this.controller,
  lazyDataSource: this.dataSource,
  itemLayout: (item, index) => this.itemLayout(item, index), //条目视图
  swipeRightMenuLayout: (index: number) => {
    this.slideRightMenuLayout(this, index)
  }, //侧滑视图
  swipeLeftMenuLayout: (index: number) => {
    this.slideRightMenuLayout(this, index)
  }
})
```

### 6、下滑二楼功能

完整功能请查看 Demo 中的 SecondFloorPage 文件。

```typescript
SecondFloorLayout({
  firstFloorView: () => { //一楼视图
    this.firstFloorView(this)
  },
  isNeedHalfFloor: false, //是否需要半楼功能
  secondFloorView: this.secondFloorView, //二楼视图
  enableScrollInteraction: (isInteraction: boolean) => {
    //用于解决嵌套的滑动组件冲突
    this.mScrollInteraction = isInteraction
  },
  topFixedView: () => {
    //顶部固定视图
    this.topFixedView(this)
  },
  sfController: this.sfController, //刷新控制器
  refreshHeaderAttribute: (attr) => {
    //刷新头及二楼滑动属性配置
    attr.fontColor = Color.White
    attr.timeFontColor = Color.White
  },
  onRefresh: () => {
    //下拉刷新
    setTimeout(() => {
      this.sfController.finishRefresh()
    }, 2000)
  },
  onScrollStatus: (status) => {
    //当前的滑动状态

  }
})
```

#### RefreshLayoutStatus 状态

```typescript
Pulling, //拖拽  下拉可以刷新
Release, //释放立即刷新
Refreshing, //正在刷新中
Finish, //刷新结束
ReleaseHalfFloor, //释放进入半楼
HalfFloor, //进入半楼
FirstFloor, //一楼
ReleaseSecondFloor, //释放进入二楼
SecondFloor, //二楼状态
SecondFloorSlideUp //二楼向上滑动状态
```

#### RefreshHeaderAttr 属性

默认的刷新头属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| width | Length | 刷新控件的宽度 |
| height | Length | 刷新头的高度 默认高度 80 |
| timeFormat | RefreshHeaderTimeFormat | 刷新头的时间格式，默认月日时分 |
| timeLabel | RefreshHeaderTimeLabel | 刷新头的标签格式 |
| hideTime | boolean | 是否隐藏刷新头时间，默认展示 |
| fontSize | number / string / Resource | 刷新头的文字大小 |
| fontColor | ResourceColor | 刷新头的文字颜色 |
| timeFontSize | number / string / Resource | 刷新头的时间文字大小 |
| timeFontColor | ResourceColor | 刷新头的时间文字颜色 |
| marginIconLeft | Length | 刷新文字距离左边的距离 |
| iconDown | PixelMap/ResourceStr/DrawableDescriptor | 刷新的下拉箭头 |
| iconUpLoad | PixelMap / ResourceStr/DrawableDescriptor | 下拉刷新 icon |
| pullingText | string /Resource | 下拉可以刷新文本 |
| releaseText | string /Resource | 释放立即刷新文本 |
| refreshingText | string /Resource | 正在刷新中文本 |
| finishText | string /Resource | 刷新结束文本 |
| releaseHalfFloorText | string /Resource | 释放进入半楼文本 |
| halfFloorText | string /Resource | 进入半楼文本 |
| firstFloorText | string /Resource | 一楼文本 |
| releaseSecondFloorText | string /Resource | 释放进入二楼文本 |
| secondFloorText | string /Resource | 二楼状态文本 |
| secondFloorSlideUpText | string /Resource | 二楼向上滑动状态文本 |

## 更多案例

可以查看相关 Demo【右侧仓库地址】。

## License

Apache License, Version 2.0

## 更新记录

### [v1.0.4] 2025-10-15

1. 解决属性无法设置问题。

### [v1.0.3] 2025-09-24

1. 解决数据无法更新问题。
2. 解决空布局默认无法加载问题
3. 处理列数无法动态更新问题

### [v1.0.2] 2025-07-15

1. 解决自动刷新多次加载造成的无法关闭问题。

### [v1.0.1] 2025-05-21

1. 新增支持 web 组件刷新加载
2. 优化 github 提出的问题

### [v1.0.0] 2025-03-20

1. 刷新库适配 V2 装饰器
2. 整体由 V1 切换至 V2 版本

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |

| 兼容性 | HarmonyOS 版本 | 5.0.0 |
| :--- | :--- | :--- |
| Created with Pixso. | | |

| 应用类型 | 应用 | Created with Pixso. |
| :--- | :--- | :--- |
| Created with Pixso. | | |
| 元服务 | | Created with Pixso. |
| Created with Pixso. | | |
| 设备类型 | 手机 | Created with Pixso. |
| Created with Pixso. | | |
| 平板 | | Created with Pixso. |
| Created with Pixso. | | |
| PC | | Created with Pixso. |
| Created with Pixso. | | |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @abner/refresh_v2
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/abae6fd178444643969626110fae2df0/PLATFORM?origin=template