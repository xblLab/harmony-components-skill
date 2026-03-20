# 周边餐饮住宿组件

## 简介

本组件提供景区周边餐饮住宿浏览功能。

## 详细介绍

### 简介

本组件提供景区周边餐饮住宿浏览功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `catering_accommodation` 和 `module_base` 模块：

```json5
"modules": [
   {
   "name": "catering_accommodation",
   "srcPath": "./xxx/catering_accommodation",
   },
   {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖：

```json5
"dependencies": {
   "catering_accommodation": "file:./xxx/catering_accommodation",
   "module_base": "file:./xxx/module_base",
}
```

#### 配置 module.json5

在主工程的 `src/main` 路径下的 `module.json5` 文件中配置如下信息：

1. 配置应用的 client ID，详细参考：配置 Client ID。
2. 在 `requestPermissions` 字段中添加如下权限：

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

#### 引入组件

```typescript
import { AttractionLive } from 'attraction_live';
```

#### 初始化景区的经纬度

```typescript
this.locationInfo.latitude = 22.92;
this.locationInfo.longitude = 113.86;
```

### API 参考

无

### 示例代码

```typescript
import { PersistenceV2 } from '@kit.ArkUI';
import { LocationInfo } from 'module_base';

@Entry
@ComponentV2
struct Index {
  @Provider('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();
  locationInfo: LocationInfo =
     PersistenceV2.connect(LocationInfo, 'locationInfo', () => new LocationInfo())!;

  aboutToAppear(): void {
     this.locationInfo.latitude = 22.92;
     this.locationInfo.longitude = 113.86;
  }

  build() {
     Navigation(this.mainPathStack) {
        Column() {
           Button('餐饮与住宿').onClick(() => {
              this.mainPathStack.pushPathByName('CateringAndAccommodation', null);
           });
        };
     }.title('餐饮住宿');
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-12-15 | 修复部分问题 |
| 1.0.0 | 2025-09-11 | 初始版本 |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| **SDK 合规使用指南** | 不涉及 |
| **隐私政策** | 不涉及 |

#### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

#### 应用类型

- 应用
- 元服务

#### 设备类型

- 手机
- 平板
- PC

#### DevEco Studio 版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c8c356db5f0a4bafbb0d42ca2ab57e2a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%91%A8%E8%BE%B9%E9%A4%90%E9%A5%AE%E4%BD%8F%E5%AE%BF%E7%BB%84%E4%BB%B6/catering_accommodation1.0.1.zip