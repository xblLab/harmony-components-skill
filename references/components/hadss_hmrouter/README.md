# HMRouter 组件

## 简介

一款功能强大的路由框架，支持服务型路由，可配置自定义拦截器、生命周期、转场动画，支持 har、Hsp，帮助开发者更好的进行模块间解耦。

## 详细介绍

HMRouter 作为应用内页面跳转场景解决方案，为开发者提供了功能完备、高效易用的路由框架。
HMRouter 底层对系统 Navigation 进行封装，集成了 Navigation、NavDestination、NavPathStack 的系统能力，提供了可复用的路由拦截、页面生命周期、自定义转场动画，并且在跳转传参、额外的生命周期、服务型路由方面对系统能力进行了扩展，同时开发者可以高效的将历史代码中的 Navigation 组件接入到 HMRouter 框架中。
目的是让开发者在开发过程中减少模板代码，降低拦截器、自定义转场动画、组件感知页面生命周期等高频开发场景的实现复杂度，帮助开发者更好的实现路由与业务模块间的解耦。

### 特性

- 基于注解声明路由信息（普通页面、Dialog 页面、单例页面）
- 注解参数支持使用字符串常量定义
- 页面路径支持正则匹配
- 支持在 Har、Hsp、Hap 中使用
- 支持 Navigation 路由栈嵌套
- 支持服务型路由
- 跳转时支持标准 URL 解析
- 支持路由拦截器（包含全局拦截、单页面拦截、跳转时一次性拦截）
- 支持生命周期回调（包含全局生命周期、单页面生命周期、NavBar 生命周期）
- 内置转场动画（普通页面、Dialog），支持交互式转场动画，同时支持配置某个页面的转场动画、跳转时的一次性动画
- 提供更多高阶转场动画，包括一镜到底等（需依赖@hadss/hmrouter-transitions）
- 支持配置自定义页面模版，可以更灵活的生成页面文件
- 支持混淆白名单自动配置
- 支持与系统 Navigation/NavDestination 组件混用

### 依赖系统版本

SDK: Ohos_sdk_public 5.0.3.135 (API 15 Release) 及以上

### 快速开始

#### 1. 安装依赖

使用 ohpm 安装

```bash
# 安装路由框架核心库
ohpm install @hadss/hmrouter

# 如需高级转场动画，安装转场动画库
ohpm install @hadss/hmrouter-transitions
```

#### 2. 配置编译插件

**依赖配置**

修改工程根目录下的 `hvigor/hvigor-config.json` 文件，加入路由编译插件

```json
{
  "dependencies": {
    "@hadss/hmrouter-plugin": "^1.2.2"  // 使用 npm 仓版本号
  },
  // ...其余配置
}
```

**插件配置**

修改工程根目录下的 `hvigorfile.ts`，使用路由编译插件

```typescript
// 工程根目录/hvigorfile.ts
import { appTasks } from '@ohos/hvigor-ohos-plugin';
import { appPlugin } from "@hadss/hmrouter-plugin";

export default {
  system: appTasks,
  plugins: [appPlugin({ ignoreModuleNames: [ /** 不需要扫描的模块 **/ ] })]
};
```

模块中单独配置，使用 `modulePlugin()`

#### 3. 初始化路由框架

在 UIAbility 或者启动框架 AppStartup 中初始化路由框架

```typescript
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 日志开启需在 init 之前调用，否则会丢失初始化日志
    HMRouterMgr.openLog("INFO")
    HMRouterMgr.init({
      context: this.context
    })
  }
}
```

使用启动框架请查看：如何在启动框架中初始化 HMRouter

#### 4. 定义路由入口

HMRouter 依赖系统 Navigation 能力，所以必须在页面中定义一个 HMNavigation 容器，并设置相关参数，具体代码如下：

```typescript
@Entry
@Component
export struct Index {
  modifier: MyNavModifier = new MyNavModifier();

  build() {
    // @Entry 中需要再套一层容器组件，Column 或者 Stack
    Column(){
      // 使用 HMNavigation 容器
      HMNavigation({
        navigationId: 'MainNavigation', homePageUrl: 'HomePage',
        options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
          dialogAnimator: HMDefaultGlobalAnimator.DIALOG_ANIMATOR,
          modifier: this.modifier
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}

class MyNavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.hideNavBar(true);
  }
}
```

Navigation 的系统属性通过 modifier 传递，部分 modifier 不支持的属性使用 options 设置

#### 5. 页面定义与路由跳转

使用 `@HMRouter` 标签定义页面，绑定拦截器、生命周期及自定义转场动画

```typescript
@HMRouter({
  pageUrl: 'PageB',
  interceptor: ['PageInterceptor'],
  lifecycle: 'pageLifecycle',
  animator: 'pageAnimator'
})
@Component
export struct PageB {
  // 获取生命周期中定义的状态变量
  @State model: ObservedModel | null = (HMRouterMgr.getCurrentLifecycleOwner().getLifecycle() as PageLifecycle).model
  @State param: HMPageParam = HMRouterMgr.getCurrentParam(HMParamType.all)

  build() {
    Column() {
      Text(`${this.model?.property}`)
      Text(`${this.param.urlParam?.get('msg')}`)
    }
  }
}
```

定义页面 HomePage，使用 `HMRouterMgr.push` 执行路由跳转至 PageB

```typescript
const PAGE_URL: string = 'HomePage'

@HMRouter({ pageUrl: PAGE_URL })
@Component
export struct HomePage {
  build() {
    Column() {
      Button('Push')
        .onClick(() => {
          HMRouterMgr.push({ pageUrl: 'PageB?msg=abcdef' })
        })
    }
  }
}
```

路由跳转支持 URL 带参数的方式，例如定义的页面 pageUrl: /pages1/users，跳转时可以指定 pageUrl 为：/pages1/users?msg=1234
通过 `HMRouterMgr.getCurrentParam` 传入 `HMParamType.all` 获取 URL 的参数内容

#### 6. 定义拦截器

使用 `HMInterceptor` 定义拦截器，并实现 IHMInterceptor 接口

```typescript
@HMInterceptor({ interceptorName: 'PageInterceptor' })
export class PageInterceptor implements IHMInterceptor {
  handle(info: HMInterceptorInfo): HMInterceptorAction {
    if (isLogin) {
      // 跳转下一个拦截器处理
      return HMInterceptorAction.DO_NEXT;
    } else {
      HMRouterMgr.push({
        pageUrl: 'LoginPage',
        param: { targetUrl: info.targetName },
        skipAllInterceptor: true
      })
      // 拦截结束，不再执行下一个拦截器，不再执行相关转场和路由栈操作
      return HMInterceptorAction.DO_REJECT;
    }
  }
}
```

#### 7. 定义生命周期

**组件感知页面生命周期**

通过 addObserver 接口，组件可以感知页面的生命周期事件：

```typescript
@Component
struct ChildComponent {
  @State backPressCount: number = 0;
  private lifecycleOwner = HMRouterMgr.getCurrentLifecycleOwner();
  private handleCallback = () => {
    this.showToast();
    this.backPressCount++;
    return true;
  }

  aboutToAppear(): void {
    this.lifecycleOwner?.addObserver(HMLifecycleState.onBackPressed, this.handleCallback);
  }

  aboutToDisappear(): void {
    this.lifecycleOwner?.removeObserver(HMLifecycleState.onBackPressed, this.handleCallback);
  }

  // 组件内定义的方法
  showToast() {
    this.getUIContext().getPromptAction().showToast({ message: RouterPageConstant.LIFECYCLE_CASE1_TOAST });
  }

  build() {
    // UI 内容
  }
}
```

**页面绑定生命周期**

使用 `@HMLifecycle` 标签定义生命周期处理器，并实现 IHMLifecycle 接口，页面可在 `@HMRouter` 注解中通过 lifecycle 属性来绑定

```typescript
@HMLifecycle({ lifecycleName: 'PageLifecycle' })
export class PageLifecycle implements IHMLifecycle {
  model: ObservedModel = new ObservedModel()
  private time: number = 0;

  onShown(ctx: HMLifecycleContext): void {
    this.time = new Date().getTime();
  }

  onHidden(ctx: HMLifecycleContext): void {
    const duration = new Date().getTime() - this.time;
    console.info(`Page ${ctx.navContext?.pathInfo.name} stay ${duration}`);
  }
}
```

#### 8. 定义转场动画

通过 `@HMAnimator` 标签定义转场动画，并实现 IHMAnimator 接口

```typescript
@HMAnimator({ animatorName: 'PageAnimator' })
export class PageAnimator implements IHMAnimator {
  effect(enterHandle: HMAnimatorHandle, exitHandle: HMAnimatorHandle): void {
    // 入场动画
    enterHandle.start((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "100%" }).opacity(0.4);
    }).finish((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "0" }).opacity(1);
    }).onFinish((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "0" }).opacity(1);
    });

    // 出场动画
    exitHandle.start((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "0" }).opacity(1);
    }).finish((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "100%" }).opacity(0.4);
    }).onFinish((modifier: AttributeUpdater<NavDestinationAttribute>) => {
      modifier.attribute?.translate({ y: "0" }).opacity(1);
    });
  }
}
```

#### 9. 服务路由使用

服务路由用于类似服务提供发现机制 (Service Provider Interface)，通过不依赖实现模块的方式获取接口实例并调用方法，可以直接获取服务实例对象，也可以直接进行方法级服务调用

```typescript
// 方法级服务
export class CustomService {
  @HMService({ serviceName: 'testFunWithReturn' })
  testFunWithReturn(param1: string, param2: string): string {
    return `调用服务 testFunWithReturn:${param1} ${param2}`
  }
}

// 定义服务接口
interface IDataService {
  fetchData(page: number, size: number): Promise<Object[]>;
}
// 实现服务提供者
@HMServiceProvider({ serviceName: 'DataService', singleton: true })
class DataServiceImpl implements IDataService {
  async fetchData(page: number, size: number): Promise<Object[]> {
    // 实现数据获取逻辑
    return [];
  }
}

@HMRouter({ pageUrl: 'test://MainPage' })
@Component
export struct Index {

  build() {
    Row() {
      Column({ space: 8 }) {
        Button('service').onClick(() => {
          // 使用 getService 拿到实例对象
          let data = HMRouterMgr.getService<IDataService>('DataService').fetchData();
          // 直接调用方法级服务
          Logger.info(HMRouterMgr.request('testFunWithReturn', 'home', 'service').data)
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

## 原理介绍

查看详情

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 1.2.2 (2025.10.27)

**Bug Fixes**

- 修复 onWillAppear 和 onReady 生命周期内获取 id 信息异常的稳定性问题

### 1.2.0 (2025.09.17)

**Features**

- 新增适配 API12 后的生命周期
- 新增支持设置默认 navigationId

**Bug Fixes**

- 修复注销生命周期、拦截器的问题

### 1.2.0-rc.0 (2025.09.02)

**Features**

- 新增自定义日志代理
- 新增页面移除操作监听器

### 1.2.0-beta.1 (2025.07.29)

**Bug Fixes**

- 修复 HSP 跨包跳转的问题

**废弃接口修改**

### 1.2.0-beta.0 (2025.06.17)

**Features**

- 支持异步拦截器，开发者可以在拦截器中调用异步接口
- 新增链式调用 API
- 通过 HMServiceFactory 提供 service 能力的扩展性，开发者可以增强 Service 的实现，实现完整的 IOC 容器
- 新增 requestWithCallback 接口，通过回调处理服务调用的返回值
- 新增 handleUri 接口，提供处理外部跳转到应用内的请求

### 1.1.0-beta.0 (2025.04.11)

**Features**

- 新增 NavigationHelper/NavDestinationHelper 类，用于系统 Navigation/NavDestination 组件接入 HMRouter
- `@HMRouter` 注解新增 useNavDst 参数，用于已经定义的 NavDestination 页面
- 动画新增 `(modifier: AttributeUpdater) => void` 回调类型，支持通过 modifier 修改页面动画属性

**Bug Fixes**

- push/replace 支持传入生命周期

### 1.0.0-rc.11 (2024.12.31)

**Features**

- 支持 `@HMServiceProvider` 注解，定义服务路由在类上

**Bug Fixes**

- 修复生命周期问题
- 修复 systemBarStyle 设置问题

### 1.0.0-rc.10 (2024.11.20)

**Features**

- 支持自定义页面模版配置
- 页面路径支持正则匹配
- 支持 url 参数自动解析
- 注解参数支持跨模块常量定义
- 支持高阶转场动画（卡片一镜到底）

**Bug Fixes**

- 全局拦截器逻辑变更，先执行全局拦截器再判断页面是否存在 #IARK6F
- 一次性动画执行逻辑修复
- 拦截器优先级问题修复 #IB2G9N

### 1.0.0-rc.6 (2024.09.27)

**Features**

- 新增自动混淆配置参数 autoObfuscation，开启可以自动配置 HMRouter 混淆白名单

**Refactor**

- 优化初始化逻辑，去掉包管理接口，从文件中读取 hsp 模块名称

### 1.0.0-rc.5 (2024.09.14)

**Bug Fixes**

- 修复 popToIndex 参数错误的 bug
- 修复无法解析 export default class 定义的变量的 bug

### 1.0.0-rc.4 (2024.09.13)

**Bug Fixes**

- 修复 HMNavigationOptions 中 toolbar 设置失效的 bug
- 修复 IHMLifecycleOwner 未导出的 bug
- 修复启动框架无法初始化的 bug
- 修复内置弹窗动画执行结束后状态未还原的 bug

### 1.0.0-rc.3 (2024.08.31)

**Bug Fixes**

- 修复动态加载在 release 模式下崩溃 bug

### 1.0.0-rc.2 (2024.08.30)

**Features**

- 支持服务路由，新增 `@HMService` 注解，`HMRouterMgr.request` 接口
- `@HMRouter` 中 pageUrl 支持字符串常量
- 新增 NavBar 生命周期

**Refactor**

- 优化动态加载、生命周期、动画

**API Changes**

- 移除 `HMRouterMgr.getCurrentLifecycle()` 接口
- 新增 `HMRouterMgr.getCurrentLifecycleOwner()` 接口，返回 IHMLifecycleOwner 生命周期托管者实例
- 变更 `IHMLifecycle.addObserver()`：生命周期观察调用方式为使用 IHMLifecycleOwner.addObserver()
- 变更 getCurrentLifecycle：获取当前生命周期实例调用方式为使用 IHMLifecycleOwner.getCurrentLifecycle()

### 1.0.0-rc.1 (2024.08.22)

**Bug Fixes**

- 修复生命周期 bug，README 更新

### 1.0.0-rc.0 (2024.08.21)

**Initial**

- 初版发布

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **基本信息** | 暂无 |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @hadss/hmrouter
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d931abcc7417425d8fdc1f79c994784a/PLATFORM?origin=template