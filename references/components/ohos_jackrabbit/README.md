# ohos/jackrabbit 通信协议组件

## 简介

Jackrabbit is a very opinionated abstraction built on top of amqplib focused on usability and implementing several messaging patterns on RabbitMQ.

## 详细介绍

### 软件简介

本软件是参照开源软件 jackrabbit 源码并用 TypeScript 语言实现了相关功能，在 OpenHarmony 上支持 AMQP（Advanced Message Queuing Protocol）网络通信协议的 library，可以在一个进程间传递异步消息。

Jackrabbit 底层依赖 amqplib 库，在 RabbitMQ 上实现了多种消息传递模式。

### 下载安装

安装命令如下：

```bash
ohpm install @ohos/jackrabbit
```

### 主要功能

- **发布消息**：支持 json 及 string 类型的消息发送，同时也支持设置相关的发布消息的配置信息。
- **消费消息**：支持设置接收消息的回调函数，也支持设置相关消费信息的配置信息。
- **交换机配置**：支持设置 direct、fanout、topic 共三种类型的交换机、支持设置交换机名称、是否持久化、是否超时等配置信息。
- **队列配置**：支持设置队列名称、是否持久化、最大长度等配置信息。
- **更为精简的 amqp 通信接口**：相对于 amqplib 提供的接口，jackrabbit 在交换机和队列操作方面提供了更为精简易用的接口；客户端增加了 Exchange 和 Queue 的类抽象，相比于 amqplib 每次都需要通过字符串参数向服务端指定对哪个交换机/队列进行操作，jackrabbit 在创建完交换机/队列后立刻就能拿到一个 Exchange/Queue 对象，以后只需要调用此对象的方法即可。
- **增加重连机制**：增加了 amqplib 原本不支持的重连机制。

## 使用说明

### 使用前言

1. 需要搭建 RabbitMQ 环境。
2. RabbitMQ 与 Erlang 是存在版本对应关系，两者版本如果不对应会出现许多问题。可参考版本对应关系：
   - RabbitMQ 版本为 "rabbitmq-server-3.10.7.exe"
   - Erlang 版本为 "otp_win64_25.0.exe"
3. 由于 RabbitMQ 默认的 guest 只能从 localhost 连接不能使用远程连接，官方给出的解决方案是通过配置文件修改 RabbitMQ 的配置，以下是修改步骤：
   - 找到 RabbitMQ 的安装目录，以 rabbitmq-server-3.10.7 为例；
   - 在 `\rabbitmq_server-3.10.7\etc` 下有个 README.txt 文件，通过文件指引找到"真正"的 RabbitMQ；
   - 在 `C:\Users%USERNAME%\AppData\Roaming\RabbitMQ` 目录下新建一个配置文件：`rabbitmq.config`，并写入：
     ```json
     [{rabbit, [{loopback_users, []}]}].
     ```
   - 保存并退出；
   - 重启 RabbitMQ 服务：
     - win 键+R 输入 cmd，打开命令行窗口；
     - 输入以下命令打开电脑服务：
       ```bash
       SERVICES.MSC
       ```
     - 找到 RabbitMQ 单击并点击重启动此服务；
4. 测试机需联网并且与服务器的 ip 地址需要相同；
5. 库实现依赖 buffer、stream、events 等 node 模块，需配置 polyfill 后才能通过编译；
6. 编译并安装 hap 包到测试机即可进行用例测试；
7. 具体使用 demo 请参考开源库 sample 页面的实现；

### 示例代码

#### 1. 默认交换机

```typescript
receive(console: Console.Model) {
    if (this.rabbit) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.default();
    let hello = exchange.queue({ name: 'hello_jackrabbit', prefetch: 0 });
    let onMessage=(data:ESObject)=> {
      console.log('received:%s', data);
    }
    hello.consume(onMessage, { noAck: true });
    this.rabbit = rabbit;
    console.info('start receiver');
  }
```

```typescript
send(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.default();
    let hello = exchange.queue({ name: 'hello_jackrabbit' });

    exchange.publish('Hello World!', { key: 'hello_jackrabbit' });
    exchange.on('drain', () => {
      console.info('Message sent: Hello World!')
      setTimeout(() => {
        rabbit.close();
      }, 100);
    });
  }
```

#### 2. 直连交换机

```typescript
receiveEnglish(console: Console.Model) {
    if (this.rabbitEnglish) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.default();
    let hello = exchange.queue({ name: 'task_queue', durable: true });

    hello.consume(onGreet);

    let onGreet=(data:ESObject, ack:ESObject)=> {
      console.log('Hello, ' + data.name + '!');
      ack();
    }

    this.rabbitEnglish = rabbit;
    console.info('start English receiver');
  }
```

```typescript
publish(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.default();
    let hello = exchange.queue({ name: 'task_queue', durable: true });

    exchange.publish({ name: 'Hunter' }, { key: 'task_queue' });
    exchange.on('drain', () => {
      console.info('Message sent: Hunter');
      setTimeout(() => {
        rabbit.close();
      }, 100);
    });
  }
```

#### 3. 扇形交换机

```typescript
receive(console: Console.Model) {
    if (this.rabbit) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.fanout();
    let logs = exchange.queue({ exclusive: true });

    logs.consume(onLog, { noAck: true });
    // logs.consume(false); // stops consuming

    let onLog=(data:ESObject)=> {
      console.log('Received log:' + data);
    }

    this.rabbit = rabbit;
    console.info('start receiver');
  }
```

```typescript
send(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.fanout();

    exchange.publish('this is a log');
    exchange.on('drain', () => {
      console.info('Message sent: this is a log');
      setTimeout(() => {
        rabbit.close();
      }, 100);
    });
  }
```

#### 4. 多队列匹配

```typescript
receive(console: Console.Model) {
    if (this.rabbit) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.direct('direct_logs_jackrabbit');
    let errors = exchange.queue({ exclusive: true, key: 'error' });
    let logs = exchange.queue({ exclusive: true, keys: ['info', 'warning'] });
    let toDisk = (data:ESObject, ack:ESObject)=> {
      console.log('Writing to disk:' + data.text);
      ack();
    }

    let toConsole=(data:ESObject, ack:ESObject)=> {
      console.log('Writing to console:' + data.text);
      ack();
    }

    errors.consume(toDisk);
    logs.consume(toConsole);


    this.rabbit = rabbit;
    console.info('start receiver');
  }
```

```typescript
send(console: Console.Model) {
    var rabbit = jackrabbit('amqp://' + this.serverIp);
    var exchange = rabbit.direct('direct_logs_jackrabbit');

    exchange.publish({ text: 'this is a harmless log' }, { key: 'info' });
    exchange.publish({ text: 'this one is more important' }, { key: 'warning' });
    exchange.publish({ text: 'pay attention to me!' }, { key: 'error' });
    exchange.on('drain', () => {
      console.info('Message sent.');
      setTimeout(() => {
        rabbit.close();
      }, 100);
    });
  }
```

#### 5. 主题交换机

```typescript
receive(console: Console.Model) {
    if (this.rabbit) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.topic('topic_animals');
    let first=(data:ESObject, ack:ESObject)=> {
      console.log('First:' + data.text);
      ack();
    }

    let second=(data:ESObject, ack:ESObject)=> {
      console.log('Second:' + data.text);
      ack();
    }

    exchange
      .queue({ exclusive: true, key: '*.orange.*' })
      .consume(first);

    exchange
      .queue({ exclusive: true, keys: ['*.*.rabbit', 'lazy.#'] })
      .consume(second);


    this.rabbit = rabbit;
    console.info('start receiver');
  }
```

```typescript
send(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    let exchange = rabbit.topic('topic_animals');

    exchange
      .publish({ text: 'both queues 1' }, { key: 'quick.orange.rabbit' })
      .publish({ text: 'both queues 2' }, { key: 'lazy.orange.elephant' })
      .publish({ text: 'first queue 1' }, { key: 'quick.orange.fox' })
      .publish({ text: 'second queue 1' }, { key: 'lazy.brown.fox' })
      .publish({ text: 'second queue 2' }, { key: 'lazy.pink.rabbit' })
      .publish({ text: 'discarded' }, { key: 'quick.brown.fox' })
      .publish({ text: 'discarded' }, { key: 'orange' })
      .publish({ text: 'second queue 3' }, { key: 'lazy.orange.male.rabbit' })
      .on('drain', () => {
        console.info('Message sent.');
        setTimeout(() => {
          rabbit.close();
        }, 100);
      });
  }
```

#### 6. 一对一连接

```typescript
startServer(console: Console.Model) {
    if (this.rabbitServer) {
      return;
    }
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    const exchange = rabbit.default();
    const rpc = exchange.queue({ name: 'rpc_queue_jackrabbit', prefetch: 1, durable: false });

    const fib = (n) => {
      if (n === 0) {
        return 0;
      }

      if (n === 1) {
        return 1;
      }
      return fib(n - 1) + fib(n - 2);
    };

    const onRequest = (data:ESObject, reply:ESObject) => {
      console.log('got request for n:' + data.n);
      if (data.n > 30) {
        console.warn(`fib(${data.n}) may costs too mush time on device, replace to fib(30)`)
        data.n = 30;
      }
      reply({ result: fib(data.n) });
    };

    rpc.consume(onRequest);

    this.rabbitServer = rabbit;
    console.info('start rpc server');
  }
```

```typescript
startClient(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    const exchange = rabbit.default();
    const rpc = exchange.queue({ name: 'rpc_queue_jackrabbit', prefetch: 1, durable: false });

    const onReply = (data:ESObject) => {
      console.log('result:' + data.result);
      rabbit.close();
    };
    rpc.on('ready', () => {
      exchange.publish({ n: 30 }, {
        key: 'rpc_queue_jackrabbit',
        reply: onReply // auto sends necessary info so the reply can come to the exclusive reply-to queue for this rabbit instance
      });
    });
    console.info('Request fib(30), wait for reply.');
  }
```

#### 7. 超时检查

```typescript
startClientTimeout(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    const exchange = rabbit.default();

    exchange.rpcClient('rpc_queue_jackrabbit_timeout', { n: 30 }, { timeout: 1000 }, (result) => {
      if (result && result instanceof Error) {
        console.error(result.toString());
      } else {
        console.info(result);
      }
    });
    console.info('Request fib(30), wait for reply(with 1s timeout).');
  }
```

```typescript
startClient(console: Console.Model) {
    let rabbit = jackrabbit('amqp://' + this.serverIp);
    const exchange = rabbit.default();

    // ensure queue is ready before sending out request
    const rpc = exchange.queue({ name: 'rpc_queue_jackrabbit_timeout', prefetch: 1, durable: false, autoDelete: true });
    rpc.on('ready', () => {

      exchange.rpcClient('rpc_queue_jackrabbit_timeout', { n: 30 }, null, (result) => {
        if (result && result instanceof Error) {
          console.error(result.toString());
        } else {
          console.info(result);
        }
      });
    });
    console.info('Request fib(30), wait for reply.');
  }
```

## 接口说明

```typescript
let rabbit = jackrabbit('amqp://' + this.serverIp);
const exchange = rabbit.default();
let hello = exchange.queue({ name: 'task_queue', durable: true });
exchange.publish('Hello World!', { key: 'hello_jackrabbit' });
```

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| `jackrabbit(url: string)` | url: url 地址 | 创建 连接实例 |
| `rabbit.default()` | - | 获取默认的直连交换机实例 |
| `exchange.queue(option: Object)` | option: 队列配置选项<br>(name: 队列名称，durable: 队列是否持久化) | 创建队列并自动绑定到当前交换机 |
| `exchange.publish(message: any, options: Object)` | message: 要发送的消息内容<br>options: 发布选项 (key: 路由键) | 发布消息 |

## 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 jackrabbit 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/jackrabbit
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)
- DevEco Studio 版本：4.1 Canary(4.1.3.317) OpenHarmony SDK:API11 (4.1.0.36)
- IDE：DevEco Studio Next ,Developer Beta1(5.0.3.121),SDK:API12 (5.0.0.16)

## 目录结构

```text
|---- Jackrabbit
|     |---- amqplib  # amqplib 库文件夹
|           |---- ets
|                 |---- lib  # 主要依赖
|                 |---- types  # 对外接口文件夹
|                 |---- callback_api.js  # callback 回调脚本
|                 |---- channel_api.js  # promise 回调脚本
|     |---- entry  # 示例代码文件夹
|     |---- library  # Jackrabbit 库文件夹
|           |----ets    
|                 |---- compat  # 兼容工具文件夹
|                 |---- node_modules  # 依赖 amqplib 库
|                 |---- types  # 对外接口文件夹
|                 |---- exchange.js  # 交换机脚本
|                 |---- jackrabbit.js  # jackrabbit 脚本
|                 |---- queue.js  # 队列脚本
|     |---- screenshot  # 效果展示截图
|     |---- README.md  # 安装使用方法
```

## 开源协议

MIT LICENSE

## 更新记录

### V2.0.2

Release the official version 2.0.2

### V2.0.1

在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66) 上验证通过

### V2.0.1-rc.0

修改 amqplib 源码引用的方式，采用 ohpm 仓库依赖的方式使用

### v2.0.0

- 适配 DevEco Studio 版本：4.1 Canary(4.1.3.317), OpenHarmony SDK:API11 (4.1.0.36)
- ArkTs 新语法适配

### v1.0.1

适配 DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）

### v1.0.0

已实现功能：
- 发布消息
- 消费消息
- 交换机配置：默认交换机、直连交换机、扇形交换机、主题交换机
- 多队列匹配
- 一对一连接
- 超时检查

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/jackrabbit
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/98cc1b0372f74ce48819bd88d9136237/PLATFORM?origin=template