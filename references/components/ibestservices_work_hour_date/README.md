# WorkHourDate 工时填报组件

## 简介

工时填报组件，与业务数据较为耦合，提供一个思路，可根据业务转换数据或二次开发。

## 详细介绍

### 简介

WorkHourDate 是一个基于 HarmonyOS 开发的工时填写以及回显组件，由公司业务抽离而来，与数据耦合度较高，可以作为一个思路提供帮助，或基于数据格式二次开发。

### 下载安装

```bash
ohpm install @ibestservices/work_hour_data
```

### 引入

```typescript
import WaterMark from '@ibestservices/work_hour_data'
```

### 代码演示

#### 页面展示

```typescript
import WorkHourDate, {DateItem} from '@ibestservices/work_hour_date'

// 省略…… 
@State dateList: DateItem[] = [
  {"day":"12-26","workHour":8,"status":"001"},
  {"day":"12-27","workHour":4.55,"status":"001"},
  {"day":"12-28","workHour":7.45,"status":"001"},
  {"day":"12-29","workHour":0,"status":"002"},
  {"day":"12-30","workHour":0,"status":"003"},
  {"day":"12-31","workHour":0,"status":"003"},
  {"day":"1-1","workHour":6.77,"status":"001"},
  {"day":"1-2","workHour":7.74,"status":"001"},
  {"day":"1-3","workHour":1.64,"status":"001"},
  {"day":"1-4","workHour":8,"status":"001"},
  {"day":"1-5","workHour":0,"status":"002"},
  {"day":"1-6","workHour":0,"status":"003"},
  {"day":"1-7","workHour":0,"status":"003"},
  {"day":"1-8","workHour":8,"status":"001"},
  {"day":"1-9","workHour":8,"status":"001"},
  {"day":"1-10","workHour":8,"status":"001"},
  {"day":"1-11","workHour":8,"status":"001"},
  {"day":"1-12","workHour":8,"status":"001"},
  {"day":"1-13","workHour":0,"status":"003"},
  {"day":"1-14","workHour":0,"status":"003"},
  {"day":"1-15","workHour":8,"status":"001"},
  {"day":"1-16","workHour":8,"status":"001"},
  {"day":"1-17","workHour":8,"status":"001"},
  {"day":"1-18","workHour":8,"status":"001"},
  {"day":"1-19","workHour":8,"status":"001"},
  {"day":"1-20","workHour":0,"status":"003"},
  {"day":"1-21","workHour":0,"status":"003"},
  {"day":"1-22","workHour":8,"status":"001"},
  {"day":"1-23","workHour":8,"status":"001"},
  {"day":"1-24","workHour":8,"status":"001"},
  {"day":"1-25","workHour":8,"status":"001"}
];

build(){
  WorkHourDate({
    daysList: this.dateList,
    itemClick: (item, dateIndex) => {
      // 这里是点击日期的回调 可以弹个弹窗修改日期等 根据业务场景编写 
      // ……
      // 如果要跟新数据，可以使用重新赋值的方式 去驱动视图更新
      this.dateList[dateIndex] = {...item, workHour: 2}
    }
  })
}
```

### API

#### Props

| 参数 | 说明 | 类型 | 是否必填 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| daysList | 日历数据数组，详细类型介绍看下面 | DateItem[] | 无 | 无 |
| itemClick | 点击具体日期的回调函数 | `(item: DateItem, index: number)=>void` | 否 | 无 |

#### 类型解释

**DateItem**

```typescript
class DateItem {
  // 当前日期
  day: string;
  // 状态
  status: DATE_STATUS | string;
  // 工时
  workHour?: string | number;

  constructor(day: string, status: DATE_STATUS | string, workHour: string | number) {
    this.day = day;
    this.status = status;
    this.workHour = workHour;
  }
}
```

**DATE_STATUS**

```typescript
export enum DATE_STATUS {
  // 默认的 有工时或为空
  DEFAULT = '001',
  // 放假的 请假的
  HOLIDAY = '002',
  // 休息
  REST = '003'
}
```

```typescript
// 根据 dateStatus 换对应的文案展示        
export const dateStatus2Text = {
  [DATE_STATUS.DEFAULT]: '',
  [DATE_STATUS.HOLIDAY]: '假',
  [DATE_STATUS.REST]: '休'
}

// 根据 dateStatus 换对应的文字颜色  
export const dateStatus2Color = {
  [DATE_STATUS.DEFAULT]: '#323640',
  [DATE_STATUS.HOLIDAY]: '#1fc691',
  [DATE_STATUS.REST]: '#969ba9'
}
```

### 约束与限制

在下述版本验证通过：

```text
DevEco Studio 3.1.1 Release
构建版本：3.1.0.501, built on June 20, 2023
Build #DS-223.8617.56.36.310501
Runtime version: 17.0.6+10-b829.5 x86_64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.

API 9 STAGE
```

### 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

### 更新记录

- **1.0.0** (2025-11-21)

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 (HarmonyOS 版本) | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ibestservices/work_hour_date
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/300d9b0aa0ac46b59e3decab2061c6bf/PLATFORM?origin=template