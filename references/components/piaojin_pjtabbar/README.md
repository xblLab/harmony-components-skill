# PJTabBar 标签栏组件

## 简介

PJTabBar 是一个用于替换系统 Tabs 的控件，支持指示器联动，支持回收页面 page，支持自定义指示器/tabbar item，自定义 tabbar item 的布局 (居左居中居右), 自定义 tabbar 的左右附加额外视图等。

## 详细介绍

### 简介

PJTabBar 是一个用于替换系统 Tabs 的控件，支持自定义指示器，Tabbar item, Tabbar item 的布局 (居左居中居右), Tabbar 的左右附加额外视图等

### 效果展示

*   指示器联动
*   自定义指示器
*   自定义 Tabbar Item
*   自定义 Item 的布局
*   自定义 Tabbar 左右的附加视图
*   更新插入删除自定义 Tabbar Item

### 下载安装

深色代码主题复制

```bash
ohpm install @piaojin/pjtabbar
```

### 使用说明

可通过 PJTabBarOptions 自定义指示器视图，大小，间距，布局，样式等，也可自定义 Tabbar Item 视图，左右附加视图等。并支持更新，添加，删除 Tabbar Item。

深色代码主题复制

#### 1. 导入

```typescript
import {PJTabComponent, PJTabBarItem, PJTabBarOptionsInterface, PJTabBarOptions} from '@ohos/pjtabbar'
```

(根据需要可导入 PJTabBar，PJTabComponentController, PJTabBarOptions 等)

#### 2. 配置与使用

```typescript
private options: PJTabBarOptionsInterface = new PJTabBarOptions()
this.options.indicatorWidth = 30
this.options.indicatorHeight = 6
this.options.indicatorColor= Color.Orange
this.options.tabBarBackGround = Color.Pink
this.options.selectedFontSize = 16
this.options.selectedFontColor = Color.Orange
this.options.tabBarContentMargin = {left: 10, right: 10}

PJTabComponent({
  items: this.items,
  tabBarOptions: this.options,
  // 注意 contentBuilder 的传值方式，这种方式下 contentBuilder 中的 this 才是正确的。
  contentBuilder: (item: PJTabBarItemInterface, index: number) => {
      this.contentBuilder(item, index)
  },
})

@Builder contentBuilder(item: PJTabBarItemInterface, index: number) {
  Text(index.toString() + ' ' + item.title)
   .width('100%')
   .height('100%')
   .textAlign(TextAlign.Center)
   .backgroundColor(Color.Green)
}
```

PJTabComponent 作为 Tabs + TabContent 使用，也可以单独使用不带 Tab content 的 PJTabBar。

#### 3. 设置指示器滚动效果

目前支持联动和普通滚动

注意:
1. contentBuilder 的传值方式，这种方式下 contentBuilder 中的 this 才是正确的，通过 this 才能正确的访问到当前调用者的属性。customerItemBuilder, customerIndicatorBuilder, leftItemBuilder 和 rightItemBuilder 等 Builder 类似。

深色代码主题复制

```typescript
PJTabComponent({
  items: this.items,
  tabBarOptions: this.options,
  // 注意 contentBuilder 的传值方式，这种方式下 contentBuilder 中的 this 才是正确的。
  contentBuilder: ($$: PJReferenceTabBarItemInterface) => {
      this.contentBuilder($$)
  },
  // 这种调用方式下 this 不是指向当前的调用者，没法通过 this 访问当前调用者的属性
  // contentBuilder: this.contentBuilder
})
```

2. 当 contentBuilder 中的组件用到 PJTabBarItem 的 title/selectedItemIndex 等属性时，并且希望当调用 controller 的 update 操作后该组件的 title/selectedItemIndex 能跟着更新，那么 contentBuilder 的内容需要封装到一个子组件中，例如 PJContentBuilderWrap。并且 PJContentBuilderWrap 需要以

深色代码主题复制

```typescript
@State(也可采用@ObjectLink) item: PJTabBarItemInterface = {id: '', index: 0, title: '' }
currentItemIndex: number = 0
@Link selectedItemIndex: number
```

的形式绑定数据。这么做的原因是当数据源从 PJTabComponent 中通过@Builder 函数引用传递到调用者的 contentBuilder 时，需要通过@State/@ObjectLink/@Link 等关键词才能绑定数据源，并且组件的 UI 才能跟着数据的变化而变化。customerItemBuilder, customerIndicatorBuilder, leftItemBuilder 和 rightItemBuilder 等 Builder 类似。
详细原因可参考官方文档：@Builder 装饰器：按引用传递参数 与 管理组件拥有的状态

深色代码主题复制

```typescript
// 子组件
@Component
struct PJContentBuilderWrap {
 @State item: PJTabBarItemInterface = {id: '', index: 0, title: '' }
 currentItemIndex: number = 0
 @Link selectedItemIndex: number

 build() {
   Column() {
     Text(this.currentItemIndex + ' ' + this.item.title + ', ' + this.selectedItemIndex)
       .width('100%')
       .height('100%')
       .textAlign(TextAlign.Center)
       .backgroundColor(Color.Green)
   }
 }
}

// 调用者的 contentBuilder 函数
@Builder contentBuilder($$: PJReferenceTabBarItemInterface, self: CRUDItemPage) {
  PJContentBuilderWrap({currentItemIndex: $$.currentItemIndex, selectedItemIndex: $$.selectedItemIndex, item: $$.item})

  // 当 content 中的组件用到 PJTabBarItem 的 title 时，并且不需要随着 controller 的 update 操作后该组件的 title 能跟着更新，那么可以不需要将 contentBuilder 的内容包装在一个组件中，如下。
  // Text($$.currentItemIndex + ' ' + $$.item.title + ', ' + $$.selectedItemIndex)
  //   .width('100%')
  //   .height('100%')
  //   .textAlign(TextAlign.Center)
  //   .backgroundColor(Color.Green)
}
```

3. 当 contentBuilder 中的组件用到 PJTabBarItem 的 title/selectedItemIndex 时，并且不需要随着 controller 的 update 操作后该组件的 title/selectedItemIndex 能跟着更新，那么可不需要将 contentBuilde 的内容包装在一个组件中。
4. 当需要更新/删除/添加 item 时需要使用 PJTabComponentController 提供的接口。

深色代码主题复制

```typescript
/**
  * Update the item with `item` at `atIndex`.
  * @param atIndex Index of the item to be updated.
  * @param item The new item used to update the current item at `atIndex`.
  */
 update(index: number, item: PJTabBarItemInterface);

 /**
  * Appends new elements to the end of an array, and returns the new length of the array.
  * @param items New elements to add to the array.
  */
 push(...items: PJTabBarItemInterface[]): number;

 /**
  * Insert the new item at `atIndex`.
  * @param atIndex Index of the new item to be inserted.
  * @param item The new item used to insert at `atIndex`.
  */
 insert(atIndex: number, item: PJTabBarItemInterface);

 /**
  * Delete the item at `atIndex`.
  * @param atIndex Delete the item at `atIndex` and return the deleted item. And return null if the `atIndex` is out of range.
  */
 delete(atIndex: number): PJTabBarItemInterface | null;

 /**
  * Replace current items with `withItems` and select item at `selectIndex`.
  * @param withItems Used to replace current items.
  * @param selectIndex If provided, will select the item at `selectIndex`. If it is not provided, the current index is used instead.
  */
 setItems(withItems: PJTabBarItemInterface[], selectIndex: number = this.currentIndex());
 
 let controller = PJTabComponentController()
 
 PJTabComponent({
    index: 0,
    items: this.items,
    controller: this.controller,
    tabBarOptions: this.options,
    contentBuilder: ($$: PJReferenceTabBarItemInterface) => {
       this.contentBuilder($$, this)
    }
  })
  
 controller.update(0, new PJTabBarItem("更新 Item"))
```

更多详细用法请参考开源库 sample 页面的实现

### PJTabBarOptions 属性说明

| 属性名 | 说明 |
| :--- | :--- |
| fontSize | number item 未选中状态下的字体大小，默认值 15 |
| selectedFontSize? | number item 选中状态下的字体大小，默认值 15 |
| fontColor | Color item 未选中状态下的字体颜色，默认值 Color.Black |
| selectedFontColor | Color item 选中状态下的字体颜色，默认值 Color.Blue |
| fontWeight | number ? FontWeight ? string item 未选中状态下的字体 Weight, 默认值 FontWeight.Regular |
| selectedFontWeight | number ? FontWeight ? string item 选中状态下的字体 Weight, 默认值 FontWeight.Regular |
| fontStyle | FontStyle item 未选中状态下的字体 Style, 默认值 FontStyle.Normal |
| selectedFontStyle | FontStyle item 选中状态下的字体 Style, 默认值 FontStyle.Normal |
| fontFamily | string？Resource item 字体的 Family, 默认值为空'' |
| textAlign | TextAlign = TextAlign.Center item text 对齐方式，默认值 TextAlign.Center |
| itemBackgroundColor | Color item 未选中状态下的背景颜色，默认值 Color.Transparent |
| selectedItemBackgroundColor | Color item 选中状态下的背景颜色，默认值 Color.Transparent |
| tabBarBackGround | Color = Color.White 整个 TabBar 的背景颜色，默认值 Color.White |
| itemSpace | number 每个 item 之间的间距，默认值 20vp |
| itemWidth? | number 每个 item 的固定宽度，默认值为 null。如果未设置则 item 的宽度由 item 内容自适应宽度 |
| itemHeight? | number 每个 item 的固定高度，默认值为 null。如果未设置则 item 的高度由 item 内容自适应高度 |
| itemBorder | BorderOptions item 未选中状态下的 border，默认值{radius: 0, width: 0, color: Color.White} |
| selectedItemBorder | BorderOptions item 未选中状态下的 border，默认值{radius: 0, width: 0, color: Color.White} |
| itemMargin | Margin item 的 Margin，默认值{top: 0, bottom: 0, left: 0, right: 0} |
| itemAnimationDuration | number tabBar 滚动到被选中的 item 的动画持续时间，默认值 300 |
| itemAlign | Alignment item 在 TabBar 中水平位置的对齐方式 (居左居中居右)，需要设置 isTabBarWidthFillParent = true，默认值 Alignment.Center |
| itemEqualDistributionType | PJItemEqualDistributionType Item 均分布局类型，默认值 PJItemEqualDistributionType.None，即不均分布局。需要注意的是只有 Item 的总长度在 PJTabBar 宽度以内时均分才适用。 |
| tabBarVerticalAlign? | VerticalAlign item 在 TabBar 中垂直方向的对齐方式 (居上居中居下)，默认值 VerticalAlign.Top |
| maxLines | number item text 的最大行数，默认值 1 |
| indicatorWidth | number 指示器宽度，默认值 20 |
| indicatorHeight | number 指示器高度，默认值 4 |
| indicatorBorderRadius | number 指示器圆角，默认值 2 |
| indicatorMargin | Margin 指示器 Margin，默认值{top: 10, bottom: 0, left: 0, right: 0} |
| indicatorColor | Color 指示器颜色，默认值 Color.Blue |
| indicatorAnimationDuration | number 指示器滚动到选中 item 的动画持续时间，默认值 300 |
| indicatorPosition | PJIndicatorPosition 指示器在 item 的位置 (在 item 上，下，中间)，默认值 PJIndicatorPosition.Bottom |
| indicatorAnimationType | PJIndicatorAnimationType = PJIndicatorAnimationType.Normal 指示器滚动的风格，目前有 Normal 和 Linkpage。Normal, 即当选中其他 item 时指示器在选中后才滚动过去。Linkpage，指示器和 tab content 滑动时联动。 |
| isSameWidthWithItem | boolean 设置指示器的宽度是否和 item 宽度一致，默认值 false, 如果设置为 true 则对 indicatorWidth 属性的设置将无效 |
| isSameHeightWithItem | boolean 设置指示器的高度是否和 item 高度一致，默认值 false, 如果设置为 true 则对 indicatorHeight 属性的设置将无效 |
| isHideIndicator | boolean 是否隐藏指示器，默认值 false |
| scrollable | ScrollDirection tabBar 滚动方向，设置为 None 时禁止滚动，即固定 TabBar Item，默认值 ScrollDirection.Horizontal |
| isLeftItemFixed | boolean tabBar 左侧附加视图是否固定住，默认值 true |
| isRightItemFixed | boolean tabBar 右侧附加视图是否固定住，默认值 true |
| isLeftItemSameHeightWithTabBar | boolean tabBar 左侧附加视图高度是否和 TabBar 一致，默认值 true |
| isRightItemSameHeightWithTabBar | boolean tabBar 右侧附加视图高度是否和 TabBar 一致，默认值 true |
| isHideLeftItem | boolean 是否隐藏 TabBar 左侧附加视图，默认值 false |
| isHideRightItem | boolean 是否隐藏 TabBar 右侧附加视图，默认值 false |
| edgeEffect | EdgeEffect tabBar 滚动到边缘的动画效果，默认值 EdgeEffect.Spring |
| tabBarContentMargin | Margin tabBar 内容的 Margin，默认值{top: 0, bottom: 0, left: 0, right: 0} |
| isTabBarWidthFillParent? | boolean tabBar 宽度是否撑满父组件，默认值 true。当设置 true 时 itemAlign 属性不起作用 (居左居中居右)，此时 TabBar 宽度是自适应的，若单独使用 PJTabBar 可自行配合 Row() {PJTabBar}.justifyContent(FlexAlign) 达到居左，居中，居右效果。 |
| shouldScrollToCurrentIndexWhenTabBarWidthChanged? | boolean tabBar 宽度变化后 (比如横竖屏切换) 当选中的 item 不可见时是否自动滚动到选中的 item，默认值 true |
| optimizeOffsetX | number item 被选中时滚动到 item 的附加偏移量，目的是让被选中的 item 尽量滚动到中间位置，默认值 120 |
| tabBarBorder? | BorderOptions tabBar border 配置，默认值 null，可用于配置 iOS 风格 Segment 组件 |
| tabsAnimationDuration | number tab content 切换 page 时的动画时长，默认值 300 毫秒 |
| tabContentScrollable | boolean 控制 tab content 是否可以滑动，默认值 true |
| enableRecycling | boolean 是否启用页签回收功能，默认值 false。当有很多页签时，同时希望减少内存压力，那么设置 enableRecycling = true。页签回收指当页签滑出屏幕外时，回收该页签内存以节省内存。回收时机依据 PJTabBarOptions 中的 cachedCount 属性值，e.g: cachedCount = 2, 页签有 1，2，3，4，5，6，当页签 1 被滑动出去后并且当前滑动到页签 4，此时页签 1 被回收，页签 2，3 还在 cache 中 (cachedCount = 2)，即 cachedCount 指可以被滑动出界面并且被缓存的页签数量。 |
| cachedCount | number 设置预加载页签个数，即指可以被滑动出界面并且被缓存的页签数量，默认值 1。该属性使用于 enableRecycling = true 的情况下。 |
| disableSwipe | boolean 禁用页签滑动切换功能，该属性使用于 enableRecycling = true 的情况下。enableRecycling = false 时设置 scrollable 以替代。 |
| displayArrow | [ArrowStyle \| boolean, boolean] 设置页签两侧的分页指示器，默认值 [false, false], 该属性使用于 enableRecycling = true 的情况下。 |

### PJTabComponentController 接口说明

| 接口名 | 说明 |
| :--- | :--- |
| currentIndex() | number 返回当前选中的 item 的 index |
| changeIndex(index: number) | 控制 PJTabComponent 切换到指定页签 |
| update(index: number, item: PJTabBarItemInterface) | 更新指定位置的 item，当 index 不在 items 的 range 内时不做响应处理。 |
| push(...items: PJTabBarItemInterface[]): number | 在 TabBar 末尾新增 item |
| insert(atIndex: number, item: PJTabBarItemInterface) | 在指定位置插入 item，当 index 不在 items 的 range 内时不做响应处理。 |
| delete(atIndex: number): PJTabBarItemInterface \| null | 删除指定位置 item，当 index 不在 items 的 range 内时不做响应处理。 |
| setItems(withItems: PJTabBarItemInterface[], selectIndex: number = this.currentIndex()) | 替换所有的 item |
| findIndex(predicate: (value: PJTabBarItemInterface, index: number, obj: PJTabBarItemInterface[]) => boolean, thisArg?: undefined): number | 根据条件查找相应 item 的 index |
| find(predicate: (value: PJTabBarItemInterface, index: number, obj: PJTabBarItemInterface[]) => boolean, thisArg?: undefined): PJTabBarItemInterface \| undefined | 根据条件查找相应的 item |
| getItem(atIndex: number): PJTabBarItemInterface \| undefined | 返回 atIndex 处的 item |
| preloadItems(indices: Optional<Array<number>>): Promise<void> \| undefined | 加载指定的 tab content |
| syncTabContentWidth(width: number) | 同步页签 (tab content) 的宽度，用于指示器联动时判断手势滑动距离的百分比，默认 tab content 是撑满屏幕宽度。 |

### PJTabBarController 接口说明

| 接口名 | 说明 |
| :--- | :--- |
| currentIndex() | number 返回当前选中的 item 的 index |
| selectItemAtIndex(index: number) | 控制 PJTabBar 选中指定 item |
| update(index: number, item: PJTabBarItemInterface) | 更新指定位置的 item |
| push(...items: PJTabBarItemInterface[]): number | 在 TabBar 末尾新增 item |
| insert(atIndex: number, item: PJTabBarItemInterface) | 在指定位置插入 item |
| delete(atIndex: number): PJTabBarItemInterface \| null | 删除指定位置 item |
| setItems(withItems: PJTabBarItemInterface[], selectIndex: number = this.currentIndex()) | 替换所有的 item |
| findIndex(predicate: (value: PJTabBarItemInterface, index: number, obj: PJTabBarItemInterface[]) => boolean, thisArg?: undefined): number | 根据条件查找相应 item 的 index |
| find(predicate: (value: PJTabBarItemInterface, index: number, obj: PJTabBarItemInterface[]) => boolean, thisArg?: undefined): PJTabBarItemInterface \| undefined | 根据条件查找相应的 item |
| getItem(atIndex: number): PJTabBarItemInterface \| undefined | 返回 atIndex 处的 item |
| syncTabContentWidth(width: number) | 同步页签 (tab content) 的宽度，用于指示器联动时判断手势滑动距离的百分比，默认 tab content 是撑满屏幕宽度。 |
| handleTouch(event: TouchEvent, currentIndex: number, duration: number \| undefined) | 处理手势滑动 tab content，使指示器跟着手势联动。 |

## 约束与限制

在下述版本验证通过：

DevEco Studio: NEXT Developer Beta2(Build Version: 5.0.3.502), SDK: API12(5.0.0)

## 目录结构

深色代码主题复制

```text
|---- PJTabBar
|     |---- entry  # 示例代码文件夹
|     |---- pjtabbar_staticlibrary  # PJTabBar 三方库核心文件夹
|           |----src
|                 |----main
|                       |----ets
|                             |----components
|                                   |----PJTabBar.ets #指示器的核心实现
|                                   |----PJTabComponent.ets #供开发使用，等于 Tabs + TabContent
|                                   |----PJTabBarItemComponent.ets #包装指示器的子组件
                             |----models
|                                   |----PJTabBarOptions.ets #包含各种配置项
|                                   |----其他.ets #其他 model 文件
                             |----datasources
|                                   |----PJTabDataSource.ets #对数据源的各种操作，比如 update, insert, push, delete 和 setItems 等。
|           |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给我，当然，我也非常欢迎你给我发 PR。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 参考的 ReadMe 写法

CircleIndicator README.md

## 更新记录

### v1.1.7 [2025.11.29]

添加配置项 tabComponentColumnAlignItems: HorizontalAlign = HorizontalAlign.Start 设置 PJTabComponent 最外层 Column 的 alignItems。

### v1.1.6 [2025.10.11]

修复 issues/ID0Q6V

### v1.1.5 [2025.10.2]

添加配置项 tabContentLayoutWeight?: number | string 设置内容页的 layoutWeight，当设置为 1 时会自动撑满剩余高度，此时设置 tabContentHeight = 'auto'也是会被撑满高度。当设置 tabContentHeight\|PJTabComponent 的 height 为某个数字或者百分比时高度值会覆盖 tabContentLayoutWeight 的效果。

### v1.1.4 [2025.9.29]

添加配置项 tabContentHeight?: Length 设置内容页的高度，默认由内容撑开高度，即自适应高度'auto'，设置后则使用设置的高度。如果给 PJTabComponent 设置了 height，则会覆盖该属性效果。

### v1.1.3 [2025.4.11]

添加配置项 itemPadding?: Padding，设置 item 的内边距。

### v1.1.2 [2025.1.14]

*   更新首页库地址描述
*   验证"1.1.1 版本设置顶部透明不管用，会显示默认蓝色，底色也是黄色"问题是否修了

### v1.1.1 [2024.12.17] With My M4 Pro Mac Min

修复以下 Issues:

*   设置 options.itemHeight=0 时下面会有一段间距如何控制
*   PJTabBar({ index: this.customTabIndex, items: this.items, tabBarOptions: this.options } index 传值总是被重置为 0
*   tabcontent 底部有一点间距，感觉很不合理，如果必须可以默认，也可以增加熟悉进行设置
*   默认选中索引问题
*   希望内容也可以支持设置 edgeEffect
*   indicatorAnimationType = PJIndicatorAnimationType.Linear 时的 bug
*   tabBarVerticalAlign 属性设置后好像没有用
*   indicatorAnimationDuration 感觉属性好像没用

### v1.1.0 [2024.09.19]

修复 PJTabBarOptionsInterface.itemEqualDistributionType 无法赋值问题。

### v1.0.9 [2024.08.28]

PJTabComponent 添加 Swiper 实现 (设置 enableRecycling = true), 当页签滑出屏幕外时，回收该页签内存以节省内存。
回收时机依据 PJTabBarOptions 中的 cachedCount 属性值，e.g: cachedCount = 2, 页签有 1，2，3，4，5，6，当页签 1 被滑动出去后并且当前滑动到页签 4，此时页签 1 被回收，页签 2，3 还在 cache 中 (cachedCount = 2)，即 cachedCount 指可以被滑动出界面并且被缓存的页签数量。

### v1.0.8 [2024.08.27]

*   修复设置 isSameWidthWithItem=true 时，指示器从长变短时一闪而过，不平滑的问题。
*   Item 添加均分布局 PJItemEqualDistributionType，注意至于单 item 不超出 PJTabBar 宽度时才有效果。

### v1.0.7 [2024.08.21]

*   指示器添加联动效果
*   对于传入接口的 index 添加有效范围判断，如果传入的 index 无效，则不响应操作。
*   添加接口 preloadItems，用于提前加载指定的 tab content.
*   添加配置项 tabsAnimationDuration: number，设置 tab content 切换 page 时的动画时长。
*   添加配置项 tabContentScrollable: boolean，控制 tab content 是否可以滑动。

### v1.0.6 [2024.08.16]

*   修复当选中非第一个页签时，调用 PJTabComponentController 的 CRUD 操作后会跳转选中第一个页签的问题。
*   修复调用 PJTabComponentController 的 update 操作后，contentBuiler \| customerItemBuilder 中使用 PJTabBarItem 的 title 等属性的组件的 UI 没有跟着更新的问题。
*   修复调用 PJTabComponentController 的 update 操作后，指示器的位置不居中的问题。
*   对数据源的操作统一放在 PJTabDataSource 中。
*   更新示例代码。

### v1.0.5 [2024.08.13]

*   修复 CRUD 操作后 item 的 index 没有更新，导致 tabbarUI 状态错乱。
*   修复 CRUD 操作后 tabs content 没更新。
*   改善指示器滚动过程中抖动问题。
*   添加在 TabBar 末尾新增元素接口：push。
*   替换 attrs 数组为 Map。

### v1.0.4 [2024.08.08]

*   添加 replace 接口，用于替换当前 items。
*   PJTabComponentController 与 PJTabBarController 接口添加注释。

### v1.0.3 [2024.08.06]

*   加快指示器与 Change Page 之间的联动。
*   修复 DevEco Studio: NEXT Developer Beta2, Preview 模式下，无法预览 PJTabComponent 问题。

### v1.0.2 [2024.07.17]

*   适配 API12。
*   修复 TabContent 底部超出大概 42vp 屏幕问题。
*   修复简介 Demo gif 加载不出来问题。
*   版本 v1.0.0 中的 bug iii,iv 验证在 API12 下已被系统修复，并删除相应 Workaround 修复方法。

### v1.0.1 [2024.07.09]

*   修复 PJComponent index 默认值为 4 问题。
*   修复简介 Demo gif 加载不出来问题。

### v1.0.0 [2024.07.05]

已实现功能

*   支持自定义指示器，TabBar Item, TabBar 左右附加视图。
*   支持 TabBar Item 居左居中居右布局。
*   支持更新，插入，删除 TabBar Item。
*   指示器跟随 TabContent 的滑动而联动。

已知系统 bug

*   已知系统 Scroll 导致的 bug，当 Scroll 内容不超出屏幕时并且 Scroll 设置 edgeEffect = EdgeEffect.Spring 的情况下，左滑 Scroll 会出现 Scroll 整体向右偏移，不知 API12 中该系统 bug 有没被修复。修复方法见函数 fixScrollXoffsetIssueIfNeeded
*   已知系统 Scroll 导致的 bug，当 Scroll 设置 edgeEffect = EdgeEffect.Spring 的情况下把 TabBar 滑动到低并且横竖屏切换 Scroll 会出现整体向右偏移，不知 API12 中该系统 bug 有没被修复。问题 4 目前的 Workaround 方式修复:

深色代码主题复制

```typescript
在 Scroll 的回调 onAreaChange 中调用
this.scroller.scrollEdge(Edge.Start)
// 滚动到当前选中的 item,attr 当前选中 item 的坐标信息
this.scroller.scrollTo({xOffset: (attr.area.position.x as number) - this.tabBarOptions.optimizeOffsetX, yOffset: this.scroller.currentOffset().yOffset, animation: {duration: this.tabBarOptions.itemAnimationDuration, curve: Curve.Linear}})
```

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | |
| 隐私政策 | 不涉及 | | |
| SDK 合规使用指南 | 不涉及 | | |

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |

Created with Pixso.

## 应用类型

| 项目 | 值 |
| :--- | :--- |
| 应用 | 应用 |
| 元服务 | 元服务 |
| 设备类型 | 手机 |
| PC | PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

Created with Pixso.

## 来源

*   原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8a8f5029807e4f2f9bb511a660cf4003/PLATFORM?origin=template