# 通用城市选择组件

## 简介

本组件提供选择城市的功能，长按城市按钮将显示城市全称。

## 详细介绍

### 简介

本组件提供选择城市的功能，长按城市按钮将显示城市全称。

### 直板机折叠屏平板

### 约束与限制

#### 环境

- DevEco Studio版本：DevEco Studio 5.0.5 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.5 Release SDK及以上
- 设备类型：华为手机（包括双折叠和阔折叠）、华为平板
- 系统版本：HarmonyOS 5.0.1(13)及以上

#### 权限

- 位置权限：ohos.permission.APPROXIMATELY_LOCATION

### 快速入门

安装组件。

> 如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的xxx目录下。

b. 在项目根目录build-profile.json5添加city_select模块。

```json5
"modules": [
   {
   "name": "city_select",
   "srcPath": "./xxx/city_select",
   },
]
```

c. 在项目根目录oh-package.json5中添加依赖

```json5
"dependencies": {
   "city_select": "file:./xxx/city_select",
}
```

引入城市选择组件句柄。

```typescript
import { CitySelect, CitySelectController, City } from 'city_select';
```

定位当前城市需要开通地图服务，详细参考地图服务的开发准备。

调用组件，详细参数配置说明参见API参考。

## API参考

### 接口

#### CitySelect(option: CitySelectOptions)

城市选择组件。

参数：

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| options | CitySelectOptions | 是 | 城市选择组件参数 |

#### CitySelectOptions对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| cityList | City[] | 是 | 城市列表 |
| hotCityList | City[] | 否 | 热门城市列表 |
| select | (city: City) => void | 否 | 选择城市 |
| cancel | () => void | 否 | 取消选择 |
| handleCurrentCity | (city: City) => void | 否 | 处理当前定位城市 |
| controller | CitySelectController | 否 | 返回逻辑控制器 |

#### City类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| name | string | 是 | 城市名称 |
| code | string | 否 | 城市code |

#### CitySelectController类型说明

| 参数名 | 类型 | 是否必填 | 说明 |
|--------|------|----------|------|
| onBackPressed | () => boolean | 否 | 返回逻辑函数，侧滑返回触发清空搜索框内容，返回到城市选择页 |

### 示例代码

```typescript
import { CITY_LIST_SAMPLE, CitySelect, HOT_CITY_LIST_SAMPLE, CitySelectController, City } from 'city_select';

@Entry
@ComponentV2
struct CitySelectPage {
  @Local currentCity: City = {
     name: '南京市',
     code: '320100',
  };
  controller: CitySelectController = new CitySelectController();

  onBackPress(): boolean | void {
     return this.controller.onBackPressed();
  }

  build() {
     NavDestination() {
        Column() {
           CitySelect({
              select: ((city) => {
                 // 选择城市
                 this.currentCity = city
              }),
              cancel: () => {
                 // 取消选择
              },
              cityList: CITY_LIST_SAMPLE,
              hotCityList: HOT_CITY_LIST_SAMPLE,
              controller: this.controller,
           })
        }
        .width('100%')
     }
     .height('100%')
        .width('100%')
        .title(`城市选择：${this.currentCity.name}`)
  }
}
```

## 更新记录

### 1.0.0（2025-11-03）

初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
|----------|----------|----------|
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |

### 隐私政策

不涉及

### SDK合规使用指南

不涉及

## 兼容性

### HarmonyOS版本

| 版本 | 支持 |
|------|------|
| 5.0.1 | ✓ |
| 5.0.2 | ✓ |
| 5.0.3 | ✓ |
| 5.0.4 | ✓ |
| 5.0.5 | ✓ |

### 应用类型

| 类型 | 支持 |
|------|------|
| 应用 | ✓ |
| 元服务 | ✓ |

### 设备类型

| 类型 | 支持 |
|------|------|
| 手机 | ✓ |
| 平板 | ✓ |
| PC | ✓ |

### DevEcoStudio版本

| 版本 | 支持 |
|------|------|
| DevEco Studio 5.0.5 | ✓ |
| DevEco Studio 5.1.0 | ✓ |
| DevEco Studio 5.1.1 | ✓ |
| DevEco Studio 6.0.0 | ✓ |

## 来源

- 原始URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1c5ebb435cf549c988ba23ffad7b8920/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%9A%E7%94%A8%E5%9F%8E%E5%B8%82%E9%80%89%E6%8B%A9%E7%BB%84%E4%BB%B6/city_select1.0.0.zip