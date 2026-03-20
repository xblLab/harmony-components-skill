# 地图找房组件

## 简介

本组件基于华为地图能力，提供了按区查找和查找全部房源的功能。

## 详细介绍

### 简介

本组件基于华为地图能力，提供了按区查找和查找全部房源的功能。

### 按区聚合全部房源

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.5(17) 及以上

#### 权限

- 获取位置权限：`ohos.permission.APPROXIMATELY_LOCATION`、`ohos.permission.LOCATION`。

### 快速入门

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 house_map 和 module_base 模块。

```json5
{
  "modules": [
    {
      "name": "house_map",
      "srcPath": "./xxx/house_map",
    },
    {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
    }
  ]
}
```

   - c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
{
  "dependencies": {
    "house_map": "file:./xxx/house_map",
    "module_base": "file:./xxx/module_base"
  }
}
```

3. 在主工程的 `src/main` 路径下的 `module.json5` 文件中配置如下信息：
   - a. 配置应用的 client ID，详细参考：[配置 Client ID](https://developer.huawei.com/consumer/cn/market/prod-detail/66ab75b1129447f19f41f9b7551ffde3/2adce9bbd4cb42d58a87e6add45594b3?origin=template)。
   - b. 在 `requestPermissions` 字段中添加如下权限。

```json5
{
  "requestPermissions": [
    ...
    {
      "name": "ohos.permission.LOCATION",
      "reason": "$string:app_name",
      "usedScene": {
        "abilities": [
          "EntryAbility"
        ],
        "when": "inuse"
      }
    },
    {
      "name": "ohos.permission.APPROXIMATELY_LOCATION",
      "reason": "$string:app_name",
      "usedScene": {
        "abilities": [
          "EntryAbility"
        ],
        "when": "inuse"
      }
    }
    ...
  ]
}
```

4. 使用该组件需要开通地图服务，详见 [开通地图服务](https://developer.huawei.com/consumer/cn/market/prod-detail/66ab75b1129447f19f41f9b7551ffde3/2adce9bbd4cb42d58a87e6add45594b3?origin=template)。
5. 引入地图工具类。

```typescript
import { AppStorageBank, https } from 'module_base';
```

6. 在合适的时机初始化当前城市及当前位置的经纬度，如下为示例：

```typescript
AppStorageBank.setCurrentLocation(31.896741, 118.912613);
AppStorageBank.setCurrentCity('南京市');
```

7. 在合适的位置通过 Navigation 路由栈跳转到本组件页面，如下为示例：

```typescript
Button('跳转地图').onClick(() => {
  let city = AppStorageBank.getCurrentCity();
  this.pathInfo.pushPathByName('HouseMap',
       [https.getNewHouseList(city), https.getSecondHouseList(city), https.getRentHouseList(city)]);
});
```

## API 参考

### 子组件

- 无

### 接口

- `HouseMap()`: 地图找房组件。

### 示例代码

```typescript
import { AppStorageBank, https } from 'module_base';

@Entry
@ComponentV2
struct Index {
  pathInfo: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
     AppStorageBank.setCurrentLocation(31.896741, 118.912613);
  }

  build() {
     Navigation(this.pathInfo) {
        Column() {
           Button('跳转地图').onClick(() => {
              let city = '南京市';
              this.pathInfo.pushPathByName('HouseMap',
                 [https.getNewHouseList(city), https.getSecondHouseList(city), https.getRentHouseList(city)]);
           });
        };
     }.title('地图找房');
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-12-15 | 下载该版本替换废弃 API |
| 1.0.0 | 2025-08-30 | 初始版本 |

## 权限与隐私

### 基本信息

- **权限与隐私**
- **合规使用指南**：不涉及
- **兼容性**：HarmonyOS 版本 5.0.1

### 权限说明

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |

### 隐私政策

- 不涉及

### 兼容性

| 项目 | 支持列表 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5, DevEco Studio 5.1.0, DevEco Studio 5.1.1, DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/66ab75b1129447f19f41f9b7551ffde3/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%B0%E5%9B%BE%E6%89%BE%E6%88%BF%E7%BB%84%E4%BB%B6/house_map1.0.1.zip