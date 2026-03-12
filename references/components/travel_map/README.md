# 地图（定位选点）组件

## 简介

本组件提供地图展示能力，并支持地图定位和选点定制功能。

## 详细介绍

### 简介

本组件提供地图展示能力，并支持地图定位和选点定制功能。

全屏地图嵌入式地图

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.1 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.1 Release SDK及以上
- 设备类型：华为手机（直板机）
- HarmonyOS版本：HarmonyOS 5.0.1(13)及以上

#### 权限

获取位置权限：ohos.permission.APPROXIMATELY_LOCATION、ohos.permission.LOCATION。

### 快速入门

#### 安装组件

如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的xxx目录下。

b. 在项目根目录build-profile.json5并添加travel_map模块

```json5
"modules": [
  {
    "name": "travel_map",
    "srcPath": "./xxx/travel_map",
  }
]
```

c. 在项目根目录oh-package.json5中添加依赖

```json5
"dependencies": {
  "travel_map": "file:./xxx/travel_map"
}
```

#### 引入组件

```typescript
import { CommonMap } from 'travel_map';
```

#### 配置地图相关权限

a. 在主工程的module.json5文件中配置如下地图相关权限。

```json5
"requestPermissions": [
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
],
```

b. 将应用的client ID配置到主工程模块的src/main/module.json5文件，详细参考：配置Client ID。

## API参考

### 接口

#### CommonMap(travelMapOptions: TravelMapOptions)

地图选点组件。

**参数说明**

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| travelMapOptions | TravelMapOptions | 是 | 地图选点详情 |

#### TravelMapOptions对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| location | Location | 是 | 位置信息 |
| icon | ResourceStr | 是 | 标记点图标 |
| titleOptions | TitleOptions | 是 | 标记点名称属性 |
| cameraSpeed | number | 是 | 相机定位移动速度 |
| zoom | number | 是 | 地图放大倍数 |
| height | number/string | 是 | 地图高度 |
| pointClickCallBack | () => void | 是 | 标记点点击回调 |

#### Location类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| latitude | number | 是 | 纬度 |
| longitude | number | 是 | 经度 |

#### TitleOptions类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| name | string | 是 | 标记点名称 |
| strokeColor | number | 是 | 标记点展示颜色 |

### 示例代码

```typescript
import { CommonMap } from 'travel_map';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
export struct Home {
  build() {
    Column() {
      CommonMap(
        {
          travelMapOptions: {
            location: {
              latitude: 30.56,
              longitude: 119.89,
            },
            icon: $r('app.media.point'),
            titleOptions: {
              name: '一间民宿',
              strokeColor: 0xFFFFFFFF,
            },
            cameraSpeed: 1000,
            zoom: 10,
            height: '100%',
            pointClickCallBack: () => {
              promptAction.showToast({ message: '点击标记点' });
            },
          },
        });
    };
  }
}
```

## 更新记录

### 1.0.3（2025-12-15）

状态管理由V1切换到V2

### 1.0.2.0（2025-10-31）

优化readme内容

### 1.0.1（2025-07-21）

优化readme

### 1.0.2（2025-07-04）

本组件提供地图展示能力，并支持地图定位和选点定制功能。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |

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

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/862d7d910139425a949502d56ff752ee/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%B0%E5%9B%BE%EF%BC%88%E5%AE%9A%E4%BD%8D%E9%80%89%E7%82%B9%EF%BC%89%E7%BB%84%E4%BB%B6/travel_map1.0.3.zip