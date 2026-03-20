# Hypium 测试框架组件

## 简介

一款应用于 OpenHarmony 上的测试框架

## 详细介绍

### 简介

Hypium 是 OpenHarmony 上的测试框架，提供测试用例编写、执行、结果显示能力，用于 OpenHarmony 系统应用接口以及应用界面测试。
Hypium 结构化模型：hypium 工程主要由 List.test.js 与 TestCase.test.js 组成。

```text
rootProject                  // Hypium 工程根目录
├── moduleA
│   ├── src
│      ├── main                   // 被测试应用目录
│      ├── ohosTest               // 测试用例目录
│         ├── ets
│            └── test
│               └── List.test.ets      
│               └── TestCase.test.ets  
└── moduleB
    ...
│               └── List.test.ets      
│               └── TestCase.test.ets  
```

### 安装使用

#### 方式一

```bash
ohpm i @ohos/hypium
```

#### 方式二

在 DevEco Studio 内使用 Hypium
工程级 oh-package.json5 内配置:

```json5
"dependencies": {
    "@ohos/hypium": "1.0.26"
}
```

**注：**
hypium 服务于 OpenHarmonyOS 应用对外接口测试、系统对外接口测试（SDK 中接口），完成 HAP 自动化测试。

#### 引入方式

```typescript
import { describe, it, expect } from '@ohos/hypium';
```

## 功能特性

| No. | 特性 | 功能说明 |
| :--- | :--- | :--- |
| 1 | 基础流程 | 支持编写及异步执行基础用例。 |
| 2 | 断言库 | 判断用例实际结果值与预期值是否相符。 |
| 3 | 异步代码测试 | 等待异步任务完成之后再判断测试是否成功。 |
| 4 | 公共能力 | 支持获取用例信息的基础能力以及日志打印、清除等能力。 |
| 5 | Mock 能力 | 支持函数级 Mock 能力，对定义的函数进行 Mock 后修改函数的行为，使其返回指定的值或者执行某种动作。 |
| 6 | 数据驱动 | 提供数据驱动能力，支持复用同一个测试脚本，使用不同输入数据驱动执行。 |
| 7 | 专项能力 | 支持筛选测试套/测试用例；支持配置跳过指定测试套/测试用例；支持配置超时时间；提供随机执行、压力测试、遇错即停等测试模式。 |

## 接口

### describe

`describe(testSuiteName: string, func: Function): void`

定义一个测试套。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| testSuiteName | string | 是 | 测试套的名称。 |
| func | Function | 是 | 测试套函数，用于注册测试用例。注意：测试套函数不支持异步函数。 |

**示例：**

```typescript
import { describe, expect, it } from '@ohos/hypium';

export default function assertCloseTest() {
    describe('assertClose', () => {
        it('assertClose_success', 0, () => {
            let a = 100;
            let b = 0.1;
            expect(a).assertClose(99, b);
        })
    })
}
```

### beforeAll

`beforeAll(func: Function): void`

在测试套内定义一个预置条件，在所有测试用例开始前执行且仅执行一次。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| func | Function | 是 | 预置动作函数，在一组测试用例（测试套）开始执行之前执行。支持异步函数。 |

**示例：**

```typescript
import { beforeAll, describe, it, expect } from '@ohos/hypium';

export default function customAssertTest() {
    describe('customAssertTest', () => {
        beforeAll(() => {
            console.info('beforeAll')
        })
        it('assertClose_success', 0, () => {
            let a = 100;
            let b = 0.1;
            expect(a).assertClose(99, b);
        })
    })
}
```

### beforeEach

`beforeEach(func: Function): void`

在测试套内定义一个预置条件，在每条测试用例开始前执行，执行次数与 it 定义的测试用例数一致。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| func | Function | 是 | 预置动作函数，在每条测试用例开始执行之前执行，支持异步函数。 |

**示例：**

```typescript
import { beforeEach, describe, it, expect } from '@ohos/hypium';

let str = "";

export default function test() {
    describe('test0', () => {
        beforeEach(() => {
            str += "A";
        })
        it('test0000', 0, () => {
            expect(str).assertEqual("A");
        })
    })
}
```

## Hypium 开放能力隐私声明

### 我们如何收集和使用您的个人信息

您在使用集成了 Hypium 开放能力的测试应用时，Hypium 不会处理您的个人信息。

### SDK 处理的个人信息

不涉及。

### SDK 集成第三方服务声明

不涉及。

### SDK 数据安全保护

不涉及。

### SDK 版本更新声明

为了向您提供最新的服务，我们会不时更新 Hypium 版本。我们强烈建议开发者集成使用最新版本的 Hypium。

## 更新记录

| 版本 | 更新内容 |
| :--- | :--- |
| 1.0.26 | 新增 SkipError 类，通过 SkipError 跳出执行的用例，在执行结果中标记为 ignore。<br>部分功能修改。 |
| 1.0.25 | 新增 beforeEachIt, afterEachIt 接口。<br>部分功能修改。 |
| 1.0.24 | 提示信息优化 |
| 1.0.23 | 断言错误提示信息优化 |
| 1.0.22 | mock 五参数失败问题修复 |
| 1.0.21 | mock 支持多参数<br>describe 中异步函数抛出日志信息<br>修复多测试套时，执行单个测试套会打印其他测试套的日志信息 |
| 1.0.14 | 堆栈信息打印到 cmd |
| 1.0.15 | 支持获取测试代码的失败堆栈信息<br>mock 代码迁移至 harmock 包<br>适配 arkts 语法<br>修复覆盖率数据容易截断的 bug |
| 1.0.16 | 修改覆盖率文件生成功能<br>修改静态方法无法 ignoreMock 函数 |
| 1.0.17 | 修改 not 断言失败提示日志<br>自定义错误 message 信息<br>添加 xdescribe, xit API 功能 |
| 1.0.18 | 添加全局变量存储 API get set<br>自定义断言功能 |
| 1.0.18-rc.0 | 添加框架 worker 执行能力 |
| 1.0.19 | 规范日志格式 |
| 1.0.20 | 代码告警整改 |

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用 |
| 元服务 | |
| 设备类型 | 手机 |
| 平板 | |
| PC | |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## 安装方式

```bash
ohpm install @ohos/hypium
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/25345c6221a343dabf37cde528ea76e8/PLATFORM?origin=template