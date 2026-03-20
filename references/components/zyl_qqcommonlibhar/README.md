# CommonLibHarQQ 功能封装组件

## 简介

QQ 二次封装组件，简化使用 QQ 分享、QQ 授权登录、计算签名等功能。

## 详细介绍

### 简介

CommonLibHar 是 qq 二次封装组件，包括分享、授权登录、计算签名等。

### 使用说明

#### 1. 添加依赖、module.json5 配置

（1）运行

```bash
ohpm i @tencent/qq-open-sdk // 大于 1.0.3
ohpm install @zyl/qqcommonlibhar
```

在工程级 `oh-package.json5` 文件中可看到新增依赖库。

（2）`module.json5` 配置文件修改

```json5
// module.json5 的"module"节点下配置 querySchemes
"querySchemes": [
   "https",
   "qqopenapi"
]  

// 在 Ability 的 skills 节点中配置 scheme
"skills": [
{
   "entities": [
     "entity.system.browser"
   ],
   "actions": [
     "ohos.want.action.viewData"
   ],
   "uris": [
     {
       "scheme": "qqopenapi", // 接收 QQ 回调数据
       "host": "xxxxxxxxx", // 业务申请的互联 appId，如果填错会导致 QQ 无法回调
       "pathRegex": "\\b(auth|share)\\b",
       "linkFeature": "Login",
     }
   ]
 }
]
```

#### 2. 授权登录接入

##### （1）调用 `IQQOpenApi.handleAuthResult()` 处理回调数据

```typescript
// 在业务 Ability.onNewWant() 中调用 (注意 IQQOpenApi 实例需要与调用 login 方法为同一实例，同时需要与 module.json5 中配置 scheme 为同一个 Ability)
onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  super.onNewWant(want, launchParam);
  let appid = 000000000   // 最好文件工程化引入，这儿简写
  QQOpenApiHolder.getInstance(appid)?.handleResult(want)
  // 使用 QQOpenApiHolder 来自于 hmrouter-----注意注意
}  
```

##### （2）简单使用

**checkQQApp** 判断是否安装 qq

```typescript
QQIsInstall(APP_ID_QQ)
```

**QQLoginWithCallback**，登录获取用户信息

`QQLoginWithCallback` 传入 `appId`, `APP_KEY`，`reqOptions: AuthReqOptions`，`() => {}` 返回 promise

@param appId
@param APP_KEY
@param {} as AuthReqOptions
@param(可传) ()=>{} firstInterface 第一个接口 qqlogin 完成，// 第一个接口 login 处理完回到自己的 app，便于给 loading

```typescript
         const APP_ID_QQ = 000000000
         const APP_KEY_QQ = "exxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
            // 最好文件工程化引入，这儿简写
         if(QQIsInstall(APP_ID_QQ)){
           QQLoginWithCallback(APP_ID_QQ,APP_KEY_QQ,{
             scope: "all",
             useQrCode: false,
             networkTimeout: 5000,
             forceWebLogin: false
           } as AuthReqOptions,
         () => {
           // 第一个接口 login 处理完回到自己的 app，便于给 loading
           this.showLoading = true
         })
             .then((res:QQLoginResult)=>{
               if(res.code===200){
                 //成功，拿到数据
                 const json: UserInfoJson = JSON.parse(res.data as string)
                   //登录成功调用用户数据的接口
                   AppStorage.setOrCreate('QQLogin', json)
               }else if (res.code===499){
                 // 用户取消
               }else if (res.code===400){
                 // 登录失败
               }
             })
             .catch((error:QQLoginResult|Error)=>{
               console.log('error',JSON.stringify(error))
             })
         }else {
           console.log('未安装 QQ，打开异常')
         }
```

#### QQOpenApiHolder 原生使用

```typescript
import { QQOpenApiHolder } from "@zyl/qqcommonlibhar"
   // 如判断是否安装原生使用
   const qqOpenApi: IQQOpenApi = QQOpenApiHolder.getInstance(APP_ID_QQ)
   qqOpenApi.isQQInstalled()
```

#### QQShare 分享

**QQShare**

@param appId: number, 
@param appKey: string, 
@param sharJson: string, // 分享的数据
@param shareType?:number, // 分享类型，默认是 2 .目前只支持图文 ark 类型 2
@param openId?: string, 没啥用的

目前只支持图片文字类型为 2

```typescript
          Button('QQShare').onClick(async () => {
           QQShare(APP_ID_QQ,APP_KEY_QQ,'{"msg_style": 0, "title":"鸿蒙 ARK 图文", "summary":"ARK 分享的内容", "brief":"互联分享", "url":"https://www.qq.com", "picture_url":"https://tangram-1251316161.file.myqcloud.com/files/20200722/796170665c821b9a1982918094aa6ba7.png"}',
           ).then((result:ShareResult)=>{
             console.log('QQShareresult',result)
             switch (result.resultType) {
               case 1: {
                 AlertDialog.show({
                   message:'分享成功'
                 })
               }
                 break
               case 2: {
                 let msg: string = result.message ?? "用户取消分享"
                 AlertDialog.show({
                   message:msg
                 })
               }
                 break
               case 3: {
                 let msg: string = result.message ?? "分享失败"
                 AlertDialog.show({
                   message:msg
                 })
               }
                 break
             }
           })
         })
```

#### 备注

1. 用户授权鸿蒙应用登录成功后，后台会派发临时票据 code(短期且仅一次有效)。
2. 业务获取 code 后，业务需通过 code+ 应用秘钥（只能存后台，客户端泄露风险高），在业务后台获取 openid+access_token+refresh_token。
3. refresh_token 有效期大于 access_token，通过刷新可获取新的 access_token+refresh_token，历史票据自动失效，因此，业务需要保存、刷新使用最新票据。

### 更新记录

- **1.0.7**: 更新文档
- **1.0.6**: 更新文档
- **1.0.5**: QQOpenApiHolder.getInstance(appid)?.handleResult 修正
- **1.0.4**: 更新文档
- **1.0.3**: qq 分享封装
- **1.0.2**: 更新版本 sdk
- **1.0.1**: 新功能，封装函数-qq 二次封装 - 完善配置和文档，新增测试用例
- **1.0.0**: 新功能，封装函数-qq 二次封装

### 权限与隐私及兼容性

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **应用类型** | 应用 / 元服务 |
| **设备类型** | 手机 / 平板 / PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |
| **兼容性** | HarmonyOS 版本 5.0.0 |

## 安装方式

```bash
ohpm install @zyl/qqcommonlibhar
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/96f4afa1fb284d94a1f5f1ac5b8fadf9/PLATFORM?origin=template