# WeiboHar 微博功能封装组件

## 简介

微博功能封装组件，简化使用，微博分享，微博登录。

## 详细介绍

### 简介

WeiboHar 微博功能封装组件支持微博分享，微博登录。

### 使用说明

#### 前期准备

**（1）module.json5 配置文件修改**

深色代码主题复制// module.json5 的"module"节点下配置 querySchemes

```json5
"querySchemes": [
  "sinaweibo",
]
```

**（2）EntryAbility.ets 配置文件修改**

深色代码主题复制 onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   // 初始化微博 sdk
   ShareWeiBoSdk.getInstance().initSdkCreate(new AuthInfo(
     this.context, 
     APP_KEY_WB, // 申请
     REDIRECT_URL_WB,// 申请
     SCOPE_WB// 申请
   ))
   // 接受回调的
   ShareWeiBoSdk.mWBAPI?.doWBAsResult(want,this.context);
}
//....
 onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   // 接受回调的
   ShareWeiBoSdk.mWBAPI?.doWBAsResult(want,this.context);
}
```

#### 微博是否安装

```typescript
checkWeiBoApp()
```

深色代码主题复制
```typescript
const flag = checkWeiBoApp() // 布尔值
```

#### 微博分享

处理数据可查看 har 包，如网络图片存沙箱路径，base63 等。

##### doWeiboShare

@param text:string 文本
@param(可传) imgUrlArr string[]  // 图片沙箱路径
@param(可传) videoUrlArr VideoType[]  // 视频路径和封面图路径
@param(可传) ctx：common.UIAbilityContext[]  // 上下文
@returns Promise<WeiboShareCallBack> //返回状态码和 message 和数据

深色代码主题复制
```typescript
import { doWeiboShare, ShareWeiBoSdk, WeiboShareCallBack } from "@zyl/weibo_har";

doWeiboShare(text, [this.pixmapUri])
```

分享类完整分享代码
由于限制，分享了视频就覆盖了图片，切视频只能传一组。

```typescript
await doWeiboShare('分享的文字', strs) // 分享图片
await doWeiboShare('分享的文字', [],[{videoPath:  videoPath, coverPath: strs[0]}]) // 分享视频。
```

深色代码主题复制
```bash
ohpm i @zyl/commonlibhar
ohpm install @zyl/weibo_har
```

```typescript
//.......
import { doWeiboShare, ShareWeiBoSdk, WeiboShareCallBack } from '@zyl/weibo_har';
import {  downloadImageWithUrlsToFile, downloadVideoWithFiles } from '@zyl/commonlibhar';
// .......
Button('微博分享').onClick(async () => {
           try {
             const strs: string[] = await downloadImageWithUrlsToFile([
               "https://i-avatar.csdnimg.cn/72ceb7652a604f8daa327a5c2d7169e5_weixin_42301175.jpg!1",
               "https://i-blog.csdnimg.cn/direct/55a24ef3c6e1481286dc46b452316d4f.png"])
             const videoPath =  await downloadVideoWithFiles('http://47.122.120.244/dist/video.MP4')
             console.log('doWeiboShare1doWeiboSharethenpixmapUri1',videoPath)
           //  await doWeiboShare('分享的文字', strs) // 分享图片
           //  await doWeiboShare('分享的文字', [],[{videoPath:  videoPath, coverPath: strs[0]}]) // 分享视频

             const res: WeiboShareCallBack<string> = await doWeiboShare('分享的文字', strs,[
               {
                 videoPath:  videoPath,
                 coverPath: strs[0] // 视频封面
               } ])
             if (res.code === 200) {
               //成功，拿到数据
               //登录成功调用用户数据的接口
             } else if (res.code === 499) {
               // 用户取消
             } else if (res.code === 400) {
               // 登录失败
             }
           }catch (e) {
             console.log('eeeeeee',e)
           }
         })
```

#### 微博登录（web 登录，授权登录）

##### 微博登录（web 登录）

深色代码主题复制
```typescript
import {  Oauth2AccessToken,UiError,WbASListener,ShareWeiBoSdk } from '@zyl/weibo_har';

let listener: WbASListener = {
             onComplete: (token: Oauth2AccessToken) => {
               console.log('微博授权成功',token)
             },
             onError: (error: UiError) => {
               console.log('微博授权出错',error)
             },
             onCancel: () => {
               console.log('微博授权取消')
             }
           };
if (ShareWeiBoSdk.mWBAPI != null) {
 ShareWeiBoSdk.mWBAPI?.authorizeWeb(listener);
}
```

##### 微博登录（客户端授权登录）

深色代码主题复制
```typescript
import {  Oauth2AccessToken,UiError,WbASListener,ShareWeiBoSdk } from '@zyl/weibo_har';
      

       const contexts: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
      Button('微博登录（客户端授权登录）').onClick(()=>{
           let listener: WbASListener = {
             onComplete: (token: Oauth2AccessToken) => {
              // 微博授权成功
             },
             onError: (error: UiError) => {
            //微博授权出错
             },
             onCancel: () => {
        //微博授权取消
             }
           };
           ShareWeiBoSdk.mWBAPI?.authorizeClient(contexts, listener);
         })
```

#### 原生方法便于扩展

深色代码主题复制
```typescript
ShareWeiBoSdk.mWBAPI
```

## 更新记录

| 版本 | 说明 |
| :--- | :--- |
| 1.0.3 | 更新文档 |
| 1.0.2 | 完善测试用例 |
| 1.0.1 | 完善微博分享文档，微博登录 |
| 1.0.0 | 新功能，封装函数，微博 sdk 二次封装，微博分享 |

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 权限名称、权限说明、使用目的：暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @zyl/weibo_har
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3d1548197acf497d8a64c40d307104ba/PLATFORM?origin=template