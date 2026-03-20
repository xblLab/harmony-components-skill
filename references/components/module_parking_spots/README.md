# 附近停车场组件

## 简介

本组件提供了展示附近停车场和收藏停车场的功能，可通过下拉刷新、获取当前位置的附近停车场。

## 详细介绍

### 简介

本组件提供了展示附近停车场和收藏停车场的功能，可通过下拉刷新、获取当前位置的附近停车场。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.0 Release 及以上

#### 权限

- **位置权限**：`ohos.permission.LOCATION`
- **模糊位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_parking_base` 和 `module_parking_spots` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_parking_spots 路径。其中 XXX 为组件存放的目录名
"modules": [
   {
   "name": "module_parking_base",
   "srcPath": "./XXX/module_parking_base"
   },
   {
   "name": "module_parking_spots",
   "srcPath": "./XXX/module_parking_spots"
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名
"dependencies": {
   "module_parking_spots": "file:./XXX/module_parking_spots"
}
```

#### 引入组件句柄

```typescript
import { SpotsTab } from 'module_parking_spots';
```

#### 展示停车场 Tab

详细入参配置说明参见 API 参考。

```typescript
SpotsTab({cardClick: (item) => {}})
```

### API 参考

#### 子组件

无

#### 接口

`SpotsTab(options?: SpotsTabOptions)`

附近停车场组件。

##### 参数

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SpotsTabOptions | 否 | 配置附近停车场组件的参数。 |

##### SpotsTabOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| cardClick | `(item: BasicParkInfo) => void` | 否 | 点击回调事件 |
| start | boolean | 否 | 页签左对齐或者居中 |
| space | number | 否 | 页签间隙 |
| offsetLeft | number | 否 | 页签左对齐时左边距 |

##### BasicParkInfo

停车场基本信息类型。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| siteId | string | 是 | ID |
| name | string | 是 | 简称 |
| addr | string | 是 | 全称 |
| location | mapCommon.LatLng | 是 | 经纬度 |
| distance | number | 是 | 距离 |
| totalSpots | number | 是 | 总车位数 |
| leftSpots | number | 是 | 剩余车位数 |
| chargeSpots | number | 是 | 总充电位数 |
| leftChargeSpots | number | 是 | 剩余充电位数 |

### 示例代码

本示例实现停车场的附近以及收藏分类显示。

```typescript
import { SpotsTab } from 'module_parking_spots';

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      SpotsTab({
        start: true,
        space: 16,
        offsetLeft: 28,
        cardClick: (item) => {
          AlertDialog.show({ alignment: DialogAlignment.Center, message: JSON.stringify(item, null, 2) })
        },
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

- **1.0.1 (2025-11-25)**
  - 下载该版本调整 readme 内容。
- **1.0.0 (2025-11-03)**
  - 下载该版本初始版本。

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |

#### 合规使用指南

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

#### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/920d81af8dc340aeb07cf93c0b7e42fd/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%99%84%E8%BF%91%E5%81%9C%E8%BD%A6%E5%9C%BA%E7%BB%84%E4%BB%B6/module_parking_spots1.0.1.zip