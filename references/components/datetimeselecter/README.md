# 多元日期时间选择器组件

## 简介

多元日期时间选择器组件是一个集成了日期选择器与时间选择器的组件，可以实时返回 string 格式或 Data 格式的被选择的当前日期值，适用面很广如预定酒店，预定门票，定时器，备忘录等场景。支持自定义时间文字样式，支持回调 Date 类型、string 类型的日期时间和 number 类型的当前时间的小时与分钟数值，支持设置选择器背景色，选择器的起始时间与选择器可选择的最终时间范围。

## 详细介绍

### 多元日期时间选择器

#### UI 效果

（此处保留原文档中的 UI 效果占位）

#### 使用

##### 安装

```bash
ohpm install datetimeselecter
```

##### 导入模块

```typescript
import { DateTimeSelecter} from 'datetimeselecter';
```

##### 引用模块组件

```typescript
DateTimeSelecter({
      startCheckStr: new Date('2024-01-01'),
      endCheckStr: new Date('2026-01-01'),
      onTimeChange:(currentTime:string)=>{
        this.messageTime = currentTime;
        console.log('pkl---',currentTime);  //2025-09-21 15:16
      },
      callBackTimeChange:(hours:number,minutes:number,currentTime:Date)=>{
        console.log('pkl---',hours,minutes,currentTime);
      },
      callBackDateChange:(date:Date)=>{
        console.log('pkl---',date);
      },
      backColor:'#fff',
      showDatePicker:true,
      showTimePicker:true
    })
```

##### 数据类型介绍

（此处保留原文档中的数据类型介绍标题）

##### 参数说明

| 参数 | 类型 | 示例/默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| selectedColor | PickerTextStyle | `{color: '#ff007dff',font: {size: '16fp',weight: FontWeight.Bold}}` | 选中日期的颜色，默认 #ff007dff。大小、粗细设置。 |
| UnselectedColor | PickerTextStyle | `{color: '#ff182431',font: {size: '16fp',weight: FontWeight.Regular}}` | 未选中日期的颜色，默认 #ff007dff。大小、粗细设置。 |
| startCheckStr | Date | `new Date('2025-01-01')` | 限定选择日期的起始日。 |
| endCheckStr | Date | `new Date('2026-01-01')` | 限定选择日期的最远日期。 |
| backColor | String | `'#FFF'` | 组件的背景色。 |
| showDatePicker | Boolean | `true` | 是否仅显示日期选择器。true 为展示，false 为不展示。 |
| showTimePicker | Boolean | `true` | 是否仅显示时间选择器。true 为展示，false 为不展示。 |
| onTimeChange | Function | `(currentDateTime: string)=>void` | 返回 string 类型 2025-09-21 15:16 格式的实时日期和时间。参考引用模块组件中的示例。 |
| callBackDateChange | Function | `(currentDate: Date)=>void` | 返回 Date 类型的实时日期。参考引用模块组件中的示例。 |
| callBackTimeChange | Function | `(hours:number,minutes:number,currentTime:Date)=>void` | 返回 Date 类型的实时日期。参考引用模块组件中的示例。 |

##### 注意事项

如果项目已配置了证书和签名信息，运行前可能需要做如下配置，若运行不报错可忽视，报错时请参考下文注意事项。

需要在工程级 `build-profile.json5` 添加 `"useNormalizedOHMUrl"` 为 true 如下代码：

```json5
"products": [
    {
      "name": "default",
      "signingConfig": "default",
      "compatibleSdkVersion": "5.0.1(12)",
      "runtimeOS": "HarmonyOS",
//必须添加的代码
      "buildOption": {
        "strictMode": {
          "useNormalizedOHMUrl": true
        }
      }
    }
  ],
```

**注意：** 如果导入引用后，运行报错 `[***] not supported when useNormalizedOHMUrl is not true`，需要在工程 `build-profile.json5` 添加 `"useNormalizedOHMUrl"` 为 true 如下代码：

```json5
"products": [
      {
        "name": "default",
        "signingConfig": "default",
        "compatibleSdkVersion": "5.0.1(12)",
        "runtimeOS": "HarmonyOS",
        //必须添加的代码
        "buildOption": {
          "strictMode": {
            "useNormalizedOHMUrl": true
          }
        }
      }
    ],
```

UI 效果和使用参考请查看 git 仓库 https://gitee.com/kylepeng2208/date-time-selecter-project.git

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 获取方式

https://gitee.com/kylepeng2208/date-time-selecter-project.git

## 更新记录

*   **1.0.1 (2025-11-13)**
    *   修复了部分问题
*   **1.0.0**
    *   支持自定义时间文字样式
    *   支持回调 Date 类型，string 类型的日期时间和 number 类型的当前时间的小时与分钟数值
    *   支持设置选择器背景色，选择器的起始时间与选择器可选择的最终时间范围

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 元服务 | 元服务 | Created with Pixso. |
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

## 隐私政策

不涉及

## SDK

不涉及

## 安装方式

```bash
ohpm install datetimeselecter
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e6d7ce51e52a4ccf892a0f5cf6bdbec1/b098cd357fa14bc8a1870ef975357acf?origin=template