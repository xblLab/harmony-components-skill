# 停车场卡片组件

## 简介

本模块为 module_parking_map 停车场地图列表组件和 module_parking_spots 停车场页签组件提供了基础能力。

## 详细介绍

### 简介

本模块为 module_parking_map 停车场地图列表组件和 module_parking_spots 停车场页签组件提供了基础能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.0 Release 及以上

#### 权限

- **位置权限**：ohos.permission.LOCATION
- **模糊位置权限**：ohos.permission.APPROXIMATELY_LOCATION

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 module_parking_base 模块。
   > // 项目根目录下 build-profile.json5 填写 module_parking_base 路径。其中 XXX 为组件存放的目录名
   ```json5
   "modules": [
      {
      "name": "module_parking_base",
      "srcPath": "./XXX/module_parking_base"
      }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   > // XXX 为组件存放的目录名
   ```json5
   "dependencies": {
      "module_parking_base": "file:./XXX/module_parking_base"
   }
   ```

#### 引入组件句柄

```typescript
import { BasicParkInfo, CommonSpotItem, ServiceUtil } from 'module_parking_base';
```

#### 停车场搜索

详细入参配置说明参见 API 参考。

```typescript
ServiceUtil.searchParking({ latitude: 39.9, longitude: 116.4 });
```

#### 停车场卡片展示

详细入参配置说明参见 API 参考。

```typescript
CommonSpotItem({ item: this.spotInfoMock, selected: true })
```

### API 参考

#### 子组件

无

#### 接口

##### CommonSpotItem(options?: CommonSpotItemOptions)

停车场卡片组件。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CommonSpotItemOptions | 否 | 配置停车场卡片组件的参数。 |

**CommonSpotItemOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| item | BasicParkInfo | 是 | 停车场基本信息 |
| cardClick | number | 否 | 点击回调事件 |
| selected | boolean | 否 | 是否选中高亮 |
| pad | Padding \| Length | 否 | 内边距 |

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

##### searchParking

`ServiceUtil.searchParking(center: mapCommon.LatLng)`

根据经纬度搜索附近停车场。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| center | mapCommon.LatLng | 是 | 搜索中心 |

### 示例代码

本示例通过 searchParking 搜索指定位置附近停车场，并通过 CommonSpotItem 卡片实现展示。

```typescript
import { BasicParkInfo, CommonSpotItem, ServiceUtil } from 'module_parking_base';

@Entry
@ComponentV2
struct Index {
  @Local spotInfo: BasicParkInfo | undefined = undefined;

  aboutToAppear(): void {
    ServiceUtil.searchParking({ latitude: 39.9, longitude: 116.4 }).then(res => {
      this.spotInfo = res.pop();
    });
  }

  build() {
    Column() {
      if (!this.spotInfo) {
        Column({ space: 10 }) {
          LoadingProgress().size({ width: 36, height: 36 })
          Text('搜索停车场中').fontSize(20)
        }
      } else {
        CommonSpotItem({ item: this.spotInfo, selected: true })
      }
    }
    .justifyContent(FlexAlign.Center)
    .padding(16)
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

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

#### HarmonyOS 版本

- 5.0.0
- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0

#### 应用类型

- 应用
- 元服务

#### 设备类型

- 手机
- 平板
- PC

#### DevEco Studio 版本

- DevEco Studio 5.0.0
- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0841ff95dd6149ccbd1186b912e435da/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%81%9C%E8%BD%A6%E5%9C%BA%E5%8D%A1%E7%89%87%E7%BB%84%E4%BB%B6/module_parking_base1.0.1.zip