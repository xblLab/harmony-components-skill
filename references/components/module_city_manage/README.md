# 城市管理组件

## 简介

本组件提供了当前城市的自动定位和刷新功能，提供热门城市的快捷选择以及区域搜索功能。并支持关注城市的拖拽排序以及增删等管理功能。

## 详细介绍

### 简介

本组件提供了当前城市的自动定位和刷新功能，提供热门城市的快捷选择以及区域搜索功能。并支持关注城市的拖拽排序以及增删等管理功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

- **获取位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_city_manage` 和 `module_weather_core` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_city_manage 和 module_weather_core 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_city_manage",
    "srcPath": "./XXX/module_city_manage"
    },
    {
    "name": "module_weather_core",
    "srcPath": "./XXX/module_weather_core"
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名
"dependencies": {
    "module_city_manage": "file:./XXX/module_city_manage"
}
```

使用该组件需要开通地图服务，详见 [开通地图服务](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/open-map-service-0000001489453405-V5)。

引入组件句柄。

```typescript
import { CityPage } from 'module_city_manage';
```

开启全局沉浸式布局。

```typescript
const win = await window.getLastWindow(getContext());
win.setWindowLayoutFullScreen(true);
```

跳转管理页面。详细参数配置说明参见 API 参考。

```typescript
this.stack.pushPathByName(CityPage.MANAGED, null, (popRes) => {}, true);
```

### API 参考

#### 子组件

无

#### applyLocationPermission 方法说明

`CityManager.applyLocationPermission(): Promise<IPosition>`

获取当前设备的大致位置。

#### pushPathByName 方法说明

`pushPathByName(name: string, param: Object, onPop: Callback<PopInfo>, animated?: boolean): void`

系统跳转方法。可通过 `onPop` 回调，接收返回数据。

#### CityPage 对象说明

页面名枚举。

| 枚举名 | 说明 |
| :--- | :--- |
| MANAGED | 城市管理页 |
| SEARCH | 城市选择页 |

#### IPostion 对象说明

获取当前设备定位的数据类型，以及 PopInfo 的 result 字段实际数据类型。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 位置名称 |
| code | string | 是 | 位置区码 |

### 示例代码

本示例通过 `pushPathByName` 实现城市管理页跳转。

```typescript
import { window } from '@kit.ArkUI';
import { CityPage } from 'module_city_manage';

@Entry
@ComponentV2
struct CityManage {
  stack: NavPathStack = new NavPathStack();
  @Local fullScreen: boolean = false;

  async aboutToAppear() {
    const win = await window.getLastWindow(getContext());
    win.setWindowLayoutFullScreen(true);
    this.fullScreen = true;
  }

  build() {
    if (this.fullScreen) {
      Navigation(this.stack) {
        Column() {
          Button('跳转').onClick(() => {
            this.stack.pushPathByName(
              CityPage.MANAGED,
              null,
              (popRes) => {
                AlertDialog.show({ message: JSON.stringify(popRes.result) })
              },
              true,
            )
          })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
      }
      .hideTitleBar(true)
    }
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-11-03 | 初始版本 |

### 权限与隐私

| 基本信息 | 详情 |
| :--- | :--- |
| 权限名称 | `ohos.permission.APPROXIMATELY_LOCATION` |
| 权限说明 | 允许应用获取设备模糊位置信息 |
| 使用目的 | 允许应用获取设备模糊位置信息 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEco Studio 版本 | 5.0.5、5.1.0、5.1.1、6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8fd0c503df1440cfa1682c4c875f9f4d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9F%8E%E5%B8%82%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/module_city_manage1.0.0.zip