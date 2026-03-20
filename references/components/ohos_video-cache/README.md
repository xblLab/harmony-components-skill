# video-cache 视频缓存组件

## 简介

OhosVideoCache 是一个支持边播放边缓存的库，只需要将音视频的 url 传递给 OhosVideoCache 处理之后再设置给播放器，OhosVideoCache 就可以一边下载音视频数据并保存在本地，一遍读取本地缓存返回给播放器，使用者无需进行其他操作。OhosVideoCache 还支持下载完成之后的断网播放，断点下载，会根据用户设置的参数自动清理缓存，避免手机里面存在过多的缓存文件占用磁盘空间，并且 OhosVideoCache 支持添加请求头和自定义缓存文件的命名。

## 详细介绍

### 简介

OhosVideoCache 是一个支持边播放边缓存的库，只需要将音视频的 url 传递给 OhosVideoCache 处理之后再设置给播放器，OhosVideoCache 就可以一边下载音视频数据并保存在本地，一遍读取本地缓存返回给播放器，使用者无需进行其他操作。OhosVideoCache 还支持下载完成之后的断网播放，断点下载，会根据用户设置的参数自动清理缓存，避免手机里面存在过多的缓存文件占用磁盘空间，并且 OhosVideoCache 支持添加请求头和自定义缓存文件的命名。

### 下载安装

```bash
ohpm install @ohos/video-cache
```

### 使用说明

安装 OhosVideoCache 库之后，在需要使用的界面先导入 OhosVideoCache 提供的 API

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';
```

#### 第一步 初始化代理服务器

建议将代理服务器设置为单例模式，整个工程只维护一个代理服务器对象，这样的好处是整个项目只维护一个代理服务器，不会生成多个服务器代理一个请求，造成资源、流量的浪费，降低应用的性能。

```typescript
import common from '@ohos.app.ability.common';
import { HttpProxyCacheServer } from '@ohos/video-cache';

export default class GlobalProxyServer {
    private CONTEXT_STR: string = 'getContext';
    private SERVER_STR: string = 'getServer';
    private static instance: GlobalProxyServer;
    private _objects: Map<string, Object | null> = new Map<string, Object | null>();

    private constructor() {
    }

    public static getInstance(): GlobalProxyServer {
        if (!GlobalProxyServer.instance) {
            GlobalProxyServer.instance = new GlobalProxyServer()
        }
        return GlobalProxyServer.instance;
    }

    getContext(): common.UIAbilityContext {
        return this._objects.get(this.CONTEXT_STR) as common.UIAbilityContext;
    }

    setContext(objectClass: common.UIAbilityContext) {
        this._objects.set(this.CONTEXT_STR, objectClass);
    }

    getServer(): HttpProxyCacheServer {
        return this._objects.get(this.SERVER_STR) as HttpProxyCacheServer;
    }

    setServer(objectClass: HttpProxyCacheServer) {
        try {
            let currentServer: HttpProxyCacheServer = this.getServer();
            currentServer.shutdown()
        } catch (err) {
        }
        this._objects.set(this.SERVER_STR, objectClass);
    }
}
```

初始化代理服务器

```typescript
let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext()).build();
GlobalProxyServer?.getInstance()?.setServer(server);
```

在需要使用的地方取出

```typescript
let tempUrl = await GlobalProxyServer?.getInstance()?.getServer()?.getProxyUrl(originUrl)
```

#### 第二步 将原始的音视频 url 交给 OhosVideoCache

```typescript
let tempUrl = await GlobalProxyServer?.getInstance()?.getServer()?.getProxyUrl(originUrl)
let proxyUrl: string | undefined = tempUrl ? tempUrl : originUrl
```

#### 第三步 将处理之后的 url 设置给播放器

```typescript
this.avPlayer!.url = proxyUrl;
```

做完这些之后播放器就可以支持边播放边缓存的能力了，音视频缓存完毕之后即使断开网络，下次再次播放该视频也是可以的。并且 OhosVideoCache 支持断点下载，某个视频下载到一部分之后停止下载，下次再次播放该视频会继续沿着上次缓存到的位置下载而不是从头开始下载。

#### 第四步 进阶玩法

##### 4.1 设置缓存文件夹位置

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .cacheDirectory(getContext().cacheDir)  // 设置缓存文件的存放位置为应用沙箱的 cache 目录 
    .build()
```

`cacheDirectory` 为非必传参数，OhosVideoCache 默认使用用沙箱的 cache 目录作为缓存文件夹。
当前 OhosVideoCache 使用 `@ohos.file.fs` 模块来实现文件的缓存功能，所以此处的缓存文件夹的位置应设置为 `@ohos.file.fs` 支持的路径，建议使用应用沙箱的 cache 目录或者 files 目录以及他们的子目录。

##### 4.2 设置缓存清理策略

###### 4.2.1 设置最大缓存容量清理策略

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .maxCacheSize(1024 * 1024 * 1024)  // 设置最大缓存容量为 1G 
    .build()
```

`maxCacheSize` 为非必传参数，OhosVideoCache 默认使用最大缓存容量清理策略，缓存文件夹最大的缓存容量为 512M。

###### 4.2.2 设置最大缓存数据清理策略

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .maxCacheFilesCount(10)  // 设置最大缓存文件个数为 10 个
    .build()
```

`maxCacheFilesCount` 为非必传参数。

**Tips:**
1. 缓存清理策略 `maxCacheSize` 和 `maxCacheFilesCount` 二者取其一即可，同时设置的话仅后设置的一个生效。
2. 当缓存清理策略为 `maxCacheSize` 时，每次请求之前以及缓存完毕之后 OhosVideoCache 会自动去检查设置的缓存文件夹，当 缓存的音视频文件的总大小加上即将缓存的文件的大小超过设置的最大缓存容量 (例如 1G) 之后就会清理掉多余的缓存文件，保证剩余空间的大小足够缓存当前文件。
3. 当缓存清理策略为 `maxCacheFilesCount` 时，每次请求之前以及缓存完毕之后 OhosVideoCache 会自动去检查设置的缓存文件夹，当 缓存的音视频文件的总个数加上即将缓存的文件的个数超过设置的最大缓存文件个数 (例如 10) 之后就会清理掉多余的缓存文件，保证缓存文件夹里剩余文件个数加上当前即将缓存的文件个数 不超过设置的最大缓存文件个数。

##### 4.3 添加请求头

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

class MyHeaderInject implements HeaderInjector {
    addHeaders(url: string): HashMap<string, string> {
        let header: HashMap<string, string> = new HashMap<string, string>();
        header.set('allowCrossProtocolRedirects', "true")
        header.set('name', "张三")
        header.set('fakeToken', "123456789")
        return header;
    }
}
let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .setHeaderInjector(new MyHeaderInject())
    .build()
```

`setHeaderInjector` 为非必传参数，OhosVideoCache 默认使用空的请求头注入器，不添加额外的请求头参数。
通过自定义的 `MyHeaderInject`，在 OhosVideoCache 使用音视频 url 发起请求的时候携带我们设置的参数。

##### 4.4 使用自定义的缓存文件命名规则

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

class MyFileNameGenerator implements FileNameGenerator {
    generate(url: string): string {
        let start: number = url.lastIndexOf("/");
        let end: number = url.lastIndexOf(".");
        let newName: string = url.substring(start, end)
        return newName
    }
}
let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .setFileNameGenerator(new MyFileNameGenerator())
    .build()
```

`setFileNameGenerator` 为非必传参数，OhosVideoCache 默认使用 MD5 加密原始的音视频 url 作为缓存文件的文件名。
如果你不想使用这种方式来命名缓存文件，那么可以自定义命名器实现 `FileNameGenerator`，在 `generate` 方法中实现自己的命名规则。例如上面示例是取原文件名作为缓存文件名。需要注意的是音视频的 url 和缓存文件名需要保证一一对应的关闭，同一个 url 每次调用本方法拿到的文件名必须是一样的，否则该视频每次都要重新下载缓存，生成新的缓存文件。

##### 4.5 注册/取消注册缓存进度监听器

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector } from '@ohos/video-cache';

let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext()).build()

class MyCacheListener implements CacheListener {
    onCacheAvailable(cacheFilePath: string, url: string, percentsAvailable: number) {
    }
}
let listener: MyCacheListener = new MyCacheListener()
server?.registerCacheListener(listener); //  注册缓存进度监听器
server?.unregisterCacheListener(listener); //  取消注册缓存进度监听器
```

使用者可以设置缓存监督监听器来监听音视频文件的下载缓存进度，并设置到界面显示。

##### 4.6 设置自定义的缓存文件清理规则

```typescript
import { HttpProxyCacheServer, HttpProxyCacheServerBuilder, CacheListener, FileNameGenerator, HeaderInjector, DiskUsage } from '@ohos/video-cache';

class MyDiskUsage implements DiskUsage {
    touch(filePath: string) {
        // TODO  这里需要自己取缓存文件夹里的缓存文件判断 然后写自己的文件删除逻辑
    }
}
let server: HttpProxyCacheServer = new HttpProxyCacheServerBuilder(getContext())
    .setDiskUsage(new MyDiskUsage())
    .build()
```

`setDiskUsage` 为非必传参数，OhosVideoCache 默认使用 LruDiskUsage 来清理缓存文件。
LruDiskUsage 里面文件的清理规则如下：

1. 每次播放器获取处理过的音视频 url 的时候以及每次缓存文件下载完毕都会去检测缓存文件夹，然后根据设置的缓存清理策略来判断是否需要清理缓存文件夹里的缓存文件。
2. 当需要清理缓存文件的时候，缓存文件里文件的清理顺序是按照距离现在最长时间未被使用的文件最先被清理，一直删除到缓存文件夹剩余的空间足够缓存当前即将缓存的文件（或者剩余的文件个数加上当前即将下载缓存的文件个数不超过设定值）。

如果需要使用不同的文件清理规则则可以参照上述的实力，使用创建自定义的类实现 `DiskUsage`，重写 `touch` 方法。再使用 `setDiskUsage` 设置给代理服务器即可。

##### 4.7 其他说明

- OhosVideoCache 支持多个音视频一同下载缓存，但是不建议同时开启多个音视频一起下载，这样会造成应用卡顿或者内存溢出。
- OhosVideoCache 支持的文件类型同 `@ohos.file.fs` 模块支持的文件类型保持一致。
- OhosVideoCache 同一个音视频 url 只会发起一个下载请求，当这个请求断开之后才会发起第二个。
- OhosVideoCache 支持拖动播放。如果拖动之后的位置减去当前播放的位置小于或者等于整个音视频大小的 20%，那么 OhosVideoCache 会等待到音视频下载缓存到拖动之后的位置才开始读取本地缓存文件的数据返回给播放器播放；如果拖动之后的位置减去当前播放的位置大于整个音视频大小的 20%，那么 OhosVideoCache 会直接返回请求到的音视频数据给播放器而不是从本地的缓存文件中读取数据返回给播放器。
- OhosVideoCache 在播放过程当中，断开网络，播放到缓存的位置停止播放，这个时候 AvPlayer 会报错 5400103 错误这个时候可以在 AvPlayer 的 `on('error', async (err) => {})` 回调中调用 AvPlayer 的 `reset` 方法进行重置播放并重新初始化 AvPlayer，重新执行一遍播放流程重新开始播放。

## 接口说明

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getProxyUrl | url: string, allowCachedFileUri: boolean = true | Promise | 将原始的音视频 url 处理之后返回，用于代理服务器拦截播放器的请求。 |
| registerCacheListener | cacheListener: CacheListener, url: string \| null = null | void | 注册缓存进度监听器。 |
| unregisterCacheListener | cacheListener: CacheListener, url: string | void | 取消注册缓存进度监听器 |
| shutdown | 无 | void | 关闭代理服务器 |
| cacheDirectory | file: string | HttpProxyCacheServerBuilder | 设置缓存文件存放的目录。 |
| setFileNameGenerator | fileNameGenerator: FileNameGenerator | HttpProxyCacheServerBuilder | 设置自定义的缓存文件生成器。 |
| maxCacheSize | maxSize: number | HttpProxyCacheServerBuilder | 设置最大容量缓存清理策略的最大缓存容量。 |
| maxCacheFilesCount | count: number | HttpProxyCacheServerBuilder | 设置最大文件个数缓存清理策略的最大文件个数。 |
| setDiskUsage | diskUsage: DiskUsage | HttpProxyCacheServerBuilder | 设置自定义的缓存文件清理实现逻辑。 |
| setHeaderInjector | headerInjector: HeaderInjector | HttpProxyCacheServerBuilder | 设置自定义的请求头注入器。 |
| build() | 无 | HttpProxyCacheServer | 构造器，用于构建出代理服务器。 |

## 约束与限制

在下述版本验证通过：
DevEco Studio:NEXT Developer Beta1(5.0.3.326), SDK: API12 (5.0.0.25)

## 目录结构

```text
|---- OhosVideoCache  
|     |---- entry  # 示例代码文件夹
        |---- pages  # 应用页面，根据测试场景的不同分为不同页面。
            |---- DiyCacheCountPage.ets  # 自定义缓存个数策略示例
               |---- DiyCacheHeaderPage.ets  # 自定义请求头注入器示例
               |---- DiyCacheSizePage.ets  # 自定义缓存容量大小策略示例
               |---- DiyFileNameGeneratorPage.ets  # 自定义命名规则示例
               |---- HttpsPlayer.ets  # AvPlayer 使用 OhosVideoCache 示例
               |---- IjkVideoPlayerPage.ets  # IjkPlayer 使用 OhosVideoCache 示例
               |---- Index.ets  # 首页
           |---- CommonConstants.ets  # 音视频 URL 常量类
           |---- JumpPathConfig.ts  # 界面跳转工具类
           |---- Logger.ts  # 日志打印工具
           |---- MediaLibraryUtils.ts  # 媒体文件工具
           |---- PlayStatus.ts  # 播放状态枚举
           |---- RouterParam.ts  # 界面跳转参数
|     |---- library  # OhosVideoCache 核心代码
        |---- bean  # 存放实体类，用于参数传递。
           |---- constants  # 存放常量类，用于 emitter 消息传递
           |---- file  # 用于缓存音视频以及缓存文件清理，缓存文件命名
           |---- headers  # 请求头注入器
           |---- interfaces  # 回调接口
           |---- sourcestorage # 音视频信息的数据存取
           |---- HttpProxyCacheServer.ets  # 代理服务器
           |---- HttpProxyCacheServerClients.ets  # 代理客户端，用于发起请求，缓存音视频，读取缓存文件
           |---- HttpProxyCache.ets  # 代理客户端缓存文件读取的真正实现
           |---- HttpUrlSource.ets  # 代理客户端音视频数据下载的真正实现
           |---- GetRequest.ets  # 请求信息解析
           
           
|     |---- README.MD  # 安装使用方法                  
```

## 开源协议

本项目基于 Apache License ，请自由地享受和参与开源。

## 更新记录

### 1.0.7

- Remove @ohos/crypto js references to reduce package size
- Remove the permissions of GET_WIFI_INFO and GET_NETWORK_INFO

### 1.0.7-rc.0

- Fix the issue where HEAD requests cannot be processed

### 1.0.6

- Release the official version

### 1.0.6-rc.2

- Fix the memory leak issue.

### 1.0.6-rc.1

- Optimize video cache cleaning

### 1.0.6-rc.0

- Support obtaining cache data size

### 1.0.5

- Fix available method error

### 1.0.4

- Fix possible port number conflicts

### 1.0.4-rc.1

- Fix the issue where getProxyUrl does not return

### 1.0.4-rc.0

- Fix the issue where the LAN cannot play videos

### 1.0.3

- Release official version

### 1.0.3-rc.3

- Fix the issue of some videos getting stuck during playback

### 1.0.3-rc.2

- Optimize video caching and playback speed

### 1.0.3-rc.1

- Fix the issue of excessive data usage

### 1.0.3-rc.0

- Fixed the issue of app crashing.
- Resolved the problem of failing to create cache folders.
- Addressed the issue where redirected videos could not be played.

### 1.0.2

- Update version 1.0.2

### 1.0.2-rc.0

- Fix the occasional stuttering issue during video playback.
- Fix the issue where the cache capacity limit does not take effect after customizing the cache path.

### 1.0.1

- 发布正式版本
- 更新 crypto-js 2.0.4 版本

### 1.0.1-rc.2

- 修改 ProxyCache.ts 文件中的部分代码

### 1.0.1-rc.1

- 修复和 ohos_ijkplayer 组合使用时拖动进度条无法定点播放问题

### 1.0.1-rc.0

- 修复和 ohos_ijkplayer 组合使用时拖动进度条超出缓存进度时出现的问题

### 1.0.0

- 解除 API 11 相关的代码逻辑限制，发布正式版本.

在下述版本验证通过：
DevEco Studio: 4.1 Canary2(4.1.3.322), SDK: API11 (4.1.0.36)

### 1.0.0-rc.0

- 发布 OhosVideoCache 的适配 HarmonyOS 版本.
- A.当前支持的能力：
- B.边下载边播放；
- C.断网播放；
- D.断点下载；
- E.自动清理缓存
- F.支持添加请求头
- G.支持自定义缓存文件的命名规则
- H.支持自定义音视频文件的缓存清理规则

在下述版本验证通过：
DevEco Studio: 4.1 Canary2(4.1.3.322), SDK: API11 (4.1.0.36)

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 属性 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 |  |
| 设备类型 | 手机 |
| 平板 |  |
| PC |  |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5713492de14a4e8fac2948ccb29df94e/PLATFORM?origin=template