# 多功能日期计算组件

## 简介

本组件提供了展示当前日期日历、自定义选中颜色、选中图标形状、周首日、是否展示休息日、是否展示农历、是否显示头部、自定义头部项插槽、节日、节气展示颜色等相关的能力，可以帮助开发者快速集成日历相关的能力。

## 详细介绍

### 简介

本组件提供了日期计算的相关能力，包括日期间隔、日期计算、阳历转阴历等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `date_calculation` 和 `base_apis` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 date_calculation 和 base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "date_calculation",
    "srcPath": "./XXX/date_calculation",
    },
    {
    "name": "base_apis",
    "srcPath": "./XXX/base_apis",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "date_calculation": "file:./XXX/date_calculation"
}
```

引入组件。

```ets
import { DateToolsCalculate } from 'date_calculation';
```

调用组件，详细参数配置说明参见 API 参考。

```ets
import { DateToolsCalculate } from 'date_calculation';

@Entry
@Component
struct Index {
  build() {
    Column() {
      DateToolsCalculate({
        startDate: new Date('2025-5-28'),
        buttonColor: '#c4272b',
        textColor: '#ffffff',
      })
    }
  }
}
```

## API 参考

### 子组件

无

### 接口

`DateToolsCalculate(options?: DateToolsCalculateOptions)`

日期计算的相关能力，包括日期间隔、日期计算、阳历转阴历等功能。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | DateToolsCalculateOptions | 否 | 日期计算功能组件。 |

**DateToolsCalculateOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| buttonColor | ResourceStr | 否 | 按钮颜色 |
| textColor | ResourceStr | 否 | 文字颜色 |
| startDate | ResourceStr \| number | 否 | 开始日期 |

### 事件

支持以下事件：

- **onIntervalSearch**
  `onSearch(callback: (betweenDates: number) => void)`
  日期间隔查询事件，返回日期间隔

- **onCalculateSearch**
  `onSearch(callback: (calculateInfo: LuckyDays) => void)`
  日期计算查询事件，返回查询日期计算详情

- **onConvertSearch**
  `onSearch(callback: (lunarDateInfo: LunarInfo) => void)`
  阳历转阴历查询事件，返回转换的日期详情

#### 参数说明

**calculateInfo (LuckyDays)**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| daysFromNow | number | 是 | 查询到的日期距离今天还有多少天 |
| solarDate | Date \| string | 是 | 阴历日期 |
| lunarDate | string | 是 | 农历日期 |
| ganZhiYear | string | 是 | 天干地支年 |
| ganZhiMonth | string | 是 | 天干地支月 |
| ganZhiDay | string | 是 | 天干地支日 |
| weekday | string | 是 | 周几 |
| forwardOrBack | CALCULATION_TYPE | 否 | 查询日期往后还是往前 |

**CALCULATION_TYPE 对象说明**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| FORWARD | string | 是 | 向前 |
| BACKWARD | string | 是 | 向后 |

**LunarInfo 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| year | string | 是 | 年 |
| month | string | 是 | 月 |
| day | string | 是 | 日 |
| weekday | string | 是 | 星期 |

**LuckyDays 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| daysFromNow | string | 是 | 距离今天的天数 |
| solarDate | string | 是 | 阳历日期 |
| lunarDate | string | 是 | 农历日期 |
| ganZhiYear | string | 是 | 天干地支年 |
| ganZhiMonth | string | 是 | 天干地支月 |
| forwardOrBack | string | 是 | 向前向后查询 |
| ganZhiDay | string | 是 | 天干地支日 |
| weekday | string | 是 | 星期 |

## 示例代码

### 示例 1（修改主题颜色）

本示例通过 `buttonColor` 实现按钮颜色切换

```ets
import { DateToolsCalculate } from 'date_calculation';

@Entry
@Component
struct Index {
  build() {
    Column() {
      DateToolsCalculate({
         startDate: new Date('2025-5-28'),
         buttonColor: '#4F616D',
         textColor: '#ffffff',
      })
    }
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.2 | 2025-10-31 | 优化 README | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E5%8A%9F%E8%83%BD%E6%97%A5%E6%9C%9F%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/date_calculation1.0.2.zip) |
| 1.0.1 | 2025-08-29 | README 内容优化 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E5%8A%9F%E8%83%BD%E6%97%A5%E6%9C%9F%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/date_calculation1.0.2.zip) |
| 1.0.0 | 2025-07-21 | 初始版本 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E5%8A%9F%E8%83%BD%E6%97%A5%E6%9C%9F%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/date_calculation1.0.2.zip) |

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

| HarmonyOS 版本 | 应用类型 | 设备类型 | DevEcoStudio 版本 |
| :--- | :--- | :--- | :--- |
| 5.0.4 | 应用 | 手机 | DevEco Studio 5.0.4 |
| 5.0.5 | 元服务 | 平板 | DevEco Studio 5.0.5 |
| - | - | PC | DevEco Studio 5.1.0 |
| - | - | PC | DevEco Studio 5.1.1 |
| - | - | PC | DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/71fe4f6befc846ab87b7170dfb026130/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E5%8A%9F%E8%83%BD%E6%97%A5%E6%9C%9F%E8%AE%A1%E7%AE%97%E7%BB%84%E4%BB%B6/date_calculation1.0.2.zip