# multi api 跨平台社交与支付能力集成封装组件

## 简介

华为、支付宝、微信、QQ 的 支付、授权登录、分享支持

## 详细介绍

MultiApi，是微信、QQ、华为的封装使用如微信支付、微信登录、微信分享，QQ 登录、QQ 分享、华为支付、华为登录等。

### 依赖引入

1. 模块 oh-package.json5 文件中引入依赖

```json5
{
 "dependencies":{
   "@mlethe/multi-api": "version"
 }
}
```

### 用法

#### 初始化

```typescript
MultiApi.instance
 .setWechat("wxd5a474c635b8fd17", "59622f0fc42838fddd69ebdb645ef1ff")
 .setQQ("102061317", "102061317")
 .setDebug(BuildProfile.DEBUG)
 .init(this.context);
```

#### 生命周期监听

1. 在继承 UIAbility 的 Ability 中的方法重新及实现

```typescript
// 进入前台的监听
onForeground(): void {
 // Ability has brought to foreground
 MultiApi.instance.onForeground();
}
// 回到 app 的监听及数据
onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
 MultiApi.instance.handleWant(want);
}
```

#### 统一回调监听

```typescript
const callback: OnActionCallback = {
 onComplete: (type: MultiMedia, record: Record<string, string>) => {
   console.log("multi onComplete: " + type + ", record->" + JSON.stringify(record));
 },
 onCancel: (type: MultiMedia) => {
   console.log("multi onCancel: " + type);
 },
 onFailure: (type: MultiMedia, code: number, msg: string) => {
   console.log("multi onFailure: " + type + ", code->" + code + ", msg->" + msg);
 }
};
```

#### 统一释放内存

在组件的 aboutToDisappear() 方法中调用

```typescript
MultiApi.instance.release();
```

## 许可证协议

Apache 2.0

## 更新记录

### 1.0.0

发布 1.0.0 初版。

### 1.0.1

微信分享回到 app 监听回调修改。

### 1.0.2

判断 app 是否安装方法优化。
QQ 授权登录失败处理修改。

### 1.0.3

QQ 授权登录没有回调修复。

### 1.0.4

QQ 授权登录 unionid 获取修复。

### 1.0.5

支持多 UIAbility。

### 1.0.6

bug 修复

### 1.0.7

请求 bug 修复

### 1.0.8

唤起的 context 支持 UIContext

### 1.0.9

添加开源仓库地址

### 1.1.0

微信支持视频分享
QQ 支持图片分享
QQ 空间支持图片分享

## 系统信息与兼容性

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @mlethe/multi-api
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3434edf3dbca4187b662c021071860f9/PLATFORM?origin=template