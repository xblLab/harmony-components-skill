# 景点实况组件

## 简介

本组件提供景区实况情况介绍功能。

## 详细介绍

### 简介

本组件提供景区实况情况介绍功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

- **网络权限**：ohos.permission.INTERNET

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `attraction_live` 和 `module_base` 模块

```json5
"modules": [
   {
   "name": "attraction_live",
   "srcPath": "./xxx/attraction_live",
   },
   {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
   }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖

```json5
"dependencies": {
   "attraction_live": "file:./xxx/attraction_live",
   "module_base": "file:./xxx/module_base",
}
```

在主工程的 `src/main` 路径下的 `module.json5` 文件中配置如下信息：

a. 配置应用的 client ID，详细参考：配置 Client ID。
b. 在 `requestPermissions` 字段中添加如下权限。

```json
"requestPermissions": [
...
{
  "name": "ohos.permission.INTERNET",
  "reason": "$string:app_name",
  "usedScene": {
     "abilities": [
       "EntryAbility"
     ],
  "when": "inuse"
  }
},
...
],
```

引入组件。

```typescript
import { AttractionLive } from 'attraction_live';
```

## API 参考

### 接口

**AttractionLive(attractionLiveInfo: AttractionLiveInfo)**
景区实况组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| attractionLiveInfo | AttractionLiveInfo[] | 是 | 景区实况信息 |

**AttractionLiveInfo 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| longitude | number | - | 经度 |
| latitude | number | - | 纬度 |
| currentDate | Date | - | 当前日期 |
| temperature | number | - | 温度 |
| currentDayVisitors | number | - | 今日游客数 |
| maxVisitors | number | - | 最大游客数 |
| maxInstantVisitors | string | - | 最大瞬时游客数 |
| weatherId | string | - | 天气 Id |
| atmosphereId | string | - | 空气质量 Id |
| name | string | - | 景区名称 |
| realTimeInfos | RealTimeInfo | - | 音频地址 |
| openTime | string | - | 音频地址 |
| ticketTime | string | - | 音频地址 |

**RealTimeInfo 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| iconResourceStr | Str | - | 实时信息图标 |
| item | string | - | 实时信息条目 |
| count | number | - | 实时人数 |

## 示例代码

```typescript
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { AttractionLive, mapperParkingSlot, ParkingSlotInfo } from 'attraction_live';
import { AttractionLiveInfo, SystemUtil } from 'module_base';

@Entry
@ComponentV2
struct Index {
 @Local attractionLiveInfo: AttractionLiveInfo = {
   longitude: 118,
   latitude: 32,
   currentDate: new Date(),
   temperature: 24,
   currentDayVisitors: 100,
   maxVisitors: 200,
   maxInstantVisitors: 100,
   weatherId: '晴',
   atmosphereId: '良好',
   name: '松山湖景区',
   openTime: '09:00-18:00',
   ticketTime: '09:00-18:00',
 }
 @Local parkingSlotList: ParkingSlotInfo[] = [];
 @Local longitude: number = 0;
 @Local latitude: number = 0;

 aboutToAppear(): void {
   this.longitude = this.attractionLiveInfo.longitude;
   this.latitude = this.attractionLiveInfo.latitude;
   this.getParkingSlot();
 }

 getParkingSlot() {
   SystemUtil.getPoiListByText(this.latitude, this.longitude, '停车场', 1000,).then((res) => {
     let parkingSlotList = mapperParkingSlot(res.sites ?? [], this.latitude, this.longitude);
     this.parkingSlotList.push(...parkingSlotList.slice(0, 3));
   }).catch((e: BusinessError) => {
     hilog.error(0x0000, 'AttractionLiveVM', 'get parking fail ' + JSON.stringify(e));
   });
 }

 build() {
   Column() {
     AttractionLive({ attractionLiveInfo: this.attractionLiveInfo });
   }.height('100%').justifyContent(FlexAlign.Center);
 }
}
```

## 更新记录

### 1.0.1 (2025-12-12)

- 下载该版本
- 修复部分兼容性问题

### 1.0.0 (2025-09-11)

- 下载该版本
- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/14e2f6d6d06742e2880c27b4f101d2b2/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%99%AF%E7%82%B9%E5%AE%9E%E5%86%B5%E7%BB%84%E4%BB%B6/attraction_live1.0.1.zip