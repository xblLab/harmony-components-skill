# 播放组件

## 简介

本组件提供了视频播放的能力。

## 详细介绍

本组件提供了视频播放的能力。

> 未加锁加锁无控制层
> 更多举报

### 实现画中画效果

#### 约束与限制

**环境**

*   DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
*   HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
*   设备类型：华为手机（包括双折叠和阔折叠）
*   系统版本：HarmonyOS 5.0.1(13) 及以上

**权限**

*   网络权限：ohos.permission.INTERNET

### 使用

1.  **安装组件**
    *   如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
    *   如果是从生态市场下载组件，请参考以下步骤安装组件。
        *   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
        *   b. 在项目根目录 `build-profile.json5` 添加 `recorded_player` 模块。
        ```json5
        // 项目根目录下 build-profile.json5 填写 recorded_player 路径。其中 XXX 为组件存放的目录名
        "modules": [
          {
            "name": "recorded_player",
            "srcPath": "./XXX/recorded_player"
          }
        ]
        ```
        *   c. 在项目根目录 `oh-package.json5` 中添加依赖。
        ```json5
        // XXX 为组件存放的目录名称
        "dependencies": {
          "recorded_player": "file:./XXX/recorded_player"
        }
        ```

2.  **引入播放组件句柄**
    ```typescript
    import { MovieItem, PlayerComponent, PlayerVM } from 'recorded_player';
    ```

3.  **调用组件**
    详细参数配置说明参见 API 参考。
    ```typescript
    PlayerComponent({
       movieItems: this.movieItems,
       playerIndex: this.indexNumber,
       fullScreen: (isLayoutFullScreen: boolean) => {},
       selectionEvent: (idx: number) => {},
       callbackTimeUpdate: (vol: number, total: number) => {}
    })
    ```

### API 参考

#### 接口

```typescript
PlayerComponent(movieItems: MovieItem, playerIndex: number)
```

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| movieItems | MovieItem[] | 是 | 源数据、播放源 |
| playerIndex | number | 是 | 数据索引 |
| fullScreen | () => void | 否 | 横竖屏切换 |
| selectionEvent | () => void | 否 | 选集回调 |
| callbackTimeUpdate | () => void | 否 | 播放进度回调 |

#### MovieItem 枚举说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| movieTitle | string | 视频标题 |
| movieUrl | string | 视频在线地址 |
| movieId | string | 数据 id |
| learnProgress | number | 视频进度 |

### 事件

支持以下事件：

*   **fullScreen**
    ```typescript
    fullScreen: () => void = () => {}
    ```
    视频全屏、竖屏切换的回调函数。

*   **selectionEvent**
    ```typescript
    selectionEvent: () => void = () => {}
    ```
    选集回调函数。

*   **callbackTimeUpdate**
    ```typescript
    callbackTimeUpdate: () => void = () => {}
    ```
    播放进度的回调函数。

### 示例代码

```typescript
import { MovieItem, PlayerComponent, PlayerVM } from 'recorded_player';

@Entry
@ComponentV2
struct PlayerTest {
  stack: NavPathStack = new NavPathStack();
  @Local playerVM: PlayerVM = PlayerVM.instance;

  @Builder
  pageMap(name: string) {
    NavDestination() {
      PlayPageBuilder()
    }
    .mode(NavDestinationMode.STANDARD)
    .backgroundColor($r('sys.color.background_secondary'))
    .hideTitleBar(true)
    .onBackPressed(() => {
      return false
    })
  }

  aboutToAppear(): void {
    // 设置支持切换
    this.playerVM.isSelections = true
    this.stack.replacePathByName('PlayPage', {});
  }

  build() {
    Navigation(this.stack) {
    }
    .hideNavBar(true)
    .hideToolBar(true)
    .hideTitleBar(true)
    .hideBackButton(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.pageMap)
    .id(this.playerVM.navId)
  }
}

@Builder
export function PlayPageBuilder() {
  PlayPage()
}

@ComponentV2
struct PlayPage {
  @Local message: string = 'Hello World';
  movieItems: MovieItem[] = [
    new MovieItem('01', '章节 1', 0,
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/plp/new-phones/video/pocket-series.mp4'),
    new MovieItem('02', '章节 2', 0,
      'https://videocdn.bodybuilding.com/video/mp4/62000/62792m.mp4'),
    new MovieItem('03', '章节 3', 0,
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/plp/new-phones/video/pocket-series.mp4'),
    new MovieItem('04', '章节 4', 0,
      'https://videocdn.bodybuilding.com/video/mp4/62000/62792m.mp4'),
    new MovieItem('05', '章节 5', 0,
      'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/plp/new-phones/video/pocket-series.mp4'),
    new MovieItem('06', '章节 6', 0,
      'https://videocdn.bodybuilding.com/video/mp4/62000/62792m.mp4'),
  ];
  @Local indexNumber: number = 0;
  @Local isLayoutFullScreen: boolean = false;

  @Builder
  playerBuilder() {
    Row() {
      PlayerComponent({
        movieItems: this.movieItems,
        playerIndex: this.indexNumber,
        fullScreen: (isLayoutFullScreen: boolean) => {
          this.isLayoutFullScreen = isLayoutFullScreen
        }
      })
        .width('100%')
        .height(this.isLayoutFullScreen ? '100%' : 184)
        .borderRadius(this.isLayoutFullScreen ? 0 : 16)
        .clip(true)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .padding(this.isLayoutFullScreen ? 0 : {
      top: 10,
      bottom: 10,
      left: 16,
      right: 16
    })
  }

  build() {
    Column() {
      this.playerBuilder()
    }
    .height('100%')
    .width('100%')
  }
}
```

### 更新记录

*   **1.0.2 (2025-12-19)**
    *   下载该版本
    *   Created with Pixso.
*   **1.0.1 (2025-12-03)**
    *   UX 问题修改
    *   画中画逻辑修改
    *   播放状态引起的闪屏问题修改
    *   控制层部分组件业务调整
    *   下载该版本
    *   Created with Pixso.
*   **1.0.0 (2025-11-03)**
    *   初始版本
    *   下载该版本
    *   Created with Pixso.

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| | ohos.permission.INTERNET | 允许使用 Internet 网络。 | 允许使用 Internet 网络。 |

### 合规使用指南

*   不涉及

### 兼容性

| 类别 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| **HarmonyOS 版本** | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| **应用类型** | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| **设备类型** | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| **DevEcoStudio 版本** | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0873f0b6a0a0471fb1ac132857acfc41/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%92%AD%E6%94%BE%E7%BB%84%E4%BB%B6/recorded_player1.0.2.zip