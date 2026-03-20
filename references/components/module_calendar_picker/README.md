# 预约日期选择组件

## 简介

本组件提供了显示当前日期、设置可选时间段、设置禁用时间段以及配置对应提示文字的功能。

## 详细介绍

### 简介

本组件提供了显示当前日期、设置可选时间段、设置禁用时间段以及配置对应提示文字的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 `module_calendar_picker` 模块。
     ```json5
     // 在项目根目录 build-profile.json5 填写 module_calendar_picker 路径。其中 XXX 为组件存放的目录名
     "modules": [
         {
             "name": "module_calendar_picker",
             "srcPath": "./XXX/module_calendar_picker",
         }
     ]
     ```
   - c. 在项目根目录 `oh-package.json5` 中添加依赖。
     ```json5
     // XXX 为组件存放的目录名称
     "dependencies": {
       "module_calendar_picker": "file:./XXX/module_calendar_picker"
     }
     ```

在 entry 模块下的 `/src/main/ets/entryability/EntryAbility.ets` 进行初始化。

```typescript
// 深色代码主题复制
import { UIBase } from 'module_calendar_picker';

onWindowStageCreate(windowStage: window.WindowStage): void {
    UIBase.init(windowStage);
}
```

引入组件

```typescript
// 深色代码主题复制
import { UICalendarPicker, TypePicker, DialogType, SwiperDirection } from 'module_calendar_picker';
```

## API 参考

### 子组件

可以包含单个子组件

### 接口

`UICalendarPicker(option: UICalendarPickerOptions)`

预约日期选择组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICalendarPickerOptions | 否 | 配置预约日期选择组件的参数。 |

#### UICalendarPickerOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | TypePicker | 否 | 日期选择器类型，默认值是 SINGLE 单日期 |
| dialogType | DialogType | 否 | 弹窗类型，支持常规弹窗和半模态弹窗，默认值 DialogType.SHEET |
| swiperDirection | SwiperDirection | 否 | 滑动方向，支持左右滑动和上下滑动，仅半模态弹窗支持上下滑动，默认值 SwiperDirection.HORIZONTAL |
| customColor | ResourceColor | 否 | 定制颜色，涉及所选日期背景色、当日字体、箭头、年月滚轮 |
| customFontColor | ResourceColor | 否 | 定制未选中文字颜色 |
| startDayOfWeek | number | 否 | 一周起始天，默认值是 0，星期天，取值范围 0 - 6 之间的整数 |
| startYear | number | 否 | 切换年月的起始年份，默认是 1900 |
| endYear | number | 否 | 切换年月的结束年份，默认是 2100 |
| rangeLimit | Date[] | 否 | 设置可选范围，取数组第一项作为可选范围的开始日期，第二项作为可选范围的结束日期 |
| disabledDates | DateItem[] | 否 | 设置禁选日期，仅针对单日期、多日期生效 |
| ableDates | DateItem[] | 否 | 设置可选日期，仅针对单日期、多日期生效，传入该值会将未在该日期中的其它日期禁用 |
| disableDayLabel | ResourceStr | 否 | 设置禁选日期下方的文字 |
| maxGap | number | 否 | 设置起止日期之间的最大跨度，仅时间段类型生效 |
| enableSelectTime | boolean | 否 | 开启时间选择，默认值否，仅单日期类型以及横向滑动 SwiperDirection.HORIZONTAL 时生效 |
| isMilitaryTime | boolean | 否 | 时间选择是否 24 小时制，默认值否 |
| sheetTitle | ResourceStr | 否 | 设置半模态弹窗标题文字 |
| sheetH | SheetSize \| Length | 否 | 设置半模态弹窗高度，仅横向滑动 SwiperDirection.HORIZONTAL 生效 |
| detents | (SheetSize \| Length), (SheetSize \| Length)?, (SheetSize \| Length)? | 否 | 设置半模态弹窗高度档位，仅纵向滑动 SwiperDirection.VERTICAL 生效 |
| selectedDate | Date | 否 | 选中的单日期，无默认值 |
| selectDates | Date[] | 否 | 选中的多日期、时间段。时间段只取前两个日期作为开始和结束日期。无默认值 |
| yOffset | number | 否 | 常规弹窗垂直方向偏移量，默认垂直居中对齐 |
| customBuildPanel | CustomBuilder | 否 | 自定义触发弹窗的控件 |

#### DateItem 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| date | Date | 是 | 日期 |
| label | string | 是 | 对应文字描述 |

#### TypePicker 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| SINGLE | 单日期 |
| MULTIPLE | 多日期 |
| RANGE | 时间段 |

#### DialogType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| DIALOG | 常规弹窗 |
| SHEET | 半模态弹窗 |

#### SwiperDirection 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| HORIZONTAL | 水平方向 |
| VERTICAL | 垂直方向 |

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onSelected | `callback: (date: Date | Date[]) => void` 确认选择的回调 |
| cancel | `callback: () => void` 取消选择的回调 |
| onClickDate | `callback: (date: Date) => void` 点击日期的回调 |

## 支持情况说明

针对是否支持选择时间、设置禁选日期、设置可选范围、设置最大跨度，不同类型的日期选择器支持情况说明如下：

| 类型 | 时间选择<br>enableSelectTime | 禁选<br>disabledDates | 可选范围<br>rangeLimit | 跨度<br>maxGap |
| :--- | :---: | :---: | :---: | :---: |
| 单日期 | √ | √ | √ | x |
| 多日期 | x | √ | √ | x |
| 时间段 | x | x | √ | √ |

## 异常情形说明

| 异常情形 | 对应结果 |
| :--- | :--- |
| 一周起始天不合法 | 取值默认值 0 |
| 起始年份小于 1900 | 取默认值 1900 |
| 结束年份大于 2100 | 取默认值 2100 |
| 起始年份晚于结束年份 | 起始年份、结束年份均为默认值 |
| 针对单日期选择，选中日期早于起始年份 | 选中日期非法，置空处理，当前视图为系统时间所在月 |
| 针对单日期选择，选中日期晚于结束年份 | 选中日期非法，置空处理，当前视图为系统时间所在月 |
| 针对单日期选择，起始年份晚于当前系统日期 | 选中日期未设置，当前视图为起始年份第一个月 |
| 针对单日期选择，结束年份早于当前系统日期 | 选中日期未设置，当前视图为结束年份最后一个月 |
| 针对多日期选择，部分选中日期不在起止年份间 | 过滤掉不在起止年份间的日期，当前视图为第一个有效日期所在月 |
| 针对多日期选择，全部选中日期不在起止年份间 | 过滤所有非法日期，当前视图为系统时间所在月 |
| 针对时间段选择，开始日期不早于结束日期 | 默认值非法，置空处理，当前视图为系统时间所在月 |
| 针对时间段选择，开始日期或结束日期不在起止年份之间 | 默认值非法，置空处理，当前视图为系统时间所在月 |
| 针对可选范围 rangeLimit，开始时间不早于结束时间 | 非法传参，参数不生效 |

## 示例代码

```typescript
import { UICalendarPicker, TypePicker, DialogType, SwiperDirection, DatesItem } from 'module_calendar_picker';

@Entry
@ComponentV2
struct Index {
    selected: Date = new Date();
    disableData: DatesItem[] = [{ label: '约满', date: new Date('2025-07-25') }];
    ableData: DatesItem[] = [{ label: '可约', date: new Date('2025-07-26') }];

    @Builder
    customPanelBuilder() {
        Row() {
            Text('指定日期')
                .fontColor('#603C00')
                .width(28)
                .fontSize($r('sys.float.ohos_id_text_size_body2'));
        }
        .height(70).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center).width(60);
    }

    build() {
        Column() {
            Column() {
                UICalendarPicker({
                    type: TypePicker.SINGLE,
                    dialogType: DialogType.SHEET,
                    enableSelectTime: true,
                    customColor: '#D1B380',
                    swiperDirection: SwiperDirection.VERTICAL,
                    selected: this.selected,
                    disabledDates: this.disableData,
                    ableDates: this.ableData,
                    customBuildPanel: (): void => {
                        this.customPanelBuilder();
                    },
                    onSelected: (res) => {
                        console.log('选择日期', res);
                    },
                });
            }
            ;
        };
    }
}
```

## 更新记录

### 1.0.1 (2025-11-03)

- 下载该版本 readme 优化。
- 修改组件名称与生态市场一致。

### 1.0.0 (2025-08-30)

- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规**：不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.0
- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.0
- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/10ac76707a844035831650cf01fff32a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%A2%84%E7%BA%A6%E6%97%A5%E6%9C%9F%E9%80%89%E6%8B%A9%E7%BB%84%E4%BB%B6/module_calendar_picker1.0.1.zip