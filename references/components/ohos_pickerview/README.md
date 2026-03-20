# pickerview 时间选择器组件

## 简介

时间选择器组件，包括时间（年月日、时分秒、年月日时分秒）选择器、地区选择器、分割线设置、文字大小颜色设置。

## 详细介绍

### 简介

PickerView 实现了一个时间选择器，能够进行时间选择、区域设置、分隔符设置以及文本大小和颜色设置。

### 显示效果

*   时间选择器（在日历之间切换）：
*   圆分割选择器：
*   城市选择器（省和市）：
*   自定义选择器：
*   卡片选取器：

### 使用说明

不同拾取器的使用方法相似。以下以时间选择器为例。

#### 1. 初始化

实例化滚动器和相应的 ShowTimePicker 组件。型号对象。

```typescript
private scroller: Scroller = new Scroller()
@State showTimeData: ShowTimePickerComponent.Model = new ShowTimePickerComponent.Model();
```

#### 属性设置

通过 Model 类对象设置 UI 属性，定义所需的样式。您还可以添加所需的回调。

```typescript
aboutToAppear() {
   this.showTimeData
       .setDividerLineStroke(2)
       .setDividerLineColor(Color.Black)
       .setFontSize(20)
       .setFontColor(Color.Red)
       .setConfirmButtonFont ("OK")
       .setCancelButtonFont ("Cancel")
       .setCancelButtonColor(Color.Red)
       .setConfirmButtonColor(Color.Black)
       .setTitleFontSize(20)
       .setTitleFontColor(Color.Black)
       .setPickerSpace(20)
       .setButtonBackgroundColor("#DCDCDC")
       .setYearRangeStart(2001)
       .setYearRangeEnd(2050)
       .setDefaultSelection([2005, 5, 11])
       .setDividerType(DividerType.CIRCLE)
       .setLineSpacingMultiplier(40)
       .withClick((event: ClickEvent) => {
       this.showTimeData.withText("clicked " + this.count++ + " times");
     });
}
```

#### UI 绘图

调用对象构造函数传递实例化的对象。

```typescript
build() {
   Stack() {
     Scroll(this.scroller) {
       Column() {
         ShowTimePickerComponent({model: this.showTimeData})
      }
     }
   }
 }
```

### 接口说明

```typescript
@State showTimeData: ShowTimePickerComponent.Model = new ShowTimePickerComponent.Model();
```

1.  设置分隔线的宽度。`this.showTimeData.setDividerLineStroke(2)`
2.  设置分隔线的颜色。`this.showTimeData.setDividerLineColor(Color.Black)`
3.  设置文本大小。`this.showTimeData.setFontSize(20)`
4.  设置文本颜色。`this.showTimeData.setFontColor(Color.Red)`
5.  设置确定按钮的文本。`this.showTimeData.setConfirmButtonFont("确定")`
6.  设置取消按钮的文本。`this.showTimeData.setCancelButtonFont("取消")`
7.  设置取消按钮的文本颜色。`this.showTimeData.setCancelButtonColor(Color.Red)`
8.  设置确定按钮的文本颜色。`this.showTimeData.setConfirmButtonColor(Color.Black)`
9.  设置标题的文本大小、确定按钮和取消按钮。`this.showTimeData.setTitleFontSize(20)`
10. 设置标题的文本颜色。`this.showTimeData.setTitleFontColor(Color.Black)`
11. 设置选择器页面之间的间距。`this.showTimeData.setPickerSpace(20)`
12. 设置按钮的背景颜色。`this.showTimeData.setButtonBackgroundColor("#7CDCDC")`
13. 设置开始时间。`this.showTimeData.setYearRangeStart(2001)`
14. 设置结束时间。`this.showTimeData.setYearRangeEnd(2050)`
15. 设置分隔器类型。`this.showTimeData.setDividerType(DividerType.CIRCLE)`
16. 设置间距。`this.showTimeData.setLineSpacingMultiplier(40)`

### 目录结构

```text
|---- pickerview 
|     |---- entry  # Sample code
|     |---- pickerview  # PickerView library
|           |---- src
        |----main
           |----ets
              |----components
                 |----common
                    |----AreaDataPickerViewLib.ets # AreaDataParse 样本选择器
                    |----CardModel.ets                  # 卡数据生成类
                    |----CardPickerComponent.ets        # 卡片选择器
                    |----ChinaDateModel.ets             # 时间实体类
                    |----CircleDividerViewLib.ets       # 圆圈分隔符 
                    |----CityPickerComponent.ets        # 城市选择器
                    |----Constant.ets                   # 常量
                    |----CustomizeModel.ets             # 自定义实体
                    |----CustomizePickerComponent.ets   # 自定义拾取器
                    |----HourSecondMinuteComponent.ets  # 时间选择器（小时和分钟）
                    |----HourSecondMinuteModel.ets      # 时间选择器（小时、分钟和秒）
                    |----LunarCalendar.ets              # 农历
                    |----LunarTimeUtil.ets              # 在阴历和阳历之间切换
                    |----PickerData.ets                 # 选择器数据
                    |----PickerModel.ets                # 选择器模型
                    |----Province.ets                   # 省、市和地区数据
                    |----ShowTimePickerViewLib.ets      # 时间选择器视图
                    |----ShowToast.ets                  # 对话框
                    |----SolarCalendar.ets              # 太阳能日历
                    |----TimePickerComponent.ets        # 时间选择器
                    |----YearReachSecondComponent.ets   # 时间选择器（年、月、日、小时、分钟和秒）
|     |---- README_EN.md  # Readme                   
```

## 更新记录

### v2.1.3

Release version 2.1.3

#### v2.1.3-rc.0

Fix the issue of unable to set button text

### v2.1.2

release new version v2.1.2

#### v2.1.1-rc.0

Code obfuscation
Modified the compilation and build warning prompt

### v2.1.0

Fixes some issues with both date pickers
V2 decorator adaptation
Chore:Added supported device types

#### v2.1.0-rc.1

Fixes some issues with both date pickers

#### v2.1.0-rc.0

V2 装饰器适配

### v2.0.1

2.0.1 正式版本

#### v2.0.1-rc.0

修复因资源文件路径错误导致库引用编译失败的问题

### v2.0.0

DevEco Studio 版本：4.1 Canary(4.1.3.317),OpenHarmony SDK:API11 (4.1.0.36)
ArkTs 语法整改

### v1.0.3

适配 DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）

### v1.0.2

api8 升级到 api9

### v1.0.0

支持三级联动 
设置是否联动 
支持 item 的分隔线设置。 
支持 item 间距设置。
时间选择器支持起始和终止日期设定。 
支持“年，月，日，时，分，秒”，“省，市，区”等选项的单位（label）显示、隐藏和自定义。 
支持自定义文字、颜色、文字大小等属性 
Item 的文字长度过长时，文字会自适应缩放到 Item 的长度，避免显示不完全的问题 
支持自定义设置容器。 
实时回调。

## 权限与隐私

### 基本信息

| 项目 | 说明 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEco Studio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/pickerview
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ded7aa51ce2043a29a26fcc217c3e430/PLATFORM?origin=template