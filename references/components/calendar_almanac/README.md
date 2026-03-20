# 黄历组件

## 简介

黄历组件支持日期动态选择，阴历阳历、五行等信息展示。

## 详细介绍

### 简介

黄历组件支持日期动态选择，阴历阳历、五行等信息展示。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.4 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.4 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.4(16) 及以上

### 快速入门

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `calendar_almanac` 和 `base_apis` 模块。

深色代码主题复制
```json5
// 在项目根目录 build-profile.json5 填写 calendar_almanac 和 base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "calendar_almanac",
    "srcPath": "./XXX/calendar_almanac",
    },
    {
    "name": "base_apis",
    "srcPath": "./XXX/base_apis",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "calendar_almanac": "file:./XXX/calendar_almanac"
}
```

引入组件。

深色代码主题复制
```typescript
import { CalendarAlmanac } from 'calendar_almanac';
```

调用组件，详细参数配置说明参见 API 参考。

深色代码主题复制
```typescript
// 引入组件
import { CalendarAlmanac } from 'calendar_almanac';

@Entry
@Component
struct Index {
  build() {
    Column() {
      CalendarAlmanac({
        selectDate: new Date('2025-06-01'),
        arrowColor: 'standard',
        selectTextColor: '#c4272b',
        onDateChange: (date: Date) => {
          console.log('日期切换，当前的日期是' + date);
        },
      });
    }
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`CalendarAlmanac(options?: CalendarAlmanacOptions)`

日历黄历组件，支持日期动态选择，阴历阳历、五行等信息展示。

参数：

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CalendarAlmanacOptions | 否 | 黄历组件的参数。 |

**CalendarAlmanacOptions 对象说明**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selectDate | string | 否 | 传入当前日期，默认当日日期 时间格式 YYYY-MM-DD |
| selectTextColor | ResourceStr | 否 | 文本按钮颜色，默认颜色#c4272b |
| arrowColor | 'standard' \| 'blue' \| 'red' | 否 | 左右切换箭头颜色，默认主题颜色 standard |

#### 事件

支持以下事件：

- **onDateChange**
  - `onDateChange(callback: (date: Date) => void)`
  - 日期变化事件，返回当前日期

#### 示例代码

**示例 1（修改传入日期）**

本示例通过 `selectDate` 实现不同日期的切换。

深色代码主题复制
```typescript
// 引入组件
import { CalendarAlmanac } from 'calendar_almanac';

@Entry
@Component
struct Index {
  build() {
    Column() {
      CalendarAlmanac({
         selectDate: new Date('2025-06-01'),
         arrowColor: "blue",
         selectTextColor: "#c4272b",
      });
    }
  }
}
```

### 更新记录

- **1.0.2 (2025-10-31)**
  
  Created with Pixso.
  
  下载该版本 README 内容优化
  
- **1.0.1 (2025-08-29)**
  
  Created with Pixso.
  
  下载该版本 README 优化
  
- **1.0.0 (2025-07-21)**
  
  Created with Pixso.
  
  下载该版本初始版本

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

#### 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c7d01af585d648f091e8eb9c3fee4549/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%BB%84%E5%8E%86%E7%BB%84%E4%BB%B6/calendar_almanac1.0.2.zip