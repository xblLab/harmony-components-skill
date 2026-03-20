# 路线规划组件

## 简介

本组件提供了旅游路线规划功能，支持用户选择出发地、目的地和游玩天数，并根据选择智能推荐旅游路线。

## 详细介绍

### 简介

本组件提供了旅游路线规划功能，支持用户选择出发地、目的地和游玩天数，并根据选择智能推荐旅游路线。

### 页面导航

- 路线规划页面
- 路线列表页面
- 路线详情页面

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3(15)Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3 及以上

#### 权限

- **位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `travel_planning` 和 `city_select` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 travel_planning 和 city_select 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "travel_planning",
        "srcPath": "./XXX/travel_planning",
    },
    {
        "name": "city_select",
        "srcPath": "./XXX/city_select",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "travel_planning": "file:./XXX/travel_planning",
}
```

#### 引入组件

```typescript
import { 
  RoutePlanningPageBuilder, 
  RouteCitySelectPageBuilder,
  RouteListPageBuilder,
  RouteDetailPageBuilder,
  ROUTE_PLANNING_PAGE,
  ROUTE_CITY_SELECT_PAGE,
  ROUTE_LIST_PAGE,
  ROUTE_DETAIL_PAGE,
  RouteListParams,
  RouteDetailParams
} from 'travel_planning';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
pageStack: NavPathStack = new NavPathStack()

@Builder
pageBuilder(name: string, param: string | undefined) {
  if (name === ROUTE_PLANNING_PAGE) {
    RoutePlanningPageBuilder(param)
  } else if (name === ROUTE_CITY_SELECT_PAGE) {
    RouteCitySelectPageBuilder(param)
  } else if (name === ROUTE_LIST_PAGE) {
    RouteListPageBuilder(parseRouteListParams(param))
  } else if (name === ROUTE_DETAIL_PAGE) {
    RouteDetailPageBuilder(parseRouteDetailParams(param))
  }
}

async aboutToAppear() {
  // 初始化时直接显示路线规划页面
  this.pageStack.pushPath({ name: ROUTE_PLANNING_PAGE, param: '' })
}

build() {
  Navigation(this.pageStack) {
    Column()
  }
  .width('100%')
  .height('100%')
  .navDestination(this.pageBuilder)
  .hideTitleBar(true)
}
```

#### 去除安全距离说明

如果需要去除 Navigation 组件的默认安全距离（让内容延伸到状态栏区域），可以在 `aboutToAppear` 方法中添加窗口全屏设置代码。取消示例代码中 `aboutToAppear` 方法内的注释即可启用。此设置会影响整个应用窗口，请根据实际需求决定是否使用。

```typescript
aboutToAppear() {
  // 可选：去除安全距离，设置窗口为全屏布局
  try {
    const uiContext = this.getUIContext()
    const context = uiContext.getHostContext() as common.Context
    if (context) {
      const mainWindow = await window.getLastWindow(context)
      if (mainWindow) {
        await mainWindow.setWindowLayoutFullScreen(true)
      }
    }
  } catch (e) {
  }
}
```

### API 参考

#### 接口

##### 路由常量

组件提供了以下路由名称常量，用于页面路由：

| 常量名 | 类型 | 说明 |
| :--- | :--- | :--- |
| `ROUTE_PLANNING_PAGE` | `string` | 路线规划页面路由名称 |
| `ROUTE_CITY_SELECT_PAGE` | `string` | 城市选择页面路由名称 |
| `ROUTE_LIST_PAGE` | `string` | 路线列表页面路由名称 |
| `ROUTE_DETAIL_PAGE` | `string` | 路线详情页面路由名称 |

##### RoutePlanningPageBuilder

`RoutePlanningPageBuilder(param?: string)`

路线规划页面构建器。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `param` | `string` | 否 | 页面参数。 |

##### RouteCitySelectPageBuilder

`RouteCitySelectPageBuilder(params?: string)`

城市选择页面构建器。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `params` | `string` | 否 | 当前选中的城市名称（可选）。 |

##### RouteListPageBuilder

`RouteListPageBuilder(params?: RouteListParams)`

路线列表页面构建器。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `params` | `RouteListParams` | 否 | 路线列表参数。 |

##### RouteDetailPageBuilder

`RouteDetailPageBuilder(params?: RouteDetailParams)`

路线详情页面构建器。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `params` | `RouteDetailParams` | 否 | 路线详情参数。 |

##### RouteListParams 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `city` | `string` | 是 | 目的地城市名称 |
| `days` | `number` | 是 | 游玩天数 |

##### RouteDetailParams 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `route` | `RouteItem` | 是 | 路线信息对象 |

##### RouteItem 对象说明

`RouteItem` 表示路线信息对象，包含以下字段：

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | `string` | 是 | 路线唯一标识符 |
| `title` | `string` | 是 | 路线标题 |
| `days` | `number` | 是 | 游玩天数 |
| `locations` | `number` | 是 | 地点数量 |
| `attractions` | `string[]` | 是 | 景点名称数组 |
| `coverImageResourceStr` | `string` | 是 | 封面图片资源 |
| `city` | `string` | 是 | 城市名称 |

### 示例代码

```typescript
import { 
  RoutePlanningPageBuilder, 
  RouteCitySelectPageBuilder,
  RouteListPageBuilder,
  RouteDetailPageBuilder,
  ROUTE_PLANNING_PAGE,
  ROUTE_CITY_SELECT_PAGE,
  ROUTE_LIST_PAGE,
  ROUTE_DETAIL_PAGE,
  RouteListParams,
  RouteDetailParams
} from 'travel_planning';
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

function parseRouteListParams(param: string | undefined): RouteListParams | undefined {
  if (!param) return undefined
  try {
    return JSON.parse(param) as RouteListParams
  } catch {
    return undefined
  }
}

function parseRouteDetailParams(param: string | undefined): RouteDetailParams | undefined {
  if (!param) return undefined
  try {
    return JSON.parse(param) as RouteDetailParams
  } catch {
    return undefined
  }
}

@Entry
@ComponentV2
struct Index {
  pageStack: NavPathStack = new NavPathStack()

  @Builder
  pageBuilder(name: string, param: string | undefined) {
    if (name === ROUTE_PLANNING_PAGE) {
      RoutePlanningPageBuilder(param)
    } else if (name === ROUTE_CITY_SELECT_PAGE) {
      RouteCitySelectPageBuilder(param)
    } else if (name === ROUTE_LIST_PAGE) {
      RouteListPageBuilder(parseRouteListParams(param))
    } else if (name === ROUTE_DETAIL_PAGE) {
      RouteDetailPageBuilder(parseRouteDetailParams(param))
    }
  }

  async aboutToAppear() {
    // 可选：去除安全距离，设置窗口为全屏布局
    // 注意：此设置会影响整个应用窗口，如需去除顶部和底部的安全距离，可取消下方注释
    try {
      const uiContext = this.getUIContext()
      const context = uiContext.getHostContext() as common.Context
      if (context) {
        const mainWindow = await window.getLastWindow(context)
        if (mainWindow) {
          await mainWindow.setWindowLayoutFullScreen(true)
        }
      }
    } catch (e) {
    }
    
    // 初始化时直接显示路线规划页面
    this.pageStack.pushPath({ name: ROUTE_PLANNING_PAGE, param: '' })
  }

  build() {
    Navigation(this.pageStack) {
      Column()
    }
    .width('100%')
    .height('100%')
    .navDestination(this.pageBuilder)
    .hideTitleBar(true)
  }
}
```

### 更新记录

#### 1.0.0 (2026-01-06)

- 初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| `ohos.permission.APPROXIMATELY_LOCATION` | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| HarmonyOS 版本 | 兼容性 |
| :--- | :--- |
| 5.0.3 | 支持 |
| 5.0.4 | 支持 |
| 5.0.5 | 支持 |
| 5.1.0 | 支持 |
| 5.1.1 | 支持 |
| 6.0.0 | 支持 |
| 6.0.1 | 支持 |

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/25bb43cfad0941fdb47ddb9c78476c4a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B7%AF%E7%BA%BF%E8%A7%84%E5%88%92%E7%BB%84%E4%BB%B6/travel_planning1.0.0.zip