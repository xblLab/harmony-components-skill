# 日期选择组件

## 简介

本组件提供入住、离开日期选择的功能。

## 详细介绍

### 简介

本组件提供入住、离开日期选择的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上
- 设备类型：华为手机（直板机）
- HarmonyOS 版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

无

### 快速入门

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 calendar_select 模块：

```json5
"modules": [
{
   "name": "calendar_select",
   "srcPath": "./xxx/calendar_select",
}
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖：

```json5
"dependencies": {
   "calendar_select": "file:./xxx/calendar_select"
}
```

引入组件。

```typescript
import { DateInfo } from 'calendar_select';
```

### API 参考

#### 接口

`DateInfo(priceList: Price[])`
日历组件。

#### 参数说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| priceList | Price[] | 是 | 价格日历 |

#### Price 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | string | 是 | 日期 |
| price | number | 是 | 价格 |

#### 示例代码

```typescript
import { hilog } from '@kit.PerformanceAnalysisKit';
import { CalendarUtil, DateInfo, DateModel, getLastDayOfMonth, getRealTimeDate } from 'calendar_select';

@Entry
@ComponentV2
export struct Home {
  @Local night: number = CalendarUtil.getNight() ?? 1;
  @Local startDate: DateModel = CalendarUtil.getStartDate();
  @Local endDate: DateModel = CalendarUtil.getEndDate();

  aboutToAppear(): void {
    // 首次初始化
    let dates: Promise<undefined> = new Promise(() => {
      if (!AppStorage.get('startDate') && !AppStorage.get('endDate')) {
        this.startDate = getRealTimeDate();
        let date = new Date();
        let days = getLastDayOfMonth(date.getFullYear(),
          date.getMonth());
        if (this.startDate.day >= days) {
          this.endDate =
            new DateModel(this.startDate.day - days + 1, this.startDate.week, this.startDate.month + 1,
              this.startDate.year);
        } else {
          this.endDate =
            new DateModel(this.startDate.day + 1, this.startDate.week, this.startDate.month, this.startDate.year);
        }

        CalendarUtil.setStartDate(this.startDate);
        CalendarUtil.setCurrentDate(this.startDate);
        CalendarUtil.setEndDate(this.endDate);
      }
    });

    dates.then(() => {
      hilog.info(0xff00, 'Sample', 'init date success');
    });
  }

  build() {
    Column() {
      DateInfo(
        {
          priceList: [],
        },
      )
        .backgroundColor('#f5f6fa')
        .borderRadius(8);
    };
  }
}
```

### 更新记录

- **2.0.0** (2025-12-10)
  - 下载该版本优化 readme，删除不必要的 startDate、endDate 等入参，使用应用级存储实现。
  - Created with Pixso.
- **1.0.2.0** (2025-10-31)
  - 下载该版本 readme 内容优化
  - Created with Pixso.
- **1.0.1** (2025-07-18)
  - 下载该版本优化 readme
  - Created with Pixso.
- **1.0.2** (2025-07-04)
  - 下载该版本
  - Created with Pixso.
- **1.0.0** (Implicit)
  - 本组件提供入住、离开日期选择的功能。
  - Created with Pixso.

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

隐私政策：不涉及
SDK 合规使用指南：不涉及

### 兼容性

| 项目 | 版本/类型 | 状态 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c6f95dc7ae364b32a60a672c142ffd67/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%A5%E6%9C%9F%E9%80%89%E6%8B%A9%E7%BB%84%E4%BB%B6/calendar_select2.0.0.zip