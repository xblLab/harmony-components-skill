# ohos-rs/traceroute 路由追踪工具组件

## 简介

基于 Rust 实现的 OpenHarmony/HarmonyOS 简易路由追踪工具。

## 安装方式

使用 ohpm 安装包。

```bash
ohpm install @ohos-rs/traceroute
```

## API 接口

```typescript
export interface HopResult {
  /** hop index */
  hop: number;
  /** current hop's target ip address */
  addr?: string;
  /** rtt */
  rtt: Array<number>;
}

export interface TraceOption {
  /**
   * Max hops
   * @default 64
   */
  maxHops: number;
  /**
   * Timeout
   * @default 1
   * @unit second
   */
  timeout: number;
  ipVersion?: "v4" | "v6" | "auto";
  /**
   * Retry times every hops
   * @default 3
   */
  reTry?: number;
}

export declare function traceRoute(
  target: string,
  options?: TraceOption | undefined | null
): Promise<HopResult[]>;

export declare function traceRouteWithSignal(
  target: string,
  signal: AbortSignal,
  options?: TraceOption | undefined | null
): Promise<HopResult[]>;
```

## 使用示例

### Basic usage

```typescript
const ret = await traceRoute("www.baidu.com");
```

### Handle onTrace

```typescript
const ret = await traceRoute("www.baidu.com", {
  onTrace: (err, data) => {
    console.log(data);
  },
});
```

### Start with cancel

We can cancel the trace with @ohos-rs/abort-controller.

```typescript
import { AbortController } from '@ohos-rs/abort-controller';

const controller = new AbortController();

async traceSignal() {
  try {
    const ret = await traceRouteWithSignal("www.baidu.com", controller.signal, {
      onTrace: (err, data) => {
        console.log(`${JSON.stringify(data)}`);
      },
    });
    console.log(`${JSON.stringify(ret)}`);
  } catch (e) {
    // Cancel will catch the error with `Trace aborted`
    console.log(`${e}`);
  }
}

async cancel() {
  controller.abort();
}
```

## 更新记录

### 0.1.2

- Add onTrace for every trace.
- Allow AbortController to cancel it.

### 0.1.1

- Fix: Add the last hop result to final result.

### 0.1.0

- Refactor: using non-blocking socket to implement.

### 0.0.1

- Init package.

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fcb5bfbc6ec647c1b996ef840b037872/PLATFORM?origin=template