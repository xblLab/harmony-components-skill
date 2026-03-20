# 轨迹地图面板组件

## 简介

本组件使用华为地图，提供了展示运动路径列表、删除路径、展示运动路径的功能，支持上传运动生成的路线，点击开始运动可按当前查看的路线信息返回。

## 详细介绍

### 简介
本组件使用华为地图，提供了展示运动路径列表、删除路径、展示运动路径的功能，支持上传运动生成的路线，点击开始运动可按当前查看的路线信息返回。

### 路线列表运动轨迹

## 约束与限制

### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机 (直板机)
- 系统版本：HarmonyOS 5.0.5(17) 及以上

### 权限

- 网络权限：`ohos.permission.INTERNET`
- 位置权限：`ohos.permission.LOCATION`
- 设备模糊位置权限：`ohos.permission.APPROXIMATELY_LOCATION`

## 快速入门

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件。
     a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
     b. 在项目根目录 `build-profile.json5` 添加 `module_trajectory` 模块。
     
     ```json5
     // 项目根目录下 build-profile.json5 填写 module_trajectory 路径。其中 XXX 为组件存放的目录名
     "modules": [
       {
         "name": "module_trajectory",
         "srcPath": "./XXX/module_trajectory"
       }
     ]
     ```

     c. 在项目根目录 `oh-package.json5` 添加依赖。
     
     ```json5
     // XXX 为组件存放的目录名称
     "dependencies": {
       "module_trajectory": "file:./XXX/module_trajectory"
     }
     ```

2. **引入组件**
   
   ```typescript
   import { LineSummaryPage } from 'module_trajectory'
   ```

3. **开通地图服务**

4. **调用组件**，详细参数配置说明参见 API 参考。
   
   ```typescript
   LineSummaryPage()
   ```

## API 参考

### 接口

`LineSummaryPage(options?: LineSummaryOptions)`

#### LineSummaryOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| onPopCallBack | `(value: PopInfo) => void` | 否 | 页面关闭回调 |
| deleteSportData | `(deleteItem: MonthItemModel[]) => void` | 否 | deleteItem：返回被删除的运动列表 |
| currentTypeTransmit | `MonthItemModel[]` | - | 是我的路线数据 |
| allCurrentTypeTransmit | `MonthItemModel[]` | - | 是全部路线数据 |
| stackNavPathStack | `Stack` | - | 是路由对象 |

#### MonthItemModel 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| year | number | 否 | 年 |
| month | number | 是 | 月 |
| day | number | 是 | 日 |
| type | SportType | 是 | 运动类型 |
| childType | ChildSportType | 是 | 运动子类型 |
| hour | number | 是 | 小时 |
| minute | number | 是 | 分钟 |
| distance | number | 是 | 运动距离 |
| toDistance | number | 否 | 目标距离 |
| timeLength | number | 是 | 运动时长 |
| targetSportItem | Target | 是 | 运动目标 |
| deplete | number | 是 | 运动消耗 |
| stepCount | number | 是 | 运动步数 |
| locusPoints | `mapCommon.LatLng[]` | 否 | 运动轨迹 |

#### SportItemTarget 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| targetType | TargetType | 是 | 目标类型 |
| value | number | 是 | 目标值 |

#### TargetType 运动类型枚举

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| DISTANCE | 0 | 距离 |
| DEPLETE | 1 | 消耗 |
| TIME_LENGTH | 2 | 时长 |
| PACE | 3 | 配速 |

#### SportType 运动类型枚举

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| ALL | 0 | 所有运动 |
| WALKING | 1 | 步行 |
| JOGGING | 2 | 跑步 |
| CYCLING | 3 | 骑行 |

#### ChildSportType 运动子类型枚举

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| FREE_WALKING | 0 | 自由走 |
| TARGET_WALKING | 1 | 目标走 |
| DOG_WALKING | 2 | 遛狗 |
| FREE_JOGGING | 4 | 自由跑 |
| TARGET_JOGGING | 5 | 目标跑 |
| FREE_CYCLING | 6 | 自由骑 |
| TARGET_CYCLING | 7 | 目标骑 |

### 事件

支持以下事件：

- **onPopCallBack**
  ```typescript
  onPopCallBack: (value: PopInfo) => void;
  ```
  返回选择的运动数据

- **deleteSportData**
  ```typescript
  deleteSportData: (deleteItem: MonthItemModel[]) => void;
  ```
  返回被删除的我的路线数据列表

## 示例代码

```typescript
import { LineSummaryPage, MonthItemModel, SportType, SportItemTarget, TargetType, RouterMap } from 'module_trajectory';
import { mapCommon } from '@kit.MapKit';

@Entry
@ComponentV2
struct Index {
  @Local sportTarget: SportItemTarget = { targetType: TargetType.DISTANCE, value: 1000 }
  @Local locusPoints: mapCommon.LatLng[] =
    [{ "latitude": 30.55446543006316, "longitude": 114.50535414078917 },
      { "latitude": 30.554622743246032, "longitude": 114.50497062350281 },
      { "latitude": 30.555146449544978, "longitude": 114.50420151519222 },
      { "latitude": 30.555417701359442, "longitude": 114.50405041735033 },
      { "latitude": 30.557001234895676, "longitude": 114.50455631390652 },
      { "latitude": 30.557953278758934, "longitude": 114.5047200676718 },
      { "latitude": 30.558028973976786, "longitude": 114.50482995308323 },
      { "latitude": 30.55764912967691, "longitude": 114.5061249599082 },
      { "latitude": 30.556920455303846, "longitude": 114.50782030962125 },
      { "latitude": 30.55634842386656, "longitude": 114.50885809458103 },
      { "latitude": 30.554756646254575, "longitude": 114.5110562769805 },
      { "latitude": 30.554575375199867, "longitude": 114.51102537916381 },
      { "latitude": 30.55233438933314, "longitude": 114.50770416307091 },
      { "latitude": 30.55497748834956, "longitude": 114.50390384146597 },
      { "latitude": 30.555441365712614, "longitude": 114.5031039462691 },
      { "latitude": 30.556299632801135, "longitude": 114.5012583893614 },
      { "latitude": 30.55673521147347, "longitude": 114.49982132608326 },
      { "latitude": 30.556836474640654, "longitude": 114.49967917834083 },
      { "latitude": 30.557154124330545, "longitude": 114.49956703430831 },
      { "latitude": 30.558266208794173, "longitude": 114.4995373429403 },
      { "latitude": 30.55843127774418, "longitude": 114.49963378829172 },
      { "latitude": 30.558479369721926, "longitude": 114.50186814042952 },
      { "latitude": 30.5582461142039, "longitude": 114.50391457930684 },
      { "latitude": 30.557644722530924, "longitude": 114.50609367932171 },
      { "latitude": 30.556907106458247, "longitude": 114.50780177934695 },
      { "latitude": 30.556744333057704, "longitude": 114.50787329200867 },
      { "latitude": 30.55590494215303, "longitude": 114.50714191819603 },
      { "latitude": 30.55433271393855, "longitude": 114.50557588006492 },
      { "latitude": 30.55442160156265, "longitude": 114.50539159357686 }]
  @Provider() currentTypeTransmit: MonthItemModel[] = []
  @Provider() allCurrentTypeTransmit: MonthItemModel[] = []
  @Provider() stack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    let current1: MonthItemModel =
      new MonthItemModel(11, 17, SportType.CYCLING, 6, 17, 0, 3300, 600, this.sportTarget, 100, 2000, this.locusPoints,
        2025)
    let current2: MonthItemModel =
      new MonthItemModel(11, 17, SportType.CYCLING, 6, 17, 0, 8000, 600, this.sportTarget, 100, 2200, this.locusPoints,
        2025)
    this.currentTypeTransmit.push(current1)
    this.allCurrentTypeTransmit.push(current1)
    this.allCurrentTypeTransmit.push(current2)
  }

  build() {
    Navigation(this.stack) {
      Column() {
        LineSummaryPage({
          onPopCallBack: (value: PopInfo) => {

          },
          deleteSportData: (deleteItem: MonthItemModel[]) => {

          }
        }).layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
  }
}
```

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.0 (2025-12-15)

Created with Pixso.

## 下载该版本

初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.APPROXIMATELY_LOCATION | 许应用获取设备模糊位置信息 | 许应用获取设备模糊位置信息 |

### 隐私政策

不涉及 SDK 合规

### 使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

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
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e3015a85a5d442929a487c1547a01351/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%BD%A8%E8%BF%B9%E5%9C%B0%E5%9B%BE%E9%9D%A2%E6%9D%BF%E7%BB%84%E4%BB%B6/module_trajectory1.0.0.zip