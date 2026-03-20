# 时间选择弹窗组件

## 简介

本组件提供通过底部弹窗选择日期时间的功能。

## 详细介绍

### 简介

本组件提供通过底部弹窗选择日期时间的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_time_select` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_time_select 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_time_select",
    "srcPath": "./XXX/module_time_select"
  }
]
```

c. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_time_select": "file:./XXX/module_time_select"
}
```

引入组件。

```typescript
import { TimeSelect } from 'module_time_select';
```

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### 接口

`TimeSelect(option?: TimeSelectOptions)`

时间选择弹窗组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | TimeSelectOptions | 否 | 配置时间选择弹窗组件的参数。 |

### TimeSelectOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| label | ResourceStr | 否 | 时间文本 |
| timeOptions | TimeOptions | 否 | 天数、起止时间等时间选项 |
| styleOptions | StyleOptions | 否 | 样式选项 |
| onTimeSelect | `(dateTime: Date \| null) => void` | 否 | 选择时间的回调 |

### TimeOptions 类型说明

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| days | number | 否 | 天数 |
| startTime | string | 否 | 起始时间 |
| endTime | string | 否 | 结束时间 |

### StyleOptions 类型说明

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| dayFgResourceColor | ResourceColor | 否 | 未被选中日期文字颜色 |
| dayFgSelectedResourceColor | ResourceColor | 否 | 被选中日期文字颜色 |
| timeBgResourceColor | ResourceColor | 否 | 未被选中时间文字颜色 |
| timeBgSelectedResourceColor | ResourceColor | 否 | 被选中时间文字颜色 |
| timeBorderResourceColor | ResourceColor | 否 | 未被选中时间边框颜色 |
| timeBorderSelectedResourceColor | ResourceColor | 否 | 被选中时间边框颜色 |

## 示例代码

```typescript
import { TimeSelect } from 'module_time_select';

@Entry
@ComponentV2
struct TimeSelectSample {
  @Local date: Date | null = null;

  @Computed
  get getTimeText() {
    if (this.date) {
      return this.date.toLocaleString();
    }
    return '请选择';
  }

  build() {
    NavDestination() {
      Column({ space: 12 }) {
        Text('请选择上门时间')
          .fontSize($r('sys.float.Subtitle_M'))
          .fontWeight(FontWeight.Bold)
          .lineHeight(21)

        TimeSelect({
          label: this.getTimeText,
          timeOptions: {
            days: 7,
            startTime: '06:59:00',
            endTime: '19:30:00',
          },
          onTimeSelect: (dateTime: Date | null) => {
            this.date = dateTime;
          },
        })
      }
      .width('100%')
      .padding(12)
      .borderRadius(16)
      .backgroundColor(Color.White)
      .alignItems(HorizontalAlign.Start)
    }
    .title('时间选择弹窗组件')
    .backgroundColor('#F1F3F5')
  }
}
```

## 更新记录

### 1.0.2 (2026-01-21)

Created with Pixso.

下载该版本改弹窗内容样式，废弃 API 整改。

### 1.0.1 (2025-10-31)

Created with Pixso.

下载该版本优化 README。

### 1.0.0 (2025-08-29)

Created with Pixso.

下载该版本本组件提供时间选择弹窗组件。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

## 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 (Created with Pixso.) |
| | 5.0.1 (Created with Pixso.) |
| | 5.0.2 (Created with Pixso.) |
| | 5.0.3 (Created with Pixso.) |
| | 5.0.4 (Created with Pixso.) |
| | 5.0.5 (Created with Pixso.) |
| | 5.1.0 (Created with Pixso.) |
| | 5.1.1 (Created with Pixso.) |
| | 6.0.0 (Created with Pixso.) |
| | 6.0.1 (Created with Pixso.) |
| 应用类型 | 应用 (Created with Pixso.) |
| | 元服务 (Created with Pixso.) |
| 设备类型 | 手机 (Created with Pixso.) |
| | 平板 (Created with Pixso.) |
| | PC (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 (Created with Pixso.) |
| | DevEco Studio 5.0.1 (Created with Pixso.) |
| | DevEco Studio 5.0.2 (Created with Pixso.) |
| | DevEco Studio 5.0.3 (Created with Pixso.) |
| | DevEco Studio 5.0.4 (Created with Pixso.) |
| | DevEco Studio 5.0.5 (Created with Pixso.) |
| | DevEco Studio 5.1.0 (Created with Pixso.) |
| | DevEco Studio 5.1.1 (Created with Pixso.) |
| | DevEco Studio 6.0.0 (Created with Pixso.) |
| | DevEco Studio 6.0.1 (Created with Pixso.) |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/dc1312907dfd44e6be95537fa6f91ac7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%97%B6%E9%97%B4%E9%80%89%E6%8B%A9%E5%BC%B9%E7%AA%97%E7%BB%84%E4%BB%B6/module_time_select1.0.2.zip