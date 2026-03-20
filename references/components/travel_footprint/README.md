# 旅行足迹组件

## 简介

本组件提供了旅行足迹管理的相关功能，支持足迹地图展示、总里程统计、足迹列表浏览、添加新足迹等能力。组件以地图为核心，结合列表展示的形式呈现用户的旅行轨迹，包括地图上的足迹标记、总行驶里程、足迹详情列表等信息，并提供添加新足迹的入口。支持足迹地图可视化、总里程统计、足迹列表展示、添加新足迹、地图与列表联动等功能。

## 详细介绍

### 简介

本组件提供了旅行足迹管理的相关功能，支持足迹地图展示、总里程统计、足迹列表浏览、添加新足迹等能力。组件以地图为核心，结合列表展示的形式呈现用户的旅行轨迹，包括地图上的足迹标记、总行驶里程、足迹详情列表等信息，并提供添加新足迹的入口。支持足迹地图可视化、总里程统计、足迹列表展示、添加新足迹、地图与列表联动等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3(15)Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3 及以上

#### 权限

无

#### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `travel_footprint` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 travel_footprint 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "travel_footprint",
    "srcPath": "./xxx/travel_footprint",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "travel_footprint": "file:./xxx/travel_footprint"
}
```

引入组件。

```typescript
import { Footprint, FootPrintItem } from 'travel_footprint';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
Footprint({
    footPrints: this.footPrints // 足迹数据
})
```

## API 参考

### 接口

#### Footprint

`Footprint(options: { footPrints: FootPrintItem[] })`

旅行足迹主组件，提供足迹地图展示、总里程统计、足迹列表浏览等功能。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| footPrints | FootPrintItem[] | 是 | 足迹数据列表 |
| returnClick | () => void | 否 | 返回按钮点击事件回调 |
| addPostClick | () => void | 否 | 添加足迹按钮点击事件回调 |
| jumpPostClick | () => void | 否 | 足迹项详情点击事件回调 |

#### LightMap

`LightMap(options: { lightItems: FootPrintItem[] })`

轻量级地图组件，用于展示足迹地理位置信息。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| lightItems | FootPrintItem[] | 是 | 用于在地图上显示的足迹数据列表 |

### 数据类型

#### FootPrintItem

足迹项数据模型，用于描述单个足迹信息。

| 属性名 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | string | 数据唯一标识 |
| city | string | 城市名称 |
| imgResourceStr | string | 足迹图片资源 |
| year | string | 足迹年份 |

#### FootPrintList

足迹列表数据模型，用于按年份分组展示足迹信息。

| 属性名 | 类型 | 说明 |
| :--- | :--- | :--- |
| year | string | 年份 |
| list | FootPrintItem[] | 该年份下的足迹列表 |

### 示例代码

```typescript
import { Footprint, FootPrintItem } from 'travel_footprint';

@Entry
@ComponentV2
struct Index {
  @Local footPrints: FootPrintItem[] = [
    {
      id: '001',
      year: '2025',
      city: '南京',
      img: $r('app.media.ic_location_nanjing')
    },
    {
      id: '002',
      year: '2025',
      city: '北京',
      img: $r('app.media.ic_location_beijing')
    },
    {
      id: '003',
      year: '2024',
      city: '上海',
      img: $r('app.media.ic_location_shanghai')
    },
    {
      id: '004',
      year: '2024',
      city: '深圳',
      img: $r('app.media.ic_location_shenzhen')
    },
    {
      id: '005',
      year: '2023',
      city: '苏州',
      img: $r('app.media.ic_location_suzhou')
    }
  ]

  build() {
    Column() {
      Footprint({
        footPrints: this.footPrints
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0A0B15', 0.0], ['#1B2C3A', 1.0]]
    })
  }
}
```

## 更新记录

### 版本信息

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.0 | 2026-01-06 | 初始版本 |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8df8fd0061e44beaa136c71110b6000a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%85%E8%A1%8C%E8%B6%B3%E8%BF%B9%E7%BB%84%E4%BB%B6/travel_footprint1.0.0.zip