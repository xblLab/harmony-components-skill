# 预约管理卡片组件

## 简介

本组件支持查看预约信息、添加日程、订阅通知、取消预约等。

## 详细介绍

### 简介

本组件支持查看预约信息、添加日程、订阅通知、取消预约等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

- **日历活动读写权限**：ohos.permission.READ_CALENDAR、ohos.permission.WRITE_CALENDAR

### 快速入门

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件。
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 reservation_card 模块。

```json5
// 项目根目录下 build-profile.json5 填写 reservation_card 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "reservation_card",
    "srcPath": "./XXX/reservation_card"
  }
]
```

   - c. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "reservation_card": "file:./XXX/reservation_card"
}
```

引入组件。

```typescript
import { ReservationCard } from 'reservation_card';
```

调用组件，详细参数配置说明参见 API 参考。

（可选）如需使用订阅能力，需要配置推送服务。

- a. 开通推送服务。
- b. 开通服务并选择订阅模板，详细参考：开通服务通知并选择订阅模板。

> [说明] 本组件只包含客户端侧代码的实现，如需完整体验推送能力，还需要补充服务端开发。详细参考：推送基于账号的订阅消息。

## API 参考

### 接口

#### ReservationCard(option?: ReservationCardOptions)

预约管理卡片组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ReservationCardOptions | 否 | 配置预约管理卡片组件的参数。 |

##### ReservationCardOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| appointInfo | AppointmentInfo | 否 | 预约信息 |
| themeColor | ResourceColor | 否 | 主题色 |
| entityIds | string | 否 | 推送模板订阅 ID，多个 ID 以英文逗号 (,) 连接 |
| systemLanguage | string | 否 | 系统语言 |
| updateReservation(setSchedule: number, setSubscription: number) => void | function | 否 | 更新预约信息事件回调 |
| cancelReservation() => void | function | 否 | 取消预约事件回调 |
| refreshReservation() => void | function | 否 | 刷新预约信息事件回调 |

##### AppointmentInfo 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| reserveTime | number | 是 | 预约时间 |
| itemName | string | 是 | 预约的项目名称 |
| contactName | string | 是 | 联系人姓名 |
| contactPhone | string | 是 | 联系人电话 |
| numbers | number | 是 | 预约人数 |
| remarks | string | 否 | 预约备注 |
| state | AppointState | 是 | 预约状态 |
| setSchedule | number | 是 | 是否添加到日程 |
| setSubscription | number | 是 | 是否订阅推送 |

##### AppointState 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| NEW | 新预约 |
| FINISH | 已完成 |
| CANCEL | 已取消 |

## 示例代码

```typescript
import { ReservationCard, AppointmentInfo, IAppointment } from 'reservation_card';

@Entry
@ComponentV2
struct Sample1 {
  @Local list: AppointmentInfo[] = [
    new AppointmentInfo({
      reserveTime: 1767061800000,
      itemName: '法式美甲',
      contactName: '1 号选手',
      contactPhone: '130****1212',
      numbers: 2,
      remarks: '大概会晚到一会',
      state: 10,
      setSchedule: 0,
      setSubscription: 0,
    } as IAppointment),
    new AppointmentInfo({
      reserveTime: 1755769268621,
      itemName: '猫眼美甲',
      contactName: '2 号选手',
      contactPhone: '130****1212',
      numbers: 4,
      remarks: '',
      state: 30,
      setSchedule: 0,
      setSubscription: 0,
    } as IAppointment),
  ];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          ForEach(this.list, (v: AppointmentInfo, index: number) => {
            ReservationCard({
              appointInfo: v,
              // todo: 替换为实际的推送服务通知模板 ID，多个 ID 以英文逗号 (,) 连接
              entityIds: 'xxx',
              cancelReservation: () => {
                this.list.splice(index, 1);
                this.getUIContext().getPromptAction().showToast({ message: '已取消预约' });
              },
            })
          }, (v: AppointmentInfo) => JSON.stringify(v))
        }
      }
      .width('100%')
      .height('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .title('预约管理卡片列表')
    .backgroundColor($r('sys.color.background_secondary'))
    .padding(16)
  }
}
```

## 更新记录

### 1.0.0.0 (2025-11-03)

下载该版本预约管理卡片组件，支持查看预约信息、添加日程、订阅通知、取消预约等。

### 1.0.0 (2025-09-11)

下载该版本初始版本。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.READ_CALENDAR | 允许应用读取日历信息 | 允许应用读取日历信息 |
| ohos.permission.WRITE_CALENDAR | 允许应用添加、移除或更改日历活动 | 允许应用添加、移除或更改日历活动 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3, 5.0.4, 5.0.5 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/4c973623335e446eb6e7759f3873fe8b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%A2%84%E7%BA%A6%E7%AE%A1%E7%90%86%E5%8D%A1%E7%89%87%E7%BB%84%E4%BB%B6/reservation_card1.0.0.zip