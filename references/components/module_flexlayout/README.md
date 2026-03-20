# 动态布局组件

## 简介

本组件支持布局描述文件进行页面布局。

## 详细介绍

### 简介

本组件支持布局描述文件进行页面布局。

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
2. 在项目根目录 `build-profile.json5` 添加 `module_flexlayout` 模块。

    ```json5
    // 项目根目录下 build-profile.json5 填写 module_flexlayout 路径。其中 XXX 为组件存放的目录名
    "modules": [
      {
        "name": "module_flexlayout",
        "srcPath": "./XXX/module_flexlayout"
      }
    ]
    ```

3. 在项目根目录 `oh-package.json5` 添加依赖。

    ```json5
    // XXX 为组件存放的目录名称
    "dependencies": {
      "module_flexlayout": "file:./XXX/module_flexlayout"
    }
    ```

引入组件。

```typescript
import { FlexLayout } from 'module_flexlayout';
```

调用组件，详细组件调用参见示例代码。

```typescript
import { FlexLayout } from 'module_flexlayout'

@Entry
@ComponentV2
struct Index {
  build() {
    FlexLayout({
       ...
    })
  }
}
```

## API 参考

### 接口

`ArticlePost(option: FlexLayoutOptions)`

动态布局组件的参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | FlexLayoutOptions | 否 | 动态布局组件的参数。 |

#### FlexLayoutOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| flexLayoutEngine | FlexLayoutEngine | 是 | 初始化类 |

#### FlexLayoutEngineOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| settingLayout | Setting | 是 | 布局描述 |
| articles | JSONObject | 是 | 文章数据 |
| breakpointModel | BreakpointModel | 是 | 断点类 |
| extraInfo | Record | 是 | 额外字段 |

### 示例代码

```typescript
// index
import { FlexLayoutPage } from './FlexLayout'

export class NavInfo {
  setting: string = ''
}

@ObservedV2
export class RequestListData {
  navInfo: NavInfo = new NavInfo()
  @Trace articles: ESObject[] = []
  extraInfo: Record<string, string | boolean | Record<string, string | boolean>[]> = {}
}

@Entry
@ComponentV2
struct Index {
  @Local flexList:RequestListData[] = [
    {
      navInfo: {
        setting: '{"type":"view","children":[{"type":"view","children":[{"type":"List","children":[{"type":"native","showType":"TopTextBottomImageCard","name":"上文下图"}],"style":{"backgroundColor":"#FFFFFF","padding-bottom":"12","margin-top":"12"}}]}]}',
      },
      articles: [
        {
          id: 'article_6',
          type: 1,
          title: '住建部称住宅层高标准将提至不低于 3 米，层高低的房子不值钱了？',
          authorId: 'author_1',
          markCount: 0,
          createTime: 1751089800000,
          commentCount: 25,
          likeCount: 6000,
          shareCount: 12000,
          isLiked: false,
          isMarked: false,
          postImgList: [
            'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_1.jpg'
          ],
          articleFrom: '1 号选手',
        },
      ],
      extraInfo: {
        'flexId':'flexId_2',
      },
    },
  ]

  build() {
    Column(){
      ForEach(this.flexList, (item: RequestListData) => {
        ListItem() {
          FlexLayoutPage({
            setting: JSON.parse(item.navInfo.setting),
            articles: item.articles,
          })
        }
      }, (item: RequestListData) => JSON.stringify(item))
    }
  }
}
```

```typescript
// FlexLayout.ets
import { CardRegister, FlexLayout, FlexLayoutEngine, LayoutSetting } from 'module_flexlayout';
import { TopTextBottomImageCard } from './TopTextBottomImageCard';

export class CardRegisterEngine {
  public static CardRegister() {
    let nodeBuilderConfigVm = CardRegister.instance
    nodeBuilderConfigVm.registerCard('TopTextBottomImageCard', wrapBuilder(TopTextBottomImageCard))
  }
}

/*
 * 动态布局组件
 * 核心逻辑参考 FrameNodeFactory.ets/NativeNodeFactory.ets
 * */
@ComponentV2
export struct FlexLayoutPage {
  @Param setting: LayoutSetting = new LayoutSetting()
  @Param articles: ESObject[] = []
  @Param flowIndex: number = 0
  @Param extraInfo: Record<string, number | string | boolean | Record<string, string | boolean>[]> = {}
  @Local flexLayoutEngine: FlexLayoutEngine = new FlexLayoutEngine()

  @Monitor('settingInfo.darkSwitch')
  darkSwitch() {
    /*
     * 调用 rebuild 接口通知 NodeContainer 组件重新回调 makeNode 方法，更新子节点。
     * */
    this.flexLayoutEngine.frameController.rebuild();
  }

  aboutToAppear(): void {
    this.extraInfo.flowIndex = this.flowIndex
    // 注册本地卡片
    CardRegisterEngine.CardRegister()
    // 初始化本地数据
    this.flexLayoutEngine.createJsonLoader(this.setting, this.articles, this.extraInfo)
  }

  build() {
    FlexLayout({
      flexLayoutEngine: this.flexLayoutEngine,
    })
  }
}
```

```typescript
// TopTextBottomImageCard.ets
import { LayoutParams } from 'module_flexlayout'
import { UIUtils } from '@kit.ArkUI'


@Builder
export function TopTextBottomImageCard(cardData: LayoutParams) {
  NativeComponent({
    cardData: cardData,
  })
}

@ComponentV2
struct NativeComponent {
  @Param @Require cardData: LayoutParams
  @Local currentIndex: number = 0

  aboutToAppear(): void {
    this.cardData.nativeCardData = UIUtils.makeObserved(this.cardData.nativeCardData)
  }

  build() {
    Column({ space:5 }) {
      Text(this.cardData.nativeCardData?.title)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('sys.color.font_primary'))
      Grid() {
        ForEach(this.cardData.nativeCardData?.postImgList, (item: string) => {
          GridItem() {
            Image(item)
              .aspectRatio(1).clip(true)
              .width('100%')
          }
        }, (item: string, index: number) => index + JSON.stringify(item))
      }
      .columnsTemplate('1fr '.repeat(this.cardData.nativeCardData?.postImgList?.length ?? 0))
      .columnsGap(8)
    }

    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
```

## 更新记录

- **1.0.0** (2025-09-10): 初始版本

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

| 项目 | 说明 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5305740f524d49a48c358515c9034746/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8A%A8%E6%80%81%E5%B8%83%E5%B1%80%E7%BB%84%E4%BB%B6/module_flexlayout1.0.0.zip