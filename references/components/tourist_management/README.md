# 常用游客管理组件

## 简介

本组件提供常用游客查看与管理，并且支持多选进行表单填充等功能。

## 详细介绍

### 简介

本组件提供常用游客查看与管理，并且支持多选进行表单填充等功能。

### 游客列表游客删除

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS 版本：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `tourist_management` 和 `module_base` 模块

```json5
"modules": [
   {
   "name": "tourist_management",
   "srcPath": "./xxx/tourist_management",
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
   "tourist_management": "file:./xxx/tourist_management",
   "module_base": "file:./xxx/module_base",
}
```

#### 引入组件

```typescript
import { Tourists } from 'tourist_management';
```

#### 新增游客管理页面

a. 在 `src/main/ets/pages` 下新增 `TouristPage.ets` 文件，文件内容见示例代码。

b. 在 `src/main` 下的 `module.json` 文件中添加路由配置。

```json
...
"routerMap": "$profile:router_map",
...
```

c. `src/main/resources/base/profile` 下新增 `router_map.json` 路由配置文件。

```json
{
  "routerMap": [
    {
      "name": "TouristPage",
      "pageSourceFile": "src/main/ets/pages/TouristPage.ets",
      "buildFunction": "TouristPageBuilder",
      "data": {
          "description": "this is TouristPage"
      }
    }
  ]
}
```

### API 参考

#### 接口

`Tourists(touristList: TouristInfo[], isInReserve: boolean, changeSelectedStatus: (isChecked: boolean, touristId: string) => void, setSelectedTourist: () => void, changeSheetContent: (isInitialPage: boolean, tourist: TouristInfo) => void, closeSheet: () => void, deleteTourist: (touristId: string) => void, addOrEditTourist: (tourist: TouristInfo, isEdit: boolean) => void)`

常用游客管理组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| touristList | TouristInfo[] | 是 | 常用游客列表 |
| isInReserve | boolean | 是 | 是否展示 checkbox |
| changeSelectedStatus | `(isChecked: boolean, touristId: string) => void` | 否 | 改变选择状态 |
| setSelectedTourist | `() => void` | 否 | 设置已选游客 |
| changeSheetContent | `(isInitialPage: boolean, tourist: TouristInfo) => void` | 否 | 改变半模态窗口内容 |
| closeSheet | `() => void` | 否 | 关闭半模态窗口 |
| deleteTourist | `(touristId: string) => void` | 否 | 删除游客 |
| addOrEditTourist | `(tourist: TouristInfo, isEdit: boolean) => void` | 否 | 新增或编辑游客 |

#### TouristInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 游客 id |
| name | ResourceStr | 是 | 游客名称 |
| phone | string | 是 | 游客联系方式 |
| cardType | number | 是 | 证件类型 |
| cardNo | string | 是 | 证件号码 |
| isChecked | boolean | 是 | 是否勾选 |

### 示例代码

#### 游客列表页面

```typescript
import { TouristInfo } from 'module_base';
import { DeleteConfirmDialog, Tourists } from 'tourist_management';

@Entry
@ComponentV2
struct Index {
 @Provider('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();
 @Local touristId: string = '';
 @Local touristList: TouristInfo[] = [{
   id: 'tourist1',
   name: '游客 1',
   phone: '1234567890',
   cardType: 1,
   cardNo: '1234567890',
   isChecked: false,
 } as ESObject];
 dialogController: CustomDialogController | null = new CustomDialogController({
   builder: DeleteConfirmDialog({
     delete: () => {
       this.touristList = this.touristList.filter(item => item.id !== this.touristId);
     },
     type: 0,
   }),
   customStyle: false,
   autoCancel: true,
   backgroundColor: $r('sys.color.ohos_id_blur_style_component_ultra_thick_color'),
 });

 build() {
   Navigation(this.mainPathStack) {
     Tourists({
       touristList: this.touristList, deleteTourist: (id: string) => {
         this.touristId = id;
         if (this.dialogController != null) {
           this.dialogController.open();
         }
       },
     });
   }.title('游客列表').mode(NavigationMode.Stack);
 }
}
```

#### 游客管理页面

```typescript
import { promptAction } from '@kit.ArkUI';
import { TouristInfo } from 'module_base';
import { Tourist } from 'tourist_management';

@Builder
export function TouristPageBuilder() {
 TouristPage();
}

@Entry
@ComponentV2
struct TouristPage {
 @Local touristInfo: TouristInfo = new TouristInfo();
 @Consumer('mainPathStack') mainPathStack: NavPathStack = new NavPathStack();

 build() {
   NavDestination() {
     Tourist({
       touristInfo: this.touristInfo,
       isEdit: false,
       addOrEditTourist: () => {
         this.getUIContext().getPromptAction().showToast({ message: '模拟新增或编辑' })
       },
     });
   }.title('游客管理');
 }
}
```

### 更新记录

- **1.0.2 (2026-02-13)**
  - 下载该版本修改证件类型问题。
- **1.0.1 (2025-12-12)**
  - 下载该版本修复部分问题。
- **1.0.0 (2025-09-11)**
  - 下载该版本初始版本。

### 权限与隐私

#### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

#### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9620f8be7cc343cab7e391e881d390c4/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%B8%B8%E7%94%A8%E6%B8%B8%E5%AE%A2%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/tourist_management1.0.2.zip