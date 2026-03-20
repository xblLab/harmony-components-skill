# axios 网络请求组件

## 简介

Axios，是一个基于 promise 的网络请求库。本库基于 npm Axios 原库进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。

## 详细介绍

### 简介

Axios，是一个基于 promise 的网络请求库，可以运行 node.js 和浏览器中。本库基于 Axios 原库 v1.3.4 版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。

### HTTP 请求

- Promise API
- request 和 response 拦截器
- 转换 request 和 response 的 data 数据
- 自动转换 JSON data 数据

### 下载安装

```bash
ohpm install @ohos/axios
```

### 需要权限

```json5
ohos.permission.INTERNET
```

### 接口和属性列表

#### 接口列表

| 方法 | 参数 | 功能 |
| :--- | :--- | :--- |
| `axios(config)` | config：请求配置 | 发送请求 |
| `axios.create(config)` | config：请求配置 | 创建实例 |
| `axios.request(config)` | config：请求配置 | 发送请求 |
| `axios.get(url[, config])` | url：请求地址<br>config：请求配置 | 发送 get 请求 |
| `axios.delete(url[, config])` | url：请求地址<br>config：请求配置 | 发送 delete 请求 |
| `axios.post(url[, data[, config]])` | url：请求地址<br>data：发送请求体数据<br>config：请求配置 | 发送 post 请求 |
| `axios.put(url[, data[, config]])` | url：请求地址<br>data：发送请求体数据<br>config：请求配置 | 发送 put 请求 |

#### 属性列表

| 属性 | 描述 |
| :--- | :--- |
| `axios.defaults['xxx']` | 默认设置。值为请求配置 config 中的配置项 例如 `axios.defaults.headers` 获取头部信息 |
| `axios.interceptors` | 拦截器。参考 [拦截器](#) 的使用 |

## 使用示例

使用前在 demo 中 `entry-->src-->main-->ets-->common-->Common.ets` 文件中改为正确的服务器地址，在 `entry-->src-->main-->resources-->rawfile` 目录下添加正确的证书，才可正常的使用 demo。

### 发起一个 GET 请求

axios 支持泛型参数，由于 ArkTS 不再支持 any 类型，需指定参数的具体类型。
如：`axios.get<T = any, R = AxiosResponse, D = any>(url)`

- **T**: 是响应数据类型。当发送一个 POST 请求时，客户端可能会收到一个 JSON 对象。T 就是这个 JSON 对象的类型。默认情况下，T 是 any，这意味着可以接收任何类型的数据。
- **R**: 是响应体的类型。当服务器返回一个响应时，响应体通常是一个 JSON 对象。R 就是这个 JSON 对象的类型。默认情况下，R 是 AxiosResponse，这意味着响应体是一个 AxiosResponse 对象，它的 data 属性是 T 类型的。
- **D**: 是请求参数的类型。当发送一个 GET 请求时，可能会在 URL 中添加一些查询参数。D 就是这些查询参数的类型。参数为空情况下，D 是 null 类型。

```typescript
import axios from '@ohos/axios'

interface userInfo {
  id: number
  name: string
  phone: number
}

// 向给定 ID 的用户发起请求
axios.get<userInfo, AxiosResponse<userInfo>, null>('/user?ID=12345')
  .then((response: AxiosResponse<userInfo>) => {
    // 处理成功情况
    console.info("id" + response.data.id)
    console.info(JSON.stringify(response));
  })
  .catch((error: AxiosError) => {
    // 处理错误情况
    console.info(JSON.stringify(error));
  })
  .then(() => {
    // 总是会执行
  });

// 上述请求也可以按以下方式完成（可选）
axios.get<userInfo, AxiosResponse<userInfo>, null>('/user', {
  params: {
    ID: 12345
  }
})
  .then((response: AxiosResponse<userInfo>) => {
    console.info("id" + response.data.id)
    console.info(JSON.stringify(response));
  })
  .catch((error: AxiosError) => {
    console.info(JSON.stringify(error));
  })
  .then(() => {
    // 总是会执行
  });

// 支持 async/await 用法
async function getUser() {
  try {
    const response: AxiosResponse = await axios.get<string, AxiosResponse<string>, null>(this.getUrl);
    console.log(JSON.stringify(response));
  } catch (error) {
    console.error(JSON.stringify(error));
  }
}
```

### 发送一个 POST 请求

```typescript
interface user {
  firstName: string
  lastName: string
}

axios.post<string, AxiosResponse<string>, user>('/user', {
  firstName: 'Fred',
  lastName: 'Flintstone'
})
  .then((response: AxiosResponse<string>) => {
    console.info(JSON.stringify(response));
  })
  .catch((error) => {
    console.info(JSON.stringify(error));
  });
```

### 发起多个并发请求

```typescript
const getUserAccount = (): Promise<AxiosResponse> => {
  return axios.get<string, AxiosResponse<string>, null>('/user/12345');
}

const getUserPermissions = (): Promise<AxiosResponse> => {
  return axios.get<string, AxiosResponse<string>, null>('/user/12345/permissions');
}

Promise.all<AxiosResponse>([getUserAccount(), getUserPermissions()])
  .then((results: AxiosResponse[]) => {
    const acct = results[0].data as string;
    const perm = results[1].data as string;
  });
```

## 使用说明

### axios API

通过向 axios 传递相关配置来创建请求

```typescript
// 发送一个 get 请求
axios<string, AxiosResponse<string>, null>({
  method: "get",
  url: 'https://www.xxx.com/info'
}).then((res: AxiosResponse) => {
  console.info('result:' + JSON.stringify(res.data));
}).catch((error: AxiosError) => {
  console.error(error.message);
})
```

```typescript
// 发送一个 get 请求（默认请求方式）
axios.get<string, AxiosResponse<string>, null>('https://www.xxx.com/info', { params: { key: "value" } })
  .then((response: AxiosResponse) => {
    console.info("result:" + JSON.stringify(response.data));
  })
  .catch((error: AxiosError) => {
    console.error("result:" + error.message);
  });
```

### 请求方法的 别名方式 来创建请求

为方便起见，为所有支持的请求方法提供了别名。

- `axios.request(config)`
- `axios.get(url[, config])`
- `axios.delete(url[, config])`
- `axios.post(url[, data[, config]])`
- `axios.put(url[, data[, config]])`

**注意:**
在使用别名方法时，url、method、data 这些属性都不必在配置中指定。

```typescript
// 发送 get 请求
axios.get<string, AxiosResponse<string>, null>('https://www.xxx.com/info', { params: { key: "value" } })
  .then((response: AxiosResponse) => {
    console.info("result:" + JSON.stringify(response.data));
  })
  .catch((error: AxiosError) => {
    console.error("result:" + error.message);
  });
```

### axios 实例

创建一个实例
您可以使用自定义配置新建一个实例。

```typescript
const instance = axios.create({
  baseURL: 'https://www.xxx.com/info',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});
```

#### 实例方法

- `axios#request(config)`
- `axios#get(url[, config])`
- `axios#delete(url[, config])`
- `axios#post(url[, data[, config]])`
- `axios#put(url[, data[, config]])`

### 请求配置

这些是创建请求时可以用的配置选项。只有 url 是必需的。如果没有指定 method，请求将默认使用 get 方法。

```json5
{
  // `url` 是用于请求的服务器 URL
  url: '/user',
  
  // `method` 是创建请求时使用的方法 支持 post/get/put/delete 方法，不区分大小写，默认为 get 方法
  method: 'get', // default
  
  // `baseURL` 将自动加在 `url` 前面，除非 `url` 是一个完整的 URL。
  // 它可以通过设置一个 `baseURL` 便于为 axios 实例的方法传递相对 URL
  baseURL: 'https://www.xxx.com/info',
  
  // `allowAbsoluteUrls` 决定 absolute url 是否会覆盖配置的 `baseUrl`。
  // 当设置为 true（默认）时，absolute `url` 将覆盖 `baseUrl`。
  // 当设置为 false 时，absolute `url` 将总是以 `baseUrl` 作为前缀。
  allowAbsoluteUrls: true,
  
  // `transformRequest` 允许在向服务器发送前，修改请求数据
  // 它只能用于 'PUT', 'POST' 和 'PATCH' 这几个请求方法
  // 数组中最后一个函数必须返回一个字符串，一个 Buffer 实例，ArrayBuffer，FormData，或 Stream
  // 修改请求头。
  transformRequest: [(data: ESObject, headers: AxiosRequestHeaders) => {
     // 对发送的 data 进行任意转换处理
     return data;
   }],

  // `transformResponse` 在传递给 then/catch 前，允许修改响应数据
  transformResponse: [ (data: ESObject, headers: AxiosResponseHeaders, status?: number)=> {
    // 对接收的 data 进行任意转换处理
    return data;
  }],
  
  // `headers` 是即将被发送的自定义请求头
  headers: {'Content-Type': 'application/json'},
  
  // `params` 是即将与请求一起发送的 URL 参数
  // 必须是一个无格式对象 (plain object)，其它对象如 URLSearchParams，必须使用 paramsSerializer 进行序列化
  params: {
    ID: 12345
  },
  
  // `paramsSerializer` 是一个负责 `params` 序列化的函数
  paramsSerializer: function(params) {
    return params
  },
  
  // `data` 是作为请求主体被发送的数据
  // 只适用于这些请求方法 'PUT', 'POST', 和 'PATCH'
  // 在没有设置 `transformRequest` 时，必须是以下类型之一，其它类型使用 transformRequest 转换处理
  // - string, plain object, ArrayBuffer
  data: {
    firstName: 'Fred'
  },
  
  // 发送请求体数据的可选语法
  // 请求方式 post
  // 只有 value 会被发送，key 则不会
  data: 'Country=Brasil&City=Belo Horizonte',
  
  // `timeout` 指定请求超时的毫秒数 (0 表示无超时时间)
  // 如果请求超过 `timeout` 的时间，请求将被中断
  timeout: 1000,
  // `readTimeout` 指定请求超时的毫秒数 (0 表示无超时时间)
  // 如果请求超过 `readTimeout` 的时间，请求将被中断
  readTimeout: 1000,
  // `connectTimeout` 指定请求连接服务器超时的毫秒数 (0 表示无超时时间)
  // 如果请求连接服务器超过 `connectTimeout` 的时间，请求将被中断
  connectTimeout: 60000,
  // `maxBodyLength`，指定网络请求内容的最大字节数 (-1 表示无最大限制)
  // 如果请求内容的字节数超过 `maxBodyLength`，请求将被中断并抛出异常
  maxBodyLength: 5*1024*1024,
  // `maxContentLength`，指定 HTTP 响应的最大字节数 (-1 表示放开 axios 层限制),默认值为 5*1024*1024，以字节为单位。最大值为 100*1024*1024，以字节为单位
  // 如果响应的最大字节数超过 `maxContentLength`，请求将被中断并抛出异常
  maxContentLength: 5*1024*1024,
  // `adapter` 允许自定义处理请求，这使测试更加容易。
  // 返回一个 promise 并提供一个有效的响应（参见 lib/adapters/README.md）。
  adapter: function (config) {
    /* ... */
  },
  // 如果设置了此参数，系统将使用用户指定路径的 CA 证书，(开发者需保证该路径下 CA 证书的可访问性)，否则将使用系统预设 CA 证书，系统预设 CA 证书位置：/etc/ssl/certs/cacert.pem。证书路径为沙箱映射路径（开发者可通过 Global.getContext().filesDir 获取应用沙箱路径）。
  caPath: '',

  // 客户端证书的 clientCert 字段，包括 4 个属性：
  // 客户端证书（cert）、客户端证书类型（certType）、证书私钥（key）和密码短语（keyPasswd）。certPath 和 keyPath 为证书沙箱映射路径
  clientCert:{
      certPath: '',  // 客户端证书路径
      certType: '',  // 客户端证书类型，包括 pem、der、p12 三种
      keyPath: '',   // 证书私钥路径
      keyPasswd: ''  // 密码短语
  }
  // 自 API 18 开始支持该属性。通过 RemoteValidation 配置使用系统 CA 或跳过验证远程服务器 CA.
  remoteValidation: 'system', // 选项包括'system'和'skip'。system: 表示使用系统 CA 配置验证; skip: 跳过验证远程服务器 CA;如果未设置此字段，系统 CA 将用于验证远程服务器的标识。

  // 优先级，范围 [1,1000]，默认是 1，值越大，优先级越高；
  priority: 1,

  //  `responseType` 指定返回数据的类型，默认无此字段。如果设置了此参数，系统将优先返回指定的类型。
  // 选项包括：string:字符串类型; object:对象类型; array_buffer:二进制数组类型。
  responseType: 'string', 

  //  `proxy`
  // 是否使用 HTTP 代理，默认为 false，不使用代理。
  // 当 proxy 为 AxiosProxyConfig 类型时，使用指定网络代理。
  proxy: {
      host: 'xx', // Host port
      port: xx, // Host port
      exclusionList: [] // Do not use a blocking list for proxy servers
  }
  
  // 使用 AbortController 取消 axios 请求
  signal: new AbortController().signal,
  
  // `onUploadProgress` 允许为上传处理进度事件
  onUploadProgress: function (progressEvent) {
    // 对原生进度事件的处理
  },
  
  // `onDownloadProgress` 允许为下载处理进度事件，下载文件必须设置该事件
  onDownloadProgress: function (progressEvent) {
    // 对原生进度事件的处理
  },
  
  // 基于应用程序的上下文，只适用于上传/下载请求
  context: context,
  
  // 下载路径。此参数，只适用于下载请求，
  // Stage 模型下使用 AbilityContext 类获取文件路径，比如：'${getContext(this).cacheDir}/test.txt’并将文件存储在此路径下
  filePath: context,
}
```

## 约束与限制

在下述版本验证通过：
DevEco Studio: NEXT Developer Beta1(5.0.3.122), SDK: API12(5.0.0.18)

**注意：**
1. 除双向证书验证 (clientCert) 及证书锁定功能必须使用 API 11+、配置使用系统 CA 或跳过验证远程服务器 CA(RemoteValidation) 必须使用 API 18+ 外，其余功能支持 API10
2. signal 属性只能取消尚未真正发出的请求。对于已经发送的请求，调用 abort() 会立即触发错误并进入 .catch()，并通过底层连接中断（destroy()）尝试终止请求，但由于 Network kit 处理机制，无法保证请求被立即停止。

## FAQ

1. 服务器返回多个 cookie，response.header 中只能读取首个 cookie。
   由于该库底层依赖 ohos.net.http 模块，ohos.net.http 也存在此问题，204.1.0.33 镜像版本已修复此问题。
2. 下载文件不会自动创建目录，若下载路径中的目录不存在，则下载失败。如 filePath 为 getContext(this).cacheDir/download/test.txt，download 目录不存在则下载失败。

## 目录结构

```text
|---- axios
|     |---- AppScope  # 示例代码文件夹
|     |---- entry  # 示例代码文件夹
|     |---- screenshots #截图
|     |---- library  # axios 库文件夹
|           |---- build  # axios 模块打包后的文件
|           |---- src  # 模块代码
|                |---- ets/components   # 模块代码
|                     |---- lib         # axios 网络请求核心代码
|            |---- index.js        # 入口文件
|            |---- index.d.ts      # 声明文件
|            |---- *.json5      # 配置文件
|     |---- README.md     # 安装使用方法
|     |---- README_zh.md  # 安装使用方法
|     |---- README.OpenSource  # 开源说明
|     |---- CHANGELOG.md  # 更新日志
```

## 开源协议

本项目遵循 MIT License

## 更新记录

### [v2.2.7] 2026.1

Release the official version

### [v2.2.7-rc.3] 2025.9

Support device national cryptography SSL

### [v2.2.7-rc.2] 2025.09

- Support signal to cancel requests
- Support allowAbsoluteUrls to fix CVE-2025-27152
- axios 新增 delete header 中的字段接口能力
- axios 相关属性适配：usingProtocol、resumeFrom、resumeTo、dnsOverHttps、dnsServers、certificatePinning、addressFamily、tlsOptions、serverAuthentication

### [v2.2.7-rc.1] 2025.07

Support setting proxy username and password

### [v2.2.7-rc.0] 2025.06

Support remoteValidation to configure the use of system CA or skip verification of remote server CA

### [v2.2.6] 2025.04

Fixed file defects caused by the dataend callback

### [v2.2.5] 2025.03

- Release the official version
- Add device types

### [v2.2.5-rc.1] 2025.01

Log rectification

### [v2.2.5-rc.0] 2024.09

toFormData 传入 number 类型时转换为 string

### [v2.2.4] 2024.09

发布正式版本

### [v2.2.4-rc.0] 2024.09

修复响应状态码为 400 时，丢失响应体的问题

### [v2.2.3] 2024.08

发布正式版本

### [v2.2.3-rc.1] 2024.08

删除调试日志

### [v2.2.3-rc.0] 2024.08

- axios 上传文件支持 put 请求
- 删除多余文件，解决开启字节码 har 能力，构建失败问题

### [v2.2.2] 2024.07

AxiosResponse 类型的 performanceTiming 参数修改为可选，兼容 axiosForHttpclient 组件

### [v2.2.1] 2024.07

发布正式版本

### [v2.2.1-rc.2] 2024.05

- 用 requestInstream 重构上传功能，axios 上传文件支持代理、证书验证功能
- 用 requestInstream 重构下载功能，axios 下载文件支持代理、证书验证功能
- 新增 maxContentLength 字段，支持定义 HTTP 响应的最大字节数
- 新增 maxBodyLength 字段，支持定义网络请求内容的最大字节数
- 新增 readTimeout，支持设置读取超时
- 新增 connectTimeout，支持设置连接超时

### [v2.2.1-rc.1] 2024.05

multipart 提交时，支持设置多部分表单数据的数据名称和数据类型类型

### [v2.2.1-rc.0] 2024.04

新增 PerformanceTiming 网络性能监测数据

### [v2.2.0] 2024.02

发布正式版本

### [v2.2.0-rc.4] 2024.02

修复

- 文件上传发送后，先返回了响应空结果，然后开始了上传的进度

### [v2.2.0-rc.3] 2024.01

修复

- 上传文件必须添加 onUploadProgress 事件
- 上传文件为 uri 必须指定文件名
- 上传文件 uri 不存在无错误返回

### [v2.2.0-rc.2] 2023-12

修复

- 更正文档泛型参数解释
- 删除代码中敏感信息
- header 中的 headerName 不支持带数字

### [v2.2.0-rc.1] 2023-12

- 支持证书锁定（API11）
- 修复：由于 OH 参数变更，修改双向校验密码参数

### [v2.2.0-rc.0] 2023-11

- 支持 p12 格式的 CA 证书（API11）
- 支持 pem,p12 格式的客户端证书，实现双向校验（API11）
- 支持设置代理

### [v2.1.1] 2023-11

发布正式版本

### [v2.1.1-rc.0] 2023-11

更新

- 放开系统侧 5MB 限制

### [v2.1.0] 2023-11

更新

- 指定返回数据的类型
- 指定自定义证书
- 设置请求优先级

### [v2.0.5] 2023-11

发布正式版本

### [v2.0.5-rc.0] 2023-10

修复

- 修复不兼容 API9 问题，版本升级小版本 2.0.4-rc.0

### [v2.0.4] 2023-09

更新

- ArkTS 语法适配整改

修复

- API 9 使用 axios 报错问题

### [v2.0.3] 2023-08

修复

- 上传文件无法获取返回数据。

### [v2.0.2] 2023-06

修复

- 已知 bug 修复。

### [v2.0.1] 2023-06

更新

- 适配 DevEco Studio: 4.0 Carry1(4.0.3.212)
- 适配 SDK: API10(4.0.8.3)

### [v2.0.0] 2023-04

新增

- 基于 axios 原库 v1.3.4 版本进行适配，已适配以下功能：
  - 发送 http 请求，自动转换 JSON data 数据
  - 上传/下载文件功能，监听上传下载事件
  - request 和 response 拦截器
  - 默认设置功能
  - Promise API
  - 包管理工具切换为 OHPM

移除

- 移除依赖的 follow-redirects、form-data、proxy-from-env 库
- 移除原库支持的 node、浏览器环境
- 移除 proxy 代理功能

### [v1.0.5] 2023-02

新增

- 兼容新版本 IDE

### [v1.0.4] 2022-09

新增

- 更新测试样例页面布局

修复

- 已知 bug 修复。

### [v1.0.2] 2022-08

修复

- 下载 header 头部设置问题修复。
- 更改 axios 导入方式。
- 新版本 RON 闪退修复。
- 参数错误无反馈问题修复。
- 说明文档新增权限说明。
- 更新说明文档。

### [v1.0.1] 2022-07

修复

- 更新错误的引用路径。

### [v1.0.0] 2022-07

基于 axios 原库 0.27.2 版本进行适配，使其可以运行在 OpenHarmony，并沿用其现有用法和特性。已支持：

- http 请求。
- Promise API。
- request 和 response 拦截器。
- 默认设置。
- 自动转换 JSON data 数据。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 隐私政策

不涉及

## SDK 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |
| Created with Pixso. | |

## 应用类型

| 应用 | Created with Pixso. |
| :--- | :--- |
| 元服务 | Created with Pixso. |

## 设备类型

| 手机 | Created with Pixso. |
| :--- | :--- |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

## DevEcoStudio 版本

| DevEco Studio 5.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @ohos/axios
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/73851e27b309455bb61518c63a7e64e2/PLATFORM?origin=template