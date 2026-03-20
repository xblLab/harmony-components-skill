# 课表组件

## 简介

本组件支持根据课程信息及相关配置进行课表 UI 渲染。

## 详细介绍

### 简介

本组件支持根据课程信息及相关配置进行课表 UI 渲染。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **HarmonyOS 版本**：HarmonyOS 5.0.3 Release 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_course_schedule` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_course_schedule 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_course_schedule",
    "srcPath": "./XXX/module_course_schedule"
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_course_schedule": "file:./XXX/module_course_schedule"
}
```

#### 引入组件

```typescript
import { ScheduleInfo, TimeInfo, ScheduleFlow } from 'module_course_schedule';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { ScheduleInfo, TimeInfo, ScheduleFlow } from 'module_course_schedule';

const MS_PER_DAY: number = 24 * 60 * 60 * 1000;

@Entry
@ComponentV2
struct Index {

  private scheduleList: ScheduleInfo[] = [
    new ScheduleInfo(
      [1, 2],     // 占用第 1 节至第 2 节课
      1,          // 当前课程处于一周的第 1 天
      '离散数学'
    ),
    new ScheduleInfo(
      [3, 4],     // 占用第 3 节至第 4 节课
      2,          // 当前课程处于一周的第 2 天
      '线性代数'
    )
  ];

  private today: Date = new Date();

  private monday: Date = (() => {
    // 0: 周日，1: 周一，..., 6: 周六
    const day: number = this.today.getDay();
    const diffToMonday: number = day === 0 ? -6 : 1 - day;
    return new Date(this.today.getTime() + diffToMonday * MS_PER_DAY);
  })();

  private sunday: Date = new Date(this.monday.getTime() + 6 * MS_PER_DAY);

  public build(): void {
    Column() {
      ScheduleFlow({
        currentDate: this.today,
        scheduleWeek: [this.monday, this.sunday],
        divideTimes: [
          new TimeInfo(4, '上午'), // 取 1 ~ 4 节课，划分至上午
          new TimeInfo(9, '下午')  // 取 5 ~ 9 节课，划分至下午
        ],
        scheduleMaxIndex: 9,       // 总共有 9 节课
        scheduleList: this.scheduleList,
        scheduleClick: (scheduleInfo: ScheduleInfo) => {
          this.getUIContext().getPromptAction().showToast({ message: scheduleInfo.scheduleName });
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.getUIContext().getAtomicServiceBar() ? 56 : 0 })
  }
}
```

### API 参考

#### ScheduleFlow(option: ScheduleFlowOptions)

##### ScheduleFlowOptions 对象说明

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| currentDate | Date | 是 | 是当前日期 |
| scheduleWeek | Date[] | 是 | 日期所在周时间段，长度为 2 |
| divideTimes | TimeInfo[] | 是 | 时间段分割信息 |
| scheduleMaxIndex | number | 是 | 课程时间段数量 |
| scheduleList | ScheduleInfo[] | 是 | 课程源数据 |
| scheduleClick | (scheduleInfo: ScheduleInfo) => void | 否 | 课程点击回调事件 |

#### TimeInfo

表示时间段分割信息的结构体，用于对课表按照时间段进行分割并显示分割标题。

| 字段名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| divideTime | number | 是 | 分割下标 |
| periodName | string \| Resource | 是 | 分割标题 |

#### ScheduleInfo

表示课程信息的结构体，用于渲染课表 UI 的源数据。

| 字段名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| daySchedule | number[] | 是 | 日程时间段 |
| weekDay | number | 是 | 日程所在日期 |
| scheduleName | string | 是 | 日程名称 |

### 示例代码

```typescript
import { ScheduleInfo, TimeInfo, ScheduleFlow } from 'module_course_schedule';

const MS_PER_DAY: number = 24 * 60 * 60 * 1000;

@Entry
@ComponentV2
struct Index {

  private scheduleList: ScheduleInfo[] = [
    new ScheduleInfo(
      [1, 2],     // 占用第 1 节至第 2 节课
      1,          // 当前课程处于一周的第 1 天
      '离散数学'
    ),
    new ScheduleInfo(
      [3, 4],     // 占用第 3 节至第 4 节课
      2,          // 当前课程处于一周的第 2 天
      '线性代数'
    )
  ];

  private today: Date = new Date();

  private monday: Date = (() => {
    // 0: 周日，1: 周一，..., 6: 周六
    const day: number = this.today.getDay();
    const diffToMonday: number = day === 0 ? -6 : 1 - day;
    return new Date(this.today.getTime() + diffToMonday * MS_PER_DAY);
  })();

  private sunday: Date = new Date(this.monday.getTime() + 6 * MS_PER_DAY);

  public build(): void {
    Column() {
      ScheduleFlow({
        currentDate: this.today,
        scheduleWeek: [this.monday, this.sunday],
        divideTimes: [
          new TimeInfo(4, '上午'), // 取 1 ~ 4 节课，划分至上午
          new TimeInfo(9, '下午')  // 取 5 ~ 9 节课，划分至下午
        ],
        scheduleMaxIndex: 9,       // 总共有 9 节课
        scheduleList: this.scheduleList,
        scheduleClick: (scheduleInfo: ScheduleInfo) => {
          this.getUIContext().getPromptAction().showToast({ message: scheduleInfo.scheduleName });
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.getUIContext().getAtomicServiceBar() ? 56 : 0 })
  }
}
```

### 更新记录

- **1.0.0** (2025-10-31)
  - 初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 基本信息

#### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |

#### 应用类型

- 应用
- 元服务

#### 设备类型

- 手机
- 平板
- PC

#### DevEco Studio 版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/87faad8efd88416e953054ee161f40e0/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AF%BE%E8%A1%A8%E7%BB%84%E4%BB%B6/module_course_schedule1.0.0.zip