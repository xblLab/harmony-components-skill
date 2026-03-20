# 热量计算组件

## 简介

本组件提供了展示卡路里计算和统计的相关功能。

## 详细介绍

### 简介

本组件提供了展示卡路里计算和统计的相关功能。

### 功能概览

计算卡路里统计卡路里

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `calorie_calculation` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 calorie_calculation 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "calorie_calculation",
    "srcPath": "./xxx/calorie_calculation",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "base_ui": "file:./xxx/base_ui",
  "calorie_calculation": "file:./xxx/calorie_calculation"
}
```

引入组件。

```typescript
import { CalorieCalculation } from 'calorie_calculation';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
CalorieCalculation({
   seriesData: this.vm.seriesData,
   dietPlanList: this.vm.dietPlanList,
   addMeal: (id: number) => {
     RouterModule.push(RouterMap.DIET_PLAN_PAGE, { 'id': id } as Record<string, number>,
       (popInfo: PopInfo) => {
         this.vm.init()
       })
   },
 })
```

## API 参考

### 接口

`CalorieCalculation(options?: CalorieCalculationOptions)`

展示卡路里计算和统计组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CalorieCalculationOptions | 否 | 展示卡路里计算和统计的参数。 |

##### CalorieCalculationOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| seriesData | number[] | 否 | 每日摄入卡路里 |
| dietPlanList | DietPlans[] | 否 | 卡路里餐食计划 |

###### DietPlans 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 否 | 餐食计划 id |
| name | string | 否 | 餐食计划名称 |
| desc | string | 否 | 餐食计划描述 |
| totalCalories | number | 否 | 餐食计划总卡路里 |
| foodList | FoodPlanCalories[] | 否 | 餐食计划食物列表 |

###### FoodPlanCalories 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 否 | 食物 id |
| name | string | 否 | 食物名称 |
| weight | number | 否 | 食物重量 |
| calories | number | 否 | 食物卡路里 |

### 事件

支持以下事件：

#### addMeal

`addMeal(callback: (id: number) => void)`

点击添加餐食计划的回调。

### 示例代码

```typescript
import { CalorieCalculation, DietPlans, FoodPlanCalories } from 'calorie_calculation';
import { promptAction } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local seriesData: number[] = [1500, 1250, 1200, 1280, 1650, 1700, 1600];
  @Local dietPlanList: DietPlans[] =
     [new DietPlans(1, 1, '早餐', '描述', 100, [new FoodPlanCalories(1, '面包', 100, 100)])];

  build() {
     RelativeContainer() {
        CalorieCalculation({
           seriesData: this.seriesData,
           dietPlanList: this.dietPlanList,
           addMeal: (id: number) => {
              promptAction.showToast({ message: '跳转加餐' })
           },
        })
     }
     .height('100%')
     .width('100%')
     .padding({ top: 45 })
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.4 | 2026-01-14 | 折叠屏适配修改，废弃 api 修改 | 下载该版本 |
| 1.0.3 | 2025-11-07 | 更新修改 readme 内容 | 下载该版本 |
| 1.0.2 | 2025-09-10 | 更新 readme 内容 | 下载该版本 |
| 1.0.1 | 2025-08-29 | 优化目录结构 | 下载该版本 |
| 1.0.0 | 2025-07-10 | 本组件提供了展示卡路里计算和统计的相关功能。 | 下载该版本 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 状态 |
| :--- | :--- |
| 5.0.4 | 支持 |
| 5.0.5 | 支持 |
| 5.1.0 | 支持 |
| 5.1.1 | 支持 |
| 6.0.0 | 支持 |
| 6.0.1 | 支持 |

### 应用类型

| 类型 | 状态 |
| :--- | :--- |
| 应用 | 支持 |
| 元服务 | 支持 |

### 设备类型

| 类型 | 状态 |
| :--- | :--- |
| 手机 | 支持 |
| 平板 | 支持 |
| PC | 支持 |

### DevEco Studio 版本

| 版本 | 状态 |
| :--- | :--- |
| DevEco Studio 5.0.4 | 支持 |
| DevEco Studio 5.0.5 | 支持 |
| DevEco Studio 5.1.0 | 支持 |
| DevEco Studio 5.1.1 | 支持 |
| DevEco Studio 6.0.0 | 支持 |
| DevEco Studio 6.0.1 | 支持 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/535d7501982a4dad9e5af19ef0d130e7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%83%AD%E9%87%8F%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/calorie_calculation1.0.4.zip