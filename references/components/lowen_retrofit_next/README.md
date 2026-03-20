# retrofit next 网络请求组件

## 简介

HarmonyOS Next 自己的 Retrofit 网络请求库。

## 详细介绍

### 简介

HarmonyOS Next 自己的 Retrofit 网络请求库，默认基于 `@ohos.net.http` 库和 `@ohos.request`，也可以支持其它 http 库扩展。可高度自定义，通过 TypeScript 构造器，快速实现鸿蒙 http 网络请求。

### 安装

```bash
ohpm install @lowen/retrofit_next
```

### 全局配置

#### 初始化

```typescript
import { Retrofit } from '@lowen/retrofit_next'

Retrofit.Builder()
      .setHost(host: string) // 设置全局 host
      .setHttpFactory(factory: HttpFactory) // 设置 Http 请求构建工厂，默认 OhosHttpFactory
      .addInterceptor(interceptor: Interceptor) // 添加拦截器，默认会加入 LogInterceptor
      .setHeaders(headers: Map<string, string>) // 设置 Header
      .addHeader(key: string, value: string) // 添加 Header
      .setConvertorFactory(factory: ConvertorFactory) // Response 数据转换，直接影响每个请求返回数据层级
      .setRequestTaskFactory(requestTaskFactory: RequestTaskFactory) // 请求任务管理器，默认 DefaultRequestTaskFactory
      .setConnectTimeout(timeout: number) // 设置超时时间
      .setLoadingFactory(factory: LoadingFactory) // 设置 Loading 状态构建工厂
      .build()
```

#### 拦截器

请求拦截器，可自定义配置。

```typescript
Retrofit.Builder()
      .addInterceptor(interceptor: Interceptor) // 添加拦截器，默认会加入 LogInterceptor
      .build()
```

#### 数据转换器

全局处理 Response 数据，统一处理返回数据，配置方式：

```typescript
Retrofit.Builder()
      .setConvertorFactory(factory: ConvertorFactory) // Response 数据转换，直接影响每个请求返回数据层级
      .build()
```

**样例：**

```typescript
import { ConvertorFactory, Response } from '@lowen/retrofit'

// 业务 Response
export interface BizResponse<T> {
  code: number
  message?: string
  data?: T
}

export interface NetworkError extends BizError {}

export interface BizError {
  code: number
  message?: string
}

export class BizConvertorFactory extends ConvertorFactory {
  public convertor(resp: Response): Promise<Object | undefined> {
    return new Promise((resolve, reject) => {
      // 接口请求成功
      if (resp.isOk) {
        // 剥离出业务 Response
        let bizResp = resp.result as BizResponse<Object>
        if (bizResp.code == 200) {
          // 业务处理成功，直接返回请求数据对象，这里返回数据会直接返回到请求方法的返回值，如这里是 User
          //  async get(@Loading loadingCallback: LoadingCallback): Promise<User> {
          //     return {} as User
          //  }
          resolve(bizResp.data)
        } else {
          // 业务失败，直接抛出异常
          let bizError: BizError = {
            code: bizResp.code,
            message: bizResp.message,
          }
          reject(bizError)
        }
      } else {
        // 接口请求异常，直接抛出异常
        let bizError: NetworkError = {
          code: resp.code ?? 500,
          message: resp.message,
        }
        reject(bizError)
      }
    })
  }
}
```

> 注：通过 ConvertorFactory 配置，可以自定义接口方法的返回值类型。

#### 请求状态

##### 全局配置

全局请求状态配置，配置方式：

```typescript
Retrofit.Builder().setLoadingFactory(new HttpLoadingFactory())
```

##### 例

```typescript
export class HttpLoadingFactory extends LoadingFactory {
  start(url: string): void {
    LoadingDialog.showLoading()
  }

  end(url: string): void {
    LoadingDialog.hide()
  }
}
```

##### BaseNoLoading

类级别装饰器，局部配置 Class 下所有方法不响应 `setLoadingFactory()` 全部 Loading 配置。

```typescript
@BaseNoLoading
export class ApiNoLoadService {}
```

##### NoLoading

方法级别装饰器，方法级别不响应 `setLoadingFactory()` 全部 Loading 配置。

```typescript
@GET('/get')
@NoLoading
async getLoading(): Promise<User> {
   return {} as User
}
```

##### Loading

方法级别装饰器，当 Class 使用 `@BaseNoLoading` 时，当前方法级别响应 `setLoadingFactory()` 全部 Loading 配置。

```typescript
@GET('/get')
@NoLoading
async getLoading(): Promise<User> {
   return {} as User
}
```

##### Loadable

参数级别装饰器，优先级高于 Loading 和 NoLoading，动态配置是否使用全局 LoadingFactory。

```typescript
@GET('/get/user')
async get(@Loadable loadable: boolean): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

##### LoadState

参数级别装饰器，优先级最高，通过 `@LoadState` 和 `LoadStateCallback` 配对使用，监控请求开始和结束，不受其它 Loading 相关装饰器影响。

```typescript
@GET('/get/user')
async get(@LoadState loadStateCallback: LoadStateCallback): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

### Host 配置

#### 1. 全局配置

```typescript
Retrofit.Builder().setHost('https://xxxxx.com') // 设置全局 host
```

#### 2. 类配置

优先级高于全局配置，作用于为当前类对象请求。

```typescript
@Host('https://xxxxx.com')
export class ApiService {}
```

### Header 配置

#### 1. 全局配置

优先级最低，若未配置 Content-type，则默认会自动加入 Header：'Content-Type', 'application/json'。

```typescript
Retrofit.Builder().setHeaders(headers: Map<string, string>) // 设置 Header
Retrofit.Builder().addHeader(key: string, value: string) // 添加 Header
```

#### 2. 类配置

优先级高于全局配置。

```typescript
@BaseHeaders({
 'Content-type': 'application/json; charset=UTF-8'
})
export class ApiService {}
```

#### 3. 方法配置

优先级高于类配置。

```typescript
@Headers({
 'key1': 'value1',
 'key2': 'value2',
})
async get(): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

#### 4. 参数配置

优先级高于方法配置。

**Header**

```typescript
async get(@Header('key1') key1: string, @Header('key2') key2: string): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

**HeaderMap**

HeaderMap 和 `Map<string,string>` 结合。

```typescript
async get(@HeaderMap map: Map<string,string>): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

### 普通请求

支持 GET，POST，OPTIONS，HEAD，PUT，DELETE，TRACE，CONNECT。

#### GET

```typescript
@GET('/get/user')
async get(): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

#### POST

```typescript
@POST('/post')
async post(@Body body: PostRequest): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

### 上传下载

#### Progress

上传下载进度，参数类型必须为 `ProgressCallback`。

```typescript
/**
 * @totalByteCount 当前已经完成的字节数
 * @processByteCount 全部字节数
 */
export type ProgressCallback = (totalByteCount: number, processByteCount: number) => void;
```

#### Upload

`@Body`，上传非文件参数，默认 HttpFactory 仅限 key-value 数据结构。
文件上传，上传进度由 `@Progress` 和 `ProgressCallback` 配置。

**@Config** 上传配置，参数类型必须为 `UploadConfig`。

```typescript
export class UploadConfig {
  /**
   * 扩展配置，自定义用
   */
  public extra?: Object

  constructor(extra: Object) {
    this.extra = extra
  }
}
```

**Part**

单位件上传，作用于方法参数。
参数类型必须为 `PartFile`，否则保存。

```typescript
/**
 * 上传，请求标头中的文件名.
 */
export class PartFile {
  /**
   * 文件名称
   */
  filename: string;
  /**
   * 表单项的名称
   */
  name: string;
  /**
   * 文件的本地存储路径
   */
  uri: string;
  /**
   * 文件后缀或类型
   */
  type: string;
}
```

**样例：**

```typescript
@Upload
@POST('/upload')
async upload(@Part file: PartFile, @Progress progressCallback: ProgressCallback): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

> 注：支持 `upload(@Part file1: PartFile, @Part file2: PartFile)` 多文件上传。

**PartList**

多文件上传，作用于方法参数。
参数类型必须为 `Array<PartFile>`。

**样例：**

```typescript
@Upload
@POST('/upload')
async upload(@PartList file: PartFile[], @Progress progressCallback: ProgressCallback): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

#### Download

文件下载，可以通过 GET 或 POST 相关配置设置下载 url（鸿蒙网络库 GET 和 POST 不会生效），也可以通过 `@Url` 直接设置下载 url。

**@Config** 下载配置，参数类型必须为 `DownloadConfig`。

```typescript
export class DownloadConfig {
  /**
   * 目标文件 Path
   */
  public targetPath: string
  /**
   * 扩展配置，自定义用
   */
  public extra?: Object

  constructor(targetPath: string, extra?: Object) {
    this.targetPath = targetPath
    this.extra = extra
  }
}
```

**样例：**

```typescript
@Download
@GET('/get/user/info')
async download(@Config config: DownloadConfig, @Progress progressCallback: ProgressCallback): Promise<BizResponse<void>> {
  return {} as BizResponse<void>
}
```

### 方法参数

#### Path

在 URL 路径段中替换指定的参数值。
使用 `toString()` 和 URL 编码将值转换为字符串。
使用该注解定义的参数的值不可为空参数值默认使用 URL 编码。

```typescript
@GET('/get/{p1}/info')
async get(@Path('p1') p1: string): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

> 例：若参数 `p1='user'`，请求完整 path 为：`/get/user/info`

#### Query

用于添加查询参数，即请求参数（Query = Url 中 '?' 后面的 key-value）。
参数值通过 `toString()` 转换为 String 并进行 URL 编码。

```typescript
@GET('/get/user/info')
async get(@Query('p1') p1: string, @Query('p2') p2: string): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

> 例：`get('v1','v2')`，Path 为：`/get/user/info?p1=v1&p2=v2`

#### QueryMap

以 map 的形式添加查询参数，即请求参数。
参数值通过 `toString()` 转换为 String 并进行 URL 编码。
参数类型必须为 `Map<string, Object>`，否则会报错。

```typescript
@GET('/get/user/info')
async get(@QueryMap querys: Map<string, Object>,): Promise<BizResponse<User>> {
    return {} as BizResponse<User>
}
```

> 例：
> ```typescript
> let params:Map<string,string> = new Map()
> params.set('p1','v1')
> params.set('p2','v2')
> get(params)
> ```
> Path 为：`/get/user/info?p1=v1&p2=v2`

#### Url

直接传入一个请求的 URL 变量，设置请求 url，直接替换到原有配置。

```typescript
@Download
async download(@Url url: string, @Config config: DownloadConfig,
@Progress progressCallback: ProgressCallback): Promise<BizResponse<void>> {
  return {} as BizResponse<void>
}
```

#### FormUrlEncoded

FormUrlEncoded 不能用于 Get 请求，不要乱用。
用于修饰 Field 注解和 FieldMap 注解。
使用该注解，表示请求正文将使用表单网址编码。字段应该声明为参数，并用 `@Field` 注释或 `FieldMap` 注释。使用 FormUrlEncoded 注解的请求将具”application / x-www-form-urlencoded" MIME 类型。

**Field**

发送 Post 请求时提交请求的表单字段，与 `@FormUrlEncoded` 注解配合使用。

```typescript
@FormUrlEncoded  
@POST("/post")  
async post(@Field("time") long time): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}

@FormUrlEncoded  
@POST("/post")  
async post(@Field("name") String... names): Promise<BizResponse<User>> {
  return {} as BizResponse<User>
}
```

**FieldMap**

表单字段，与 Field、FormUrlEncoded 配合；接受 Map 类型，非 String 类型会调用 `toString()` 方法。

```typescript
@FormUrlEncoded  
@POST("/post")  
Call<List<Repo>> things(@FieldMap Map<String, String> params);  
  return {} as BizResponse<User>
}
```

### 自定义扩展

#### 扩展装饰器

`BaseExtra`（类级别装饰器），`FixedExtra`（方法级别装饰器），`Extra`（参数级别装饰器），自定义扩展获取，`RequestTask.extra`，该扩展参数可在 Interceptor 和自定义 `RequestTaskFactory`，`HttpFactory` 中使用。

**例：**

```typescript
@BaseExtra('BaseExtra')
export class ApiService {
  @FixedExtra('FixedExtra')
  async getLoading(@Extra extra: string): Promise<User> {
    return {} as User
  }
}
```

#### 自定义 http 请求工厂

```typescript
/**
 * 鸿蒙原生 Http 构建工厂
 */
export class CustomHttpFactory extends HttpFactory {
  /**
   * http 网络请求
   * @param task 请求任务
   * @returns
   */
  public httpRequest(task: RequestTask): Promise<HttpResponse> {
   let extra: ExtraObject | undefined = task.extra
  }
}
```

#### 自定义拦截器

```typescript
export class LogInterceptor extends Interceptor {
 public intercept(chain: Chain): Promise<Response> {
    let extra: ExtraObject | undefined = chain.request.extra
 }
}
```

#### 请求任务自定义管理

重写 `RequestTaskFactory`，默认 `DefaultRequestTaskFactory`。

#### 网络请求自定义

重写 `HttpFactory`，默认 `OhosHttpFactory`。

## 更新记录

### [v1.0.3] 2026-01

- 优化日志打印
- 新增 RetrofitController，手动取消普通 http 请求
- fix body 数据传递过程中会屏蔽 0
- fix POST 表单提交服务接收的时候看着是多包了一层{}

### [v1.0.2] 2024-09

- 修复文件上传非文件参数不生效的问题

### [v1.0.1] 2024-09

- 修复 @FormUrlEncoded POST 参数无法提交的 bug
- 优化文档

### [v1.0.0] 2024-08

- 发布 1.0.0 初版

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @lowen/retrofit_next
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fadf3fd396ee4bc28ff8bdd0e6a01937/PLATFORM?origin=template