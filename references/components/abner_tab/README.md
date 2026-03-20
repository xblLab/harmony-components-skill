# 自定义指示器组件 tab

## 简介

tab 是一个封装了主页底部导航按钮和通用的页签指示器，优化了系统 tab，支持指示器跟随手势滑动，支持自定义指示器，支持右侧添加按钮等功能，并且增加了丰富的属性配置，旨在让代码调用更加的便捷。

## 详细介绍

### 组件介绍

tab 是一个封装了主页底部导航按钮和通用的页签指示器，优化了系统 tab，支持指示器跟随手势滑动，支持自定义指示器，支持右侧添加按钮等功能，并且增加了丰富的属性配置，旨在让代码调用更加的便捷。本组件基于 ArkTS 构建，适配 HarmonyOS API 12 及以上版本。

### 组件特点

1. 简化了系统 Api 代码，使用更加简洁。
2. 自定义了指示器滑动，支持随着手势滑动。
3. 封装了底部按钮，丰富了属性多样化，使用更加便捷。

### 核心优势

**简洁性**
封装了系统的能力，代码调用更加的简洁，只需关注数据，让开发趋于简洁化。

**稳定性**
经过严格的测试和优化，保证了组件的稳定性和可靠性，确保集成方的业务不受影响。

### 作者介绍

李一鸣，资深鸿蒙应用架构师和程序员，常年活跃于各大技术平台，撰写鸿蒙技术文章截止当前近 150 多篇，开发鸿蒙组件截止当前已有 22 个，多个组件获得了很多开发者的一致认可。针对鸿蒙系统，主要专注于为开发者提供高效、便捷的基础组件及 SDK 开发工具与技术支持。致力于帮助开发者快速上手鸿蒙生态，提供丰富的开发资源、示例代码、技术文档以及定制化解决方案，助力开发者在鸿蒙生态中实现无限可能。

### 约束与限制

在下述版本通过验证：

| DevEco Studio 版本号 | HarmonyOS SDK 版本号 | 手机操作系统 ROM 版本号 |
| :--- | :--- | :--- |
| DevEco Studio 6.0.0.858【API18】 | HarmonyOS SDK 5.1.05.1.0.150(SP15C00E128R6P1logpatch02) | - |

## 功能效果

### 目前支持功能

0. 支持自定义底部 tab 形式。
1. 支持底部 tab 图文形式。
2. 支持底部中间图片形式。
3. 支持底部圆角浮动形式。
4. 支持指示器跟随手势滑动。
5. 支持自定义指示器。
6. 支持右侧添加按钮。
7. 支持指示器图片形式。
8. 支持点击和滑动拦截。

## 支持 API 版本

Api 版本：>=12

## 快速使用

### 远程依赖方式使用

**方式一：** 在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

```bash
ohpm install @abner/tab
```

**方式二：** 在工程的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/tab": "^1.1.2"}
```

### 查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个 oh_modules 文件，并创建源代码文件，有则成功，无则失败，如下：

## 基本使用

### 1、底部导航案例

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例一，使用封装的 BottomTabLayout，只需要 page 视图即可
 * */
@Entry
@Component
struct BottomTabPage1 {
  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab 对应的页面
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例一" })

      BottomTabLayout({
        itemPage: this.itemPage, //tab 对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab 点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
      })
    }.height("100%")

  }
}
```

#### 相关属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| itemPageBuilderParam | BuilderParam | tab 对应得页面 |
| tabSelectedColor | ResourceColor | tab 选中颜色 |
| tabNormalColor | ResourceColor | tab 未选中颜色 |
| tabSelectedBgColor | ResourceColor | 选中背景颜色 |
| tabNormalBgColor | ResourceColor | 未选中背景颜色 |
| tabIconWidth | number | 图片 icon 的宽度，默认 20 |
| tabIconHeight | number | 图片 icon 的高度，默认 20 |
| tabSize | number | tab 文字大小 |
| tabWeight | number /FontWeight / string | 文字权重 |
| tabLabelMarginTop | number | 标签距离图片的高度 |
| tabBarArray | Array | tab 数据源 |
| tabWidth | Length | tab 指示器的宽度 |
| tabHeight | number | tab 指示器的高度，默认 56 |
| currentIndex | number | 当前索引，默认是第一个 |
| onChangePage | Callback | 回调方法页面切换监听 |
| onTabBarClick | Callback | tab 点击回调 tab 点击监听 |
| tabScrollable | boolean | 是否可滑动，默认不可以滑动 |
| tabMarginBottom | number | tab 距离底部的距离 |
| isTabClickIntercept | boolean | tab 点击拦截，默认 false 不拦截 |
| onDoubleClick | Callback | 回调方法双击 |
| bottomTabType | BottomTabType | 设置底部导航模式，默认为普通模式 |
| bottomTabBorderOptions | BorderOptions | 设置底部导航边框样式 |
| navBarBackgroundColor | ResourceColor | 底部导航栏背景颜色 |
| tabPositionIntercept | Array | 按照索引拦截，具体传递对应索引即可 |

### 2、底部导航案例 2，自定义 Tab 视图

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例二，使用 BaseBottomTabLayout，可以自定义 Tab 视图
 * */
@Entry
@Component
struct BottomTabPage2 {
  private currentIndex = 0 //默认是第一个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab 对应的页面
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义 Tab 视图，自己绘制
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    Column() {
      Image(this.currentIndex == index ? item.selectedIcon
        : item.normalIcon)
        .width(30).height(30)
      Text(item.title)
        .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
        .fontSize(14)
        .margin({ top: 5 })
    }.width("100%")
  }


  build() {
    Column() {
      ActionBar({ title: "底部导航案例二" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onTabBarClick: (position) => {
          //tab 点击
          console.log("====点击了 Tab" + position)
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      })
    }
  }
}
```

#### 相关属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| itemPageBuilderParam | BuilderParam | tab 对应得页面 |
| tabSelectedColor | ResourceColor | tab 选中颜色 |
| tabNormalColor | ResourceColor | tab 未选中颜色 |
| tabSelectedBgColor | ResourceColor | 选中背景颜色 |
| tabNormalBgColor | ResourceColor | 未选中背景颜色 |
| tabIconWidth | number | 图片 icon 的宽度，默认 20 |
| tabIconHeight | number | 图片 icon 的高度，默认 20 |
| tabSize | number | tab 文字大小 |
| tabWeight | number /FontWeight / string | 文字权重 |
| tabLabelMarginTop | number | 标签距离图片的高度 |
| tabBarArray | Array | tab 数据源 |
| tabWidth | Length | tab 指示器的宽度 |
| tabHeight | number | tab 指示器的高度，默认 56 |
| currentIndex | number | 当前索引，默认是第一个 |
| onChangePage | Callback | 回调方法页面切换监听 |
| onTabBarClick | Callback | tab 点击回调 tab 点击监听 |
| tabScrollable | boolean | 是否可滑动，默认不可以滑动 |
| tabMarginBottom | number | tab 距离底部的距离 |
| isMarginBottom | boolean | 默认开启，tab 距离底部的距离 |
| isTabClickIntercept | boolean | tab 点击拦截，默认 false 不拦截 |
| onDoubleClick | Callback | 回调方法双击 |
| bottomTabType | BottomTabType | 设置底部导航模式，默认为普通模式 |
| bottomTabBorderOptions | BorderOptions | 设置底部导航边框样式 |
| navBarBackgroundColor | ResourceColor | 底部导航栏背景颜色 |
| tabPositionIntercept | Array | 按照索引拦截，具体传递对应索引即可 |

### 3、底部导航案例 3，中间图片

```typescript
/**
 * AUTHOR:AbnerMing
 * DATE:2024/3/5
 * INTRODUCE:底部导航案例中间图片
 * */
@Entry
@Component
struct BottomTabPage4 {
  private currentIndex = 0 //默认是第一个

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab 对应的页面
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义 Tab 视图，自己绘制
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemTab(index: number, item: TabBar) {
    if (index == 2) {
      Column() {
        Image($r("app.media.add"))
          .width(50).height(50)
          .margin({ top: -10 })
      }
    } else {
      Column() {
        Column() {
          Image(this.currentIndex == index ? item.selectedIcon
            : item.normalIcon)
            .width(30).height(30)
          Text(item.title)
            .fontColor(this.currentIndex == index ? "#D81E06" : "#000000")
            .fontSize(14)
            .margin({ top: 5 })
        }
      }.width("100%")
      .justifyContent(FlexAlign.Center)
    }
  }

  build() {
    Column() {
      ActionBar({ title: "自定义底部导航 (中间图片)" })
      BaseBottomTabLayout({
        itemPage: this.itemPage,
        itemTab: this.itemTab,
        barBackgroundColor: "#e8e8e8",
        centerImageMarginBottom: 10,
        tabBar: [
          new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
          new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
          new TabBar("中间图片"),
          new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
          new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
        ],
        tabMarginBottom: 30, //距离底部的距离，一般可以获取底部导航栏的高度，然后进行设置
        onTabBarClick: (position) => {
          //tab 点击
          console.log("====点击了 Tab" + position)
        },
        onChangePage: (position) => {
          //页面切换
          console.log("====页面切换了" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
      })
    }
  }
}
```

### 4、普通指示器导航【滑动】

**简单案例**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二"],
  itemPage: this.itemPage,
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**设置圆角**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabDividerStrokeWidth = 10
    tab.tabDividerLineCapStyle = LineCapStyle.Round
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**设置宽度**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabDividerWidth = 20
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**跟随文字宽度**

```typescript
TabLayout({
  tabBar: ["一", "第二", "条目三", "是条目四", "我是条目五", "最后是条目六"],
  itemPage: this.itemPage,
  tabAttribute: (tab) => {
    tab.tabItemWidth = undefined
    tab.tabItemMargin = { left: 10, right: 10 }
    //更改下划线的宽度
    tab.tabDividerWidth = undefined
  },
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**左侧按钮**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabMenu: this.itemMenu, //按钮
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**自定义下划线**

```typescript
BaseTabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabModel: {
    tabDividerStrokeWidth: 15
  },
  itemTabIndicator: () => {
    this.tabItemTabIndicator(this) //自己定义指示器
  },
  itemTab: (index: number, item: string) => {
    this.tabItem(this, index, item)
  },
})
```

#### 相关属性

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| tabWidth | Length | tab 指示器的宽度 |
| tabHeight | number | tab 指示器的高度 |
| onChangePage | Callback | 回调方法 (position: number) 页面改变回调 |
| currentIndex | number | 当前索引，默认第 0 个 |
| tabScrollable | boolean | 是否可以滑动切换页面，默认可以滑动 |
| tabBarArray | Array | 数据源 |
| itemPage | Callback | 回调方法 BuilderParam (index: number, item: string)tab 对应得页面 |
| tabAttribute | Callback | 回调方法 (attribute: TabModel) 设置 tab 相关属性 |
| isHideDivider | boolean | 是否隐藏下划线，默认展示 |
| isTabAlignLeft | boolean | 是否从最左边开始，默认不是 |
| barMode | BarMode | 是均分还是可滑动，默认滑动 |
| onTabBarClick | Callback | 回调方法 (position: number)tab 点击回调 |
| isShowTabMenu | boolean | 是否展示右边的按钮选项，默认不展示 |
| tabMenu | Callback | 回调方法 BuilderParam 右边展示的按钮视图 |
| tabMenuWidth | number | tab 右侧按钮的宽度 |
| tabMenuMarginRight | number | tab 按钮距离右侧的距离 |
| isTabClickIntercept | boolean | 是否拦截点击和滑动 |

### 5、普通指示器导航【不可滑动】

**简单案例**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二", "条目三", "条目四", "条目五", "条目六"],
  itemPage: this.itemPage,
  tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

**均分**

```typescript
TabLayout({
  tabBar: ["条目一", "条目二"],
  barMode: BarMode.Fixed, //均分
  tabType: TabType.DEFAULT, //普通的需要设置默认值，指示器不会跟着手势滑动
  itemPage: this.itemPage,
  onChangePage: (position) => {
    //页面改变
    console.log("===页面改变:" + position)
  },
  onTabBarClick: (position) => {
    //点击改变
    console.log("===点击改变:" + position)
  }
})
```

### 6、底部导航【圆角形式】

```typescript
@Entry
@Component
struct BottomTabPage5 {
  tabsController: TabsController = new TabsController()
  @State tabBar: Array<TabBar> = [
    new TabBar("首页", $r("app.media.ic_home_select"), $r("app.media.ic_home_unselect")),
    new TabBar("网络", $r("app.media.ic_net_select"), $r("app.media.ic_net_unselect")),
    new TabBar("列表", $r("app.media.ic_list_select"), $r("app.media.ic_list_unselect")),
    new TabBar("组件", $r("app.media.ic_view_select"), $r("app.media.ic_view_unselect"))
  ]

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:tab 对应的页面
   * @param index 索引
   * @param item TabBar 对象，非必须
   * */
  @Builder
  itemPage(index: number, item: TabBar) {
    Text(item.title)
      .width("100%")
      .height("100%")
      .textAlign(TextAlign.Center)
      .backgroundColor("#E8E8E8")
  }

  build() {
    Column() {
      ActionBar({ title: "底部导航案例一" })

      BottomTabLayout({
        tabsController: this.tabsController,
        itemPage: this.itemPage, //tab 对应的页面
        tabSelectedColor: "#D81E06", //文字选择颜色
        tabNormalColor: Color.Black, //文字未选择颜色
        tabLabelMarginTop: 10, //文字距离图片的高度
        tabScrollable: false, //是否可以滑动
        bottomTabType: BottomTabType.ROUNDED, //底部圆角导航
        bottomTabMargin: { bottom: 40, left: "10%" },
        tabWidth: "80%",
        bottomTabBorderOptions: { radius: 30 },
        barBackgroundColor: Color.White,
        onChangePage: (position) => {
          //页面切换
          console.log("===========页面切换:" + position)
        },
        onTabBarClick: (position) => {
          //tab 点击
          console.log("===========单击:" + position)
        },
        onDoubleClick: (position) => {
          //双击
          console.log("===========双击:" + position)
        },
        onTabAppear: () => {
          this.tabsController.preloadItems([1, 2])
        },
        tabBar: this.tabBar
      })
    }.height("100%")

  }
}
```

## 更新记录

*   **1.1.2 (2025-11-17)**
    1.  优化 TabBar 传递资源
    2.  解决因左右边距导致的指示器未对齐问题
    3.  增加拦截参数，可动态控制是否拦截
*   **1.0.7 (2025-03-06)**
    1.  har 组件包新增签名，用于上架生态市场

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限要求 | 无权限要求 | 无权限要求 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @abner/tab
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/932405b44aae4c27be81a2cafb7d8a84/b6a17875746941e0b5606c9b1eb174f8?origin=template