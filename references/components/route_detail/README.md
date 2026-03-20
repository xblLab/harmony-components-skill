# 公交路线详情组件

## 简介

本组件提供了展示公交路线详情的相关功能，开发者传入对应数据后，可以快速绘制公交路线以及动态展示公交信息。

## 详细介绍

### 简介

本组件提供了展示公交路线详情的相关功能，开发者传入对应数据后，可以快速绘制公交路线以及动态展示公交信息。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.1.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.0 Release SDK 及以上
- **设备类型**：华为手机（直板机、双折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.0(12) 及以上

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `route_detail` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 route_detail 路径。其中 XXX 为组件存放的目录名
"modules": [
 { 
   "name": "route_detail",
   "srcPath": "./xxx/route_detail",
 }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies":
{
   "route_detail": "file:./xxx/route_detail"
}
```

引入组件与路线详情组件句柄。

```typescript
import { RouteDetail, BusLineInfo } from 'route_detail'
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
RouteDetail({
   stationLocation: [],
   busLocation: [{ longitude: 116.4585837, latitude: 39.9072769 }, { longitude: 116.4397, latitude: 39.90719247 }],
   busLineInfo: new BusLineInfo(this.longLineName, '下行', '6：00', '22：00', 2, 3, this.line, []),
   nearToMe: 3,
   busIndex: [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9]
}]
```

## API 参考

### 子组件

无

### 接口

#### RouteDetail(options?: RouteDetailOptions)

公交路线详情组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | RouteDetailOptions | 否 | 展示公交路线详情的参数 |

**RouteDetailOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| stationLocation | SearchSet[] | 否 | 站点信息列表，用于在地图上绘制信息 |
| busLocation | mapCommon.LatLng[] | 否 | 公交位置列表，用于在地图上绘制公交车位置 |
| busLineInfo | BusLineInfo | 否 | 公交路线具体信息，用于卡片展示 |
| nearToMe | number | 否 | 距离最近的公交车的下标，默认值为 -1 |
| busIndex | number[] | 否 | 当前线路上公交车索引数数组，默认值 [] |

**SearchSet 接口说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| lineName | string | 是 | 线路名称，比如 1 路 |
| startStation | string | 是 | 起始站点名称 |
| endStation | string | 是 | 终点站名称 |
| coordX | number | 否 | 经度 |
| coordY | number | 否 | 纬度 |
| stationName | string | 否 | 当前站点名称 |
| sequence | number | 否 | 站点顺序 |

**BusLineInfo 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| busNumber | string | 否 | 车次名称 |
| direction | string | 否 | 行车方向 |
| lineFirstTime | string | 否 | 首班车时间 |
| lineEndTime | string | 否 | 末班车时间 |
| price | number | 否 | 票价 |
| currentStation | number | 否 | 当前站点索引 |
| line | string[] | 否 | 站点名称列表 |
| nearestThreeBuses | BusFromCurrent[] | 否 | 距离最近的三辆车信息 |

**BusFromCurrent 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| remainStop | number | 否 | 剩余站点数，默认值 0 |
| remainDistance | number | 否 | 剩余距离，默认值 0 |
| remainMinute | number | 否 | 剩余时间，默认值 0 |

## 示例代码

```typescript
import { mapCommon } from '@kit.MapKit'
import { BusFromCurrent, BusLineInfo, RouteDetail, SearchSet } from 'route_detail'

@Entry
@ComponentV2
struct Index {
 @Local line: string[] = ['四惠枢纽站', '八王坟西']
 @Local nearInfos: BusFromCurrent[] = [new BusFromCurrent(2, 2, 3)]
 @Local stationLocation: SearchSet[] = [{
   'lineName': '1 路',
   'startStation': '四惠枢纽站',
   'endStation': '老山公交场站',
   'coordX': 116.490437,
   'coordY': 39.90536209,
   'stationName': '四惠枢纽站',
   'sequence': 1
 }, {
   'lineName': '1 路',
   'startStation': '四惠枢纽站',
   'endStation': '老山公交场站',
   'coordX': 116.469076,
   'coordY': 39.90718736,
   'stationName': '八王坟西',
   'sequence': 2
 }]
 @Local busLocation: mapCommon.LatLng[] = [{ longitude: 116.490437, latitude: 39.90536209 }]

 build() {
   Column() {
     RouteDetail({
       stationLocation: this.stationLocation,
       busLocation: this.busLocation,
       busLineInfo: new BusLineInfo('1 路', '老山公交场站方向', '6：00', '22：00', 2, 3, this.line, this.nearInfos),
       nearToMe: 0,
       busIndex: [0.1, 1.1]
     })
   }
 }
}
```

## 更新记录

- **1.0.1 (2025-08-30)**：状态管理 V1 切 V2 修改 README
- **1.0.0 (2025-07-31)**：初始版本

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

## 兼容性

### HarmonyOS 版本

- 5.0.0
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

### DevEcoStudio 版本

- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4ba72855181a45dfb52b0505dbff8a5e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%85%AC%E4%BA%A4%E8%B7%AF%E7%BA%BF%E8%AF%A6%E6%83%85%E7%BB%84%E4%BB%B6/route_detail1.0.1.zip