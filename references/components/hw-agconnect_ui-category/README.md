# 分类 UICategory

## 简介

UICategory 是基于 open harmony 基础组件开发的分类组件，支持单级分类、多级分类。

## 详细介绍

### 简介

UICategory 是基于 open harmony 基础组件开发的分类组件，支持单级分类、多级分类。

### 约束与限制

#### 环境

DevEco Studio 版本：DevEco Studio5.0.0 Release 及以上
HarmonyOS SDK 版本：HarmonyOS5.0.0 Release SDK 及以上
设备类型：华为手机（包括双折叠和阔折叠）和 华为平板
系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

安装组件。

```bash
ohpm install @hw-agconnect/ui-base;
ohpm install @hw-agconnect/ui-category;
```

当前模板已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.1 版本模板。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-base;
ohpm install @hw-agconnect/ui-category@1.0.1;
```

引入组件。

```ets
// 在应用的入口文件进行初始化，比如说 EntryAbility.ets
import { UIBase } from '@hw-agconnect/ui-base';

onWindowStageCreate(windowStage: window.WindowStage): void {
  UIBase.init(windowStage);
}

// 引入组件
import { UICategory } from '@hw-agconnect/ui-category';
```

调用组件，详细参数配置说明参见 API 参考。

```ets
UICategory({
  title: '标题',
  type: TypeCategory.SINGLE,
  options: [this.options],
  isLayoutFullScreen: false,
  buildContentParam: () => {
    this.buildContent()
  },
})
```

## API 参考

### 子组件

无

### 接口

UICategory(options: UICategoryOptions)

分类组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICategoryOptions | 是 | 配置分类组件的参数。 |

##### UICategoryOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | TypeCategory | 否 | 分类类别，默认是一级分类，TypeCategory.SINGLE |
| title | string \| Resource | 是 | 页面标题 |
| backIconResource | Resource | 否 | 自定义返回图标 |
| searchIconResource | Resource | 否 | 自定义搜索图标 |
| customFontSizeLength | Length | 否 | 自定义按钮文字大小，默认值 14vp |
| customPopFontSizeLength | Length | 否 | 自定义气泡按钮文字大小，默认值 16vp |
| customSelectedColorResourceColor | ResourceColor | 否 | 自定义按钮选中后的文字颜色 |
| defaultFontColorResourceColor | ResourceColor | 否 | 自定义按钮默认的文字颜色 |
| customSelectedBgColorResourceColor | ResourceColor | 否 | 自定义按钮选中后的背景色 |
| defaultBgColorResourceColor | ResourceColor | 否 | 自定义按钮默认的背景色 |
| customBtnHLength | Length | 否 | 单个按钮的高度，单列默认值 36，多列默认值 28 |
| customBtnWLength | Length | 否 | 单个按钮的宽度，默认自适应，但限制在最小宽度和最大宽度之间 |
| btnMinWidthLength | Length | 否 | 单个按钮最小宽度，默认值 80，限制不可小于 40 |
| btnMaxWidthLength | Length | 否 | 单个按钮最大宽度，默认值 130，限制不可大于 200 |
| options | CategoryList[] | 是 | 按钮数据 |
| isLayoutFullScreen | boolean | 否 | 是当前窗口是否为沉浸式，默认值 true |
| showBackIcon | boolean | 否 | 是否展示返回按钮，默认值 true |
| showSearchIcon | boolean | 否 | 是否展示搜索按钮，默认值 true |
| defaultSelectFirst | boolean | 否 | 是否默认所有类目的第一项，默认值 true，当 defaultSelectIndex 不设置或者设置为空数组时生效 |
| defaultSelectIndex | number[] | 否 | 默认初始选择项索引数组 |
| briefLabelWithParentInfo | boolean | 否 | 缩略 label 是否含有父类信息，默认值 false，只对多级分类生效 |
| customBriefLabel | string \| Resource | 否 | 自定义简化的 label，只对多级分类生效 |
| enableBriefLabel | boolean | 否 | 是否启用简化 label，只对多级分类生效，默认值 true |
| buildTitleBar | callback: () => void | 否 | 自定义标题栏 |
| buildContentParam | callback: () => void | 是 | 自定义内容区。当 enableBriefLabel 设置为 true 时，自定义内容区仅支持 Scroll、List 容器组件。 |
| onSelected | callback: (selected: Map<string, CategoryItem>, index:number[]) => void | 否 | 点击分类后触发该事件，参数 selected 为当前所选择的分类，参数 index 为当前所选择的索引数组 |
| onSearch | callback: () => void | 否 | 搜索按钮的 onClick 事件 |
| onBack | callback: () => void | 否 | 顶部标题栏中返回按钮的 onClick 事件 |

#### 枚举说明

##### TypeCategory 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| SINGLE | 单级分类 |
| MULTIPLE | 多级分类 |

#### 对象说明

##### CategoryList 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 分类 id，唯一索引 |
| label | string \| Resource | 是 | 分类文字描述 |
| items | CategoryItem[] | 是 | 分类所包含的条目 |

##### CategoryItem 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 是每个子分类的 id，唯一索引 |
| label | string \| Resource | 是 | 是每个子分类的文字展示 |
| disabled | boolean | 否 | 是否禁选，默认值 false |
| handler | () => void | 否 | 每个子分类点击后的 onClick 事件 |

## 示例代码

### 示例 1（单级分类）

```ets
import { UICategory, CategoryList, CategoryItem, TypeCategory } from '@hw-agconnect/ui-category';
import { AppStorageV2 } from '@kit.ArkUI';

@ObservedV2
export class EnableImmersiveConfig {
  @Trace enableImmersive: boolean = false;
}

@Entry
@ComponentV2
struct Index {
  @Local config: EnableImmersiveConfig = AppStorageV2.connect(
    EnableImmersiveConfig, 'UI.Immersive', () => new EnableImmersiveConfig()
  )!;
  @Local options: CategoryList = new CategoryList('itemA', 'itemA', [
    new CategoryItem('itemA1', 'AAAAA'),
    new CategoryItem('itemA2', 'AAAAA'),
    new CategoryItem('itemA3', 'AAAAA'),
    new CategoryItem('itemA4', 'AAAAA'),
    new CategoryItem('itemA5', 'AAAAA'),
    new CategoryItem('itemA6', 'AAAAA'),
    new CategoryItem('itemA7', 'AAAAA'),
    new CategoryItem('itemA8', 'AAAAA'),
    new CategoryItem('itemA9', 'AAAAA'),
    new CategoryItem('itemA10', 'AAAAA'),
  ]);
  @Local contentList: string[] = ['1', '2', '3', '4', '5'];

  @Builder
  buildContent() {
    Scroll() {
      Column({ space: 10 }) {
        ForEach(this.contentList, (item: string) => {
          Text(item)
            .width('100%')
            .height(200)
            .backgroundColor(Color.White)
            .textAlign(TextAlign.Center)
            .borderRadius(12)
        })
      }.padding(16)
    }
  }

  build() {
    Row() {
      Column() {
        UICategory({
          title: '单级分类',
          type: TypeCategory.SINGLE,
          showBackIcon: true,
          showSearchIcon: true,
          isLayoutFullScreen: this.config.enableImmersive,
          options: [this.options],
          buildContentParam: () => {
            this.buildContent()
          },
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

### 示例 2（多级分类）

```ets
import { UICategory, CategoryList, CategoryItem, TypeCategory, CategoryListArray } from '@hw-agconnect/ui-category';
import { AppStorageV2 } from '@kit.ArkUI';

@ObservedV2
export class EnableImmersiveConfig {
  @Trace enableImmersive: boolean = false;
}

@Entry
@ComponentV2
struct Index {
  @Local config: EnableImmersiveConfig = AppStorageV2.connect(
    EnableImmersiveConfig, 'UI.Immersive', () => new EnableImmersiveConfig()
  )!;
  private scroller: Scroller = new Scroller();
  @Local options: CategoryListArray = [
    new CategoryList('itemA', 'itemA', [
      new CategoryItem('itemA1', 'AAAAA'),
      new CategoryItem('itemA2', 'AAAAA'),
      new CategoryItem('itemA3', 'AAAAA'),
      new CategoryItem('itemA4', 'AAAAA'),
      new CategoryItem('itemA5', 'AAAAA'),
      new CategoryItem('itemA6', 'AAAAA'),
      new CategoryItem('itemA7', 'AAAAA'),
      new CategoryItem('itemA8', 'AAAAA'),
      new CategoryItem('itemA9', 'AAAAA'),
      new CategoryItem('itemA10', 'AAAAA'),
    ]),
    new CategoryList('itemB', 'itemB', [
      new CategoryItem('itemB1', 'BBBBB'),
      new CategoryItem('itemB2', 'BBBBB'),
      new CategoryItem('itemB3', 'BBBBB'),
      new CategoryItem('itemB4', 'BBBBB'),
      new CategoryItem('itemB5', 'BBBBB'),
      new CategoryItem('itemB6', 'BBBBB'),
      new CategoryItem('itemB7', 'BBBBB'),
      new CategoryItem('itemB8', 'BBBBB'),
      new CategoryItem('itemB9', 'BBBBB'),
      new CategoryItem('itemB10', 'BBBBB'),
    ]),
    new CategoryList('itemC', 'itemC', [
      new CategoryItem('itemC1', 'CCCCC'),
      new CategoryItem('itemC2', 'CCCCC'),
      new CategoryItem('itemC3', 'CCCCC'),
      new CategoryItem('itemC4', 'CCCCC'),
      new CategoryItem('itemC5', 'CCCCC'),
      new CategoryItem('itemC6', 'CCCCC'),
      new CategoryItem('itemC7', 'CCCCC'),
      new CategoryItem('itemC8', 'CCCCC'),
      new CategoryItem('itemC9', 'CCCCC'),
      new CategoryItem('itemC10', 'CCCCC'),
    ]),
  ];
  @Local contentList: string[] = ['1', '2', '3', '4', '5', '6', '7'];

  @Builder
  buildContent() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        ForEach(this.contentList, (item: string) => {
          Text(item)
            .width('100%')
            .height(300)
            .backgroundColor(Color.White)
            .textAlign(TextAlign.Center)
            .borderRadius(12)
        })
      }.padding(16)
    }
    .width('100%')
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST,
    })
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off)
  }

  build() {
    Row() {
      Column() {
        UICategory({
          title: '多级分类',
          type: TypeCategory.MULTIPLE,
          options: this.options,
          isLayoutFullScreen: this.config.enableImmersive,
          buildContentParam: () => {
            this.buildContent()
          },
          onSelected: () => {
            this.scroller.scrollTo({ xOffset: 0, yOffset: 0, animation: { duration: 0 } })
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

### 示例 3（歌手）

```ets
import { UICategory, CategoryList, CategoryItem, TypeCategory, CategoryListArray } from '@hw-agconnect/ui-category';
import { AppStorageV2 } from '@kit.ArkUI';

@ObservedV2
export class EnableImmersiveConfig {
  @Trace enableImmersive: boolean = false;
}

class Singer {
  name: string = '';
  followers: number = 0;
  langId: string = '';
  genderId: string = '';
  typeId: string = '';

  constructor(name: string, followers: number, langId: string, genderId: string, typeId: string) {
    this.name = name;
    this.followers = followers;
    this.langId = langId;
    this.genderId = genderId;
    this.typeId = typeId;
  }
}

@Entry
@ComponentV2
struct Index {
  @Local config: EnableImmersiveConfig = AppStorageV2.connect(
    EnableImmersiveConfig, 'UI.Immersive', () => new EnableImmersiveConfig()
  )!;
  @Local customBtnBgColor: ResourceColor = '#E84026';
  @Local selected: Map<string, CategoryItem> = new Map();
  @Local options: CategoryListArray = [
    new CategoryList('111', '语种', [
      new CategoryItem('itemA0', '全部'),
      new CategoryItem('itemA1', '华语'),
      new CategoryItem('itemA2', '英语'),
      new CategoryItem('itemA3', '粤语'),
      new CategoryItem('itemA4', '日语'),
      new CategoryItem('itemA5', '韩语'),
      new CategoryItem('itemA6', '其他'),
    ]),
    new CategoryList('222', '性别', [
      new CategoryItem('itemB0', '全部'),
      new CategoryItem('itemB1', '男歌手'),
      new CategoryItem('itemB2', '女歌手'),
      new CategoryItem('itemB3', '组合'),
    ]),
    new CategoryList('333', '类型', [
      new CategoryItem('itemC0', '全部'),
      new CategoryItem('itemC1', '流行'),
      new CategoryItem('itemC2', '电子'),
      new CategoryItem('itemC3', '摇滚'),
      new CategoryItem('itemC4', '古风'),
      new CategoryItem('itemC5', '轻音乐'),
      new CategoryItem('itemC6', '说唱'),
      new CategoryItem('itemC7', '另类/独立'),
    ]),
  ];
  @Local contentList: Singer[] = [
    new Singer('陈奕迅', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('林俊杰', 200, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('周深', 100, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('王菲', 300, 'itemA1', 'itemB2', 'itemC1'),
    new Singer('孙燕姿', 150, 'itemA1', 'itemB2', 'itemC1'),
    new Singer('毛不易', 170, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('郭顶', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('陈粒', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('许嵩', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('方大同', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('莫文蔚', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('陈楚生', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('周传雄', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('徐佳莹', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('胡彦斌', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('蔡依林', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('王心凌', 217, 'itemA1', 'itemB1', 'itemC1'),
    new Singer('唐朝乐队', 217, 'itemA1', 'itemB3', 'itemC3'),
    new Singer('新裤子乐队', 217, 'itemA1', 'itemB3', 'itemC3'),
    new Singer('Justin Bieber', 217, 'itemA2', 'itemB1', 'itemC1'),
    new Singer('Alan Walker', 217, 'itemA2', 'itemB1', 'itemC1'),
    new Singer('Justin Bieber123', 217, 'itemA2', 'itemB2', 'itemC1'),
    new Singer('Alan Walker123', 217, 'itemA2', 'itemB2', 'itemC1'),
    new Singer('Alan Walker456', 217, 'itemA4', 'itemB2', 'itemC1'),
    new Singer('陈奕迅 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('林俊杰 33', 200, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('周深 33', 100, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('王菲 33', 300, 'itemA3', 'itemB2', 'itemC1'),
    new Singer('孙燕姿 33', 150, 'itemA3', 'itemB2', 'itemC1'),
    new Singer('毛不易 33', 170, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('郭顶 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('陈粒 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('许嵩 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('方大同 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('莫文蔚 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('陈楚生 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('周传雄 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('徐佳莹 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('胡彦斌 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('蔡依林 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('王心凌 33', 217, 'itemA3', 'itemB1', 'itemC1'),
    new Singer('唐朝乐队 33', 217, 'itemA3', 'itemB3', 'itemC3'),
    new Singer('新裤子乐队 33', 217, 'itemA3', 'itemB3', 'itemC3'),
    new Singer('Justin Bieber33', 217, 'itemA2', 'itemB1', 'itemC1'),
    new Singer('Alan Walker33', 217, 'itemA2', 'itemB1', 'itemC1'),
  ];
  private scroller: Scroller = new Scroller();

  onSelect(selected: Map<string, CategoryItem>) {
    this.selected = selected;
    this.scroller.scrollTo({ xOffset: 0, yOffset: 0, animation: { duration: 0 } })
  }

  getList() {
    return this.contentList.filter((item) => {
      const langIdSelected = this.selected.get('111')?.id;
      const genderIdSelected = this.selected.get('222')?.id;
      const typeIdSelected = this.selected.get('333')?.id;

      return (item.langId === langIdSelected || 'itemA0' === langIdSelected)
        && (item.genderId === genderIdSelected || 'itemB0' === genderIdSelected)
        && (item.typeId === typeIdSelected || 'itemC0' === typeIdSelected);
    })
  }

  @Builder
  buildContent() {
    Column() {
      List({ space: 10, scroller: this.scroller }) {
        ForEach(this.getList(), (item: Singer) => {
          ListItem() {
            Row() {
              Row({ space: 12 }) {
                // 替换为实际存在的资源
                Image($r('app.media.ic_user_portrait')).width(50).height(50)
                Column({ space: 4 }) {
                  Text(item.name).fontSize($r('sys.float.ohos_id_text_size_body1'))
                  Text(`粉丝${item.followers.toString()}万`)
                    .fontSize($r('sys.float.ohos_id_text_size_body2'))
                    .fontColor(Color.Grey)
                }.constraintSize({ maxWidth: '80%' }).alignItems(HorizontalAlign.Start)
              }

              Button() {
                Row({ space: 4 }) {
                  // 替换为实际存在的资源
                  Image($r('app.media.ic_public_add')).width(16).height(16).fillColor(this.customBtnBgColor)
                  Text('关注').fontSize($r('sys.float.ohos_id_text_size_button3')).fontColor(this.customBtnBgColor)
                }.width(70).height(30).justifyContent(FlexAlign.Center)
              }.backgroundColor($r('sys.color.ohos_id_color_background'))
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)
          }
          .stateStyles({
            pressed: { .backgroundColor($r('sys.color.ohos_id_color_click_effect'))
            },
          })
        })
      }
      .width('100%')
      .padding(16)
      .divider({
        strokeWidth: 0.5,
        color: Color.Grey,
        startMargin: 10,
        endMargin: 10
      })
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST,
      })
    }
    .width('100%')
  }

  build() {
    Row() {
      Column() {
        UICategory({
          type: TypeCategory.MULTIPLE,
          title: '歌手',
          options: this.options,
          isLayoutFullScreen: this.config.enableImmersive,
          customSelectedBgColor: this.customBtnBgColor,
          showSearchIcon: false,
          buildContentParam: () => {
            this.buildContent()
          },
          onSelected: (selected) => {
            this.onSelect(selected);
          },
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

### 示例 4（初始化和回调）

```ets
import { UICategory, CategoryList, CategoryItem, TypeCategory, CategoryListArray } from '@hw-agconnect/ui-category';
import { AppStorageV2, promptAction } from '@kit.ArkUI';

@ObservedV2
export class EnableImmersiveConfig {
  @Trace enableImmersive: boolean = false;
}

@Entry
@ComponentV2
struct Index {
  @Local config: EnableImmersiveConfig = AppStorageV2.connect(
    EnableImmersiveConfig, 'UI.Immersive', () => new EnableImmersiveConfig(),
  )!;
  private scroller: Scroller = new Scroller();
  @Local options: CategoryListArray = [
    new CategoryList('itemA', 'itemA', [
      new CategoryItem('itemA1', 'AAAAA'),
      new CategoryItem('itemA2', 'AAAAA'),
      new CategoryItem('itemA3', 'AAAAA'),
      new CategoryItem('itemA4', 'AAAAA'),
      new CategoryItem('itemA5', 'AAAAA'),
      new CategoryItem('itemA6', 'AAAAA'),
      new CategoryItem('itemA7', 'AAAAA'),
      new CategoryItem('itemA8', 'AAAAA'),
      new CategoryItem('itemA9', 'AAAAA'),
      new CategoryItem('itemA10', 'AAAAA'),
    ]),
    new CategoryList('itemB', 'itemB', [
      new CategoryItem('itemB1', 'BBBBB'),
      new CategoryItem('itemB2', 'BBBBB'),
      new CategoryItem('itemB3', 'BBBBB'),
      new CategoryItem('itemB4', 'BBBBB'),
      new CategoryItem('itemB5', 'BBBBB'),
      new CategoryItem('itemB6', 'BBBBB'),
      new CategoryItem('itemB7', 'BBBBB'),
      new CategoryItem('itemB8', 'BBBBB'),
      new CategoryItem('itemB9', 'BBBBB'),
      new CategoryItem('itemB10', 'BBBBB'),
    ]),
    new CategoryList('itemC', 'itemC', [
      new CategoryItem('itemC1', 'CCCCC'),
      new CategoryItem('itemC2', 'CCCCC'),
      new CategoryItem('itemC3', 'CCCCC'),
      new CategoryItem('itemC4', 'CCCCC'),
      new CategoryItem('itemC5', 'CCCCC'),
      new CategoryItem('itemC6', 'CCCCC'),
      new CategoryItem('itemC7', 'CCCCC'),
      new CategoryItem('itemC8', 'CCCCC'),
      new CategoryItem('itemC9', 'CCCCC'),
      new CategoryItem('itemC10', 'CCCCC'),
    ]),
  ];
  @Local contentList: string[] = ['1', '2', '3', '4', '5', '6', '7'];

  @Builder
  buildContent() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        ForEach(this.contentList, (item: string) => {
          Text(item)
            .width('100%')
            .height(300)
            .backgroundColor(Color.White)
            .textAlign(TextAlign.Center)
            .borderRadius(12)
        })
      }.padding(16)
    }
    .width('100%')
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST,
    })
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off)
  }

  build() {
    Row() {
      Column() {
        UICategory({
          title: 'Category Init',
          type: TypeCategory.MULTIPLE,
          defaultSelectIndex: [9, 9, 9],
          options: this.options,
          isLayoutFullScreen: this.config.enableImmersive,
          briefLabelWithParentInfo: true,
          buildContentParam: () => {
            this.buildContent()
          },
          onSelected: (map, index) => {
            promptAction.showToast({ message: '已选择索引数组:' + index.toString() });
          },
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

## 更新记录

### 2.0.2 (2025-12-12)

Created with Pixso.

下载该版本内部资源

### 2.0.1 (2025-12-02)

Created with Pixso.

下载该版本支持设置默认选择。选择回调事件，新增已选择的类目索引数组。支持定制按钮宽高和颜色，文字大小和颜色。

### 2.0.0 (2025-10-23)

Created with Pixso.

下载该版本从 2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.X 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

### 1.0.1 (2025-09-30)

Created with Pixso.

下载该版本更新组件描述、关键词、主页等信息

### 权限与隐私

基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

隐私政策不涉及

SDK 合规使用指南 不涉及

### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.0 |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |

| 应用类型 |
| :--- |
| 应用 |
| 元服务 |

| 设备类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

| DevEcoStudio 版本 |
| :--- |
| DevEco Studio 5.0.0 |
| DevEco Studio 5.0.1 |
| DevEco Studio 5.0.2 |
| DevEco Studio 5.0.3 |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @hw-agconnect/ui-category
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/eb79c5eecce84ce8aac261e41d588427/2adce9bbd4cb42d58a87e6add45594b3?origin=template