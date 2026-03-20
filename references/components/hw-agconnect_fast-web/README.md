# Web容器 FastWeb

## 简介

FastWeb是基于open harmony基础组件开发的高性能Web容器，提供具有预启动、预渲染、预编译JavaScript生成字节码缓存、离线资源免拦截注入等能力的Web组件。

## 详细介绍

### 简介

FastWeb是基于open harmony基础组件开发的高性能Web容器，它提供预启动、预渲染、预编译JavaScript生成字节码缓存、离线资源拦截注入等能力，适用于提升H5页面核心业务加载速度的场景。

### 使用方式

**方式一：全面改造H5页面，完全基于FastWeb整体能力进行优化**

无论待优化的H5页面之前是否已封装成Web容器，均可通过FastWeb的完整能力（预启动、预渲染、预编译JavaScript生成字节码缓存、离线资源拦截注入）进行性能优化。

您可以预先创建一个空的ArkWeb组件，例如，在App启动时创建，或者在其他合适的页面创建。在展示H5页面时，挂载已经创建的FastWeb组件。

请注意，使用此方式，您需要删除原有的Web容器，并将属性和事件重新写入FastWeb暴露的对象中。

**方式二：不修改原有H5页面，基于FastWeb部分能力进行优化**

如果已经将H5页面封装成Web容器，并希望在不修改原页面的基础上进行优化，您可以通过FastWeb的预编译JavaScript生成字节码缓存和离线资源拦截注入功能来实现。

同样，您需要预先创建一个空的ArkWeb组件，可以在App启动时创建，或者其他合适的页面创建。在展示H5页面时，使用您已经开发的Web页面，不需要针对FastWeb组件做任何改动。

### 使用建议

- FastWeb组件的核心优势在于网络大资源的预加载能力，而非复杂业务逻辑处理，建议优先用于性能优化关键路径。
- 若应用涉及桥接功能需求，推荐通过方式二调用FastWeb组件，以确保桥接通信的稳定性和兼容性。
- 创建FastWeb组件将占用内存（每个FastWeb组件大约200MB）和计算资源，建议避免一次性创建大量FastWeb组件，以减少资源消耗。

### 提升效果

| 场景 | 首次打开，无缓存 | 多次打开，有缓存 | 说明 |
|:---|:---|:---|:---|
| 直接加载Web页面 | 5413.58ms | 1345.93ms | 在页面加载时才开始拉起渲染进程、发起资源请求，增加加载时间 |
| 使用FastWeb组件 | 2714.48ms | 811.03ms | 在未进入到页面前，预先启动Web进程并预先渲染页面，节省了用户后续启动Web组件拉起渲染进程的时间；同时预先下载JavaScript文件并编译生成字节码缓存，提前下载图片等资源预置到内存中，节省了网络请求时间 |

## 快速开始

### 安装

```bash
ohpm install @hw-agconnect/fast-web
```

### 使用

```typescript
// EntryAbility.ets（在EntryAbility.ets中创建ArkWeb组件后，整个应用的页面都可以挂载Web节点。也可以在其他合适的页面创建。）
import { createFastWeb, IJavaScriptConfig, IResourceConfig, WebProperties } from '@hw-agconnect/fast-web';
import { WEB1_ID } from 'FastWebSample';

onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
    // WebProperties对象包括原生Web组件的WebOptions、属性和事件
    const webProperties = new WebProperties();
    webProperties.defaultFontSize = 30;
    webProperties.onAlert = () => {
      console.log('初始事件')
      return true
    }
    // 预编译的JavaScript资源
    const javaScriptConfigs: IJavaScriptConfig[] = [
      {
        url: 'http://www.example.com/example.js',
        localPath: 'example.js',
      }
    ]
    // 拦截注入的离线资源如图片、样式表和脚本资源
    const resourceConfigs: IResourceConfig[] = [
      {
        localPath: 'example.jpg',
        urlList: [
          'http://www.example.com/example.jpg',
        ],
        type: webview.OfflineResourceType.IMAGE,
      }
    ];
    // 预先创建空的ArkWeb动态组件（需传入UIContext），提前拉起渲染进程
    createFastWeb({
      id: WEB1_ID,
      uiContext: windowStage.getMainWindowSync().getUIContext(),
      webProperties,
      javaScriptConfigs,
      resourceConfigs
    });
  });
}
```

## 约束与限制

### 环境

- DevEco Studio版本：DevEco Studio 5.0.1 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.1 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13) 及以上

### 权限

- 网络权限：`ohos.permission.INTERNET`

## 接口

### FastWeb(options: FastWebParam)

**FastWebParam对象说明**

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | 复用FastWeb的id |
| url | ResourceStr | 是 | 加载的网页地址 |

### createFastWeb(options: FastWebOptions)方法说明

创建空的ArkWeb组件，支持提前注入资源、传入FastWeb组件的属性和事件等操作。

**FastWebOptions对象说明**

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | FastWeb组件的id |
| uiContext | UIContext | 是 | UIContext实例 |
| webProperties | WebProperties | 否 | 包括原生Web组件的WebOptions、属性和事件 |
| javaScriptConfigs | IJavaScriptConfig[] | 否 | 预编译JavaScript |
| resourceConfigs | IResourceConfig[] | 否 | 离线资源如图片、样式表和脚本资源等 |
| url | ResourceStr | 否 | web组件加载的网络地址，仅限于单个H5页面的场景，需要配合isPreActive参数一起使用 |
| fastWebController | WebviewController | 否 | 通过fastWebController可以控制Web组件各种行为，不传绑定默认的WebviewController |
| isPreActive | boolean | 否 | 是否启用预渲染，仅限于单个H5页面的场景，默认为true，需要配合url参数一起使用 |
| remainingRetries | number | 否 | 资源失败重新下载的次数，默认为3次 |

### createNWeb方法说明（不推荐，建议使用createFastWeb方法）

创建空的ArkWeb组件，支持提前注入资源、传入FastWeb组件的属性和事件等操作。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | FastWeb组件的id |
| uiContext | UIContext | 是 | UIContext实例 |
| webProperties | WebProperties | 否 | 包括原生Web组件的WebOptions、属性和事件 |
| javaScriptConfigs | IJavaScriptConfig[] | 否 | 预编译JavaScript |
| resourceConfigs | IResourceConfig[] | 否 | 离线资源如图片、样式表和脚本资源等 |

### getFastWebController方法说明

获取FastWeb组件的WebviewController。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | FastWeb组件的id |

**返回值：**

| 属性 | 类型 | 说明 |
|:---|:---|:---|
| controller | WebviewController | FastWeb组件的控制器 |

### getFastWebProperties方法说明

获取FastWeb组件的WebProperties，可以对属性和事件进行修改，修改后需要调用updateWeb方法进行更新。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | FastWeb组件的id |

**返回值：**

| 属性 | 类型 | 说明 |
|:---|:---|:---|
| webProperties | WebProperties | 包括原生Web组件的WebOptions、属性和事件 |

### updateWeb方法说明

更新FastWeb组件的WebProperties。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | FastWeb组件的id |

### preLoadUrl方法说明

预渲染H5页面，建议在跳转页面的onShown事件中使用。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | web组件的id |
| url | ResourceStr | 否 | 加载的网页地址,默认值为'about:blank' |

### release方法说明

删除FastWeb节点。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | 需要删除的FastWeb组件的id |

### clear方法说明

清空存储的资源。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | 需要清空资源的FastWeb组件的id |

### webOptionMap对象说明（不推荐，建议使用getFastWebProperties方法）

从对象中获取WebProperties。

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| id | string | 是 | web组件的id |

### IJavaScriptConfig对象说明

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| url | string | 是 | 网页JavaScript的地址 |
| localPath | string | 是 | 资源存储的文件名和文件后缀 |
| options | webview.CacheOptions | 否 | 用于控制字节码缓存更新 |

### IResourceConfig对象说明

| 参数 | 类型 | 必填 | 说明 |
|:---|:---|:---|:---|
| urlList | string[] | 是 | 网页资源的地址，列表的第一项将作为资源的源(Origin)，如果仅提供一个网络地址，则使用该地址作为这个资源的源。目前仅支持一个网页资源的地址作为该资源的下载地址，如果提供多个地址，就选择最后一个地址作为该资源的下载地址。 |
| type | webview.OfflineResourceType | 是 | 资源类型 |
| localPath | string | 是 | 资源存储的文件名和文件后缀 |
| responseHeaders | Header[] | 否 | 资源对应的HTTP响应头 |

## 示例

### 示例1（方式一：全面改造H5页面，完全基于FastWeb整体能力进行优化）

示例代码使用Navigation，运行示例代码之前需要进行系统路由表的配置，具体操作如下：在entry/src/main目录下的工程配置文件module.json5中的module字段里配置 `"routerMap": "$profile:route_map"`，在entry/src/main/resources/base/profile目录下新增route_map.json文件，文件内容如下：

```json5
{
  "routerMap": [
    {
      "name": "buttonListSample",
      "pageSourceFile": "src/main/ets/pages/ButtonListSample.ets",
      "buildFunction": "buttonListSample"
    },
    {
      "name": "fastWeb",
      "pageSourceFile": "src/main/ets/pages/FastWebSample.ets",
      "buildFunction": "fastWebSampleBuilder"
    }
  ]
}
```

**预先创建一个空的ArkWeb组件，将资源注入到内存中。Web在请求资源时会进行拦截，并在内存中寻找对应Url地址的资源使用。（可以在App启动时创建，或者其他合适的页面创建。）**

```typescript
// EntryAbility.ets
import { webview } from '@kit.ArkWeb';
import { createFastWeb, IJavaScriptConfig, IResourceConfig, WebProperties } from '@hw-agconnect/fast-web';
import { WEB1_ID } from '../pages/FastWebSample';

onWindowStageCreate(windowStage: window.WindowStage): void {
  windowStage.loadContent('pages/Index', (err) => {
    // WebProperties对象包括原生Web组件的WebOptions、属性和事件
    const webProperties = new WebProperties();
    webProperties.defaultFontSize = 30;
    webProperties.onAlert = () => {
      console.log('初始事件')
      return true
    }
    // 预编译的JavaScript资源
    const javaScriptConfigs: IJavaScriptConfig[] = [
      {
        url: 'http://www.example.com/example.js',
        localPath: 'example.js',
      }
    ]
    // 拦截注入的离线资源如图片、样式表和脚本资源
    const resourceConfigs: IResourceConfig[] = [
      {
        localPath: 'example.jpg',
        urlList: [
          'http://www.example.com/example.jpg',
        ],
        type: webview.OfflineResourceType.IMAGE,
      }
    ];
    // 预先创建一个空的ArkWeb动态组件（需传入UIContext），拉起渲染进程
    createFastWeb({
      id: WEB1_ID,
      uiContext: windowStage.getMainWindowSync().getUIContext(),
      webProperties,
      javaScriptConfigs,
      resourceConfigs
    });
  });
}
```

**按钮页面，点击按钮可以跳转到FastWeb页面，根据传入的路由参数加载不同的H5页面。**

```typescript
// ButtonListSample.ets
import { preLoadUrl } from '@hw-agconnect/fast-web'
import { WEB1_ID } from './FastWebSample';

@Builder
export function buttonListSample() {
  ButtonListSample();
}

@ComponentV2
struct ButtonListSample {
  @Consumer('navPathStack') pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Button('地址1')
          .width('100%')
          .height(50)
          .margin({ top: 10 })
          .onClick(() => {
            this.pathStack.pushPathByName('fastWeb', 'www.example1.com')
          })

        Button('地址2')
          .width('100%')
          .height(50)
          .margin({ top: 10 })
          .onClick(() => {
            this.pathStack.pushPathByName('fastWeb', 'www.example2.com')
          })
      }
      .height('100%')
      .width('100%')
    }
    .onShown(() => {
      preLoadUrl(WEB1_ID)
    })
  }
}
```

**使用FastWeb组件的页面，挂载之前创建的ArkWeb组件。**

```typescript
// FastWebSample.ets 
import { FastWeb, getFastWebController, getFastWebProperties, updateWeb } from '@hw-agconnect/fast-web'

export const WEB1_ID = 'web1Id'

@Builder
export function fastWebSampleBuilder() {
  FastWebSample();
}

@ComponentV2
struct FastWebSample {
  @Consumer('navPathStack') pathStack: NavPathStack = new NavPathStack();
  @Local url: ResourceStr = ''

  aboutToAppear(): void {
    this.url = this.pathStack.getParamByName('fastWeb')[0] as string
    // 更新web的属性和事件
    const webProperties = getFastWebProperties(WEB1_ID)
    if (webProperties) {
      webProperties.defaultFontSize = 60
      webProperties.onAlert = () => {
        console.log('测试事件变化')
        return true
      }
      updateWeb(WEB1_ID)
    }
  }

  build() {
    NavDestination() {
      Column() {
        FastWeb({ webId: WEB1_ID, url: this.url })
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .onBackPressed(() => {
      // onBackPressed事件在NavDestination中触发，如果在其他不含NavDestination的页面中应写在onBackPress生命周期里
      const controller = getFastWebController(WEB1_ID)
      // 当前页面是否可后退给定的step步
      if (controller && controller.accessStep(-1)) {
        controller.backward(); // 返回上一个web页
        // 执行用户自定义返回逻辑
        return true;
      } else {
        // 执行系统默认返回逻辑，返回上一个page页
        return false;
      }
    })
  }
}
```

### 示例2（方式二：不修改原有H5页面，基于FastWeb部分能力进行优化）

示例代码使用Navigation，运行示例代码之前需要进行系统路由表的配置，具体操作如下：在entry/src/main目录下的工程配置文件module.json5中的module字段里配置 `"routerMap": "$profile:route_map"`，在entry/src/main/resources/base/profile目录下新增route_map.json文件，文件内容如下：

```json5
{
  "routerMap": [
    {
      "name": "buttonListSample",
      "pageSourceFile": "src/main/ets/pages/ButtonListSample.ets",
      "buildFunction": "buttonListSample"
    },
    {
      "name": "webSample",
      "pageSourceFile": "src/main/ets/pages/WebSample.ets",
      "buildFunction": "webSampleBuilder"
    }
  ]
}
```

**预先创建一个空的ArkWeb组件，将资源注入到内存中。Web在请求资源时会进行拦截，并在内存中寻找对应Url地址的资源使用。**

```typescript
// EntryAbility.ets
import { createFastWeb } from '@hw-agconnect/fast-web';

onWindowStageCreate(windowStage: window.WindowStage): void { 
  windowStage.loadContent('pages/Index', (err) => {
    // 预先创建一个空的ArkWeb动态组件（需传入UIContext），拉起渲染进程
    createFastWeb({
      id: 'webId',
      uiContext: windowStage.getMainWindowSync().getUIContext(),
    });
  });
}
```

**按钮页面，点击按钮可以跳转到Web页面。**

```typescript
// ButtonListSample.ets
@Builder
export function buttonListSample() {
  ButtonListSample();
}

@ComponentV2
struct ButtonListSample {
  @Consumer('navPathStack') pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Button('WebSample')
          .width('100%')
          .height(50)
          .margin({ top: 10 })
          .onClick(() => {
            this.pathStack.pushPathByName('WebSample', '')
          })
      }
      .height('100%')
      .width('100%')
    }
  }
}
```

**使用Web页面，即用户自定义的web页面，不需要针对FastWeb组件做任何改动**

```typescript
// WebSample.ets
import { webview } from '@kit.ArkWeb';

@Builder
export function webSampleBuilder() {
  WebSample();
}

@ComponentV2
struct WebSample {
  @Local controller: WebviewController = new webview.WebviewController()

  build() {
    NavDestination() {
      Column() {
        Web({ src: 'www.example.com', controller: this.controller })
      }
      .width('100%')
      .height('100%')
    }
  }
}
```

## 更新记录

### 1.0.3（2025-09-09）

- 解决首屏加载FastWeb导致闪退的bug
- readme修改

### 1.0.2（2025-08-15）

- 新增createFastWeb方法
- 新增getFastWebProperties方法
- 新增getFastWebController方法
- 新增release方法
- 新增clear方法
- 支持资源下载失败后重下

### 1.0.1（2025-07-21）

- url支持复合类型 string | Resource
- 属性和事件在使用页面进行更新
- 解决二次进入页面时会缓存之前的页面的问题

### 1.0.0（2025-05-30）

- 提供具有预启动、预渲染、预编译JavaScript生成字节码缓存、离线资源免拦截注入等能力的Web组件

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|:---|:---|:---|
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio版本

- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 安装方式

```bash
ohpm install @hw-agconnect/fast-web
```

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/686766c4728d43cc9741728552a560bf/2adce9bbd4cb42d58a87e6add45594b3?origin=template