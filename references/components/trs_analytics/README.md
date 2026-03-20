# TrsAnalytics 系统事件自动记录组件

## 简介

系统事件在应用启动后自动记录。

## 详细介绍

### 简介

TrsAnalytics 系统事件自动记录组件，包括应用的启动、挂起、退出，通过 HMNavigation 和 router 跳转的页面进入和退出的事件。

### 安装

深色代码主题复制 ohpm install trs_analytics

### 初始化方式

SDK 提供了初始化方式，如下：

#### 直接传入配置对象

```typescript
// 在 EntryAbility 中初始化
深色代码主题复制 config:string = "{\n" +
  "  \"appKey\": \"m7u51ju2_1i7c72wgi60uj\",\n" +
  "  \"url\": \"http://ta.trs.cn/c\",\n" +
  "  \"mpId\": \"207\",\n" +
  "  \"channel\": \"\",\n" +
  "  \"debugAble\": true,\n" +
  "  \"threshold\": 4,\n" +
  "  \"locationEnable\": true,\n" +
  "  \"encryptEnable\": true\n" +
  "}"
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  let taConfig:ConfigBuilder = JSON.parse(this.config )as ConfigBuilder
  TAController.init(this.context,taConfig)
  super.onCreate(want,launchParam)
}
```

### 主要功能

- 系统事件在应用启动后自动记录
- 包括应用的启动，挂起，退出
- 通过 HMNavigation 和 router 跳转的页面进入和退出的事件
- 应用 aaid（不需要权限）上报关联

### 页面统计

```typescript
// 记录页面进入（适用于 tab 页面，page 名称可用 tabtitle）
TAController.onPageStart(pageName: string)

// 记录页面退出
TAController.onPageEnd(pageName: string, pageType: string)
```

### 自定义事件

```typescript
// 发送自定义事件
// let map:Map<string, Object> = new TRSExtrasBuilder()
//   .pageType("首页")
//   .objectType(ITAConstant.OBJECT_TYPE_ACTIVITY)
//   .objectID("10000")
//   .objectName("央行整顿虚拟货币")
//   .objectIDs("1,2,3")
//   .selfObjectID("11")
//   .attachObjectID("222")
//   .eventName("点击新闻")
//   .eventDetail("点击首页新闻")
//   .classifyID("333")
//   .classifyName("财经")
//   .searchWord("央行")
//   .number(100)
//   .sequence(1)
//   .success(true)
//   .percentage(0.50)
//   .put("operationName", "lixinghui")
//   .objectName('null')
//   .put("se_newsArticleType", 2019)
  
//   // 计时事件
// if (this.timer == "开始计时") {
//   // 初始化开始计时
//   this.timerInfo = new TRSOperationInfo("A002")
//     .setEventName("记录阅读事件")
//     .setObjectID("10000")
//     .setObjectName("川田到了")
//   this.timer = "计时中，再次点击发送事件"
// }else{
//   if (this.timerInfo) {
//     // 结束计时
//     this.timerInfo.calDuration()
//     TAController.onEvent("A100",this.timerInfo)
//     this.timer = "开始计时"
//   }
//
// }
  
let params = new Map<string, Object>()
params.set("key", "value")
TAController.onEvent(eventCode: string, params: Map<string, Object>)
```

### 用户账号

```typescript
// 发送用户账号变更事件
// this.account = new TRSUserAccount("21","张三")
// this.account.addExtra("sex", "男");
//
// this.account.addExtra("age", 15);
//   let eventType = TRSAccountEventType.MODIFY;
// TRSAccountEventType.LOGOUT
//  TRSAccountEventType.LOGIN
TAController.onUserEvent(eventType: TRSAccountEventType, account: TRSUserAccount)
```

### 位置信息

```typescript
// 手动设置位置信息
TAController.setLocation(latitude: number, longitude: number)
```

### 关联第三方

```typescript
// 设置与其他第三方的关联性
// let map:Map<string,string> = new Map()
// map.set(ITAConstant.GInsight_ID, "lixinghui-gxid")
TAController.setCorrelationWithOthers(newDeviceId: string, imei: string, idMap: Map<string, string>)
```

### 权限说明

如果需要使用位置功能，请在应用配置文件中添加以下权限：

- ohos.permission.LOCATION
- ohos.permission.APPROXIMATELY_LOCATION

### 注意事项

- 初始化建议在应用启动时尽早调用
- 使用位置功能需要确保已获取相应权限
- 加密功能通过 encryptEnable 配置项控制
- 调试模式可通过 debugAble 配置项开启

## 更新记录

- **2026.02.02 V1.0.12**
  - 优化部分上报事件部分字段不准确的问题 (V1.0.11 版本可能还会出现此问题)
- **2026.02.02 V1.0.11**
  - 优化部分上报事件部分字段不准确的问题
- **2026.01.15 V1.0.10**
  - 优化 sdkVersion 和 osVersion 一样的问题
- **2026.01.15 V1.0.9**
  - 优化上报版本不对的问题
- **2026.01.14 V1.0.8**
  - 优化部分数据带有引号的问题
- **2025.06.27 V1.0.7**
  - 优化部分数据不能正常发送的问题
- **2025.06.25 V1.0.6**
  - 优化获取 SDK 版本号的问题
- **2025.06.24 V1.0.5**
  - 优化获取设备标识的问题
- **2025.06.19 V1.0.4**
  - 优化部分事件不能获取用户 ID 的问题
- **2025.06.17 V1.0.3**
  - 使用时间统计错乱的问题
- **2025.03.10 V1.0.2**
  - 启动次数统计错乱的问题
- **2025.03.07 V1.0.1**
  - 记录页面事件的时候可以填充自定义参数
  - 位置信息在 sdk 里面不做权限申请操作，只判断有没有权限

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| **权限与隐私基本信息** | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| **隐私政策** | 不涉及 SDK 合规使用指南 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **应用类型** | 应用<br>元服务 |
| **设备类型** | 手机<br>平板<br>PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

> Created with Pixso.

## 安装方式

```bash
ohpm install trs_analytics
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2887ccce6ecc4b9084066b6a4174a403/PLATFORM?origin=template