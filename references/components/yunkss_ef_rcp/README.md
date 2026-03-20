# 鸿蒙网络请求 ef_rcp

## 简介

ef_rcp 是 eftool 的 rcp 网络请求相关包。提供了 rcp 的上传，下载，post,get,cancel,delete,put 等操作

## 详细介绍

### 功能介绍

ef_rcp 是 eftool 的 rcp 网络请求相关包。提供了 rcp 的上传，下载，post,get,cancel,delete,put 等操作

### 模块介绍

- **efRcp**：提供针对 efRcp 的一系列请求相关功能的配置工具类
- **efRcpConfig**：efRcp 所有的相关配置命名空间
- **efRcpClientApi**：提供针对于统一 post,get,delete,put 等请求的灵活封装
- **EfRcpError**：efRcp 的统一异常处理对象，内置 toString 方法
- **EfRcpResponse**：efRcp 的统一响应对象，成功请求的数据为 data 异常的结果为 error

### 环境要求

- **IDE**: DevEcoStudio 5.0.x
- **API**: API12

### 快速入门

深色代码主题复制

```bash
ohpm install @yunkss/ef_rcp
```

### 使用样例

深色代码主题复制

```typescript
async postJSON() {
    let dto = await efRcpClientApi.post<OutDTO<UserDTO>>({
      url: '/api/eftool/post',
      isParams: true, //此处模拟虽然是 post，但是需要将参数拼接 url 的特例
      query: {
        "nickName": "1",
        "account": '1',
        "age": 12,
        "hobby": ["吃", "喝", "敲代码"],
        "sex": true
      }
    });
    this.message = JSON.stringify(dto);
  }
```

### 示例效果

### API 说明

#### 前言

efRcp 封装需要大家共建和提出建议与需求，已完善传 post,postForm,put,get,delete,cancel 请求，统一上传下载，以及配置证书，期待大家提出宝贵意见

后端 Demo 示例为 Java 开发，大家自行下载使用与阅读，如有问题请提出 Issue

后端 Demo 示例地址点此访问

#### 1. efRcpConfig 配置类参数详解 (1.0.8 有改动)

**timeout 超时对象**

深色代码主题复制

```typescript
/**
 * 允许建立连接的最长时间
 */
connectMs?: number;
/**
 * 允许传输数据的最长时间
 */
transferMs?: number;
```

**sysCodeEvent 系统级别的请求响应码对象 (1.0.1 有改动)**

深色代码主题复制

```typescript
/**
 * 请求响应码监听 - 业务自行处理数据
 */
listener: (code: number) => void = () => {};
```

**businessCodeEvent 业务级别的请求响应码对象 (1.0.1+)**

深色代码主题复制

```typescript
/**
 * 业务级别自定义错误编码/异常 code 字段名称
 */
businessCodeName: string = '';
/**
 * 请求响应码监听 - 业务自行处理数据
 */
listener: (code: Object | null) => void = () => {
};
```

**codeEvent 系统级别和业务自定义级别请求响应码对象 (1.0.8+)**

深色代码主题复制

```typescript
/**
 * 业务级别自定义错误编码/异常 code 字段名称
 */
businessCodeName: string = '';
/**
 * 请求响应码监听 - 业务自行处理数据 sysCode 系统级别编码，busCode 业务自定义编码
 */
listener: (sysCode: Object | null, busCode: Object | null) => void = () => {
};
```

**cryptoEvent 请求拦截加解密操作**

深色代码主题复制

```typescript
/**
 * 请求加密操作 - 业务自行处理数据 - 默认无任何操作直接返回
 */
requestEncoder: (request: rcp.RequestContext) => rcp.RequestContext =
  (request: rcp.RequestContext): rcp.RequestContext => {
    return request;
  };
/**
 * 请求解密操作 - 业务自行处理数据 - 默认无任何操作直接返回
 */
responseDecoder: (response: rcp.Response) => rcp.Response =
  (response: rcp.Response): rcp.Response => {
    return response;
  };
```

**sessionListener 会话监听器**

深色代码主题复制

```typescript
/**
 * 会话关闭事件回调。会话关闭时调用
 */
onClosed: () => void = () => {};
/**
 * 会话取消事件的回调。会话取消时调用
 */
onCanceled: () => void = () => {};
```

**uploadEvent 上传相关事件**

深色代码主题复制

```typescript
/**
 * 监听上传进度
 */
onUploadProgress: (progress: number) => void = (progress: number) => {};
```

**downloadEvent 下载相关事件**

深色代码主题复制

```typescript
/**
 * 监听下载进度
 */
onDownloadProgress: (progress: number) => void = (progress: number) => {};
```

**securityCfg 证书相关配置**

深色代码主题复制

```typescript
/**
 * 证书颁发机构
 */
remoteValidation?: 'system' | 'skip' | rcp.CertificateAuthority | rcp.ValidationCallback = 'system';
/**
 * 客户端证书，身份认证
 */
certificate?: rcp.ClientCertificate;
/**
 * 安全连接期间的服务器身份验证配置
 */
serverAuthentication?: rcp.ServerAuthentication
```

**securityUtil 证书工具类**

深色代码主题复制

```typescript
/**
 * 读取证书内容
 * @param certPath 证书地址需要为沙箱环境地址
 * @returns 证书字符串
 */
static readClientCerts(certPath: string): string;
```

**loading 全局加载对象设置**

深色代码主题复制

```typescript
/**
 * 是否启用 - 默认 true
 */
static enable: boolean = true;
/**
 * loading 提示内容 - 默认为【努力获取数据中，请稍后...】
 */
static content: string = '努力获取数据中，请稍后...';
/**
 * 动画 builder 属性 - 图片类 - 只支持 gif 动图 暂不支持在内部使用状态变量
 */
static imgBuilder?: WrappedBuilder<[]>;
/**
 * loading 是否为 lottie 动画
 */
static enableLottie: boolean = false
/**
 * lottie 动画所需画板 - enableLottie 为 true 时生效
 */
static lottieRenderingCtx: CanvasRenderingContext2D =  new CanvasRenderingContext2D(new RenderingContextSettings(true));
/**
 * 自定义 Loading 弹框 1.0.8+
 */
static loadingBuilder?: WrappedBuilder<[]>;
```

**token token 相关配置**

深色代码主题复制

```typescript
/**
 * 登录成功后的 token 的 key
 */
static tokenName: string = 'authorization';
/**
 * 登录成功后的 token 值
 */
static tokenValue: string = '';
```

**commonParams 请求公共传参 (1.0.6 有改动)**

深色代码主题复制

```typescript
/**
* 基础请求前缀地址 非必填 需要时设置
*/
baseURL?:string; 
/**
 * 请求路径 必填
 */
url: string = '';
/**
 * 当次请求需要设置的请求头
 */
headers?: Record<string, string>;
/**
 * 当次请求需要设置的 cookies
 */
cookies?: Record<string, string>;
/**
 * 当次请求需要设置的 loading 文本
 */
loadingTxt?: string;
/**
 * 当次请求的临时开启或关闭 Loading 控制 (1.0.6+)
 */
loading?: boolean;
/**
 * Loading 窗口的背景颜色 (1.0.7+)
 */
loadingColor?: string;
```

**requestBaseParams post/put 请求所需参数对象 - 继承所有 commonParams 参数 (1.0.2 有改动)**

深色代码主题复制

```typescript
/**
 * 请求参数 post/put
 */
 query: Record<string, Object> | rcp.FormFields | rcp.MultipartFormFields | ESObject = {};
/**
 * 解决 post 传参但是需要将参数拼接 URL 情况
 */
isParams?: boolean;
```

**deleteParams delete 请求所需参数对象 - 继承所有 commonParams 参数 (1.0.3+)**

深色代码主题复制

```typescript
/**
 * 请求参数 delete
 */
query: Record<string, Object> | ESObject = {};
```

**uploadParams 上传入参对象 - 继承所有 commonParams 参数 (1.0.6 有改动)**

深色代码主题复制

```typescript
/**
 * 上传文件字段
 */
fileInfo: rcp.MultipartFormFields = {};
/**
 * 断点续传参数 (1.0.6+)
 */
transferRange: rcp.TransferRange = {};
```

**downloadParams 下载入参对象 - 继承所有 commonParams 参数**

深色代码主题复制

```typescript
/**
 * 下载文件名
 */
fileName: string = '';
```

**isConvertError 请求转换 JSON 失败时是否返回结果字符串**

深色代码主题复制

```typescript
export let isConvertError: boolean = false;
```

#### 2. efRcp 工具类 (1.0.8 有改动)

- **getInstance**: 懒汉模式获取 EfRcp 类单例
- **create**: 创建 session 对象 如业务某些地方需要根据参数重新创建 session 则可多次调用，默认只需要调用一次
- **builder**: 获取构建后的 session 对象
- **setBaseURL**: 设置全局请求地址前缀 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **enableLogInterceptor**: 是否启用日志拦截器 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addCustomInterceptors**: 添加用户自定义拦截器 - 可添加多个 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addCommonHeaders**: 添加公共的 header - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addCommonCookies**: 添加公共的 cookie - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **setConfig**: 全部自定义 session 配置 - 特殊场景如 efRcp 所有默认配置均不满足开发需求，则全部自定义并设置
  - 注意调用完 setConfig 后必须调用 create 方法重新创建 session 对象，否则配置不生效
- **addSysCodeEvent**: 添加统一的系统框架级别编码拦截操作 (1.0.1 有改动) - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addBusinessCodeEvent**: 添加统一的业务级别编码拦截操作 (1.0.1+) - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addCryptoEvent**: 添加自定义加解密拦截 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **setTimeOut**: 设置超时时间 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **setSessionListener**: 设置会话监听 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **setUploadEvent**: 设置上传进度操作 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **setDownLoadEvent**: 设置下载进度操作 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **addSecurity**: 设置证书 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **disableLoading**: 禁用全局加载框 - 设置后无需重新创建
  - 1.0.6+ 支持传入变量来控制是否启用，且无需再次 create
- **setLoadingContent**: 更改全局默认 loading 的提示内容 - 设置后无需重新创建
- **setLoadingImg**: 更改全局默认 loading 的图片 - 全局 builder，内容业务自行传入，只支持 gif 动图，不支持内部使用状态变量
- **enableLottie**: 启用 loading 加载使用 lottie 动画 - 设置后无需重新创建
- **setLottieAnimation**: 设置 lottie 动画 - 设置后无需重新创建
- **setDNS**: 设置 DNS 相关配置 - 设置后需要调用 create 重新创建，可批量链式调用后最后再去 create
- **efRcp**: 抛出的全局 efRcp 对象，可链式调用
- **convertError**: 将异常结果转换
- **setLoadingBuilder**: 设置自定义 Loading 弹框内容样式 (1.0.8+)
- **addCodeEvent**: 添加系统以及业务编码同时监听 (1.0.8+)

#### 3. efRcpClientApi 工具类 (1.0.3 有改动)

该工具类提供统一简化各种请求方式

**post 请求 json 格式 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async post<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//postParam post 请求所需参数，详见 efRcpConfig.requestBaseParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**postForm 请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明   参数为 form 格式
async postForm<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//postParam post 请求所需参数，详见 efRcpConfig.requestBaseParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**postMultipartForm 请求 async/await 方式 (1.0.2+)**

深色代码主题复制

```typescript
//参数说明   参数为 MultipartForm 格式
async postMultipartForm<E>(postParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//postParam post 请求所需参数，详见 efRcpConfig.requestBaseParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**get 请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明 格式为  getXXXX/id/name/xxxx
async get<E>(getParam: efRcpConfig.commonParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//getParam get 请求所需参数，详见 efRcpConfig.commonParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**put 请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async put<E>(putParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//putParam put 请求所需参数，详见 efRcpConfig.requestBaseParams
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**delete 请求 async/await 方式 (1.0.3 有改动)**

深色代码主题复制

```typescript
//参数说明
async delete<E>(deleteParam: efRcpConfig.deleteParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//deleteParam delete 请求所需参数，详见 efRcpConfig.deleteParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**patch 请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async patch<E>(patchParam: efRcpConfig.requestBaseParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//patchParam patch 请求所需参数，详见 efRcpConfig.requestBaseParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**cancel 请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async cancel(url: string)
//url 为取消请求方法的 url 全路径应该为 efRcpParams.baseURL+url 组合而成
```

**uploadFile 统一的上传请求 MultipartFormFields 形式 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async uploadFile<E>(uploadParam: efRcpConfig.uploadParams, cls?: ClassConstructor<E>,securityCfg?: efRcpConfig.securityCfg): Promise<EfRcpResponse<E>>
//uploadParam 上传文件所需参数，详见 efRcpConfig.uploadParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**downloadFile 统一的下载请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async downloadFile<E>(downloadParam: efRcpConfig.downloadParams, cls?: ClassConstructor<E>): Promise<EfRcpResponse<E>>
//downloadParam 下载文件所需参数，详见 efRcpConfig.downloadParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

**downloadStream 统一的下载请求 async/await 方式**

深色代码主题复制

```typescript
//参数说明
async downloadStream<E>(downloadParam: efRcpConfig.downloadParams, cls?: ClassConstructor<E>): Promise<EfRcpResponse<E>>
//downloadParam 下载文件所需参数，详见 efRcpConfig.downloadParams
//cls 需要返回的泛型对象，内部会做类型转换，转换后泛型的方法调用不会报错，嵌套对象时只有第一层生效
//securityCfg 本次请求是否需要更换证书 - 证书对象，详见 efRcpConfig.securityCfg
//EfRcpResponse<E> 为响应结果对象，请求成功数据存入 data 字段，请求失败存入 error 字段，如有场景需要判断系统框架级别 error 则获取使用
```

## 技术支持

WX IT_CSXissue https://gitee.com/yunkss/ef-tool/issues

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

1.0.10 (2025-07-10) 根据插件市场要求优化权限与隐私基本信息 权限名称  权限说明  使用目的 无无无隐私政策不涉及 SDK 合规使用指南 不涉及 兼容性 HarmonyOS 版本  5.0.0 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		

 应用类型  应用 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		

 元服务 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
	

 设备类型  手机 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		

 平板 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
	

 PC 
	
			Created with Pixso.
	
	
		
			
		
	
	
		
		
		
		
		
		
		
	

 DevEcoStudio 版本  DevEco Studio 5.0.0 
	
			Created with Pixso.

## 安装方式

```bash
ohpm install @yunkss/ef_rcp
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/54800dfeeb8a4986bb27dfbe8c395698/477dd36278b94ca7911ac3d109da886a?origin=template