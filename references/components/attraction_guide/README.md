# 景区导览组件

## 简介

提供景区景点及配套设施导览功能。

## 详细介绍

### 简介

提供景区景点及配套设施导览功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 6.0.1(21) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`
- **获取位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`、`ohos.permission.LOCATION`

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `attraction_guide`、`attraction_announcement` 和 `module_base` 模块。

```json5
"modules": [
   {
   "name": "attraction_guide",
   "srcPath": "./xxx/attraction_guide",
   },
   {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
   },
   {
      "name": "attraction_announcement",
      "srcPath": "./xxx/attraction_announcement",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "attraction_guide": "file:./xxx/attraction_guide",
   "attraction_announcement": "file:./xxx/attraction_announcement",
   "module_base": "file:./xxx/module_base"
}
```

在主工程的 `src/main` 路径下的 `module.json5` 文件中配置如下信息：

1. 配置应用的 client ID，详细参考：配置 Client ID。
2. 在 `requestPermissions` 字段中添加如下权限。

```json5
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
{
  "name": "ohos.permission.APPROXIMATELY_LOCATION",
  "reason": "$string:app_name",
  "usedScene": {
     "abilities": [
       "EntryAbility"
     ],
  "when": "inuse"
  }
},
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
...
],
```

引入组件。

```typescript
import { AttractionGuide } from 'attraction_guide';
```

## API 参考

### 接口

**AttractionGuide(location: number[], initAttractionInfo: AttractionsInfo)**
景区导览组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| location | number[] | 是 | 经纬度信息 |
| initAttractionInfo | AttractionsInfo | 是 | 初始景区导览信息 |

#### AttractionsInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| banners | ResourceStr[] | 是 | 封面图 |
| attractions | AttractionInfo[] | 是 | 景点信息列表 |

#### AttractionInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| labels | string[] | 是 | 景点标签 |
| detailImages | ResourceStr[] | 是 | 景点详情图片 |
| attractionId | number | 是 | 景点 id |
| brief | string | 是 | 景点简介 |
| name | string | 是 | 景点名称 |
| location | string | 是 | 景点详细地址 |
| longitude | number | 是 | 景点经度 |
| latitude | number | 是 | 景点纬度 |
| banner | ResourceStr | 是 | 景点 banner |
| icon | ResourceStr | 是 | 景点图标 |
| introduction | string | 是 | 景点介绍 |
| consultPhone | string | 是 | 景点咨询电话 |
| audio | string | 是 | 景点音频 |
| isHot | number | 是 | 是否热门景点 |

## 示例代码

```typescript
import { AttractionGuide } from 'attraction_guide';
import { AttractionsInfo } from 'module_base';

@Entry
@ComponentV2
struct Index {
  @Provider('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();
  @Local attractionsInfo: AttractionsInfo = {
     banners: [],
     attractions: [
        {
           labels: ['文化建筑', '异域风情'],
           detailImages: ['https://agc-storage-drcn.platform.dbankcloud.cn/v0/scenic-i0v1l/common%2FHeidelberg.png?token=99ed2760-b4e9-4e46-87ed-8c99af510410'],
           attractionId: 0,
           name: '海德尔堡',
           banner: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/scenic-i0v1l/common%2FHeidelberg_B.png?token=66ceba4d-be1d-4c87-a01b-98ed7002c2de',
           icon: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/scenic-i0v1l/common%2FHeidelberg_I.png?token=75fb65ee-9519-40aa-8ac5-4681c1e4a278',
           isHot: 1,
           latitude: 22.878538,
           longitude: 113.886642,
           audio: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/scenic-i0v1l/phone%2FDelacey%20-%20Dream%20It%20Possible.flac?token=0252b0cb-b617-4708-86dc-5b0d052529ab',
           location: '松山湖欧洲小镇 L 区',
           brief: '',
           introduction: '',
           consultPhone: ''
        }
     ],
  }

  build() {
     Navigation(this.mainPathStack) {
        AttractionGuide({
           location: [22.92, 113.86],
           initAttractionInfo: this.attractionsInfo,
        }).height('90%');
     }.title('景区导览').mode(NavigationMode.Stack);
  }
}
```

## 更新记录

- **1.0.2 (2026-02-13)**
  - 下载该版本新增小艺智能体功能。
- **1.0.1 (2025-12-15)**
  - 下载该版本修复部分问题。
- **1.0.0 (2025-11-03)**
  - 下载该版本初始版本。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |

### 合规使用指南

不涉及

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 6.0.1 |
| 应用类型 | 应用 |
| 元服务 | 支持 |
| 设备类型 | 手机、平板、PC |
| DevEco Studio 版本 | DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d0817bc2c5e741c78a18e1b558198afd/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%99%AF%E5%8C%BA%E5%AF%BC%E8%A7%88%E7%BB%84%E4%BB%B6/attraction_guide1.0.2.zip