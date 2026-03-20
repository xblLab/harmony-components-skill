# 半模态城市选择组件

## 简介

本组件支持通过定位、首字母选择、搜索等多种方式进行城市选择。

## 详细介绍

### 简介

本组件支持通过定位、首字母选择、搜索等多种方式进行城市选择。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.4 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.4 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.4 Release 及以上

#### 权限

获取位置权限：ohos.permission.APPROXIMATELY_LOCATION

### 快速入门

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 build-profile.json5 添加 module_city_select 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 module_city_select 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_city_select",
    "srcPath": "./XXX/module_city_select",
    }
]
```

c. 在项目根目录 oh-package.json5 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_city_select": "file:./XXX/module_city_select"
}
```

开通地图服务用于实现城市的定位。

引入组件。

深色代码主题复制
```typescript
import { CitySearchController, UICitySelect } from 'module_city_select'
```

## API 参考

### UICitySelect(option: UICitySelectOptions)

**UICitySelectOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| currentCity | string | 否 | 当前定位城市 |
| controller | CitySelectController | 否 | 城市选择控制器 |
| goBack(city?: string) => void | Function | 否 | 返回上一级页面 |
| emitUpdateCityLocation(city: string) => void | Function | 否 | 更新当前定位城市的回调 |

### CitySelectController

分类组件的控制器，用于控制分类条目的滚动。同一个控制器不可以控制多个分类组件。

#### constructor

`constructor()`

CitySelectController 的构造函数。

#### onBackPressed

`onBackPressed(): boolean`

触发组件内部返回事件

### 示例代码

深色代码主题复制
```typescript
import { CitySearchController, UICitySelect } from 'module_city_select';

@Entry
@ComponentV2
struct CitySelectSample {
 @Local currentCity: string = '武汉';
 controller: CitySearchController = new CitySearchController();

 onBackPress(): boolean | void {
   return this.controller.onBackPressed();
 }

 build() {
   NavDestination() {
     Column() {
       UICitySelect({
         currentCity: this.currentCity,
         controller: this.controller,
         emitUpdateCityLocation: (city: string) => {
           this.currentCity = city;
         },
         goBack: (citySelected?: string) => {
           if (citySelected){
             this.currentCity = citySelected
             const message = citySelected ? `选择了${citySelected}并返回` : '直接返回';
             this.getUIContext().getPromptAction().showToast({ message });
           }
         },
       })
     }
     .width('100%')
   }
   .height('100%')
   .width('100%')
   .title('城市选择组件')
 }
}
```

## 更新记录

1.0.1 (2025-11-03)

Created with Pixso.

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 状态 |
| :--- | :--- |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |

### 应用类型

| 类型 | 状态 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 状态 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEcoStudio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d8a89e644d084aa883cc51b6e8619f63/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%8D%8A%E6%A8%A1%E6%80%81%E5%9F%8E%E5%B8%82%E9%80%89%E6%8B%A9%E7%BB%84%E4%BB%B6/module_city_select1.0.1.zip