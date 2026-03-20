# 一镜到底组件

## 简介

本组件支持卡片展开、搜索、查看大图一镜到底效果。

## 详细介绍

### 简介

本组件支持卡片展开、搜索、查看大图一镜到底效果。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_transition` 模块。

   ```json5
   // 项目根目录下 build-profile.json5 填写 module_transition 路径。其中 XXX 为组件存放的目录名
   "modules": [
     {
       "name": "module_transition",
       "srcPath": "./XXX/module_transition"
     }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 添加依赖。

   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_transition": "file:./XXX/module_transition"
   }
   ```

## 集成步骤

在 `EntryAbility.ets` 的 `onWindowStageCreate` 函数中添加如下调用：

```ets
onWindowStageCreate(windowStage: window.WindowStage): void {
    ...
    LoneTakeAnimationsTransition.init(windowStage);
    ...
}
```

### Navigation 组件修改

```ets
Navigation(RouterUtils.getStack()) {
}
.hideNavBar(true)
.enabled(this.isEnabled)
.hideTitleBar(true)
.customNavContentTransition((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => {
  return LoneTakeAnimationsTransition.customNavContentTransition(from, to, operation, {
    // 自定义转场过程中禁用手势，避免出现体验问题
    onTransitionStart: () => {
      this.isEnabled = false;
    },
    onTransitionEnd: () => {
      this.isEnabled = true;
    }
  });
})
```

### 触发页的修改，路由集成

```ets
// 在点击触发页的组件后，通过 generateLongTakeParam 接口创建 LongTakeTransitionParam 对象
let longTakeTransitionParam: LongTakeTransitionParam | undefined =
  LoneTakeAnimationsTransition.generateLongTakeParam(this.uiContext,
    componentId ??
      'news_flow_' + cardData.extraInfo.channelId + '_' + cardData.extraInfo.flowIndex + '_' +
      cardData.extraInfo.flexId, 9);
if (longTakeTransitionParam) {
  params.longTakeTransitionParam = longTakeTransitionParam;
}
RouterToNews.pushToNewsDetails<NewsResponse>(params)
```

### 目标页的修改

```ets
NavDestination() {
  if (this.longTakeSession) {
    CardLongTakeDelegate({
      longTakeSession: this.longTakeSession,
      contentBuilder: (): void => {
        this.ContentBuilder()
      },
    })
  } else {
    this.ContentBuilder()
  }
}
.backgroundColor(this.longTakeSession.navDestinationBgColor)
.hideTitleBar(true)
.id('ArticleFeedDetails')
.onSizeChange((oldValue: SizeOptions, newValue: SizeOptions) => {
  this.longTakeSession.setNewSize(newValue);
})
.onReady((navDestContext: NavDestinationContext) => {
  let param = navDestContext.pathInfo?.param as Record<string, Object>;
  let longTakeTransitionParam = param.longTakeTransitionParam as LongTakeTransitionParam;
  if (longTakeTransitionParam) {
    longTakeSession.init(navDestContext, longTakeTransitionParam, {
      pop: () => {
        navDestContext.pathStack.pop()
      },
    });
  }
})
```

引入组件。

```ets
import { CardLongTakeDelegate, ImageLongTakeDelegate } from 'module_transition';
```

调用组件，详细组件调用参见示例代码。

## API 参考

### 接口

`CardLongTakeDelegate(option: LongTakeTransitionDelegateOptions)`

一镜到底组件的参数。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | LongTakeTransitionDelegateOptions | 否 | 配置一镜到底组件的参数。 |

#### LongTakeTransitionDelegateOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| contentBuilder | CustomBuilder | - | 一镜到底自定义组件 |
| longTakeSession | LongTakeAnimationProperties | - | 一镜到底配置 |

#### LongTakeAnimationProperties 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| navDestinationBgColor | ResourceColor | 否 | 导航目标页面的背景色 |
| snapShotOpacity | number | 否 | 快照（页面截图 / 预览图）的透明度 |
| postPageOpacity | number | 否 | 目标页面（跳转后页面）的透明度 |
| translateX | number | 否 | 横向平移距离 |
| translateY | number | 否 | 纵向平移距离 |
| scaleValue | number | 否 | 缩放比例值 |
| clipWidthDimension | - | 否 | 裁剪区域的宽度 |
| clipHeightDimension | - | 否 | 裁剪区域的高度 |
| radius | number | 否 | 圆角半径 |
| positionXValue | number | 否 | X 轴位置值 |
| positionYValue | number | 否 | Y 轴位置值 |
| navDestSize | SizeOptions | 否 | 导航目标页面的尺寸配置 |
| snapShotSize | SizeOptions | 否 | 快照（页面截图 / 预览图）的尺寸配置 |
| snapShotPositionX | number | 否 | 快照的 X 轴位置 |
| snapShotPositionY | number | 否 | 快照的 Y 轴位置 |
| options | LongTakeSessionOptions | 否 | 一镜到底会话的全局配置选项 |
| type | LongTakeTransitionType | 否 | 一镜到底过渡动画的类型 |
| finalBgColor | ResourceColor | 否 | 过渡动画结束后目标页面的最终背景色 |
| animationCount | number | 否 | 动画执行的次数 |
| initScale | number | 否 | 初始缩放比例 |
| initTranslateX | number | 否 | 初始横向平移距离 |
| initTranslateY | number | 否 | 初始纵向平移距离 |
| initClipWidthDimension | - | 否 | 初始裁剪宽度 |
| initClipHeightDimension | - | 否 | 初始裁剪高度 |
| initPositionValueX | number | 否 | 初始 X 轴位置值 |
| initPositionValueY | number | 否 | 初始 Y 轴位置值 |
| cardItemInfoPxRectInfoPx | PxRectInfoPx | 否 | 卡片类组件的信息区域像素值 |
| postPageSharedComponentId | string | 否 | 目标页面共享组件的唯一标识 ID |
| navPathStack | NavPathStack | 否 | 导航路径栈 |
| transitionParam | LongTakeTransitionParam | 否 | 过渡动画的参数集合 |

## 示例代码

### 运行配置（以示例 1 举例，示例 2 同理）

在项目 `src/main/resources/base/profile` 目录下新建 `route_map.json` 文件：

```json
{
  "routerMap": [
    {
      "name": "CardLongTakePageOne",
      "pageSourceFile": "src/main/ets/pages/CardLongTakePageOne.ets",
      "buildFunction": "CardLongTakePageOneBuilder",
      "data": {
        "description": "this is CardLongTakePageOne"
      }
    },
    {
      "name": "CardLongTakePageTwo",
      "pageSourceFile": "src/main/ets/pages/CardLongTakePageTwo.ets",
      "buildFunction": "CardLongTakePageTwoBuilder"
    }
  ]
}
```

在 `src/main/module.json5` 中集成 `routerMap`：

```json5
{
  "module": {
    ....
    "routerMap": "$profile:route_map"
    ...
  }
}
```

### 示例 1（卡片一镜到底）

**index.ets**

```ets
import { LoneTakeAnimationsTransition } from 'module_transition';

@Entry
@ComponentV2
struct Index {
  private pageInfos: NavPathStack = new NavPathStack();

  @Local isEnabled: boolean = true;

  aboutToAppear(): void {
    this.pageInfos.replacePath({ name: 'CardLongTakePageOne' });
  }

  build() {
    Navigation(this.pageInfos)
      .hideNavBar(true)
      .customNavContentTransition((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => {
        return LoneTakeAnimationsTransition.customNavContentTransition(from, to, operation, {
          // 自定义转场过程中禁用手势，避免出现体验问题
          onTransitionStart: () => {
            this.isEnabled = false;
          },
          onTransitionEnd: () => {
            this.isEnabled = true;
          }
        });
      })
      .enabled(this.isEnabled)
  }
}
```

**CardLongTakePageOne.ets**

```ets
import { LoneTakeAnimationsTransition, LongTakeTransitionParam } from 'module_transition';

const TAG: string = 'CardLongTakePageOne';

const RADIUS: number = 9;

@Builder
export function CardLongTakePageOneBuilder() {
  CardLongTakePageOne();
}

@ComponentV2
export struct CardLongTakePageOne {
  private pageInfos: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Home({
        pageInfos: this.pageInfos,
      })
    }
    .title('卡片一镜到底首页')
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}

@ComponentV2
struct Home {
  @Param pageInfos: NavPathStack = new NavPathStack();
  @Local dataSource: number[] = []
  @Local columnWidth: number = 0;
  @Local columnType: string = '';

  aboutToAppear(): void {
    for (let i = 0; i < 100; i++) {
      this.dataSource.push(i);
    }
  }

  private onColumnClicked(indexValue: string, snapShotComponentId: string): void {
    let param: Record<string, Object> = {};
    let clickedIndex = parseInt(indexValue);
    param['indexValue'] = clickedIndex;
    param['snapShotId'] = snapShotComponentId;

    let longTakeTransitionParam: LongTakeTransitionParam | undefined =
      LoneTakeAnimationsTransition.generateLongTakeParam(this.getUIContext(), snapShotComponentId, RADIUS);
    if (longTakeTransitionParam) {
      param['longTakeTransitionParam'] = longTakeTransitionParam;
    }
    this.pageInfos.pushPath({ name: 'CardLongTakePageTwo', param: param })
  }

  @Builder
  cardBuilder(item: number) {
    Row({ space: 20 }) {
      Image($r('app.media.startIcon'))
        .height(80)
        .width(80)
      Text(item.toString())
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('sys.color.background_secondary'))
  }

  build() {
    Stack() {
      WaterFlow() {
        ForEach(this.dataSource, (item: number, index: number) => {
          FlowItem() {
            Column() {
              this.cardBuilder(item)
            }
            .width('100%')
            .height(200)
          }
          .borderRadius(RADIUS)
          .onClick(() => {
            this.onColumnClicked(index.toString(), 'demo_' + index)
          })
          .clip(true)
          .id('demo_' + index)
        }, (item: string) => item)
      }
      .columnsTemplate(this.columnType)
      .columnsGap(5)
      .rowsGap(5)
      .width('100%')
      .height('100%')
    }
    .size({ width: '100%', height: '100%' })
    .padding({ left: 10, right: 10 })
  }
}
```

**CardLongTakePageTwo.ets**

```ets
import { LongTakeAnimationProperties, CardLongTakeDelegate, LongTakeTransitionParam } from 'module_transition';

@Builder
export function CardLongTakePageTwoBuilder() {
  CardLongTakePageTwo();
}

@ComponentV2
export struct CardLongTakePageTwo {
  @Local indexValue: number = -1;
  @Local pageInfos: NavPathStack = new NavPathStack();
  @Local longTakeSession: LongTakeAnimationProperties = new LongTakeAnimationProperties();
  @Local longTakeTransitionParam: LongTakeTransitionParam | undefined = undefined;

  private onBackPressed(): boolean {
    this.pageInfos.pop();
    return true;
  }

  @Builder
  ContentBuilder() {
    Column({ space: 50 }) {
      Image($r('app.media.startIcon')).width(200).height(200)
      Text(this.indexValue.toString())
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('sys.color.background_primary'))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  build() {
    NavDestination() {
      CardLongTakeDelegate({
        longTakeSession: this.longTakeSession,
        contentBuilder: (): void => {
          this.ContentBuilder()
        },
      })
    }
    // 弹出页需要修改 navDestination 的背景颜色为 session 中的值
    .backgroundColor(this.longTakeSession.navDestinationBgColor)
    .onSizeChange((oldValue: SizeOptions, newValue: SizeOptions) => {
      this.longTakeSession.setNewSize(newValue);
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .hideTitleBar(true)
    .onReady((navDestContext: NavDestinationContext) => {
      this.pageInfos = navDestContext.pathStack;
      console.log(JSON.stringify(navDestContext.pathStack.getAllPathName()), 'RouterUtils.getStack()')
      let param = navDestContext.pathInfo?.param as Record<string, Object>;
      this.indexValue = param['indexValue'] as number;
      this.longTakeTransitionParam = param['longTakeTransitionParam'] as LongTakeTransitionParam;
      if (this.longTakeTransitionParam) {
        this.longTakeSession.init(navDestContext, this.longTakeTransitionParam, {
          pop: () => {
            this.pageInfos.pop()
          },
        });
      }
    })
    .onBackPressed(() => {
      return this.onBackPressed();
    })
  }
}
```

### 示例 2（图片一镜到底）

**index.ets**

```ets
import { LoneTakeAnimationsTransition } from 'module_transition';

@Entry
@ComponentV2
struct Index {
  private pageInfos: NavPathStack = new NavPathStack();

  @Local isEnabled: boolean = true;

  aboutToAppear(): void {
    this.pageInfos.replacePath({ name: 'ImageLongTakePageOne' });
  }

  build() {
    Navigation(this.pageInfos)
      .hideNavBar(true)
      .customNavContentTransition((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => {
        return LoneTakeAnimationsTransition.customNavContentTransition(from, to, operation, {
          // 自定义转场过程中禁用手势，避免出现体验问题
          onTransitionStart: () => {
            this.isEnabled = false;
          },
          onTransitionEnd: () => {
            this.isEnabled = true;
          }
        });
      })
      .enabled(this.isEnabled)
  }
}
```

**ImageLongTakePageOne.ets**

```ets
import { LoneTakeAnimationsTransition, LongTakeTransitionParam } from 'module_transition';
const RADIUS: number = 9;

@Builder
export function ImageLongTakePageOneBuilder() {
  ImageLongTakePageOne();
}

@ComponentV2
export struct ImageLongTakePageOne {
  private pageInfos: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Home({
        pageInfos: this.pageInfos,
      })
    }
    .title('图片一镜到底首页')
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}

@ComponentV2
struct Home {
  @Param pageInfos: NavPathStack = new NavPathStack();
  @Local clickedIndex: number = 0
  @Local componentId: string = 'demo_image'
  @Local isFirstPageShow: boolean = true;
  @Local dataSource: string[] = [
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_2.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_3.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_4.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_5.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_6.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_7.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_8.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_9.jpg',
    'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_tra_10.jpg',
  ]

  onIndexChange(index: number): void {
    this.clickedIndex = index;
  }

  onBack(): void {
    this.isFirstPageShow = true;
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.dataSource,
          (item: string, index: number) => {
            GridItem() {
              if (this.clickedIndex !== index || (this.isFirstPageShow)) {
                Stack({ alignContent: Alignment.BottomEnd }) {
                  Image(item)
                    .objectFit(ImageFit.Cover)
                    .borderRadius(12)
                    .clip(true)
                    .aspectRatio(1)
                    .geometryTransition(item + this.componentId)
                    .transition(TransitionEffect.opacity(0.99))
                    .onClick(() => {
                      let param: Record<string, Object> = {};
                      /*
                       * 实际携带的 transitionId 需要全局唯一且保持一致
                      */
                      param.componentId = this.componentId
                      param.imageList = this.dataSource
                      this.clickedIndex = index;
                      param.selectedIndex = this.clickedIndex;
                      param.onBackToFirstPage = () => {
                        this.onBack();
                      }
                      param.onIndexChange = (index: number) => {
                        this.onIndexChange(index);
                      };
                      this.getUIContext().animateTo({
                        duration: 150,
                        curve: Curve.EaseIn,
                      }, () => {
                        this.pageInfos.pushPathByName('ImageLongTakePageTwo', param, () => {}, false)
                      })
                      this.isFirstPageShow = false;
                    })
                }
              }
            }
          }, (item: string) => JSON.stringify(item))
      }
      .columnsTemplate('1fr '.repeat(3))
      .columnsGap(8)
    }
  }
}
```

**ImageLongTakePageTwo.ets**

```ets
import {
  ImageLongTakeDelegate
} from 'module_transition';

@Builder
export function ImageLongTakePageTwoBuilder() {
  ImageLongTakePageTwo();
}

@ComponentV2
export struct ImageLongTakePageTwo {
  @Local componentId: string = ''
  @Local imageList: string[] = []
  @Local pageInfos: NavPathStack = new NavPathStack();
  private onIndexChange: (index: number) => void = (_index: number) => {}
  @Local selectedIndex: number = 0;
  private onFirstPageShow: () => void = () => {};
  backToFirstPage: () => void = () => {
    animateTo({
      duration: 200,
      curve: Curve.EaseIn,
    }, () => {
      this.onFirstPageShow();
      this.pageInfos.pop(false);
    })
  }

  build() {
    NavDestination() {
      Swiper() {
        ForEach(this.imageList, (item: string, index: number) => {
          ImageLongTakeDelegate({
            componentId: this.componentId,
            imageUrl: item,
            backToFirstPage: () => {
              this.backToFirstPage()
            },
          })
        }, (item: string) => item)
      }
      .transition(TransitionEffect.opacity(0.99))
      .width('100%')
      .height('100%')
      .clip(false)
      .index(this.selectedIndex)
      .onChange((index: number) => {
        this.selectedIndex = index;
        this.onIndexChange(index);
      })
      .onAnimationStart((_: number, targetIndex: number) => {
        this.onIndexChange(targetIndex);
      })
      .indicator(false)
    }
    .mode(NavDestinationMode.DIALOG)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.backToFirstPage();
      return true;
    })
    .transition(TransitionEffect.opacity(0.99))
    .onReady((navDestContext: NavDestinationContext) => {
      this.pageInfos = navDestContext.pathStack;
      let param = navDestContext.pathInfo?.param as Record<string, Object>;
      this.componentId = param.componentId as string
      this.imageList = param.imageList as string[]
      this.selectedIndex = param.selectedIndex as number
      this.onFirstPageShow = param.onBackToFirstPage as () => void;
      this.onIndexChange = param.onIndexChange as (index: number) => void;
    })
  }
}
```

## 更新记录

### 1.0.0 (2025-11-03)

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

#### 兼容性

| HarmonyOS 版本 | DevEco Studio 版本 | 应用类型 | 设备类型 |
| :--- | :--- | :--- | :--- |
| 5.0.1 | 5.0.3 | 应用 | 手机 |
| 5.0.2 | 5.0.4 | 元服务 | 平板 |
| 5.0.3 | 5.0.5 | - | PC |
| 5.0.4 | 5.1.0 | - | - |
| 5.0.5 | 5.1.1 | - | - |
| 5.1.0 | 6.0.0 | - | - |
| 5.1.1 | - | - | - |
| 6.0.0 | - | - | - |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5c073c4e27ea42488f2919cfa7d2213b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%95%9C%E5%88%B0%E5%BA%95%E7%BB%84%E4%BB%B6/module_transition1.0.0.zip