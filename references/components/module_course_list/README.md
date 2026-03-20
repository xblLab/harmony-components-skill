# 课程列表组件

## 简介

展示课程列表信息，支持使用垂直、水平展示方向，支持自定义字体、颜色、角标等。

## 详细介绍

### 简介

展示课程列表信息，支持使用垂直、水平展示方向，支持自定义字体、颜色、角标等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.2 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.2 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.2 Release 及以上

#### 权限

无

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_course_list` 模块。
   
   ```json5
   // 在项目根目录 build-profile.json5 填写 module_ui_base 和 module_course_list 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_ui_base",
           "srcPath": "./XXX/module_ui_base",
       },
       {
           "name": "module_course_list",
           "srcPath": "./XXX/module_course_list",
       }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。
   
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_course_list": "file:./XXX/module_course_list"
   }
   ```

引入课程列表组件句柄。

```typescript
import { CourseList } from 'module_course_list';
```

调用组件，详见示例代码详细参数配置说明参见 API 参考。

## API 参考

### 子组件

无

### 接口

`CourseList(options: CourseListOptions)`

课程列表组件。

### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CourseListOptions | 否 | 配置日历组件的参数。 |

### 事件

支持以下事件：

| 事件名 | 回调签名 | 说明 |
| :--- | :--- | :--- |
| handleClick | `(course: CourseInfo) => void` | 点击课程卡片时触发的事件 |

### CourseListOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| coursesList | [CourseInfo](#CourseInfo 接口说明)[] | 否 | 课程列表。 |
| isVertical | boolean | 否 | 是否垂直展示列表，默认为 `true`。 |
| showTag | boolean | 否 | 是否显示左上角的标签，默认为 `true`。 |
| customTagResourceStr | ResourceStr | 否 | 自定义标签。 |
| titleColor | ResourceColor | 否 | 标题文字颜色，默认为 `#191919`。 |
| titleSize | ResourceStr \| number | 否 | 标题文字大小，默认为 `16fp`。 |
| descColor | ResourceColor | 否 | 课程介绍文字颜色，默认为 `#990000`。 |
| descSize | ResourceStr \| number | 否 | 课程介绍文字大小，默认为 `12fp`。 |
| themeColor | ResourceColor | 否 | 主题颜色，默认为 `#FE4F35`。 |
| priceSize | ResourceStr \| number | 否 | 价格文字大小，默认为 `16fp`。 |
| isLoading | boolean | 否 | 是否处于加载状态，默认为 `false`。 |

### CourseInfo 接口说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| courseId | number | 是 | 课程 ID。 |
| type | number | 是 | 课程类型。 |
| name | string | 是 | 课程名称。 |
| summary | string | 是 | 课程摘要。 |
| detail | string | 是 | 课程详细描述。 |
| mainDiagram | ResourceStr | 是 | 课程主图资源路径。 |
| price | number | 是 | 课程价格。 |
| expireType | number | 是 | 课程过期类型。 |
| startTime | string | 是 | 课程开始时间。 |
| endTime | string | 是 | 课程结束时间。 |
| orderTime | string | 是 | 课程下单时间。 |
| classHour | number | 是 | 课程总课时数。 |
| status | number | 是 | 课程状态（1：未上课，2：在读中，3：已结课）。 |
| currentHour | number | 是 | 当前课时数。 |
| timetable | CourseTimetable | 是 | 课程时间表。 |

### CourseTimetable 接口说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weekdays | number[] | 是 | 课程安排的星期几（0 表示星期日）。 |
| startTime | string | 是 | 课程开始时间（格式：hh:mm）。 |
| endTime | string | 是 | 课程结束时间（格式：hh:mm）。 |

## 示例代码

### 示例一

```typescript
import { CourseInfo, CourseList } from 'module_course_list';

const mock1: CourseInfo = {
  courseId: 101,
  type: 1,
  name: '钢琴基础入门课程',
  summary: '5-10 岁 | 零基础入门',
  detail: '本课程由专业钢琴教师设计，包含钢琴基础知识、练习曲、音乐理论等内容，帮助你从零开始掌握钢琴演奏技巧。',
  mainDiagram: $r('app.media.img_course_cover1'),
  price: 199,
  expireType: 1,
  startTime: '1741046400000',
  endTime: '1762137600000',
  orderTime: '1735699200000',
  classHour: 15,
  status: 1,
  currentHour: 0,
  timetable: {
    weekdays: [0, 4],
    startTime: '09:00',
    endTime: '10:00',
  },
};

const mock2: CourseInfo = {
  courseId: 102,
  type: 1,
  name: '吉他初学者进阶课程',
  summary: '适合有基础的吉他爱好者，提升演奏技巧。',
  detail: '本课程针对有一定吉他基础的学员，教授吉他进阶技巧、常用和弦和经典吉他曲目。让你在短时间内提高吉他水平。',
  mainDiagram: $r('app.media.img_course_cover2'),
  price: 299,
  expireType: 1,
  startTime: '1741046400000',
  endTime: '1762137600000',
  orderTime: '',
  classHour: 15,
  status: 2,
  currentHour: 10,
  timetable: {
    weekdays: [2, 4],
    startTime: '19:00',
    endTime: '20:00',
  },
};

@Entry
@ComponentV2
struct PreviewPage {
  @Local
  list: CourseInfo[] = [mock1, mock2];
  @Local
  open: boolean = false;
  @Local
  isVertical: boolean = false;

  @Computed
  get title() {
    return this.isVertical ? '课程列表竖版' : '课程列表横版';
  }

  build() {
    Column({ space: 16 }) {
      Button('课程列表横版')
        .onClick(() => {
          this.isVertical = false;
          this.open = true;
        });

      Button('课程列表竖版')
        .onClick(() => {
          this.isVertical = true;
          this.open = true;
        });
    }
    .bindSheet($$this.open, this.buildList, {
      preferType: SheetType.CENTER,
      detents: [SheetSize.MEDIUM],
      title: { title: this.title },
    });
  }

  @Builder
  buildList() {
    Column() {
      CourseList({
        coursesList: this.list,
        isVertical: this.isVertical,
        handleClick: (item: CourseInfo) => {
          this.getUIContext().getPromptAction().showToast({
            message: `点击了课程，名称为${item.name}`,
          });
        },
      });
    }
    .padding(24);
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-11-07 | 下载该版本 README 修改 |
| 1.0.0 | 2025-11-03 | 下载该版本 |

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2f097a9c0b5640eaae3e2d2a098e6509/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AF%BE%E7%A8%8B%E5%88%97%E8%A1%A8%E7%BB%84%E4%BB%B6/module_course_list1.0.1.zip