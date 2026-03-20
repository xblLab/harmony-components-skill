# 简易支付组件

## 简介

本组件支持选择华为支付拉起收银台、微信支付拉起微信、支付宝支付拉起支付宝。

## 详细介绍

### 简介

本组件提供了通过华为支付、支付宝支付和微信支付方式进行订单支付的能力，开发者可以根据业务需要选择实现相关支付方式。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

#### 调试

本组件不支持使用模拟器调试，请使用真机进行调试。

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `aggregated_payment` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 aggregated_payment 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "aggregated_payment",
    "srcPath": "./xxx/aggregated_payment",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "aggregated_payment": "file:./xxx/aggregated_payment"
}
```

#### 配置签名和指纹

完成华为支付服务器侧预下单开发，配置 `ChannelInfo` 中华为支付的 `preOrderInfo` 字段为预下单 `orderStr`，详情参考商户基础支付场景。

```typescript
// 预下单 orderStr 示例
hwOrderStr: string = '{"app_id":"***","merc_no":"***","prepay_id":"xxx","timestamp":"1680259863114","noncestr":"1487b8a60ed9f9ecc0ba759fbec23f4f","sign":"****","auth_id":"***"}';
```

完成微信支付相关的商户权限申请及微信权限开通，并完成 App 下单相关服务器开发，配置 `WxExtraInfo` 中的相关字段为支付参数，详情请参考微信 App 支付。

```typescript
// WxExtraInfo 对象示例
{
  partnerId: '****',
  appId: '****',
  packageValue: 'Sign=WXPay',
  prepayId: '****',
  nonceStr: '****',
  timeStamp:'****',
  sign : '****',
  extData: '****'
}
```

#### 引入支付组件句柄

```typescript
import { AggregatedPaymentPicker, ChannelType, WxExtraInfo } from 'aggregated_payment';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
AggregatedPaymentPicker({
   channelInfo: [{
     channelType: ChannelType.HUAWEI_PAY,
     name: '华为支付',
     icon: $r('app.media.hwpay'),
     preOrderInfo: this.hwOrderStr,
   }, {
     channelType: ChannelType.WECHAT_PAY,
     preOrderInfo: this.wxOrderReq,
     appId: MockApi.WX_APP_ID,
     icon: $r('app.media.wechat'),
     name: '微信支付',
     event: () => {
       this.isShow = false;
     },
   }, {
     channelType: ChannelType.ALI_PAY,
     name: '支付宝支付',
     icon: $r('app.media.alipay'),
     preOrderInfo: this.aliOrderStr,
   }],
   paySuccessEvent: (type: ChannelType) => {
     promptAction.showToast({
       message: type.toString(),
       duration: 2000,
     });
     this.pageInfos.pushPathByName('NavSample', null);
     this.isShow = false;
   },
 });
```

## API 参考

### 子组件

无

### 接口

`AggregatedPaymentPicker(channelType:ChannelType, adId:string, adType:AdType, appId:string, appName:string, closeCallBack:() => void)`

支付组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| channelType | ChannelType | 是 | 广告渠道信息数组 |
| adId | string | 是 | 广告位 ID |
| adType | AdType | 是 | 广告类型 |
| appId | string | 否 | 应用 ID，除华为广告必填 |
| appName | string | 否 | 应用名称，除华为广告必填 |
| closeCallBack | () => void | 是 | 关闭广告回调函数 |

### ChannelType 枚举说明

| 名称 | 值 | 说明 |
| :--- | :--- | :--- |
| HUAWEI_AD | 0 | 华为广告 |
| CSJ_AD | 1 | 穿山甲广告 |

### 事件

支持以下事件：

- **closeCallBack**
  - `closeCallBack: () => void = () => {}`
  - 广告关闭时的回调函数。

### 示例代码

本示例提供了实现支付宝支付、华为支付和微信支付的配置。

```typescript
import { promptAction } from '@kit.ArkUI';
import { AggregatedPaymentPicker, ChannelType, WxExtraInfo } from 'aggregated_payment';

@Entry
@ComponentV2
struct Index {
  @Local isShow: boolean = false;
  hwOrderStr: string =
     '{"app_id":"***","merc_no":"***","prepay_id":"xxx","timestamp":"1680259863114","noncestr":"1487b8a60ed9f9ecc0ba759fbec23f4f","sign":"****","auth_id":"***"}';
  wxAppId: string = 'wx05b3e2e9fc730840';
  wxOrderReq: WxExtraInfo = {
     partnerId: '2480306091',
     appId: 'wx05b3e2e9fc730840',
     packageValue: 'Sign=WXPay',
     prepayId: 'wx26161523845794ecced251acf2b6860000',
     nonceStr: 'vmall_240926161523_993_2774',
     timeStamp: '1747722044',
     sign: 'rAqsrx5yLfRNBGvlHYuLhUsNK0OPeOLQ5xlvhxFo9guPU4HeNtzRdPaGAXAzXvn7V5chVe8sj3BfvDgwXlCKctCcFIllOgheyZbZ7btFC++9bW0QTijhWo1hZ6LhvjcKQ1zf53RGX7zf7GBu9sheqWPKlWqJJzynBZo8UH5Wow9t/WK5fanNj6ST2U2zPQGxuCH+DBMOKJAhhaalrOXlqj+feEiz1bLAzEmhLzIREgcWJQyZmdI5VO0B8r11ND+o1iBYgoohDUuJc+bd9r6RvmZBSE+HqggWE4p3D0/NzY7mQH+51u0osfOfaTHVLqlUM3IMoXi1vH4a0Qrg1P6c0g==',
     extData: 'extData',
  }
  aliOrderStr: string =
     'app_id=2014100900013222&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22xxx%22%2C%22out_trade_no%22%3A%221749781791192%22%7D&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA2&timestamp=2016-07-29%2016%3A55%3A53&version=1.0&sign=c5Zc29h1veR5S%2BI3pvGamcT1vGJ7KtBSl8MNvuHXHwyaLcyRVIGEAutETyOqvMgcklNG4E%2F1PxNHqznGIiF69gYTSex1jdaYe21q0TV%2FYw5ulC2ZbCc6zmNViQHMq5UmtByZhNFZZPEC22ff8bXbwQWuINPWLQGChKwi18Bb8xpduC3ZnCI0vdHpPq9%2FefK4SWOuQZdVz%2FvKI0GfhCZdEkmrsi7zEmjWfzeUmKlUQKDGBpZHOXZpz4nSmC7dS3IXwFzP8jQOyy%2BJ%2Ba5cURclCjOmqxpcIGsJP3y243oYqluwGX%2BpyIH%2Fd2U88r0ssKb33Y4kWNJMWRaECJASRhL9OA%3D%3D'

  build() {
     RelativeContainer() {
        Button('立即支付')
           .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
           })
           .bindSheet($$this.isShow, this.paymentChannelSheet(), { showClose: false, preferType: SheetType.CENTER, height: 250 })
           .onClick(() => {
              this.isShow = true;
           })
     }
     .height('100%')
        .width('100%')
  }

  @Builder
  paymentChannelSheet() {
     AggregatedPaymentPicker({
        channelInfo: [{
           channelType: ChannelType.HUAWEI_PAY,
           name: '华为支付',
           icon: $r('app.media.startIcon'),
           preOrderInfo: this.hwOrderStr,
        }, {
           channelType: ChannelType.WECHAT_PAY,
           preOrderInfo: this.wxOrderReq,
           appId: this.wxAppId,
           icon: $r('app.media.startIcon'),
           name: '微信支付',
           event: () => {
              this.isShow = false;
           },
        }, {
           channelType: ChannelType.ALI_PAY,
           name: '支付宝支付',
           icon: $r('app.media.startIcon'),
           preOrderInfo: this.aliOrderStr,
        }],
        paySuccessEvent: (type: ChannelType) => {
           promptAction.showToast({
              message: '支付成功~',
              duration: 2000,
           });
           this.isShow = false;
           // 支付成功回调
        },
     });
  }
}
```

## 更新记录

### 1.0.2 (2025-11-07)
- 下载该版本更新 readme 内容

### 1.0.1 (2025-11-03)
- 下载该版本更新 readme 内容

### 1.0.0 (2025-08-29)
- 下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及 SDK 合规使用指南

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/36ceb110c9df4660bb543620ab80155a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%94%AF%E4%BB%98%E7%BB%84%E4%BB%B6/aggregated_payment1.0.2.zip