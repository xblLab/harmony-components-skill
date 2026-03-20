# 每日打卡组件

## 简介

本组件提供了每日运动记录的展示功能，包括周视图日历、三层圆环仪表盘展示步数/距离/卡路里的完成情况、未达标记录列表等功能。支持滑动切换周，选择日期查看详细数据，并可跳转到运动页面。

## 详细介绍

### 简介

本组件提供了每日运动记录的展示功能，包括周视图日历、三层圆环仪表盘展示步数/距离/卡路里的完成情况、未达标记录列表等功能。支持滑动切换周，选择日期查看详细数据，并可跳转到运动页面。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机 (直板机)
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 快速入门

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件：
     - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
     - b. 在项目根目录 `build-profile.json5` 添加 `module_daily` 模块。
       ```json5
       // 项目根目录下 build-profile.json5 填写 module_daily 路径。其中 XXX 为组件存放的目录名
       "modules": [
         {
           "name": "module_daily",
           "srcPath": "./XXX/module_daily"
         }
       ]
       ```
     - c. 在项目根目录 `oh-package.json5` 添加依赖。
       ```json5
       // XXX 为组件存放的目录名称
       "dependencies": {
         "module_daily": "file:./XXX/module_daily"
       }
       ```

2. **在 EntryAbility 的 onWindowStageCreate 中设置全屏模式**
   ```typescript
   let windowClass: window.Window = windowStage.getMainWindowSync();
   await windowClass.setWindowLayoutFullScreen(true);
   ```

3. **引入组件**
   ```typescript
   import { DailyRecord} from 'module_daily'
   ```

4. **调用组件**
   详细参数配置说明参见 API 参考。
   ```typescript
   DailyRecord()
   ```

### API 参考

#### 接口

**DailyRecord(options?: DailyRecordOptions)**
每日运动记录页面组件，包含周视图日历、三层圆环仪表盘、未达标记录列表等功能。

**DailyRecordOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| calendarBuilder() => void | void | 是 | 日历构建器，用于自定义日历组件 |
| toAllSportPage() => void | void | 否 | 点击"所有运动记录"按钮时的回调函数 |
| toSportPage(date: Date, sportSingleRingType: SportSingleRingType) => void | void | 否 | 点击未达标记录"继续运动"按钮时的回调函数，返回选中日期和运动类型 |

**SportSingleRingType 枚举说明**
运动单环类型枚举，用于标识运动数据类型。

| 枚举值 | 值 | 说明 |
| :--- | :--- | :--- |
| Step | 0 | 步数 |
| Distance | 1 | 距离 |
| Calorie | 2 | 卡路里 |

**DailyRecordVM 对象说明**
每日运动记录数据模型，通过 `@Provider('attendanceRecordVM')` 在父组件中提供，子组件通过 `@Consumer('attendanceRecordVM')` 接收。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| swiperData | number[] | 否 | 滑动器数据 |
| weekDateModel | WeekDateModel[] | 否 | 周日期模型列表 |
| weekModel | WeekModel[] | 否 | 周模型列表 |
| swiperIndex | number | 否 | 当前滑动器索引，默认值为 1 |
| dateIndex | number | 否 | 当前选中的周索引，默认值为 0 |
| weekDateModelItem | WeekDateModel | 否 | 当前选中的日期模型 |
| currentDate | Date | 否 | 当前选中的日期，默认值为当前日期 |

**WeekDateModel 对象说明**
周日期模型，包含单个日期的运动数据。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| selected | boolean | 否 | 是否选中，默认值为 false |
| date | Date | 否 | 日期，默认值为当前日期 |
| week | string | 否 | 周几，如"周一" |
| day | string | 否 | 日期，如"01" |
| stepData | number[] | 否 | 步数数据，[当前值，目标值]，默认值为 [0, 1000] |
| distanceData | number[] | 否 | 距离数据，[当前值 (米), 目标值 (公里)]，默认值为 [0, 1000] |
| caloriesData | number[] | 否 | 卡路里数据，[当前值，目标值]，默认值为 [0, 1000] |

**WeekModel 对象说明**
周模型，包含一周的日期数据。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| weekDateModel | WeekDateModel[] | 是 | 周日期模型列表 |

**DailyRecordVM 方法说明**

| 方法名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| initDataList | date: Date | void | 初始化周数据列表，传入要显示的日期 |
| swiperChange | - | void | 周面板数据切换时调用 |
| selectDate | date: Date, swiperIndex: number, itemIndex: number, weekModelData: WeekModel[] | void | 选择日期时调用，更新选中状态 |
| queryDateRunningData | date: Date | WeekDateModel | 查询指定日期的运动数据，返回步数、距离、卡路里数据 |

#### 事件

支持以下事件：

- **toAllSportPage**
  ```typescript
  toAllSportPage: () => void;
  ```
  点击"所有运动记录"按钮时触发，用于跳转到所有运动记录页面。

- **toSportPage**
  ```typescript
  toSportPage: (date: Date, sportSingleRingType: SportSingleRingType) => void;
  ```
  点击未达标记录的"继续运动"按钮时触发，返回选中的日期和运动类型，用于跳转到运动页面。

### 示例代码

```typescript
import { DailyRecord, DailyRecordVM } from 'module_daily';
import { SportSingleRingType } from 'module_daily/src/main/ets/components/SportSingleRing';
import { SportRecord, SportTarget } from 'module_daily/src/main/ets/models/SportRecord';
import { PreferenceUtil } from 'module_daily/src/main/ets/utils/PreferenceUtil';

@Entry
@ComponentV2
struct Index {
  @Provider('attendanceRecordVM') attendanceRecordVM: DailyRecordVM = new DailyRecordVM()

  aboutToAppear() {
    // 初始化 Mock 数据
    this.initMockData()
    // 初始化周数据
    this.attendanceRecordVM.initDataList(new Date())
  }

  /**
   * 初始化 Mock 运动记录数据
   */
  initMockData() {
    const today = new Date()
    const mockRecords: SportRecord[] = []
    
    // 生成最近 7 天的 Mock 数据
    for (let i = 0; i < 7; i++) {
      const date = new Date(today)
      date.setDate(date.getDate() - i)
      
      // 创建目标数据
      const target: SportTarget = {
        stepCount: 10000,      // 目标步数：10000 步
        distance: 8000,        // 目标距离：8 公里（单位：米，8000 米=8 公里）
        deplete: 500,          // 目标消耗：500 千卡
        timeLength: 60      // 目标时长：60 分钟
      }
      
      // 创建运动记录，每天的数据略有不同
      const record: SportRecord = {
        year: date.getFullYear(),
        month: date.getMonth() + 1,
        day: date.getDate(),
        totalTarget: target,
        // 模拟实际完成数据（完成度在 60%-120% 之间）
        totalStepCount: Math.floor(6000 + Math.random() * 6000),  // 6000-12000 步
        // 距离：4-9 公里，转换为米存储（4000-9000 米）
        totalDistance: Math.floor((4 + Math.random() * 5) * 1000),
        totalDeplete: Math.floor(300 + Math.random() * 300)  // 300-600 千卡
      }
      
      mockRecords.push(record)
    }
    
    // 将 Mock 数据存储到 AppStorage，供 SportServiceApi 使用
    AppStorage.setOrCreate(PreferenceUtil.ALL_RECORD_DATA_KEY, mockRecords)
  }

  /**
   * 日历构建器示例
   * 注意：实际使用时需要根据项目中的日历组件进行自定义
   */
  @Builder
  calendarBuilder() {
    Row() {
      // 左箭头按钮（切换到上一周）
      // 注意：需要替换为实际的图标资源路径
      Text('<')
        .fontSize(18)
        .fontColor('#333333')
        .onClick(() => {
          // 切换到上一周
          const date = new Date(this.attendanceRecordVM.currentDate)
          date.setDate(date.getDate() - 7)
          this.attendanceRecordVM.currentDate = date
          this.attendanceRecordVM.initDataList(date)
        })

      // 显示当前日期
      Text(this.formatDate(this.attendanceRecordVM.currentDate))
        .fontSize(15)
        .fontColor('#333333')
        .padding({ left: 12, right: 12 })

      // 右箭头按钮（切换到下一周）
      // 注意：需要替换为实际的图标资源路径
      Text('>')
        .fontSize(18)
        .fontColor('#333333')
        .onClick(() => {
          // 切换到下一周
          const date = new Date(this.attendanceRecordVM.currentDate)
          date.setDate(date.getDate() + 7)
          this.attendanceRecordVM.currentDate = date
          this.attendanceRecordVM.initDataList(date)
        })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }

  /**
   * 格式化日期
   */
  formatDate(date: Date): string {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')
    return `${year}-${month}-${day}`
  }

  build() {
    NavDestination() {
      DailyRecord({
        calendarBuilder: () => {
          this.calendarBuilder()
        },
        toAllSportPage: () => {
          // 跳转到所有运动记录页面
          console.info('跳转到所有运动记录页面')
          // 实际使用时，可以调用路由跳转：
          // RouterUtils.pushPathByName(RouterMap.ALL_SPORT_RECORDS_PAGE)
        },
        toSportPage: (date: Date, sportSingleRingType: SportSingleRingType) => {
          // 跳转到运动页面
          const typeName = sportSingleRingType === SportSingleRingType.Step ? '步数' :
            sportSingleRingType === SportSingleRingType.Distance ? '距离' : '卡路里'
          console.info(`跳转到运动页面，日期：${this.formatDate(date)}，类型：${typeName}`)
          // 实际使用时，可以调用路由跳转：
          // RouterUtils.pushPathByName(RouterMap.REAL_TIME_MOTION_PAGE, {
          //   'date': date,
          //   'sportType': sportSingleRingType
          // } as ESObject)
        }
      })
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
    .onWillShow(() => {
      // 页面显示时初始化数据
      this.attendanceRecordVM.initDataList(this.attendanceRecordVM.currentDate)
    })
  }
}
```

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

**1.0.0 (2025-12-15)**
- 初始版本

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/de8a9de8260e43fa9b5f5025cfac3e80/2adce9bbd4cb42d58a87e6add45594b3?origin=template

### OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%AF%8F%E6%97%A5%E6%89%93%E5%8D%A1%E7%BB%84%E4%BB%B6/module_daily1.0.0.zip