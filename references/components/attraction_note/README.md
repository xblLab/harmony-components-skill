# 游记组件

## 简介

本组件提供游记浏览搜索、详情查看及评论等功能。

## 详细介绍

### 功能简介

本组件提供景区游记浏览搜索、详情查看、游记评论、推荐线路查看等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

- **获取位置权限**：`ohos.permission.APPROXIMATELY_LOCATION`、`ohos.permission.LOCATION`
- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `attraction_note` 和 `module_base` 模块。

```json5
"modules": [
   {
   "name": "attraction_note",
   "srcPath": "./xxx/attraction_note",
   },
   {
      "name": "module_base",
      "srcPath": "./xxx/module_base",
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "attraction_note": "file:./xxx/attraction_note",
   "module_base": "file:./xxx/module_base"
}
```

#### 配置地图相关权限

1. 在主工程的 `module.json5` 文件中配置如下地图相关权限。

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

2. 将应用的 client ID 配置到主工程模块的 `src/main/module.json5` 文件，详细参考：[配置 Client ID](https://developer.huawei.com/consumer/cn/market/prod-detail/27cac469caa64574b600766601a0b410/2adce9bbd4cb42d58a87e6add45594b3?origin=template)。

#### 引入组件

```typescript
import { PageGround } from 'attraction_note';
```

#### 初始化组件所需的路由栈和经纬度信息

```typescript
@Provider('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();
private locationInfo: LocationInfo =
         PersistenceV2.connect(LocationInfo, 'locationInfo', () => new LocationInfo())!;

aboutToAppear(): void {
   this.locationInfo.latitude = 22.92
   this.locationInfo.longitude = 113.86
}
```

在 `module_base` 模块的 `src/main/resources/base/profile` 目录下的 `router_map.json` 文件中配置如下内容：

```json
...
{
   "name": "Tickets",
   "pageSourceFile": "src/main/ets/pages/Tickets.ets",
   "buildFunction": "TicketsBuilder"
 },
 {
   "name": "AttractionDetail",
   "pageSourceFile": "src/main/ets/pages/AttractionDetail.ets",
   "buildFunction": "AttractionDetailBuilder"
 }
...
```

### API 参考

#### 接口

**PageGround(isShowBack: boolean)**

游记组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| isShowBack | boolean | 是 | 是否展示返回 |

#### 示例代码

```typescript
import { PersistenceV2 } from '@kit.ArkUI';
import { PageGround } from 'attraction_note';
import { LocationInfo } from 'module_base';

@Entry
@ComponentV2
struct Index {
 @Provider('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();
 private locationInfo: LocationInfo =
   PersistenceV2.connect(LocationInfo, 'locationInfo', () => new LocationInfo())!;

 aboutToAppear(): void {
   this.locationInfo.latitude = 22.92
   this.locationInfo.longitude = 113.86
 }

 build() {
   Navigation(this.mainPathStack) {
     Column() {
       PageGround({
         isShowBack: false,
       })
     }.height('90%')
   }.hideTitleBar(true);
 }
}
```

### 更新记录

- **1.0.4 (2025-12-15)**：下载该版本修复部分问题。
- **1.0.3 (2025-09-11)**：下载该版本新增游记关联游览线路功能。
- **1.0.2.0 (2025-08-29)**：下载该版本 readme 内容优化。
- **1.0.1 (2025-07-18)**：下载该版本优化 readme。
- **1.0.2 (2025-07-04)**：下载该版本本组件提供游记浏览搜索、详情查看及评论等功能。

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

#### 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/27cac469caa64574b600766601a0b410/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%B8%B8%E8%AE%B0%E7%BB%84%E4%BB%B6/attraction_note1.0.4.zip