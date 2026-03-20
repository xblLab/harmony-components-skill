# 日程提醒组件

## 简介

日历重要提醒支持新增以及编辑日历、生日、纪念日、待办，支持将日程添加到系统日历提醒中。

## 详细介绍

### 简介

日历重要提醒支持新增以及编辑日历、生日、纪念日、待办，支持将日程添加到系统日历提醒中。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **获取日历读取权限**：`ohos.permission.WRITE_CALENDAR`，`ohos.permission.READ_CALENDAR`。
- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `calendar_events` 和 `base_apis` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 base_calendar 和 base_apis 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "calendar_events",
        "srcPath": "./XXX/calendar_events",
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
  "calendar_events": "file:./XXX/calendar_events"
}
```

#### 引入组件

```typescript
import { CalendarEventMain } from 'calendar_events';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
// 引入组件
import { CalendarEventMain, UserEventItem } from 'calendar_events';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack() 
  build() {
    Navigation(this.pageInfo) {
      CalendarEventMain({
        pathStack: this.pageInfo,
        onCalendarEventChange: (userEventInfo: UserEventItem) => {
          console.log('change userEventInfo', JSON.stringify(userEventInfo));
        },
        onCalendarEventDelete: (userEventInfo: UserEventItem) => {
          console.log('delete userEventInfo', JSON.stringify(userEventInfo));
        },
      });
    }
    .hideTitleBar(true)
  }
}
```

## API 参考

### 子组件

无

### 接口

`CalendarEventMain(options?: CalendarEventMainOptions)`

日历重要提醒，支持新增以及编辑日历、生日、纪念日、待办，支持将日程添加到系统日历提醒中。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CalendarEventMainOptions | 否 | 提醒组件的参数。 |

#### CalendarEventMainOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pathStack | NavPathStack | 是 | 传入当前组件所在路由栈 |

#### UserEventItem 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 日程提醒 ID |
| eventType | EVENT_TYPE | 是 | 日程提醒类型 |
| eventId | number | 是 | 添加到日历之后生成的 ID |
| content | string | 是 | 日程提醒内容 |
| date | CalendarStartDate | 是 | 开始日期时间、结束日期时间 |
| repeatType | string | 是 | 提醒类型 |
| remindList | REMIND_MENU | 是 | 重复类型 |
| remarks | string | 否 | 备注 |
| isDone | boolean | 否 | 是否完成 |

#### CalendarStartDate 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | Date | 是 | 日期 |
| time | string | 是 | 时间 |

#### EVENT_TYPE 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| SCHEDULE | schedule | 是 | 日程 |
| BIRTHDAY | birthday | 是 | 生日 |
| ANNIVERSARIES | anniversaries | 是 | 纪念日 |
| TODO | todo | 是 | 待办 |

#### REMIND_MENU 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| NO_REPEAT | 不重复 | 是 | |
| DAILY | 每天 | 是 | |
| WEEKLY | 每周 | 是 | |
| MONTHLY | 每月 | 是 | |
| YEARLY | 每年 | 是 | |
| HOLIDAY | 法定工作日 | 是 | |

### 事件

支持以下事件：

- **onCalendarEventChange**
  ```typescript
  onCalendarEventChange(callback: (userEventInfo: UserEventItem) => void)
  ```
  日程提醒添加更新回调，返回添加或者更新的日程信息。

- **onCalendarEventDelete**
  ```typescript
  onCalendarEventDelete(callback: (userEventInfo: UserEventItem) => void)
  ```
  日程提醒删除回调，返回当前删除的日程信息。

## 示例代码

### 示例 1（修改传入日期）

本示例通过 `onCalendarEventChange` 回调获取添加的日程信息。

```typescript
import { CalendarEventMain, UserEventItem } from 'calendar_events';

@Entry
@Component
struct Index {
  pageInfo: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfo) {
      CalendarEventMain({
        pathStack: this.pageInfo,
        onCalendarEventChange: (userEventInfo: UserEventItem) => {
          console.log('change userEventInfo', JSON.stringify(userEventInfo));
        },
      })
    }
    .hideTitleBar(true)
  }
}
```

## 更新记录

- **1.0.2** (2025-09-25): README 优化
- **1.0.1** (2025-08-29): README 内容优化
- **1.0.0** (2025-07-21): 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.WRITE_CALENDAR | 允许应用添加、移除或更改日历活动 | 允许应用添加、移除或更改日历活动 |
| ohos.permission.READ_CALENDAR | 允许应用读取日历信息 | 允许应用读取日历信息 |

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.4 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机 |
| 平板 | 是 |
| PC | 是 |
| DevEco Studio 版本 | DevEco Studio 5.0.4 |
| DevEco Studio 版本 | DevEco Studio 5.0.5 |
| DevEco Studio 版本 | DevEco Studio 5.1.0 |
| DevEco Studio 版本 | DevEco Studio 5.1.1 |
| DevEco Studio 版本 | DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a326fa24711740178c3db7ace7c80575/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%A5%E7%A8%8B%E6%8F%90%E9%86%92%E7%BB%84%E4%BB%B6/calendar_events1.0.2.zip