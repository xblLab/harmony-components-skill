# 侧边分类组件 UISideCategory

## 简介

UISideCategory 是基于 open harmony 基础组件开发的组件，支持垂直滑动的一级分类和按钮式的二级分类，支持联动，只有一级分类时滚动右侧区域，左侧导航区自动切换；有二级分类时，滚动右侧区域，上方二级分类自动切换，支持自定义样式等。

## 详细介绍

### 简介

UISideCategory 是基于 open harmony 基础组件开发的组件，支持垂直滑动的一级分类和按钮式的二级分类，支持联动，只有一级分类时滚动右侧区域，左侧导航区自动切换；有二级分类时，滚动右侧区域，上方二级分类自动切换，支持自定义样式等。

### 约束与限制

#### 环境

DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
设备类型：华为手机（包括双折叠和阔折叠）、华为平板
系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

安装组件。
```bash
ohpm install @hw-agconnect/ui-side-category
```

工程配置。
Entry 模块下 src/main/ets/entryability/EntryAbility.ets 获取 UIContext 实例。
```typescript
onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
    contextUtil.setUiContext(windowStage.getMainWindowSync().getUIContext());
  });
}
```

引入组件。
```typescript
import { CategoryItem, SubCategoryItem, ItemInfo, UISideCategory } from '@hw-agconnect/ui-side-category';
```

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### 接口

#### CategoryList(options?: CategoryListOptions)

按分类展示列表组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CategoryListOptions | 是 | 分类列表组件参数 |

#### CategoryListOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| categoryTabs | CategoryItem[] | 是 | 一级分类列表数据 |
| productList | SubCategoryItem[] | 是 | 二级列表项 |
| initIndex | number | 否 | 一级分类列表初始索引，默认值为 0 |
| tabFontSize | ResourceStr | 否 | 左侧一级分类的字体大小，默认值为$r('sys.float.Body_M')，推荐范围为 12-18vp |
| tabFontWeight | FontWeight | 否 | 左侧一级分类的字重，默认值为 FontWeight.Regular |
| tabCheckedFontColor | ResourceColor | 否 | 左侧一级分类选中项的字体颜色，默认值为$r('sys.color.font_emphasize') |
| tabUncheckedFontColor | ResourceColor | 否 | 左侧一级分类未选中项的字体颜色，默认值为$r('sys.color.font_secondary') |
| tabCheckedBgColor | ResourceColor | 否 | 左侧一级分类选中项的背景颜色，默认值为'' |
| tabUncheckedBgColor | ResourceColor | 否 | 左侧一级分类未选中项的背景颜色，默认值为'' |
| subFontSize | ResourceStr | 否 | 上方二级分类的字体大小，默认值为$r('sys.float.Body_M')，推荐范围为 12-18vp |
| subFontWeight | FontWeight | 否 | 上方二级分类的字重，默认值为 FontWeight.Regular |
| subCheckedFontColor | ResourceColor | 否 | 上方二级分类选中项的字体颜色，默认值为$r('sys.color.font_on_primary') |
| subUncheckedFontColor | ResourceColor | 否 | 上方二级分类未选中项的字体颜色，默认值为$r('sys.color.font_primary') |
| subCheckedBgColor | ResourceColor | 否 | 上方二级分类选中项的背景颜色，默认值为$r('sys.color.background_emphasize') |
| subUncheckedBgColor | ResourceColor | 否 | 上方二级分类未选中项的背景颜色，默认值为$r('sys.color.background_tertiary') |
| showLeftBar | boolean | 否 | 左侧一级分类选中项是否显示标识条，默认值为 false |
| leftBarHeight | string \| number | 否 | 左侧一级分类选中项标识条的高度，默认值为 20vp |
| leftBarWidth | string \| number | 否 | 左侧一级分类选中项标识条的宽度，默认值为 2vp |
| leftBarColor | ResourceColor | 否 | 左侧一级分类选中项标识条的颜色，默认值为$r('sys.color.icon_emphasize') |
| tabBarScroller | Scroller | 否 | 一级分类滚动控制器 |
| subBarScroller | Scroller | 否 | 二级分类滚动控制器 |
| scroller | Scroller | 否 | 二级列表项滚动控制器 |
| headerBuilderParam | Param(label: string) => void | 是 | 自定义二级列表项头部组件的内容 |
| contentBuilderParam | Param(item: RepeatItem<SubCategoryItem>) => void | 是 | 自定义二级列表项组件的内容 |
| onTabClick | Param(tabItem: CategoryItem) => void | 否 | 点击左侧一级分类触发的回调 |

#### CategoryItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 一级分类 id |
| label | string | 是 | 一级分类名称 |
| subCategoryId | string[] | 否 | 一级分类所包含的二级子分类 id |

#### SubCategoryItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 二级分类 id |
| label | string | 是 | 二级分类名称 |
| itemList | ItemInfo[] | 是 | 二级分类包含的列表 |

#### ItemInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | id |
| title | string | 是 | 名称 |
| description | string | 否 | 描述 |
| imgSrc | ResourceStr | 否 | 缩略图 |

### 示例代码

#### 示例 1（宫格分类）

```typescript
import { CategoryItem, SubCategoryItem, ItemInfo, UISideCategory } from '@hw-agconnect/ui-side-category';

@Entry
@ComponentV2
struct CategoryListSample {
  @Local currentIndex: number = 0

  build() {
    NavDestination() {
      RelativeContainer() {
        UISideCategory({
          categoryTabs: this.tabList,
          productList: this.recipeCategoryList,
          initIndex: this.currentIndex,
          tabBarScroller: new Scroller(),
          subBarScroller: new Scroller(),
          scroller: new Scroller(),
          headerBuilderParam: this.headerBuilder,
          contentBuilderParam: this.contentBuilder,
          onTabClick: (tabItem: CategoryItem) => {
            this.getProductList(tabItem)
          },
        })
      }.height('100%').width('100%')
    }.title('宫格分类')
  }

  @Builder
  headerBuilder(label: string) {
    if (label.length) {
      Row() {
        Text(label)
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      }
      .margin({ bottom: 12 })
    }
  }

  @Builder
  contentBuilder(obj: RepeatItem<SubCategoryItem>) {
    Grid() {
      Repeat(obj.item.itemList)
        .each((gridItem: RepeatItem<ItemInfo>) => {
          GridItem() {
            Column() {
              Image(gridItem.item.imgSrc)
                .borderRadius(8)
                .width(96)
                .height(96)
              Text(gridItem.item.title)
                .fontSize($r('sys.float.Body_M'))
                .fontWeight(FontWeight.Medium)
                .fontColor($r('sys.color.font_primary'))
                .textAlign(TextAlign.Center)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: 8 })
            }
          }
        })
        .key((item: ItemInfo) => JSON.stringify(item))
    }
    .rowsGap(12)
    .columnsGap(16)
  }

  getProductList(tabItem: CategoryItem) {
    switch (tabItem.id) {
      case '1':
        this.recipeCategoryList = this.list1;
        break;
      case '2':
        this.recipeCategoryList = this.list2;
        break;
      case '3':
        this.recipeCategoryList = this.list3;
        break;
      default:
        this.recipeCategoryList = [];
        break;
    }
  }

  @Local list1: SubCategoryItem[] = [{
    id: '1001',
    label: '热门菜肴',
    itemList: [{
      id: '1001_1',
      title: '西红柿牛腩 1001',
      imgSrc: $r('app.media.startIcon'),
      description: '牛肉软烂，汤汁浓郁。'
    },
      {
        id: '1001_2',
        title: '可乐鸡翅',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，甜香可口的家常美食。'
      },
      {
        id: '1001_3',
        title: '宫保鸡丁',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的中式家常菜，鸡肉鲜嫩，花生米香脆，口味香辣酸甜。'
      },
      {
        id: '1001_4',
        title: '鱼香肉丝',
        imgSrc: $r('app.media.startIcon'),
        description: '具有鱼香味的经典川菜，肉丝鲜嫩，配菜丰富。'
      },
      {
        id: '1001_5',
        title: '糖醋排骨',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，口味酸甜的经典家常菜。'
      }],
  }, {
    id: '1002',
    label: '家常菜',
    itemList: [{
      id: '1002_1',
      title: '清蒸鱼 1002',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    }, {
      id: '1002_2',
      title: '油焖大虾',
      imgSrc: $r('app.media.startIcon'),
      description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
    },
      {
        id: '1002_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '1002_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '1003',
    label: '下饭菜',
    itemList: [{
      id: '1003_1',
      title: '清蒸鱼 1003',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1003_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1003_3',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '1004',
    label: '快手菜',
    itemList: [{
      id: '1004_1',
      title: '清蒸鱼 1004',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1004_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1004_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '1005',
    label: '肉类',
    itemList: [{
      id: '1005_1',
      title: '清蒸鱼 1005',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1005_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1005_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '1006',
    label: '夜宵',
    itemList: [{
      id: '1006_1',
      title: '清蒸鱼 1006',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1006_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1006_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }];
  @Local list2 : SubCategoryItem[] = [{
    id: '2001',
    label: '海鲜',
    itemList: [{
      id: '2001_1',
      title: '清蒸鱼 2001',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2001_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2001_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '2001_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      },
      {
        id: '2001_5',
        title: '地三鲜',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的东北素菜，鲜香下饭。'
      }],
  }, {
    id: '2002',
    label: '热门菜肴',
    itemList: [{
      id: '2002_1',
      title: '西红柿牛腩 2002',
      imgSrc: $r('app.media.startIcon'),
      description: '牛肉软烂，汤汁浓郁，酸甜可口。'
    },
      {
        id: '2002_2',
        title: '可乐鸡翅',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，甜香可口的家常美食。'
      },
      {
        id: '2002_3',
        title: '宫保鸡丁',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的中式家常菜，鸡肉鲜嫩，花生米香脆，口味香辣酸甜。'
      },
      {
        id: '2002_4',
        title: '鱼香肉丝',
        imgSrc: $r('app.media.startIcon'),
        description: '具有鱼香味的经典川菜，肉丝鲜嫩，配菜丰富。'
      },
      {
        id: '2002_5',
        title: '糖醋排骨',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，口味酸甜的经典家常菜。'
      }],
  }, {
    id: '2003',
    label: '蔬菜',
    itemList: [{
      id: '2003_1',
      title: '清蒸鱼 2003',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2003_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2003_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '2003_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '2004',
    label: '豆制品',
    itemList: [{
      id: '2004_1',
      title: '清蒸鱼 2004',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2004_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2004_3',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }];
  @Local list3: SubCategoryItem[] =[{
    id: '3001',
    label: '家常菜',
    itemList: [{
      id: '3001_1',
      title: '清蒸鱼 3001',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '3001_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '3001_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '3002',
    label: '下饭菜',
    itemList: [{
      id: '3002_1',
      title: '清蒸鱼',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '3002_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '3002_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '3002_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      },
      {
        id: '3002_5',
        title: '地三鲜',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的东北素菜，鲜香下饭。'
      }],
  }]
  @Local recipeCategoryList: SubCategoryItem[] = this.list1
  @Local tabList: CategoryItem[] = [{
    id: '1',
    label: '分类 1',
    subCategoryId: ['1001', '1002', '1003', '1004', '1005', '1006'],
  }, {
    id: '2',
    label: '分类 2',
    subCategoryId: ['2001', '2002', '2003', '2004'],
  }, {
    id: '3',
    label: '分类 3',
    subCategoryId: ['3001', '3002'],
  }];
}
```

#### 示例 2（列表分类）

```typescript
import { CategoryItem, SubCategoryItem, ItemInfo, UISideCategory } from '@hw-agconnect/ui-side-category';

@Entry
@ComponentV2
struct CategoryListSample {
  @Local currentIndex: number = 0

  build() {
    NavDestination() {
      RelativeContainer() {
        UISideCategory({
          categoryTabs: this.tabList,
          productList: this.recipeCategoryList,
          initIndex: this.currentIndex,
          showLeftBar: true,
          tabUncheckedBgColor: '#F1F3F5',
          tabBarScroller: new Scroller(),
          subBarScroller: new Scroller(),
          scroller: new Scroller(),
          headerBuilderParam: this.headerBuilder,
          contentBuilderParam: this.contentBuilder,
          onTabClick: (tabItem: CategoryItem) => {
            this.getProductList(tabItem)
          },
        })
      }.height('100%').width('100%')
    }.title('列表分类')
  }

  @Builder
  headerBuilder(label: string) {
    if (label.length) {
      Row() {
        Text(label)
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      }
      .margin({ bottom: 12 })
    }
  }

  @Builder
  contentBuilder(obj: RepeatItem<SubCategoryItem>) {
    List({ space: 12 }) {
      Repeat(obj.item.itemList)
        .each((listItem: RepeatItem<ItemInfo>) => {
          ListItem() {
            Row() {
              Image(listItem.item.imgSrc)
                .width(96)
                .height(72)
                .borderRadius(8)
                .margin({ right: 8 })

              Column({ space: 4 }) {
                Text(listItem.item.title)
                  .fontSize($r('sys.float.Body_M'))
                  .fontWeight(FontWeight.Medium)
                  .fontColor($r('sys.color.font_primary'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(2)
                  .width('100%')
                Text(listItem.item.description)
                  .fontSize($r('sys.float.Body_M'))
                  .fontWeight(FontWeight.Regular)
                  .fontColor($r('sys.color.font_secondary'))
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
          }
        })
        .key((item: ItemInfo) => JSON.stringify(item))
    }
  }

  getProductList(tabItem: CategoryItem) {
    switch (tabItem.id) {
      case '1':
        this.recipeCategoryList = this.list1;
        break;
      case '2':
        this.recipeCategoryList = this.list2;
        break;
      case '3':
        this.recipeCategoryList = this.list3;
        break;
      default:
        this.recipeCategoryList = [];
        break;
    }
  }

  @Local list1: SubCategoryItem[] = [{
    id: '1001',
    label: '热门菜肴',
    itemList: [{
      id: '1001_1',
      title: '西红柿牛腩 1001',
      imgSrc: $r('app.media.startIcon'),
      description: '牛肉软烂，汤汁浓郁。'
    },
      {
        id: '1001_2',
        title: '可乐鸡翅',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，甜香可口的家常美食。'
      },
      {
        id: '1001_3',
        title: '宫保鸡丁',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的中式家常菜，鸡肉鲜嫩，花生米香脆，口味香辣酸甜。'
      },
      {
        id: '1001_4',
        title: '鱼香肉丝',
        imgSrc: $r('app.media.startIcon'),
        description: '具有鱼香味的经典川菜，肉丝鲜嫩，配菜丰富。'
      },
      {
        id: '1001_5',
        title: '糖醋排骨',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，口味酸甜的经典家常菜。'
      }],
  }, {
    id: '1002',
    label: '家常菜',
    itemList: [{
      id: '1002_1',
      title: '清蒸鱼 1002',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    }, {
      id: '1002_2',
      title: '油焖大虾',
      imgSrc: $r('app.media.startIcon'),
      description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
    },
      {
        id: '1002_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '1002_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '1003',
    label: '下饭菜',
    itemList: [{
      id: '1003_1',
      title: '清蒸鱼 1003',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1003_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1003_3',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '1004',
    label: '快手菜',
    itemList: [{
      id: '1004_1',
      title: '清蒸鱼 1004',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1004_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1004_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '1005',
    label: '肉类',
    itemList: [{
      id: '1005_1',
      title: '清蒸鱼 1005',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1005_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1005_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '1006',
    label: '夜宵',
    itemList: [{
      id: '1006_1',
      title: '清蒸鱼 1006',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '1006_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '1006_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }];
  @Local list2 : SubCategoryItem[] = [{
    id: '2001',
    label: '海鲜',
    itemList: [{
      id: '2001_1',
      title: '清蒸鱼 2001',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2001_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2001_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '2001_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      },
      {
        id: '2001_5',
        title: '地三鲜',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的东北素菜，鲜香下饭。'
      }],
  }, {
    id: '2002',
    label: '热门菜肴',
    itemList: [{
      id: '2002_1',
      title: '西红柿牛腩 2002',
      imgSrc: $r('app.media.startIcon'),
      description: '牛肉软烂，汤汁浓郁，酸甜可口。'
    },
      {
        id: '2002_2',
        title: '可乐鸡翅',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，甜香可口的家常美食。'
      },
      {
        id: '2002_3',
        title: '宫保鸡丁',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的中式家常菜，鸡肉鲜嫩，花生米香脆，口味香辣酸甜。'
      },
      {
        id: '2002_4',
        title: '鱼香肉丝',
        imgSrc: $r('app.media.startIcon'),
        description: '具有鱼香味的经典川菜，肉丝鲜嫩，配菜丰富。'
      },
      {
        id: '2002_5',
        title: '糖醋排骨',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，口味酸甜的经典家常菜。'
      }],
  }, {
    id: '2003',
    label: '蔬菜',
    itemList: [{
      id: '2003_1',
      title: '清蒸鱼 2003',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2003_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2003_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '2003_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }, {
    id: '2004',
    label: '豆制品',
    itemList: [{
      id: '2004_1',
      title: '清蒸鱼 2004',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '2004_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '2004_3',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      }],
  }];
  @Local list3: SubCategoryItem[] =[{
    id: '3001',
    label: '家常菜',
    itemList: [{
      id: '3001_1',
      title: '清蒸鱼 3001',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '3001_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '3001_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      }],
  }, {
    id: '3002',
    label: '下饭菜',
    itemList: [{
      id: '3002_1',
      title: '清蒸鱼',
      imgSrc: $r('app.media.startIcon'),
      description: '清淡鲜美，保留鱼的原汁原味，营养丰富。'
    },
      {
        id: '3002_2',
        title: '油焖大虾',
        imgSrc: $r('app.media.startIcon'),
        description: '色泽红亮，虾肉鲜嫩，味道浓郁。'
      },
      {
        id: '3002_3',
        title: '清炒西兰花',
        imgSrc: $r('app.media.startIcon'),
        description: '一道清爽可口的素菜，西兰花营养丰富。'
      },
      {
        id: '3002_4',
        title: '醋溜白菜',
        imgSrc: $r('app.media.startIcon'),
        description: '酸甜可口，开胃下饭的醋溜白菜。'
      },
      {
        id: '3002_5',
        title: '地三鲜',
        imgSrc: $r('app.media.startIcon'),
        description: '经典的东北素菜，鲜香下饭。'
      }],
  }]
  @Local recipeCategoryList: SubCategoryItem[] = this.list1
  @Local tabList: CategoryItem[] = [{
    id: '1',
    label: '分类 1',
    subCategoryId: ['1001', '1002', '1003', '1004', '1005', '1006'],
  }, {
    id: '2',
    label: '分类 2',
    subCategoryId: ['2001', '2002', '2003', '2004'],
  }, {
    id: '3',
    label: '分类 3',
    subCategoryId: ['3001', '3002'],
  }];
}
```

## 更新记录

### 1.0.0 (2026-01-27)

Created with Pixso.

下载该版本

初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

隐私政策：不涉及

SDK 合规使用指南：不涉及

Created with Pixso.

### 基本信息

Created with Pixso.

### 兼容性

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
| 6.0.2 | Created with Pixso. |

Created with Pixso.

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

Created with Pixso.

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

Created with Pixso.

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |
| DevEco Studio 6.0.2 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-side-category
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e2a5ad8398f44fcfb3e3044cf2bd74c5/2adce9bbd4cb42d58a87e6add45594b3?origin=template