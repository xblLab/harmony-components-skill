# Polka 网络框架组件

## 简介

Polka 是一个极其简洁、高性能的 Express.js 替代方案。在提供了 HTTP 服务器功能之外，增加了对路由、中间件和子应用程序的支持。

## 详细介绍

### 简介

Polka 是一个极其简洁、高性能的 Express.js 替代方案。在提供了 HTTP 服务器功能之外，增加了对路由、中间件和子应用程序的支持。

本项目为基于开源库 Polka 进行 OpenHarmony 的移植版本：

### 一、基础特性

- 提供 HTTP 1.1 支持。
- 没有固定的配置文件、日志记录、授权等。
- 对 cookies 的基本支持。
- 支持 GET、POST 方法的参数解析。
- 一些内置对 HEAD、POST 和 DELETE 等请求的支持。
- 支持文件上传。
- 不缓存任何东西。
- 默认情况下不限制带宽、请求时间或同时连接数。
- 所有标题名称均转换为小写，因此它们在浏览器/客户端之间不会发生变化。
- 持久连接（连接“保持活动”）支持通过单个套接字连接来处理多个请求。

### 二、静态文件服务器

- 支持动态内容和文件服务。
- 文件服务器支持目录列表，index.html 以及 index.htm。
- 文件服务器支持部分内容（流式传输和继续下载）。
- 文件服务器支持 ETags。
- 文件服务器对没有的目录执行 301 重定向技巧/。
- 包含最常见的 MIME 类型的内置列表。

## 下载安装

```bash
ohpm install @ohos/polka
```

## 需要权限

```text
ohos.permission.INTERNET
```

## 使用说明

### 在 pages 页面中使用

```typescript
import polka, { IncomingMessage, ServerResponse, statik, Request } from '@ohos/polka';

const app = new polka();

interface SelfRequest extends Request {
  hello: string;
  foo: string;
}

function one(req: SelfRequest, res: ServerResponse, next) {
    req.hello = 'world';
    next();
}

function two(req: SelfRequest, res: ServerResponse, next) {
    req.foo = '...needs better demo';
    next();
}

app
  .use(one, two)
  .get('/users', (req: SelfRequest, res: ServerResponse) => {
    res.end(`User: ${req.params.id}`);
  })
  .get('/get-params', (req: IncomingMessage, res: ServerResponse) => {
    res.end(`User: ${req.params.id}`);
  })
  .post('/post-params', (req: IncomingMessage, res: ServerResponse) => {
    res.end(`User: ${req.params.id}`);
  })
  // 通过 get 发送 upload 接口，获取上传文件的 html 结果，用户可通过该界面进行文件上传
  .get('/upload', (req: IncomingMessage, res: ServerResponse) => {
    res.writeHead(200, {
      'Content-Type': statik.mime.getType('.html'),
    });
    res.end(fileUploadHtml);
  })
  // 通过 post 发送 upload 接口，文件上传
  .post('/upload', (req: IncomingMessage, res: ServerResponse) => {
    let keys = Array.from(req.files.keys());
    // 获取上传文件内容长度
    let bufLength = req.files.get(keys[0]).buffer.byteLength;
    // writeLength 后台新建文件内容长度
    let writeLength =
      createFile(context.filesDir, req.parameters.get(keys[0])[0], req.files.get(keys[0]).buffer);
    if (bufLength === writeLength) {
      res.writeHead(200, {
        'Content-Type': 'text/plain',
      });
      res.end('upload success!');
    } else {
      res.writeHead(200, {
        'Content-Type': 'text/plain',
      });
      res.end('upload failure!');
    }
  })
  .listen(3000, () => {
    console.log(`> Running on localhost:3000`);
  });
  
// 当 polka().listen() 执行后，服务开启，server 属性会被同步更新，server.stop() 则用来关闭当前服务
app.server?.stop();

export const fileUploadHtml = `
<html>
 <body>
  <p>This is a file upload test for NanoHTTPD.</p>
   <form action="/upload" enctype="multipart/form-data" method="post" id="test_form">
    <label for="file">File:</label>
       <input type="file" id="datafile1" name="file" size="40"><br>
       <input type="hidden" name="time" id='time' value=''><br>
       <button type="button" onclick='doSubmitForm()'>提交</button>
   </form>
   <br>
   <button onclick="test()">test</button>
   <script>

   function doSubmitForm(){
      let form = document.getElementById('test_form');
      let time = document.getElementById('time');
      time.value = new Date().getTime();
      form.submit();
  }
   function test() {
      const time1 = new Date().getTime();
      alert('testinner');
      // 请求的网址
      let url = 'http://172.20.10.10:9990/post-params';
      // 发起请求
      let _fetch = fetch(url, {method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'}, body: 'id=1&name=zhangsan&age=23}'}).then(function (response) {
          // response.status 表示响应的 http 状态码
          alert('response.status === ' + response.status);
          const time2 = new Date().getTime();
          const time = time2 - time1;
          alert(time + 'ms');
          if (response.status === 200) {
            // json 是返回的 response 提供的一个方法，
            // 会把返回的 json 字符串反序列化成对象，也被包装成一个 Promise 了
            return response.text();
          }
      });
      _fetch.then(function(e){
        alert(e);
      })
    }
   </script>
 </body>
</html>`
```

### 使用场景说明

#### get('/get-params', (req: IncomingMessage, res: ServerResponse) => {})
使用 get 请求方式，获取接口'get-params'下的数据时，使用 req.parameters 直接获取请求体信息。

#### post('/post-params', (req: IncomingMessage, res: ServerResponse) => {})
使用 post 请求方式，获取接口'post-params'下的数据时，在请求头中解析出来的 contentType 为'application/x-www-form-urlencoded'或者'application/json'时，使用 req.parameters 获取请求体信息。若解析出来的的 contentType 为'multipart/form-data'，使用 req.parameters.get(keys[0])[0] 获取文件名，req.files.get(keys[0]).buffer 获取文件内容。

## 接口说明

### 一、API

#### 1、polka(options)

options 对应的字段参数功能，返回 polka 实例
- options.server：调用 polka.listen() 时使用的服务器实例
- options.onError：一个捕获所有错误的处理程序；每当中间件抛出一个错误时执行
- options.onNoMatch：没有匹配的路由定义时的处理程序

#### 2、use(base, ...fn)

将中间件或子应用程序注册到服务器，它们将在路由处理器之前执行
- base -- 类型：String，默认值：undefined，中间件或子应用程序应挂载的基本路径
- fn -- 类型：Function 或 Array，一次可以传递一个或多个函数。每个函数都必须有标准化的（req,res,next）签名

#### 3、parse(req) 解析给定请求的'req.url'属性

返回：对象或 undefined

#### 4、listen() 直接返回当前的 Polka 实例，允许链式操作

返回：Polka

#### 5、handler(req, res, parsed) 主要的 Polka IncomingMessage 处理程序。它接收所有请求，并尝试将传入的 URL 与已知路由进行匹配

**req 类型：IncomingMessage。**

**内置属性**
- socket：储存网络服务器的 socket 信息
- uri：请求 URI
- method：请求方法
- headers：请求头信息
- cookies：cookies 信息
- url：存储 URL
- path：存储路径
- parameters：请求参数
- queryParameterString：查询参数字符串
- files：文件信息

**接口说明：**

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| getParameters() | | 获取 parameters 中参数列表 |
| getQueryParameterString() | | 获取查询参数字符串 |
| getRemoteIpAddress() | | 提供 socket 客户端返回 Ip 地址 |
| getCookies() | | 获取请求头中 cookie 信息 |
| getUri() | | 获取 header 中包含的 uri 信息 |
| getHeaders() | | 获取 headers 对象 |
| getParms() | | 获取参数列表 |
| getMethod() | | 获取请求类型的方法 |
| getInputStream() | | 获取 socket 字符串 |
| execute() | client 客户端的 TCP 连接 bufferPool 缓冲池解析 HTTP 请求头 | |
| parseBody() | files 用于存储文件的 Map callback 解析完成后的回调函解析请求体，处理 POST 和 PUT 方法中的数据 | |

**res 类型：ServerResponse。**

**内置属性**
- statusCode：状态值
- statusMessage：状态信息
- writableEnded：是否调用了 end() 方法
- writableFinished：是否调用了 client.send() 方法
- headersSent：是否已在响应中发送标头信息

**接口说明**

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| writeHead() | | 输出响应头 |
| addCookieHeader() | | 添加 Set-Cookie 信息 |
| setHeader(name, value) | name 字段的值为 value 设置响应头 | |
| setHeaders(headersMap) | 参数可以为 Map 对象设置响应头 | |
| getHeader(name) | name 为头部 key 值获取 header 中 name 字段的 value | |
| hasHeader(name) | name 为头部 key 值检查 header 中是否包含 name 字段 | |
| getHeaderNames() | | 获取 header 中的所有 name 字段 |
| removeHeader(name) | name 为头部 key 值从 header 中删除 name 字段 | |
| getHeaders() | | 获取整个 header 信息 |
| end() | client 客户端的 TCP 连接 bufferPool 缓冲池发送所有响应标头和正文 | |

**parsed，类型：object。** 可选地提供一个解析的 URL 对象。如果您已经解析了传入路径，则很有用。否则，app.parse（又名 parseurl）将默认运行

### 二、路由

用于定义应用程序如何响应不同的 HTTP 方法和 URL。每个路由都由一个路径模式、一个 HTTP 方法和一个处理程序（即要执行的操作）组成。

```typescript
app.METHOD(pattern, handler);
```

- app 是 polka 的实列
- METHOD 是任何有效的 HTTP/1.1 方法，需小写
- pattern 是路由模式（字符串）
- handler 是匹配模式时要执行的函数

```typescript
import polka, { IncomingMessage, ServerResponse, statik, Request } from '@ohos/polka';

const app = polka();

app.get('/', (req, res) => { 
    res.end('Hello world!'); 
});

app.post('/users', (req, res) => {
    res.end('Create a new User!');
});
```

### 三、中间件

在接收请求和执行路由的处理程序响应之间运行的函数。中间件参数接收请求（req）、响应（res）和回调（next）

```typescript
// Log every request
function logger(req, res, next) {
  console.log(`~> Received ${req.method} on ${req.url}`);
  next(); // move on
}

function authorize(req, res, next) {
  // mutate req; available later
  req.token = req.headers['authorization'];
  req.token ? next() : ((res.statusCode=401) && res.end('No token!'));
}

polka().use(logger, authorize).get('*', (req, res) => {
  console.log(`~> user token: ${req.token}`);
  res.end('Hello, valid user');
});
```

### 四、文件服务器（node-static）

```typescript
// Create a node-static server instance to serve the './public' folder

import polka, { IncomingMessage, ServerResponse, statik, Request } from '@ohos/polka';

const app = polka();

const file = new statik.Server(context, '/');
const dir = new statik.Server(context, '/', { gzip: true });

app
.use((req, res, next) => {
  dir.serve(req, res, function (e) {
    if (e && (e.status === 404)) {
      next();
    }
  });
})
.get('/file', (req: IncomingMessage, res: ServerResponse) => {
  file.serveFile(
    '/file.txt', 200, {}, req, res
  );
})
.get('/upload', (req: IncomingMessage, res: ServerResponse) => {
  res.writeHead(200, {
    'Content-Type': statik.mime.getType('.html')
  });
  res.end(fileUploadHtml);
})
.post('/upload', (req: IncomingMessage, res: ServerResponse) => {
  let keys = Array.from(req.files.keys());
  let bufLength = req.files.get(keys[0]).buffer.byteLength;
  let writeLength = createFile(context.filesDir, req.parameters.get(keys[0])[0], req.files.get(keys[0]).buffer);
  if (bufLength === writeLength) {
    res.writeHead(200, {
      'Content-Type': 'text/plain',
    });
    res.end('upload success!');
  } else {
    res.writeHead(200, {
      'Content-Type': 'text/plain',
    });
    res.end('upload failure!');
  }
})
.listen(9990, '0.0.0.0', () => {
  // ...
});
```

```html
// Client File Upload
 
<form action="/upload" enctype="multipart/form-data" method="post">
  <label for="file">File:</label>
     <input type="file" id="datafile1" name="file" size="40"><br>
  <input type="submit">
 </form>
```

#### 1、接口说明

- 创建文件服务器实例 new statik.Server()
- 在一个特定的目录中提供文件，把它作为第一个参数传递 new statik.Server('/public')
- 可以指定参数 new statik.Server('/public', { gzip: true });
- 服务特定文件 serveFile('/error.html', 500, {}, request, response)

#### 2、new statik.Server('./public', options)，options 参数说明

- options.gzip: 是否启用对发送压缩响应的支持
- options.indexFile: 提供目录时选择自定义索引文件

## 约束与限制

在下述版本验证通过：

- DevEco Studio: (5.0.3.400SP7), SDK: API12(5.0.0.71)

## 目录结构

```text
|---- ohos_polka  
|     |---- entry  # 示例代码文件夹
|     |---- library  # polka 库文件夹
|           |---- index.ts  # 对外接口
|           └─src/main/ets/common/util
|                          |---- event-emitter.ts # 事件触发和事件监听器类
|                          |---- fs.ts # 文件操作类
|                          |---- log.ts # 日志打印相关操作类
|                          |---- util.ts # 公共工具类
|           └─src/main/ets/http/core
|                          ├─content
|                               |---- ContentType.ts  # 基本的 ContentType 类
|                               |---- Cookie.ts  # 基本的 cookie 类
|                               |---- CookieHandler.ts  # 提供对 Cookie 的基本支持
|                          ├─request
|                               |---- BufferPool.ts  # BufferPool 类，继承自 EventEmitter，用于处理数据缓冲
|                               |---- IncomingMessage.ts  # 解析和处理 HTTP 请求类
|                          ├─response
|                               |---- ServerResponse.ts  # 基础的 HTTP 响应类
|                          |---- index.ts # 实现的简单的 http
|                          |---- Server.ts # 继承 NanoHTTPD 的简单服务类
|           └─src/main/ets/node-static
|                          ├─mime
|                               ├─types
|                                   |---- other.ts  # 标准库之外的 mimetype 库
|                                   |---- standard.ts  # 标准的 mimetype 库
|                               |---- index.ts # 提供一个 mimetype 接口类
|                               |---- Mime.ts # 定义 mimetype 扩展映射
|                          ├─node-static
|                               |---- util.js  # 文件服务器的相关工具类
|                          |---- index.js # 提供一个简单的文件服务器
|           └─src/main/ets/polka
|                          ├─regexparam
|                               |---- index.js # 正则处理类
|                          ├─trouter
|                               |---- index.js # 路由处理类
|                          ├─url
|                               |---- index.js # 中解析 url 的工具类
|                          |---- index.js # polka 类
|---- README.md  # 安装使用方法   
```

## 开源协议

This project is licensed under MIT License

## 遗留问题

- 目前不支持 websocket
- 当前不支持手动关闭服务器
- 当前文件上传不支持超过 20MB 的文件 (底座影响，后续 rom 版本会修复)

## 更新记录

### v1.0.4

- docs
  - doc changes  release official version

### v1.0.4-rc.3

- fixes
  - Fix stop() so servers shut down cleanly between runs

### v1.0.4-rc.2

- fixes
  - Fix for large file downloads

### v1.0.4-rc.1

- fixes
  - Fixed the issue of incorrect decoding of Chinese files during transmission

### v1.0.4-rc.0

- fixes
  - Fix the issue of lost characters when decoding params.

### v1.0.3

- docs
  - doc changes

### v1.0.2

- chore
  - fix repository from gitee to gitcode in oh-packaage.json5.

### v1.0.1

- fixes
  - Clean up potential buffer objects and close the close service.

### v1.0.0

- fixes
  - There is a memory leak and the repair buffer cannot be released.
  - Modify repository address.
  - Modify the LICENSE link in the README document.

### v1.0.0-rc.3

- fixes
  - The POST or PUT request is responded twice.

### v1.0.0-rc.2

- fixes
  - Multiple requests sent by the browser are received at the same time.

### v1.0.0-rc.1

- fixes
  - The static server cannot load the front-end packed HTML file.

### v1.0.0-rc.0

- Adapts to polka, implements local HTTP encoding and decoding, and provides the static file server function.

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |

Created with Pixso.

## 应用类型

| 项目 | 内容 |
| :--- | :--- |
| 应用类型 | 应用 |

Created with Pixso.

## 元服务

| 项目 | 内容 |
| :--- | :--- |
| 元服务 | 无 |

Created with Pixso.

## 设备类型

| 项目 | 内容 |
| :--- | :--- |
| 手机 | 手机 |
| 平板 | 平板 |
| PC | PC |

Created with Pixso.

## DevEcoStudio 版本

| 项目 | 内容 |
| :--- | :--- |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @ohos/polka
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d899d46e893d45e3a0f60692528d6024/PLATFORM?origin=template