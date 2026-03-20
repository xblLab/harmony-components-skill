# Logger 日志框架组件

## 简介

Logger 是一款简单、漂亮、实用的鸿蒙应用日志框架，可自定义日志行为，比如日志缓存、上报等。

## 详细介绍

### 简介

Logger 是一款简单、漂亮、实用的鸿蒙应用日志框架，是基于鸿蒙系统提供的 hiLog 日志库封装的，主要特性：

- 支持堆栈信息输出；
- 支持众多数据格式输出，如基本数据类型、对象、Map、List、JSON 等格式，可以一次性打印多个数据格式的数据；
- 支持自定义 TAG；
- 支持在日志定位跳转到源码；
- 支持自定义日志行为，比如日志上报、缓存本地等。

### 使用

#### 初始化

默认情况下不需要手动初始化，直接通过 Logger 类调用不同 level 的函数打印日志，如下：

```typescript
const map = new Map<string, Object>()
map.set('name', 'HZWei')
map.set('age', '18')
map.set('user', new UserInfo('HZWei', 20))
Logger.f(map)
```

建议通过 Logger 的 init() 方法进行初始化配置，默认配置在 release 环境不会关闭日志输出。可根据自身需求来初始化配置信息，如下：

```typescript
Logger.init({
  domain: 0x6666,
  showStack: true,
  fullStack: false,
  showDivider: true,
  debug: true,
  tag: 'xml'
} as LogConfig)
```

配置参数：

- **domain**: 作用域，是一个十六进制整数，范围从 0x0 到 0xffff
- **tag**: 日志标记，默认是 Logger
- **debug**: 控制是否打印日志，为 true 时会输出日志，反之则不会
- **fullStack**: 是否输出全部堆栈信息，建议设为 false，日志会更简洁
- **showStack**: 是否显示堆栈信息
- **showDivider**: 是否显示分割线

```typescript
export interface LogConfig {
  readonly domain: number 
  readonly tag?: string
  readonly debug: boolean
  readonly fullStack?: boolean
  readonly showStack?: boolean
  readonly showDivider?: boolean,
}
```

#### 打印各种数据格式

```typescript
// 基本数据类型
const msg = 'Hello World';
const msg2 = 'Hello Logger';
Logger.i(msg)

// 数组
const messages = [msg, msg2]
Logger.d(messages)

// 多个数据格式一起打印
const user = new UserInfo('HZWei', 18)
Logger.w(user)
Logger.e(user, messages, 12, true)

// json
Logger.json(user)

// map
const map = new Map<string, Object>()
map.set('name', 'HZWei')
map.set('age', '18')
map.set('user', new UserInfo('HZWei', 20))
Logger.f(map)

// ArrayList
const list = new ArrayList<string>()
list.add('HZWei')
list.add('XML')
Logger.w(list)

// 自定义 tag
Logger.wt('hzw', 20)
```

#### 自定义日志行为

目前 Logger 只支持在控制台打印，如果需要将日志上传到服务器或者保存本地，可以实现 ILogAdapter 接口来实现对应的逻辑。ILogAdapter 是一个接口，代表日志适配器，定义了与日志记录相关的操作，比如日志开关控制和日志信息行为出口。

```typescript
export class UplaodLogAdapter implements ILogAdapter {

  // 控制是否上传    
  isLoggable(level: hilog.LogLevel, tag: string): boolean {
    return true / false
  }
  
  // 实现上传逻辑
  log(level: hilog.LogLevel, tag: string, msg: string, ...args: ObjectOrNull[]): void {
      
  }

}
```

接着通过 Logger 的 addLogAdapter() 方法将 UplaodLogAdapter 实例添加到适配器容器中。

```typescript
Logger.addLogAdapter(new UplaodLogAdapter())
```

## 更新记录

### 1.1.1

- 支持长日志完整输出，避免内容截断问题
- 优化堆栈信息输出格式，提升调试体验
- 新增 initialize 方法，用于初始化 Logger 配置，init 方法已被废弃
- 新增 getLogger 方法，支持更灵活的自定义配置

### 1.0.2

- 支持单个日志自定义配置

### 1.0.1

- 修复日志换行问题

### 1.0.0

- 核心功能实现

## 兼容性

| 项目 | 说明 |
| :--- | :--- |
| **权限与隐私** | 不涉及 SDK 合规使用指南 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |
| **HarmonyOS 版本** | 5.0.0 |

## 安装方式

```bash
ohpm install @hzw/logger
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/daf04d3a39724bce8a1f9b13becf614c/PLATFORM?origin=template