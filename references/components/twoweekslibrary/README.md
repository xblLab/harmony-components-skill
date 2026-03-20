# 两周日历组件

## 简介

两周日历组件，是一款可以提供两周日历与星期的日历组件，并可以自动标记当天日期所在的位置和自定义日期颜色和文字信息等，使用场景比较小众，如景点购票或预约或其他仅需要两行两周最近日期的场景。

## 详细介绍

### UI 效果

（此处为 UI 效果图占位）

### 使用

#### 安装

```bash
ohpm install twoweekslibrary
```

#### 导入模块

```typescript
import { TwoweekComp } from "twoweekslibrary"
```

#### 引用模块组件

```typescript
TwoweekComp(options: TwoweekCompOption)
```

### TwoweekCompOption 参数对象介绍

#### 参数类型说明

- **CallBackFun**
  - 类型：`(dayItem: riqiType, currentIndex: number) => void`
  - 说明：可回调当前日期所在下标与日期元素，可通过 index 进行针对某天做点击事件进行提示和跳转。
- **todayIconResourceStr**
  - 类型：自定义今日图标
- **colorToday**
  - 类型：`string`
  - 说明：定义今天背景色。
- **colorOtherday**
  - 类型：`string`
  - 说明：定义其他天背景色。
- **colorList**
  - 类型：`string[]`
  - 说明：定义日历背景色 `Array.from({length: 14})`。
- **markList**
  - 类型：`MarkType[]`
  - 说明：定义日期块中间额外信息，如有票 - 无票 - 暂未开启 `Array.from({length: 14})`。
- **todayIndexCallBack**
  - 类型：`(TodayIndex: number) => void`
  - 说明：今日含对应日期元素的下标回调。

#### riqiType 对象介绍

| 参数说明 | 类型 |
| :--- | :--- |
| weekNum | 星期几 `number` |
| weekString | 星期几汉字格式 `string` |
| Idate | 日期信息 `Date` |
| dayNum | 日期/几号 `number` |
| mark | 自定义的日期块上标文字 `string` |
| isToday | 是否为今天 `boolean` |
| backGroudColorofDay | 日期块背景色 `string` |
| Oncliked | 点击对应日期所触发的事件 `(res: riqiType) => void` |

#### 自定义信息 MarkType 对象介绍

| 参数说明 | 类型 |
| :--- | :--- |
| mark | 自定义的文字内容 `string` |
| markForntSize | 字体大小 `number` |
| markForntWeight | 字体加粗值 `number` |
| markForntColor | 字体颜色 `number` |

### 引用自定义操作示例

```typescript
TwoweekComp({
     colorToday: '#ff5',
     colorOtherday: '#f4f4',
     todayIcon: $r('app.media.startIcon'), // 或字符串图片链接
     CallBackFun: (riqi: riqiType, index: number) => {
       console.log(riqi.weekString + '-' + '第' + (index + 1) + '天')  // 周四 - 第 11 天
       if (index + 1 == 2) {
         // 对当前组件的第 2 天进行--自定义逻辑
         console.log('加上自己想要执行的逻辑')
       }
     }
   })
```

### 自定义深度定制整个日历背景色与添加备注字段（如：有票、未开售）

```typescript
TwoweekComp({
         CallBackFun: (dayItem: riqiType, currentIndex: number) => {
          console.log('pkl---CallBackFun', dayItem, currentIndex)
           this.currentIndexDay = currentIndex
        },
        colorList: this.colorList,
        markList: this.markList,
        todayIndexCallBack: (todayIndex: number) => {
          // 方便找到今日以后的 n 天，如月票是今日及后 3 天是可预约的我们就通过 this.colorList[index] 设置这 4 天的背景色为绿色
          this.colorList.forEach((item, index) => {
            if (index >= todayIndex && index <= todayIndex + 3) {
              this.colorList[index] = '#8080'
              this.markList[index] = {
                mark: '有票'
              }
            } else if (index > todayIndex + 3) {
               this.colorList[index] = 'rgba(0,0,0,0.5)'
              this.markList[index] = {
                mark: '暂未开放'
              }
            } else {
              this.colorList[index] = 'rgba(0,0,0,0.5)'
              this.markList[index] = {
                mark: '已关闭'
              }
            }
          })
        }
      })
```

## 注意事项

1. 如果导入引用后，运行报错 `[***] not supported when useNormalizedOHMUrl is not true`
2. 需要在工程级 `build-profile.json5` 中添加 `"useNormalizedOHMUrl"` 为 `true`，如下代码：

```json5
"products": [
       {
        "name": "default",
        "signingConfig": "default",
        "compatibleSdkVersion": "5.0.1(12)",
        "runtimeOS": "HarmonyOS",
           // 必须添加的代码
       "buildOption": {
         "strictMode": {
           "useNormalizedOHMUrl": true
           }
         }
        }
      ],
```

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 获取方式

https://gitee.com/kylepeng2208/twoweekslibary.git

## 更新记录

- **1.0.3 (2025-11-14)**
- **1.0.0** 第一个版本，自动获取当天所在位置并标记
- **1.0.1** 修复次月 1 号的渲染，不是 32 号；可传入回调函数获取当日元素与当日所在日历数组下标索引，在回调中通过 currentIndex 进行单个日期的点击事件的自定义，可传入自定义今日图标，可传入今天日期的背景色和其他日背景色
- **1.0.2** 今日下标回调，定义日历 mark 额外信息，如有票 - 无票 - 暂未开启，可传入自定义整个日历的不同天的背景色
- **1.0.3** 增了华为的兼容配置权限与隐私基本信息

## 兼容性

### 权限信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 系统版本支持

- HarmonyOS 版本：5.0.1
- HarmonyOS 版本：5.0.2
- HarmonyOS 版本：5.0.3
- HarmonyOS 版本：5.0.4
- HarmonyOS 版本：5.0.5
- HarmonyOS 版本：5.1.0
- HarmonyOS 版本：5.1.1
- HarmonyOS 版本：6.0.0

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本支持

- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 安装方式

```bash
ohpm install twoweekslibrary
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/303dafe5d5354e6db97e209964ff3811/b098cd357fa14bc8a1870ef975357acf?origin=template