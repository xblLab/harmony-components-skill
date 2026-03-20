# WebBridgeAdapter 事件分发调用组件

## 简介

一个 Web 端与鸿蒙应用通信交互的 JSBridge 事件分发调用适配器，简单易用，能有效解耦鸿蒙应用与 JavaScript 交互的事件分发、拦截与接收。

## 详细介绍

### 简介

WebBridgeAdapter 是一个 Web 端与 HarmonyOS 通信交互的 JSBridge 事件分发调用适配器，简单易用，能有效解耦 HarmonyOS 与 Web 交互的事件分发、拦截与接收。

### 相关特性

- 适配 HarmonyOS，API 13+
- 逻辑简单，使用方便，不影响原先 Web 组件
- 支持控制台打印调试，可查看分发流程以及方法执行耗时
- 支持 Bridge 名称自定义
- 支持 App 端与 Web 端互相发送 Event 事件
- 支持以 Plugin 类的方式集中统一管理 JSApi
- 支持 callback 和 Promise 两种调用方式、支持一次调用多次回调
- 支持 JSApi 是否存在以及是否可用检测
- 支持 JSApi 方法分发执行前进行拦截
- 支持 JSApi 方法和类级别的黑名单控制
- 支持 VConsole 控制台显示调用入参与出参
- 支持对 JSApi 调用结果数据的全局转换
- ...

## 安装使用

### Step 1. 在项目中使用 ohpm 安装

```bash
ohpm install @ilye/web-bridge-adapter
```

### Step 2. 在 UIAbility 的 onCreate 方法中进行初始化

可选，若不设置将使用默认。

```typescript
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    ArkWebBridge.create()
      .logEnable(true)            // 设置是否可日志打印，默认 false
      .logTag("YourLogName")      // 设置日志打印的 Tag 值，默认 LYWeb
      .bridgeName("JSBridge")     // 设置 BridgeName，默认 JSBridge
      // ...
      .apply()
}
```

### Step 3. 创建 WebBridgeAdapter 对象并与 Web 组件建立桥接

#### 创建 WebBridgeAdapter

```typescript
// 第二个参数为调用 Web 方法，可不传，当传入的时候需自己实现调用 Web 方法
private bridgeAdapter: WebBridgeAdapter = new WebBridgeAdapter(this.controller,
    (method: string, args: Object, callback?: WebEventCallback) => {
      // 调用 web 方法
});
```

#### 与 Web 组件建立桥接

```typescript
Web({
    xxxxx
  })
  .javaScriptAccess(true)
  // 方式 1：
  .javaScriptProxy(this.bridgeAdapter.javaScriptProxy)
  // 方式 2：在 onControllerAttached 回调中注入
  .onControllerAttached(() => {
    // WebviewController 载入完成后，注入 JavaScriptProxy
     this.bridgeAdapter.injectJavaScriptProxy();
  })
```

### Step 4. 创建 Plugin 类继承 WebSimplePlugin 并按需实现对应方法

- `onInitialize` 初始化操作
- `onPrepare` 预处理
- `interceptEvent` Web 事件拦截处理
- `handleEvent` Web 事件处理
- `onRelease` 释放资源

```typescript
export class CustomPlugin extends WebSimplePlugin {
  onPrepare(filter: WebEventFilter): void {
    super.onPrepare(filter);
    filter.addAction("test")
    filter.addAction("test2")
  }

  handleEvent(event: WebEvent, context: WebBridgeContext): boolean {
    const action = event.action;
    if (action === "test") {
      // 返回调用结果
      context.sendBridgeResult({
               "k11": "v11",
               "k12": "v12"
             });
      return true;
    }
    if (action === "test2") {
      // 一次调用多次返回，若 Web 端使用 Promise 接收结果数据，多次回调保持状态将失效
      setInterval(() => {
        context.sendBridgeResultWithCallbackKept({
          "k21": "v21",
          "k22": "v22"
        });
      }, 1000 * 5)
      return true;
    }
    return super.handleEvent(event, context);
  }
}
```

> **注意**：若需要一次调用多次回调，Web 端必须使用 callback 方式进行结果数据的接收。

### Step 5. 把自定义的 Plugin 注册到 ArkWebBridge 中

```typescript
// 在合适的时机注册 plugin，建议在 UIAbility 的 onCreate 方法中进行注册
ArkWebBridge.registerPlugin(CustomPlugin);
// 注册多个 plugin
ArkWebBridge.registerPlugin(CustomPlugin, CustomPlugin1, CustomPlugin2);
```

完成以上步骤，就可以在 web 页面进行调用了。

## Web 端调用 HarmonyOS 端实例

### 使用 promise 形式进行无参调用

```javascript
YourBridgeName.call('test')
  .then((res)=>{
     alert(JSON.stringify(res))
   })
  .catch((error)=>{
   alert(error)
  })
```

### 使用 promise 形式进行有参调用

```javascript
YourBridgeName.call('test',{
               "param1": "p1",
               "param2": "p2"
              })
  .then((res)=>{
     alert(JSON.stringify(res))
   })
  .catch((error)=>{
   alert(error)
  })
```

### 使用 callback 形式无参调用

```javascript
YourBridgeName.call('test2', (res)=>{
                 alert(JSON.stringify(res))
               })
```

### 使用 callback 形式有参调用

```javascript
YourBridgeName.call('test2',{
                "param1": "p1",
                "param2": "p2"
            }, (res)=>{
              alert(JSON.stringify(res))
            })
```

## HarmonyOS 端调用 Web 端

```typescript
/**
* 调用 Web 方法
* 
* @param method  方法名称
* @param args    参数
* @param callback webEvent 回调
*/
bridgeAdapter.sendToWeb(method, args, callback)
```

通过以上方法将会把所有的调用分发到 constructor 中的 CallWebAction 回调中，这里可以统一进行 Web 端的调用执行，你可以选择自己进行 Web 方法的调用或使用内置的实现。

### App 发布事件到 Web 端

#### Web 端注册监听 Event 事件

```javascript
// 无接收数据
document.addEventListener(event, function() {
  console.log('原生发送了 Event：'+event);
},false);

// 有接收数据
document.addEventListener(event, function(e) {
  console.log('原生发送了 Event：'+ event +" 参数："+ e.detail);
},false);
```

#### App 端调用方法发布 Event 事件

```typescript
/**
 * 发布 Event 到 Web 端
 *
 * @param event 事件名称
 * @param data 事件数据
 */
bridgeAdapter.postEventToWeb(event, data);

/**
 * 延迟发布 Event 到 Web 端
 *
 * @param event 事件名称
 * @param delay 延迟时间，单位毫秒
 * @param data 事件数据
 */
bridgeAdapter.postEventDelayedToWeb(event, delay, data)
```

### Web 发布事件到 App 端

#### App 端设置 WebEventConsumer

Web 端调用发送 Event 相关方法后会统一调用设置的 WebEventConsumer 进行事件消费，接收到 Event 如何操作由使用者自己实现。

```typescript
bridgeAdapter.setWebEventConsumer((event:string,data:Object)=>{
  console.log('Web 发送了 Event：'+ event +" 参数："+ JSON.stringify(data));
})
```

#### Web 端通过设置的 BridgeName 调用方法发布 Event 事件

```javascript
/**
 * Web 发布事件到 App 端
 *
 * @param event 事件名称
 * @param data 事件数据
 */
YourBridgeName.postEvent(event, data);

/**
 * Web 延迟发布事件到 App 端
 *
 * @param event 事件名称
 * @param delay 延迟时间，单位毫秒
 * @param data 事件数据
 */
YourBridgeName.postEventDelayed(event,delay,data);
```

## WebPlugin 和 JSApi 黑名单过滤

当前支持 Plugin 级和 JSApi 方法级的黑名单过滤。

- **Plugin 级**：通过 PluginName 进行判断
- **JSApi 方法级**：通过具体 JSApi 方法名进行判断

若想使用 WebPlugin 和 JSApi 过滤，首先需要开启过滤选项，同时你也可在该方法添加黑名单过滤项。

```typescript
ArkWebBridge.create()
  .filter4PluginEnable(true)             // 是否启用 Plugin 过滤，默认 false
  .addPlugin2BlackList(TestPlugin.name)  // 配置要加入 BlackList 的 Plugin 名称，可传入 Array
  .filter4JSApiEnable(true)              // 是否启用 JSApi 过滤，默认 false
  .addJSApi2BlackList('test')            // 配置要加入 BlackList 的 JSApi 名称，可传入 Array
  .apply()
```

除上述黑名单过滤项配置外，你还可以通过 ArkWebBridge 的以下方法进行黑名单的操作：

```typescript
// 添加 Plugin 到黑名单
addPlugin2BlackList(pluginName: string | Array<string>)
// 从黑名单移除 plugin
removePluginInBlackList(pluginName: string)
// 清空 plugin 黑名单
clearPluginBlackList()
// 添加 JSApi 到黑名单
addJSApi2BlackList(jsApiName: string | Array<string>)
// 从黑名单移除 JSApi
removeJSApiInBlackList(jsApiName: string)
// 清空 JSApi 黑名单
clearJSApiBlackList()
```

## ArkWebBridge 其他 Api 方法

```typescript
release         : 释放资源         
hasAction       : 判断是否包含某个 JSApi 方法 
canIUse         : 获取某个 JSApi 方法是否可用              
...           
```

## 自定义事件分发

若你不想使用提供的 WebBridgeAdapter 方法，又想使用其进行事件的分发与接收，该库也是支持的，你可通过以下方式实现。

### Step 1. 在你向 Web 注入的对象中创建 WebBridgeLiteAdapter

```typescript
// 在你向 Web 注入的对象中创建 WebBridgeLiteAdapter
private bridgeAdapter: WebBridgeLiteAdapter = new WebBridgeLiteAdapter();
```

### Step 2. 在你自定义的方法调用 call 方法或对 call 方法的回调结果进行自定义修改等

```typescript
// 在你自定义的方法调用 call 方法或对 call 方法的回调结果进行自定义修改等
yourCustom(method: string, args?: ESObject | WebEventCallback, callback?: WebEventCallback): Promise<Object> {
    return this.bridgeAdapter.call(method, args, callback)
}
```

## 返回结果信息说明

| codemsg | 说明 |
| :--- | :--- |
| Y | 成功回调 |
| N | 失败回调 |
| C | 取消回调 |
| B1001 | 无效的参数 |
| B1002 | 没有插件注册该调用方法 |
| B1003 | 注册调用方法的插件在黑名单中 |
| B1004 | 调用的方法在黑名单中 |

## 许可证协议

MIT

## 更新记录

### 2.2.2（DevEco Studio 6.0.2 Release）

- 优化部分代码细节，去除 IDE 警告
- 添加 UIContext 参数支持，可在 Plugin 类中通过 WebEvent 对象获取
- 完善部分错误处理以提高可维护性和健壮性

### 2.2.1（DevEco Studio 6.0.1 Release）

- 移除 WebBridgeConsumer 接口并优化实现
- 新增 setWebBridgeResultConverter 用于处理 Web 调用结果数据的转换
- 优化代码细节，去除无用的代码

### 2.2.0（DevEco Studio 6.0.1 Release）

- 优化耗时日志相关代码细节
- 升级依赖库版本

### 2.1.2（DevEco Studio 6.0.1 Release）

- 新增 postEventToWebDelayed 原生调用发布 Event 到 Web 端方法替换 postEventDelayedToWeb 方法
- 添加 VConsole 控制台控制显示 JSBridge 事件 Call 的入参和出参
- 升级 commons 依赖版本

### 2.1.1（DevEco Studio 5.0.5 Release）

- 添加通过插件对象注册 WebPlugin，用于部分需要向 Plugin 类传入自定义参数的场景
- 添加部分流程打印日志信息，完善部分代码注释

### 2.1.0（DevEco Studio 5.0.5 Release）

- 添加 postEvent、postEventDelayed 等 Web 端调用发布 Event 到原生端方法 (需调用 setWebEventConsumer 自己进行监听进行发送或处理)
- 优化部分方法命名，修改 postDelayedEventToWeb 为 postEventDelayedToWeb

### 2.0.0（DevEco Studio 5.0.5 Release）

- 添加 postEventToWeb、postDelayedEventToWeb 等原生调用发布 Event 到 Web 端方法 (支持携带参数)
- 优化部分方法命名
- 发布 2.0.0 正式版

### 2.0.0-rc.0（DevEco Studio 5.0.5 Release）

- 使用 Common 通用组件替换部分内部使用的方法
- 优化代码细节，去除部分冗余代码
- 完善 Readme 文档

### 1.2.2

- 优化代码细节

### 1.2.1

- 添加调用 Web 端方法默认实现
- 完善参数校验流程以及相关结果信息，详看返回结果信息说明
- 完善 Plugin 以及 JSApi 黑名单相关判断
- 优化代码细节

### 1.2.0

- 新增判断是否有 JSApi 以及 JSApi 是否可用等方法
- 优化代码，去除部分不必要的代码。

### 1.1.0

- 新增 Plugin 以及 JSApi 黑名单控制。
- 优化代码。

### 1.0.0 初版

- 发布 1.0.0 初版。

## 权限与隐私基本信息

| 项目 | 详情 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @ilye/web-bridge-adapter
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f98a3e0489d04db6886c845a76134766/PLATFORM?origin=template