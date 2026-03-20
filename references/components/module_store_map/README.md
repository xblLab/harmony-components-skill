# 商铺地图组件

## 简介

商铺地图组件，支持展示商铺地理位置和用户所在位置，支持在首次安装时请求地理位置权限，可以帮助开发者快速集成地图相关能力并进行定位展示。

## 详细介绍

### 简介

商铺地图组件，支持展示商铺地理位置和用户所在位置，支持在首次安装时请求地理位置权限，可以帮助开发者快速集成地图相关能力并进行定位展示。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.2 Release 及以上

#### 权限

| 权限 | 说明 |
| :--- | :--- |
| `ohos.permission.APPROXIMATELY_LOCATION` | 获取位置权限 |
| `ohos.permission.LOCATION` | 获取位置权限 |
| `ohos.permission.INTERNET` | 网络权限 |

## 快速入门

使用本组件前请确保工程项目已完成地图服务配置。

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_store_map` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_ui_base 和 module_store_map 路径。其中 XXX 为组件存放的目录名
"modules": [
   {
   "name": "module_ui_base",
   "srcPath": "./XXX/module_ui_base",
   },
   {
   "name": "module_store_map",
   "srcPath": "./XXX/module_store_map",
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_store_map": "file:./XXX/module_store_map"
}
```

### 引入商铺地图组件句柄

```typescript
import { StoreMap } from 'module_store_map';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { StoreMap } from 'module_store_map';

@Entry
@Component
struct Page1 {
  build() {
    Column() {
      StoreMap({
        storeInfo: {
          shopName: '琴之美 (鼓楼店)',
          latitude: 32.0603,
          longitude: 118.7969,
          address: '江苏省南京市鼓楼区音乐之路 123 号'
        },
        showInfoWindow: false,
        mapHeight: '100%',
      });
    };
  }
}
```

## API 参考

### 子组件

无

### StoreMap(options: StoreMapOptions)

#### StoreMapOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| mapWidth | Length | 否 | 地图宽度，默认为 `'100%'`。 |
| mapHeight | Length | 否 | 地图高度，默认为 `200`。 |
| showInfoWindow | boolean | 否 | 是否显示信息窗口，默认为 `false`。 |
| storeInfo | StoreMapInfo | 否 | 存储相关信息。 |
| showUserLocation | boolean | 否 | 是否显示用户位置，默认为 `false`。 |
| customInfoWindow | ($$: map.MarkerDelegate) => void | 否 | 自定义信息窗口构建函数。 |

#### StoreMapInfo 类型说明

| 字段名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| shopName | string | 是 | 商铺名称 |
| latitude | number | 是 | 纬度 |
| longitude | number | 是 | 经度 |
| address | string | 是 | 商铺地址 |

## 示例代码

### 示例一（展示用户位置和信息窗，点击导航跳转华为地图）

```typescript
import { StoreMap } from 'module_store_map';

@Entry
@Component
struct Page2 {
 build() {
   Column() {
     StoreMap({
       storeInfo: {
         shopName: '琴之美 (鼓楼店)',
         latitude: 32.0603,
         longitude: 118.7969,
         address: '江苏省南京市鼓楼区音乐之路 123 号'
       },
       showInfoWindow: true,
       showUserLocation: true,
       mapHeight: '100%',
     });
   };
 }
}
```

## 更新记录

### 1.0.1 (2025-11-07)

- Created with Pixso.

### 1.0.0 (2025-11-03)

- Created with Pixso.

### 初始版本

- Created with Pixso.

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 权限 | ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| 权限 | ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| 权限 | ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 合规使用指南

- 不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

> Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/944433d2bca64ba09671384011be5e38/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E9%93%BA%E5%9C%B0%E5%9B%BE%E7%BB%84%E4%BB%B6/module_store_map1.0.1.zip