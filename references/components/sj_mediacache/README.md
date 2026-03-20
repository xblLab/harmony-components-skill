# mediacache 视频缓存组件

## 简介

用于支持音视频边播放边缓存 (mp3、mp4、m3u8、mpeg-dash 等); 可代理媒体数据请求并优先提供缓存数据，从而减少网络流量并提升播放流畅度。

## 详细介绍

### 简介

MediaCache for HarmonyOS
用于支持音视频边播放边缓存 (mp3、mp4、m3u8、mpeg-dash 等); 可代理媒体数据请求并优先提供缓存数据，从而减少网络流量并提升播放流畅度。

### 主要特性

边播放边缓存现已支持以下三类远程资源:
- 基于文件的媒体 (MP3、AAC、WAV、FLAC、OGG、MP4、MOV 等常见格式);
- HTTP Live Streaming (HLS/m3u8)：自动解析播放列表并代理各媒体片段请求;
- MPEG-DASH (MPD)：自动解析播放列表并代理各媒体分段请求，包括视频、音频和字幕轨道;

- 支持预缓存/预加载，可缓存指定大小的数据或全部数据;
- 支持数据加解密，保存数据时加密，读取数据时解密;
- 支持导出，将媒体数据导出到指定的目录;
- 支持资源代理，可将任意资源 (本地文件、内存数据、动态生成流等) 映射为通过 HTTP URL 访问的媒体资源;

### 安装

```bash
ohpm install @sj/mediacache
```

### 在项目中引用

在需要依赖的模块找到 oh-package.json5 文件，新增如下依赖并同步:

```json5
{
  "dependencies": {
    "@sj/mediacache": "^1.2.0"
  }
}
```

### 初始化

在开始代理请求之前，请先初始化以启动代理服务:

```typescript
await MCMediaCache.prepare(getContext());
```

### 播放

播放时需要通过代理地址进行播放; 所以在播放之前请使用该方法生成代理地址，然后设置给播放器播放即可实现边播放边缓存:

```typescript
const resUrl = 'http://www.example.com/video.mp4'; // 原始地址
const proxyUrl = await MCMediaCache.proxy(resUrl); // 生成代理地址

const player: media.AVPlayer;
player.url = proxyUrl; // 设置代理地址播放即可实现边播边缓存
```

### 预缓存

预先缓存指定大小的数据:

```typescript
// 直接使用原始地址进行预缓存即可;
MCMediaCache.prefetch(resUrl, {
  prefetchSize: 5 * 1024 * 1024, // 假设预缓存 5M
  onProgress: (progress) => console.log(`[progress] ${progress}`)
});
```

预先缓存指定数量的媒体片段: 这个配置主要用于流媒体 (HLS)，因为它的播放列表 (playlist) 中通常包含多个段 (ts) 文件，通过以下配置来指定需要预缓存的文件数:

```typescript
// 直接使用原始地址进行预缓存即可;
MCMediaCache.prefetch(resUrl, {
  prefetchSegmentCount: 1, // 假设预缓存 1 个片段
  onProgress: (progress) => console.log(`[progress] ${progress}`)
});
```

### 导出数据

**导出**: 导出媒体数据到指定目录，导出过程中如果媒体数据仅存在部分缓存，则会发起网络请求获取剩余数据，如果缓存都已存在，则不会请求网络:

```typescript
const ctx = this.getUIContext().getHostContext()!;
const targetDir = ctx.filesDir + '/my_exports/video1'; // 导出目录
const resUrl = 'http://www.example.com/video.mp4'; // 要导出的视频

// 开始导出
MCMediaCache.exportToDirectory(resUrl, targetDir, {
  conflictStrategy: MCCopyFileConflictStrategy.Overwrite,
  onProgress: (progress) => {
    console.log(`[export progress] ${progress}`);
  }
}).then(() => {
    console.log(`导出成功`);
}).catch((e: Error) => {
  console.log(`导出失败：${e.message}`);
});
```

**播放**: 播放导出的媒体数据，通过代理指定目录使用返回的代理地址进行播放:

```typescript
// 代理指定目录进行播放，返回代理地址;
// 当通过 exportToDirectory 导出媒体数据后，可使用该接口生成代理地址进行播放;
const ctx = this.getUIContext().getHostContext()!;
const targetDir = ctx.filesDir + '/my_exports/video1'; // 导出目录

// 获取代理地址
const proxyUrl = await MCMediaCache.proxyDir(targetDir);

// 设置播放; 这里以 AVPlayer 为例，直接设置代理地址播放即可;
const player: media.AVPlayer;
player.url = proxyUrl;
```

### 虚拟资源代理

可将任意资源 (本地文件、内存数据、动态生成流等) 映射为通过 HTTP URL 访问的媒体资源;

```typescript
// 以下将一个普通文件，映射为可通过 HTTP URL 访问的媒体资源
// 1. 本地文件的路径
const filePath = xxx;
// 2. 注册虚拟资源 (全局注册一次即可), 传入的 key 请确保全局唯一
MCMediaCache.setVirtualResource("key-local-media", { filePath: filePath });

// 3. 在需要播放时通过 key 获取映射的代理地址进行播放
const proxyUrl = await MCMediaCache.proxyVirtualResource("key-local-media");
player.url = proxyUrl;
```

### 其他配置

**配置请求头**: 发起请求前回调，可以在回调中修改请求，添加请求头，cookies 等;

```typescript
MCMediaCache.setRequestHandler((request) => {
  request.setHeader('key', 'value');
});
```

**数据加密**: 保存数据时加密; 缓存数据写入到文件时回调，你可以对数据进行一些加密处理;

```typescript
MCMediaCache.setDataEncryptionHandler(async (resUrl, dataOffset, data) => {
  // xxx
});
```

**数据解密**: 读取数据时解密; 读取数据时回调，如果原数据被加密但是播放时需要解密，你可以在该回调中进行解密处理;

```typescript
MCMediaCache.setDataDecryptionHandler(async (resUrl, dataOffset, data) => {
  // xxx
});
```

**缓存标识处理 (确保相同视频只缓存一次)**: 由于相同的标识将引用同一份缓存，当出现多个地址指向同一个视频，例如 url 可能带有鉴权之类的参数，这部分很容易发生变化，但这些地址都指向同一个视频，为了确保只缓存一份视频，你可以在这里将这些会变化的参数移除;

```typescript
MCMediaCache.setAssetIdentifierPreprocessor(async (resUrl) => {
  const resUrl = 'http://www.example.com/video.mp4?token=xxx';
  const index = resUrl.indexOf('?');
  return index !== -1 ? resUrl.slice(0, index) : resUrl;
});
```

**缓存管理**:
- 个数限制：可以配置缓存个数，超过限制时将会自动删除旧的缓存:

```typescript
// 缓存个数限制：0 表示不限制;
MCMediaCache.cacheConfig.countLimit = 0;
```

- 保存时长限制 (单位：毫秒): 超过限制自动删除;

```typescript
// 保存时长限制 (单位：毫秒): 0 表示不限制;
MCMediaCache.cacheConfig.maxAge = 0;
```

- 所有缓存能够占用的磁盘大小 (单位：字节): 超过限制时将会自动删除旧的缓存;

```typescript
// 磁盘空间限制 (单位：字节): 0 表示不限制;
MCMediaCache.cacheConfig.maxDiskSize = 0;
```

- 磁盘空间预警阈值 (单位：字节): 当磁盘剩余空间不足小于预警阈值时将会自动删除旧的缓存:

```typescript
// 磁盘空间预警阈值 (单位：字节): 0 表示不限制;
MCMediaCache.cacheConfig.diskSpaceWarningThreshold = 0;
```

**配置控制台日志**:

```typescript
MCMediaCache.setLogEnabled(BuildProfile.DEBUG); // 是否开启日志;
MCMediaCache.setLogLevel(MCLogLevel.DEBUG); // 设置日志等级;
MCMediaCache.setLogWhiteModules([MCLogModule.MCHttpConnectionHandler, MCLogModule.MCHttpResponse]) // 允许打印哪些模块的日志;
```

### 许可证协议

MIT

### 更新记录

- **[v1.2.1]** 2026/01/12
  - Add CORS header to HTTP responses
- **[v1.2.0]** 2025/10/14
  - 新增 虚拟资源代理，可将任意资源 (本地文件、内存数据、动态生成流等) 映射为通过 HTTP URL 访问的媒体资源;
- **[v1.1.3]** 2025/10/11
  - 增加对 HTTP 302 重定向的处理;
- **[v1.1.2]** 2025/10/11
  - 修改媒体元数据探测请求方式，由 HEAD 请求改为 GET 请求;
- **[v1.1.1]** 2025/10/10
  - 调整多码率流选择器的处理，允许保留所有码流;
- **[v1.1.0]** 2025/09/14
  - 新增 MPEG-DASH 的有限支持，具体支持情况如下:
    - 完整支持：边播放边缓存;
    - 暂未支持：预缓存、导出;
- **[v1.0.8]** 2025/08/19
  - 优化导出进度和预加载进度计算;
  - 添加 example 目录;
- **[v1.0.7]** 2025/08/18
  - 新增导出与导出播放接口，可将缓存导出到指定目录;
- **[v1.0.6]** 2025/08/08
  - 优化部分实现类;
- **[v1.0.5]** 2025/07/24
  - 修复中止 Fetcher 时当前的 Loader 未一起取消的问题;
- **[v1.0.4]** 2025/07/23
  - 读写操作性能提升;
  - 修复预加载大量占用 CPU 的问题;
- **[v1.0.3]** 2025/03
  - 调整初始化方法，由外部传入 context;
- **[v1.0.2]** 2025/01
  - 修复 cannot find record '&@sj/mediacache/xxx';
- **[v1.0.1]** 2025/01
  - 完善读取和写入数据的处理逻辑;
  - 完善错误日志输出;
- **[v1.0.0]** 2024/12
  - 代理请求;
  - 支持预缓存;
  - 支持缓存管理;
  - 支持日志配置;

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

Created with Pixso.

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 |  |
| 设备类型 | 手机 |
| 平板 |  |
| PC |  |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.
Created with Pixso.
Created with Pixso.
Created with Pixso.
Created with Pixso.
Created with Pixso.
Created with Pixso.

## 安装方式

```bash
ohpm install @sj/mediacache
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/279cc92dac3441debe8e35e772f23200/PLATFORM?origin=template