# HttpClient 通信协议组件

## 简介

HttpClient 是 OpenHarmony 里一个高效执行的 HTTP 客户端，使用它可使您的内容加载更快，并节省您的流量。

## 详细介绍

### HttpClient 简介

HTTP 是现代应用程序通过网络交换数据和媒体的主要方式。httpclient 是 OpenHarmony 里一个高效执行的 HTTP 客户端，使用它可使您的内容加载更快，并节省您的流量。httpclient 以人们耳熟能详的 OKHTTP 为基础，整合 android-async-http，AutobahnAndroid，OkGo 等库的功能特性，致力于在 OpenHarmony 打造一款高效易用，功能齐全的网络请求库。当前版本的 httpclient 依托系统提供的网络请求能力和上传下载能力，在此基础上进行拓展开发，已经实现的功能特性如下所示：

- 支持全局配置调试开关，超时时间，公共请求头和请求参数等，支持链式调用。
- 自定义任务调度器维护任务队列处理同步/异步请求。
- 支持 tag 取消请求。
- 支持设置自定义拦截器。
- 支持重定向。
- 支持客户端解压缩。
- 支持文件上传下载。
- 支持 cookie 管理。
- 支持对请求内容加解密。
- 支持自定义请求。
- 支持身份 authentication。
- 支持证书校验。
- 支持响应缓存。
- 支持请求配置 responseData 属性。
- 支持设置请求优先级。
- 支持证书锁定。
- 支持跳过证书验证

## 下载安装

```bash
ohpm install @ohos/httpclient
```

## 使用说明

API 使用方式变更 (原有的 httpclient 已废弃 )，新的使用方式请参照以下的使用说明。

### 添加网络请求权限

在 entry 的 module.json5 中添加网络请求权限：

```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    },
    {
      "name": "ohos.permission.GET_NETWORK_INFO"
    }
  ]
}
```

### 导入依赖

```typescript
import { HttpClient, TimeUnit } from '@ohos/httpclient';
```

### 获取 HttpClient 对象并配置超时时间

```typescript
this.client = new HttpClient.Builder()
    .setConnectTimeout(10, TimeUnit.SECONDS)
    .setReadTimeout(10, TimeUnit.SECONDS)
    .setWriteTimeout(10, TimeUnit.SECONDS)
    .build();

let status: string = '' // 响应码
let content: string = '' // 响应内容
```

### GET 请求方法示例

```typescript
import { HttpClient, Request, Logger } from '@ohos/httpclient';

// 配置请求参数
let request = new Request.Builder()
    .get("https://postman-echo.com/get?foo1=bar1&foo2=bar2")
    .addHeader("Content-Type", "application/json")
    .params("testKey1", "testValue1")
    .params("testKey2", "testValue2")
    .build();

// 发起请求
this.client.newCall(request).enqueue((result) => {
    if (result) {
        this.status = result.responseCode.toString();
    }
    if (result.result) {
        this.content = result.result;
    } else {
        this.content = JSON.stringify(result);
    }
    Logger.info("onComplete -> Status : " + this.status);
    Logger.info("onComplete -> Content : " + JSON.stringify(this.content));
}, (error) => {
    this.status = error.code.toString();
    this.content = error.data;
    Logger.info("onError -> Error : " + this.content);
});
```

### POST 请求方法示例

```typescript
import { HttpClient, Request, RequestBody, Logger } from '@ohos/httpclient';

let request: Request = new Request.Builder()
    .url("https://1.94.37.200:8080/user/requestBodyPost")
    .post(RequestBody.create(
        {
            "email": "zhang_san@gmail.com",
            "name": "zhang_san"
        },
        new Mime.Builder().contentType('application/json').build().getMime()
    ))
    .ca([this.certData])
    .build();

this.client.newCall(request).execute().then((result) => {
    if (result) {
        this.status = result.responseCode.toString();
    }
    if (result.result) {
        this.content = result.result;
    } else {
        this.content = JSON.stringify(result);
    }
    Logger.info("onComplete -> Status : " + this.status);
    Logger.info("onComplete -> Content : " + JSON.stringify(this.content));
}).catch((error) => {
    this.status = error.code.toString();
    this.content = error.data;
    Logger.error("onError -> Error : " + this.content);
});
```

### POST 请求方法带两个参数示例

```typescript
import { HttpClient, Request, RequestBody, Mime, Logger } from '@ohos/httpclient';

let request = new Request.Builder()
    .url("https://postman-echo.com/post")
    .post(RequestBody.create({
        a: 'a1', b: 'b1'
    }, new Mime.Builder()
        .contentType('application/json', 'charset', 'utf8').build().getMime()))
    .build();

// 发起同步请求
this.client.newCall(request).execute().then((result) => {
    if (result) {
        this.status = result.responseCode.toString();
    }
    if (result.result) {
        this.content = result.result;
    } else {
        this.content = JSON.stringify(result);
    }
    Logger.info("onComplete -> Status : " + this.status);
    Logger.info("onComplete -> Content : " + JSON.stringify(this.content));
}).catch((error) => {
    this.status = error.code.toString();
    this.content = error.data;
    Logger.error("onError -> Error : " + this.content);
});
```

### POST 请求方法使用 FormEncoder 示例

```typescript
import { HttpClient, Request, FormEncoder, Logger } from '@ohos/httpclient';

let formEncoder = new FormEncoder.Builder()
    .add("email", "zhang_san@gmail.com")
    .add("name", "zhang_san")
    .build();

let feBody = formEncoder.createRequestBody();
let request: Request = new Request.Builder()
    .url("https://1.94.37.200:8080/user/requestParamPost")
    // 发送表单请求的时候，请配置 header 的 Content-Type 值为 application/x-www-form-urlencoded
    .addHeader("Content-Type", "application/x-www-form-urlencoded")
    .post(feBody)
    .ca([this.certData])
    .build();

this.client.newCall(request).execute().then((result) => {
    if (result) {
        this.status = result.responseCode.toString();
    }
    if (result.result) {
        this.content = result.result;
    } else {
        this.content = JSON.stringify(result);
    }
    Logger.info("onComplete -> Status : " + this.status);
    Logger.info("onComplete -> Content : " + JSON.stringify(this.content));
}).catch((error) => {
    this.status = error.code.toString();
    this.content = error.data;
    Logger.error("onError -> Error : " + this.content);
});
```

## 接口说明

### Request.Builder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| setAbilityContext | abilityContext | Request.Builder | 设置上下文，用于上传下载的参数 |
| convertor | convertorType | Request.Builder | 设置转换器类型，用于将响应结果解析转换为需要的类型 |
| setCookieJar | cookieJar | Request.Builder | 设置 cookieJar，用于自动获取缓存的 cookie，并自动设置给请求头 |
| setCookieManager | cookieManager | Request.Builder | 设置 cookie 管理器，用于设置 cookie 策略 |
| retryOnConnectionFailure | isRetryOnConnectionFailure | Request.Builder | 设置当前请求失败是否重试 |
| retryMaxLimit | maxValue | Request.Builder | 设置当前请求可以重试的最大次数 |
| retryConnectionCount | count | Request.Builder | 设置当前请求当前已经重试次数 |
| followRedirects | FollowRedirects | Request.Builder | 设置当前请求是否是允许重定向 |
| redirectMaxLimit | maxValue | Request.Builder | 设置当前请求可以重定向的最大次数 |
| redirectionCount | count | Request.Builder | 设置当前请求当前已经重定向次数 |
| addInterceptor | req, resp | Request.Builder | 添加拦截器，req 参数是请求拦截器，resp 是响应拦截器。本方法允许多次调用添加多个拦截器。参数允许为空。 |
| headers | value | Request.Builder | 当前请求设置请求头 |
| cache | value | Request.Builder | 设置当前请求开启缓存 |
| addHeader | key, value | Request.Builder | 当前请求的请求头添加参数 |
| setDefaultUserAgent | value | Request.Builder | 当前请求设置默认的用户代理，它是一个特殊字符串头，使得服务器能够识别客户使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件等。 |
| setDefaultContentType | value | Request.Builder | 当前请求设置默认的媒体类型信息。 |
| body | value | Request.Builder | 当前请求设置请求体 |
| url | value | Request.Builder | 当前请求设置请求地址 |
| tag | value | Request.Builder | 当前请求设置标签，用于取消请求 |
| method | value | Request.Builder | 当前请求设置请求请求方式 |
| params | key, value | Request.Builder | 当前请求设置请求参数，用于拼接在请求路径 url 后面 |
| addFileParams | files, data | Request.Builder | 当前请求添加文件上传参数 |
| setFileName | name | Request.Builder | 当前请求设置文件名，用于下载请求 |
| get | url | Request.Builder | 当前请求的请求方式设置为 GET，如果参数 url 不为空则还需为 request 设置请求路径 url |
| put | body | Request.Builder | 当前请求的请求方式设置为 PUT，如果参数 body 不为空则还需为 request 设置请求体 body |
| delete | 暂无 | Request.Builder | 当前请求的请求方式设置为 DELETE |
| head | 暂无 | Request.Builder | 当前请求的请求方式设置为 HEAD |
| options | 暂无 | Request.Builder | 当前请求的请求方式设置为 OPTIONS |
| post | body | Request.Builder | 当前请求的请求方式设置为 POST，如果参数 body 不为空则还需为 request 设置请求体 body |
| upload | files, data | Request.Builder | 当前请求的请求方式设置为 UPLOAD，同时设置文件列表参数 files 和额外参数 data |
| download | url, filename | Request.Builder | 当前请求的请求方式设置为 DOWNLOAD，如果参数 filename 不为空则还需为 request 设置文件名 filename |
| trace | 暂无 | Request.Builder | 当前请求的请求方式设置为 TRACE |
| connect | 暂无 | Request.Builder | 当前请求的请求方式设置为 CONNECT |
| setDefaultConfig | defaultConfig | Request.Builder | 当前请求添加默认配置，主要包括设置默认的 content_type 和 user_agent，可以通过传入一个 json 文件的方式来全局配置 |
| build | 暂无 | Request.Builder | 当前请求根据设置的各种参数构建一个 request 请求对象 |
| setEntryObj | value, flag | Request.Builder | 设置自定义请求对象，第一个参数是自定义实体空对象，第二个参数异步请求需要传入 true 用来表示是自定义请求，同步可不传，默认为 false |
| setHttpDataType | HttpDataType | Request.Builder | 返回设置响应的数据类型，未设置该属性时，默认返回 string 数据类型。 |
| setPriority | number | Request.Builder | 当前请求设置优先级 |
| skipRemoteValidation | boolean | Request.Builder | 当前请求设置是否跳过证书验证，默认为 false |

### HttpClient.Builder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| addInterceptor | aInterceptor | HttpClient.Builder | 为 HTTP 请求客户端添加拦截器，用于在发起请求之前或者获取到相应数据之后进行某些特殊操作 |
| authenticator | aAuthenticator | HttpClient.Builder | 为 HTTP 请求客户端添加身份 authentication，可以在请求头中添加账号密码等信息。 |
| setConnectTimeout | timeout, unit | HttpClient.Builder | 为 HTTP 请求客户端设置连接超时时间 |
| setReadTimeout | timeout, unit | HttpClient.Builder | 为 HTTP 请求客户端设置读取超时时间 |
| setWriteTimeout | timeout, unit | HttpClient.Builder | 为 HTTP 请求客户端设置写入超时时间 |
| _setTimeOut | timeout, timeUnit, timeoutType | HttpClient.Builder | 为 HTTP 请求客户端设置超时时间，根据 timeoutType 来区分是连接超时时间还是读取超时时间或者是写入超时时间。 |
| build | 暂无 | HttpClient.Builder | 构建 HTTP 请求客户端对象 |
| dns | dns: Dns | HttpClient.Builder | 设置自定义 DNS 解析 |
| addEventListener | EventListener | HttpClient.Builder | 添加网络事件监听 |
| setProxy | type, host, port | HttpClient.Builder | - |

### HttpCall

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getRequest | 暂无 | Request | 获取当前请求任务的请求对象 |
| getClient | 暂无 | HttpClient | 获取当前请求任务的请求客户端 |
| execute | 暂无 | Promise | 当前请求任务发起同步请求 |
| enqueue | 暂无 | 暂无 | 当前请求任务发起异步请求 |
| getSuccessCallback | 暂无 | Callback | 获取当前请求任务的请求成功回调接口 |
| getFailureCallback | 暂无 | Callback | 获取当前请求任务的请求失败回调接口 |
| cancel | 暂无 | 暂无 | 取消当前请求任务 |
| isCancelled | 暂无 | Boolean | 获取当前请求任务是否成功取消了 |
| executed | 暂无 | Promise | 当前自定义请求任务发起同步请求 |
| checkCertificateX509TrustManager | 暂无 | HttpCall | 设置自定义证书校验函数 |
| setCertificatePinner | certificatePinner | HttpCall | 设置证书锁定 |

### X509TrustManager

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| checkClientTrusted | cert: Framework.X509Cert | void | 校验客户端证书 |
| checkServerTrusted | cert: Framework.X509Cert | void | 校验服务器证书 |

### WebSocket

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| request | 暂无 | Request | 获取 Request |
| queueSize | 暂无 | number | 获取队列大小 |
| send | text: string ArrayBuffer | Promise | 向服务器发送消息 |
| close | code: number, reason?: string | Promise | 断开连接 |

### WebSocketListener

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| onOpen | webSocket: RealWebSocket, response: string | void | WebSocket 连接成功监听回调 |
| onMessage | webSocket: RealWebSocket, text: string ArrayBuffer | void | WebSocket 服务端响应监听回调 |
| onClosed | webSocket: RealWebSocket, code: number, reason: string | void | WebSocket 连接关闭监听回调 |
| onFailure | webSocket: RealWebSocket, e: Error, response?: string | void | WebSocket 连接失败监听回调 |

### RealWebSocket

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| request | 暂无 | Request | 获取 Request |
| queueSize | 暂无 | number | 获取队列大小 |
| send | text: string ArrayBuffer | Promise | 向服务器发送消息 |
| close | code: number, reason?: string | Promise | 断开连接 |

### RequestBody

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| create | content: String/JSON Object of Key:Value pair | RequestBody | 创建 RequestBody 对象 |

### RequestBuilder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| buildAndExecute | 无 | void | 构建并执行 RequestBuilder |
| newCall | 无 | void | 执行请求 |
| header | name: String, value: String | RequestBuilder | 传入 key、value 构建请求头 |
| connectTimeout | timeout: Long | RequestBuilder | 设置连接超时时间 |
| url | value: String | RequestBuilder | 设置请求 url |
| GET | 无 | RequestBuilder | 构建 GET 请求方法 |
| PUT | body: RequestBody | RequestBuilder | 构建 PUT 请求方法 |
| DELETE | 无 | RequestBuilder | 构建 DELETE 请求方法 |
| POST | 无 | RequestBuilder | 构建 POST 请求方法 |
| UPLOAD | files: Array, data: Array | RequestBuilder | 构建 UPLOAD 请求方法 |
| CONNECT | 无 | RequestBuilder | 构建 CONNECT 请求方法 |

### MimeBuilder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| contentType | value: String | void | 添加 MimeBuilder contentType。 |

### FormEncodingBuilder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| add | name: String, value: String | void | 以键值对形式添加参数 |
| build | 无 | void | 获取 RequestBody 对象 |

### FileUploadBuilder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| addFile | furi: String | void | 添加文件 URI 到参数里用于上传 |
| addData | name: String, value: String | void | 以键值对形式添加请求数据 |
| buildFile | 无 | void | 生成用于上传的文件对象 |
| buildData | 无 | void | 构建用于上传的数据 |

### BinaryFileChunkUploadBuilder

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| addBinaryFile | abilityContext, chunkUploadOptions | void | 添加分片上传配置信息 |
| addData | name: String, value: String | void | 以键值对形式添加请求数据 |
| addUploadCallback | callback | void | 添加上传完成/失败回调 |
| addUploadProgress | uploadProgressCallback | void | 添加上传进度回调 |

### RetryAndFollowUpInterceptor

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| intercept | chain: Chain | Promise | 拦截响应结果 |
| followUpRequest | request: Request, userResponse: Response | Request | 根据请求结果生成重试策略 |
| retryAfter | userResponse: Response, defaultDelay: number | number | 获取响应 header 中的 Retry-After |

### Dns

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| lookup | hostname: String | Promise<Array<connection.NetAddress>> | 自定义 DNS 解析 |

### NetAuthenticator

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| constructor | userName: string, password: string | void | 添加用户名和密码 |
| authenticate | request: Request, response: Response | Request | 对请求头添加身份 authentication 凭证 |

### RealTLSSocket

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| setCaDataByRes | resourceManager: resmgr.ResourceManager, resName: string[], callBack | void | 设置 Ca 证书或者证书链 |
| setCertDataByRes | resourceManager: resmgr.ResourceManager, resName: string, callBack | void | 设置本地数字证书 |
| setKeyDataByRes | resourceManager: resmgr.ResourceManager, resName: string, callBack | void | 设置密钥 |
| setOptions | options: socket.TLSSecureOptions | RealTLSSocket | 设置 tls 连接相关配置 |
| setAddress | ipAddress: string | void | 设置 ip 地址 |
| setPort | port: number | void | 设置端口 |
| bind | callback?: (err, data) => void | void | 绑定端口 |
| connect | callback?: (err, data) => void | void | 建立 tls 连接 |
| send | data, callback?: (err, data) => void | void | 发送数据 |
| getRemoteCertificate | callback: (err, data) => void | void | 获取远程证书 |
| getSignatureAlgorithms | callback: (err, data) => void | void | 获取签名算法 |
| setVerify | isVerify: boolean | void | 设置是否校验证书 |
| verifyCertificate | callback: (err, data) => void | void | 证书校验 |
| setCertificateManager | certificateManager: CertificateManager | void | 自定义证书校验 |

### TLSSocketListener

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| onBind | err: string, data: string | void | 绑定端口监听 |
| onMessage | err: string, data: string | void | 接收消息监听 |
| onConnect | err: string, data: string | void | 连接服务器监听 |
| onClose | err: string, data: string | void | 关闭监听 |
| onError | err: string, data: string | void | 错误监听 |
| onSend | err: string, data: string | void | 发送监听 |
| setExtraOptions | err: string, data: string | void | 设置属性操作监听 |

### CertificateVerify

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| verifyCertificate | callback: (err, data) => void | void | 证书校验 |
| verifyCipherSuite | callback: (err, data) => void | void | 加密套件验证 |
| verifyIpAddress | callback: (err, data) => void | void | 地址校验 |
| verifyProtocol | callback: (err, data) => void | void | 通信协议校验 |
| verifySignatureAlgorithms | callback: (err, data) => void | void | 签名算法校验 |
| verifyTime | callback: (err, data) => void | void | 有效时间校验 |

### Cache

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| constructor | filePath: string, maxSize: number, context: Context | void | 设置 journal 创建的文件地址和大小 |
| key | url: string | string | 返回一个使用 md5 编码后的 url |
| get | request: Request | Response | 根据 request 读取本地缓存的缓存信息 |
| put | response: Response | string | 写入响应体 |
| remove | request: Request | void | 删除当前 request 的响应缓存信息 |
| evictAll | NA | void | 删除全部的响应缓存信息 |
| update | cache: Response, network: Response | void | 更新缓存信息 |
| writeSuccessCount | NA | number | 获取写入成功的计数 |
| size | NA | number | 获取当前缓存的大小 |
| maxSize | NA | number | 获取当前缓存的最大值 |
| flush | NA | void | 刷新缓存 |
| close | NA | void | 关闭缓存 |
| directory | NA | string | 获取当前文件所在的文件地址 |
| trackResponse | cacheStrategy: CacheStrategy.CacheStrategy | void | 设置命中缓存的计数 |
| trackConditionalCacheHit | NA | number | 增加跟踪条件缓存命中 |
| networkCount | NA | number | 添加网络计数 |
| hitCount | NA | number | 获取点击次数 |
| requestCount | NA | number | 获取请求的计数 |

### CacheControl

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| FORCE_NETWORK | NA | CacheControl | 强制请求使用网络请求 |
| FORCE_CACHE | NA | CacheControl | 强制请求使用缓存请求 |
| noCache | NA | boolean | 获取当前请求头或者响应头是否包含禁止缓存的信息 |
| noStore | NA | boolean | 获取当前请求头或者响应头是否包含禁止缓存的信息 |
| maxAgeSeconds | NA | number | 获取缓存的最大的存在时间 |
| sMaxAgeSeconds | NA | number | 获取缓存的最大的存在时间 |
| isPrivate | NA | boolean | 获取是否是私有的请求 |
| isPublic | NA | boolean | 获取是否是公有的请求 |
| mustRevalidate | NA | boolean | 获取是否需要重新验证 |
| maxStaleSeconds | NA | number | 获取最大的持续秒数 |
| minFreshSeconds | NA | number | 最短的刷新时间 |
| onlyIfCached | NA | boolean | 获取是否仅缓存 |
| noTransform | NA | boolean | 没有变化 |
| immutable | NA | boolean | 获取不变的 |
| parse | NA | CacheControl | 根据 header 创建 CacheControl |
| toString | NA | string | 获取缓存控制器转字符串 |
| Builder | NA | Builder | 获取 CacheControl 的 Builder 模式 |
| noCache | NA | Builder | 设置不缓存 |
| noStore | NA | Builder | 设置不缓存 |
| maxAge | maxAge: number | Builder | 设置最大的请求或响应的时效 |
| maxStale | NA | Builder | 设置不缓存 |
| onlyIfCached | NA | Builder | 设置仅缓存 |
| noTransform | NA | Builder | 设置没有变化 |
| immutable | NA | Builder | 设置获取不变的 |
| build | NA | CacheControl | Builder 模式结束返回 CacheControl 对象 |

### gZipUtil

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| gZipString | strvalue: string | Uint8Array | 编码 Uint8Array 数据 |
| ungZipString | value: any | string | 解码字符串 |
| gZipFile | srcFilePath: string, targetFilePath: string | void | 编码文件 |
| ungZipFile | srcFilePath: string, targetFilePath: string | void | 解码文件 |
| stringToUint8Array | str: string | Uint8Array | 字符串转 Uint8Array |

### HttpDataType

指定返回数据的类型。

| 接口名 | 值 | 说明 |
| :--- | :--- | :--- |
| STRING | 0 | 字符串类型。 |
| OBJECT | 1 | 对象类型。 |
| ARRAY_BUFFER | 2 | 二进制数组类型。 |

### CertificatePinnerBuilder

指定证书锁定内容。

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| add | hostname: string, sha: string | CertificatePinnerBuilder | 添加证书锁定参数 |
| build | NA | CertificatePinner | 构造证书锁定实例 |

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806, SDK:API12 Release(5.0.0.66)
- DevEco Studio 版本：4.1 Canary(4.1.3.317), OpenHarmony SDK: API11 (4.1.0.36)
- DevEco Studio 版本：4.1 Canary(4.1.3.319), OpenHarmony SDK: API11 (4.1.3.1)
- DevEco Studio 版本：4.1 Canary(4.1.3.500), OpenHarmony SDK: API11 (4.1.5.6)

## 目录结构

```text
|---- httpclient  
|     |---- entry  # 示例代码文件夹
|     |---- library  # httpclient 库文件夹
            |---- builders  # 请求体构建者模块 主要用于构建不同类型的请求体，例如文件上传，multipart
            |---- cache  # 缓存的事件数据操作模块
            |---- callback  # 响应回调模块，用于将相应结果解析之后转换为常见的几种类型回调给调用者，例如 string,JSON 对象，bytestring
            |---- code  # 响应码模块，服务器返回的响应结果码
            |---- connection  # 路由模块，管理请求中的多路由
            |---- cookies  # cookie 管理模块，主要处理将响应结果解析并根据设置的缓存策略缓存响应头里面的 cookie，取出 cookie，更新 cookie
            |---- core  # 核心模块，主要是从封装的 request 里面解析请求参数和相应结果，调用拦截器，处理错误重试和重定向，dns 解析，调用系统的@ohos.net.http 模块发起请求
            |---- dispatcher  # 任务管理器模块，用于处理同步和异步任务队列
            |---- http  # 判断 http method 类型
            |---- interceptor  # 拦截器模块，链式拦截器处理网络请求
            |---- protocols  # 支持的协议
            |---- response  # 响应结果模块，用于接收服务端返回的结果
            |---- utils  # 工具类，提供 dns 解析，gzip 解压缩，文件名校验，打印日志，获取 URL 的域名或者 IP，双端队列等功能
            |---- HttpCall.ts  # 一个请求任务，分为同步请求和异步请求，封装了请求参数，请求客户端，请求成功和失败的回调，请求是否取消的标志。
            |---- HttpClient.ts  # 请求客户端，用于生成请求任务用于发起请求，设置请求参数，处理 gzip 解压缩，取消请求。
            |---- Interceptor.ts  # 拦截器接口
            |---- Request.ts  # 请求对象，用于封装请求信息，包含请求头和请求体。 
            |---- RequestBody.ts  # 请求体，用于封装请求体信息。
            |---- WebSocket.ts  # websocket 模块回调接口。 
            |---- RealWebSocket.ts  # websocket 模块，用于提供 websocket 支持。 
            |---- WebSocketListener.ts  # websocket 状态监听器。 
            |---- Dns.ts  # 用于自定义自定义 DNS 解析器。 
            |---- CertificatePinner.ts  # 证书锁定类构建器。
            |---- DnsSystem.ts  # 系统默认 DNS 解析器。 
            |---- Route.ts  # 路由。 
            |---- RouteSelector.ts  # 路由选择器。 
            |---- Address.ts  # 请求地址。 
            |---- authenticator  # 身份 authentication 模块，用于提供网络请求 401 之后身份 authentication。 
            |---- tls  # 证书校验模块，用于 tls 的证书解析和校验。 
            |---- enum  # 参数对应的枚举类型。 
            |---- index.ts  # httpclient 对外接口
|     |---- README.MD  # 安装使用方法                   
|     |---- README_zh.MD  # 安装使用方法                   
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给组件，当然，也非常欢迎给组件提 PR。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 2.0.6

Release official version

### 2.0.6-rc.3

Fixed the issue where the domain name did not go through custom DNS resolution after redirection.

### 2.0.6-rc.2

Fixed the issue where asynchronous queue objects are not deleted after the repair request ends.

### 2.0.6-rc.1

Fixed the issue where Delete/Post/Put could not correctly request urls carrying Chinese Params

### 2.0.6-rc.0

- Fixed the issue where delete requests could not carry the body
- Fixed the issue where put requests were actually post requests
- Fixed the issue where the Host in the Header field of post/put requests was constructed incorrectly
- Fixed the issue where Post/Put could not correctly request urls carrying Params

### 2.0.5

Release the official version

### 2.0.5-rc.3

1. Code check compilation build fatal issue modification.

### 2.0.5-rc.2

- Skipping certificate verification is supported
- Fix occasional encoding issues with Chinese characters in response
- Fix the issue of some error logs being missing

### 2.0.5-rc.1

- Fix Failed to post/put binary content after setting certificate or certificate Pinner
- Change the default boundary value of the multipart type to a random value

### 2.0.5-rc.0

修复 tls 请求 chunk 乱码问题

### 2.0.4

适配 crypto-js 2.0.4

### 2.0.3

- 修复 单次请求数据量过大报 response data exceeds the maximum limit
- 在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK:API12 Release(5.0.0.66) 上验证通过

### 2.0.2

- 修复 Transfer-Encoding:chunked 响应数据出现冗余数据
- 修复 Transfer-Encoding:chunked 响应数据丢失情况
- 修复 Request 接口 NewBuilder() 未继承原始 request 属性的问题
- 修复 NewBuilder() 未继承 client 导致丢失超时设置

### 2.0.2-rc.1

修复 Transfer-Encoding:chunked 响应数据出现冗余数据

### 2.0.2-rc.0

- 修复 Transfer-Encoding:chunked 响应数据丢失情况
- 修复 Request 接口 NewBuilder() 未继承原始 request 属性的问题

### 2.0.1

- 修复 chunked 响应体的数据一次返回时，出现数据丢失现象
- 过滤多次块的大小脏数据
- 修复 gZipUtil 工具使用 pako 入参问题

### 2.0.1-rc.9

- 修复 post 请求发送 body 数据包含中文长度不对问题
- 修复部分 post 请求返回数据出现尾部"0"情况
- pako 依赖库升级到 2.1.0
- 修复 chunked 响应体数据 null 的情况
- 过滤响应体出现响应头后块的大小脏数据

### 2.0.1-rc.8

修复上传 ArrayBuffer 过程中字节 00 都变成 20 的问题

### 2.0.1-rc.7

修复 cancelRequestByTag 接口报错问题。

### 2.0.1-rc.6

修复部分 https 请求返回响应体多出几个字符内容问题。

### 2.0.1-rc.5

修复概率性 socket 关闭两次问题。

### 2.0.1-rc.4

修复使用 CryptoJS.MD5() 语法报错问题

### 2.0.1-rc.3

修复请求为 gzip 压缩机制时，返回数据长度计算错误问题。

### 2.0.1-rc.2

修复当数据量过大时，String.fromCharCode.apply() 方法超出调用栈的最大容量而产生崩溃的问题。

### 2.0.1-rc.1

- 修复 post 请求时，部分接口响应的 result 结果为空问题。
- 新增 Logger 开关方法 setDebugSwitch。

### 2.0.1-rc.0

支持使用系统默认的 CA 证书进行通信时进行自定义证书校验。

### 2.0.0

- 修复多个 HttpClient 对象执行多个请求时，拦截器没有和对象的拦截器进行关联，而导致拦截器调用错乱问题。
- 修复服务端返回 401 时，重试 20 次问题。
- 修复 Cookie 日期字符串转化错误问题。

### 2.0.0-rc.9

支持使用系统默认的 CA 证书进行通信，依赖手机 SDK 版本更新。

### 2.0.0-rc.8

修改在 Request.ts 文件中，Builder 构造函数的 url 和 client 属性赋值方式。

### 2.0.0-rc.7

- 修复 https 发送 Post 和 PUT 请求失败问题
- 修复以表单形式形式进行 post 请求服务端无法通过@RequestParams 进解析报文

### 2.0.0-rc.6

- 修复事件监听 DNS 监听失败的问题
- 修复事件监听 callStart 监听传参问题
- 支持 GZIP 返回的数据格式问题
- 修复设置 responseType 属性返回格式问题
- 修改证书锁定功能指纹参数为证书公钥指纹

### 2.0.0-rc.5

- 修复 xts 用例
- 修复设置证书 password 失效的问题
- 增加获取 rawfile 路径下证书的方法

### 2.0.0-rc.4

- 完善自定义证书校验功能，
- 增加 tls 双向证书的 key,cert 的配置
- 修复 socket 通讯中获取端口失败

### 2.0.0-rc.3

完善自定义证书校验功能

### 2.0.0-rc.2

添加自定义证书校验功能

### 2.0.0-rc.0

- 框架优化采用链式拦截器
- 支持网络请求在遇到常见的错误之后自动重新发起请求
- 支持 http2 协议网络请求
- 支持二进制文件分片上传
- 支持自定义 DNS 解析
- 支持 WebSocket 协议请求
- 网络请求身份认证
- tls 证书校验
- 支持响应缓存，缓存当前 get 请求
- 支持解析请求响应为自定义数据类型
- 适配 DevEco Studio 3.1 Beta1 版本
- 优化 API 使用方式
- 适配更新 readme 中约束与限制的版本号，并更新 CHANGELOG 中的版本号
- ArkTs 新语法适配
- Cache 的构造函数由 constructor(filePath: string,maxSize: number) 变更为 constructor(filePath: string,maxSize: number, context: Context)

### 1.0.5

替换 API9 beta 版本废弃的上传下载接口

### 1.0.4

- 适配 DevEco 3.1.0.100
- 修复 Content-Type 设置错误导致请求失败的 BUG

### 1.0.3

文件上传增加文件显示名

### 1.0.2

- stage 模型适配
- API 9 适配
- 修复 multipart 方式参数合并 BUG，修复 cookie 存储 BUG，修复 API9 文件路径出错 BUG

### 1.0.1

httpclient 集成 okio 依赖，并添加相关的示例代码

### 1.0.0

- gradle 项目结构转型为 hvigor 项目结构.
- 项目代码优化以及添加 readme.en.md

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | 应用类型 | 元服务 | 设备类型 | DevEcoStudio 版本 |
| :--- | :--- | :--- | :--- | :--- |
| 5.0.0 | 应用 | - | 手机 | DevEco Studio 5.0.3 |
| - | - | - | 平板 | - |
| - | - | - | PC | - |

## 安装方式

```bash
ohpm install @ohos/httpclient
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/332caa882cdc4618a6567bf059b6b017/PLATFORM?origin=template