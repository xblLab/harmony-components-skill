# imageknife 图像加载缓存组件

## 简介

专门为 OpenHarmony 打造的一款图像加载缓存库，致力于更高效、更轻便、更简单。

## 详细介绍

### 简介

专门为 OpenHarmony 打造的一款图像加载缓存库，致力于更高效、更轻便、更简单。当前 ImageKnife 已停止演进，推荐 imageknifepro：既提供 ArkTs 组件方式给 ArkTs 应用使用，也提供 Native 组件的方式使用；图片加载更快；支持通过拦截器的方式，自定义网络下载，解码，文件缓存，内存缓存。通过责任链 - 拦截器模式，图片加载任务可以同时应用多个自定义加载方式。

本项目参考开源库 Glide 进行 OpenHarmony 的自研版本：

- 支持自定义内存缓存策略，支持设置内存缓存的大小 (默认 LRU 策略)
- 支持磁盘二级缓存，对于下载图片会保存一份至磁盘当中
- 支持自定义实现图片获取/网络下载
- 支持监听网络下载回调进度
- 继承 Image 的能力，支持 option 传入 border，设置边框，圆角
- 继承 Image 的能力，支持 option 传入 objectFit 设置图片缩放，包括 objectFit 为 auto 时根据图片自适应高度
- 支持通过设置 transform 缩放图片
- 并发请求数量，支持请求排队队列的优先级
- 支持生命周期已销毁的图片，不再发起请求
- 自定义缓存 key
- 自定义 http 网络请求头
- 支持 writeCacheStrategy 控制缓存的存入策略 (只存入内存或文件缓存)
- 支持 preLoadCache 预加载图片
- 支持 onlyRetrieveFromCache 仅用缓存加载
- 支持使用一个或多个图片变换，如模糊，高亮等
- 内存降采样优化，节约内存的占用

#### 待实现特性

- 支持自定义图片解码

#### 注意

3.x 版本相对 2.x 版本做了重大的重构，主要体现在：

- 使用 Image 组件代替 Canvas 组件渲染
- 重构 Dispatch 分发逻辑，支持控制并发请求数，支持请求排队队列的优先级
- 支持通过 initMemoryCache 自定义策略内存缓存策略和大小
- 支持 option 自定义实现图片获取/网络下载

因此 API 及能力上，目前有部分差异，主要体现在：

- 不支持 drawLifeCycle 接口，通过 canvas 自会图片
- mainScaleType，border 等参数，新版本与系统 Image 保持一致
- gif/webp 动图播放与控制 (ImageAnimator 实现)
- 抗锯齿相关参数

## 下载安装

```bash
ohpm install @ohos/imageknife
```

```typescript
// 如果需要用文件缓存，需要提前初始化文件缓存
await ImageKnife.getInstance().initFileCache(context, 256, 256 * 1024 * 1024)
```

## 使用说明

### 1. 显示本地资源图片

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc: $r("app.media.app_icon"),
    placeholderSrc: $r("app.media.loading"),
    errorholderSrc: $r("app.media.app_icon"),
    objectFit: ImageFit.Auto
  }
}).width(100).height(100)
```

### 2. 显示本地 context files 下文件

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc: this.localFile,
    placeholderSrc: $r("app.media.loading"),
    errorholderSrc: $r("app.media.app_icon"),
    objectFit: ImageFit.Auto
  }
}).width(100).height(100)
```

### 3. 显示网络图片

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc:"https://www.openharmony.cn/_nuxt/img/logo.dcf95b3.png",
    placeholderSrc: $r("app.media.loading"),
    errorholderSrc: $r("app.media.app_icon"),
    objectFit: ImageFit.Auto
  }
}).width(100).height(100)
```

### 4. 自定义下载图片

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc: "https://file.atomgit.com/uploads/user/1704857786989_8994.jpeg",
    placeholderSrc: $r("app.media.loading"),
    errorholderSrc: $r("app.media.app_icon"),
    objectFit: ImageFit.Auto,
    customGetImage: custom
 }
}).width(100).height(100)

// 自定义实现图片获取方法，如自定义网络下载
@Concurrent
async function custom(context: Context, src: string | PixelMap | Resource): Promise<ArrayBuffer | undefined> {
  console.info("ImageKnife::  custom download：" + src)
  // 举例写死从本地文件读取，也可以自己请求网络图片
  return context.resourceManager.getMediaContentSync($r("app.media.bb").id).buffer as ArrayBuffer
}
```

### 5. 监听网络下载进度

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc:"https://www.openharmony.cn/_nuxt/img/logo.dcf95b3.png",
    progressListener:(progress:number)=>{console.info("ImageKinfe:: call back progress = " + progress)}
  }
}).width(100).height(100)
```

### 6. 支持 option 传入 border，设置边框，圆角

```typescript
ImageKnifeComponent({ imageKnifeOption: 
{
   loadSrc: $r("app.media.rabbit"),
   border: {radius:50}
  }
}).width(100).height(100)
```

### 7. 支持 option 图片变换

```typescript
ImageKnifeComponent({ imageKnifeOption: 
{
   loadSrc: $r("app.media.rabbit"),
   border: {radius:50},
   transformation: new BlurTransformation(3)
  }
}).width(100).height(100)
```

#### 多种组合变换用法

```typescript
let transformations: collections.Array<PixelMapTransformation> = new collections.Array<PixelMapTransformation>();
transformations.push(new BlurTransformation(5));
transformations.push(new BrightnessTransformation(0.2));
ImageKnifeComponent({
  imageKnifeOption: {
  loadSrc: $r('app.media.pngSample'),
  placeholderSrc: $r("app.media.loading"),
  errorholderSrc: $r("app.media.app_icon"),
  objectFit: ImageFit.Contain,
  border: { radius: { topLeft: 50, bottomRight: 50 } }, // 圆角设置
  transformation: transformations.length > 0 ? new MultiTransTransformation(transformations) : undefined // 图形变换组
}
}).width(300)
  .height(300)
  .rotate({ angle: 90 }) // 旋转 90 度
  .contrast(12) // 对比度滤波器
```

其它变换相关属性，可叠加实现组合变换效果

#### 圆形裁剪变换示例

```typescript
ImageKnifeComponent({ imageKnifeOption: 
  {
  loadSrc: $r('app.media.pngSample'),
  objectFit: ImageFit.Cover,
  border: { radius: 150 }
}
}).width(300)
  .height(300)
```

#### 圆形裁剪带边框变换示例

```typescript
ImageKnifeComponent({ imageKnifeOption: 
  {
  loadSrc: $r('app.media.pngSample'),
  objectFit: ImageFit.Cover,
  border: { radius: 150, color: Color.Red, width: 5 }
}
}).width(300)
  .height(300)
```

#### 对比度滤波变换示例

```typescript
ImageKnifeComponent({
  imageKnifeOption: {
    loadSrc: $r("app.media.pngSample")
  }
}).width(300)
  .height(300)
  .contrast(12)
```

#### 旋转变换示例

```typescript
ImageKnifeComponent({
  imageKnifeOption:  {
    loadSrc: $r("app.media.pngSample")
  }
}).width(300)
  .height(300)
  .rotate({angle:90})
  .backgroundColor(Color.Pink)
```

### 8. 监听图片加载成功与失败

```typescript
ImageKnifeComponent({ imageKnifeOption: 
{
   loadSrc: $r("app.media.rabbit"),
   onLoadListener:{
    onLoadStart:()=>{
     this.starTime = new Date().getTime()
     console.info("Load start: ");
    },
    onLoadFailed: (err) => {
     console.error("Load Failed Reason: " + err + "  cost " + (new Date().getTime() - this.starTime) + " milliseconds");
    },
    onLoadSuccess: (data, imageData) => {
     console.info("Load Successful: cost " + (new Date().getTime() - this.starTime) + " milliseconds");
     return data;
    },
    onLoadCancel(err){
      console.info(err)
    }
   }
 }
}).width(100).height(100)
```

### 9. ImageKnifeComponent - syncLoad

设置是否同步加载图片，默认是异步加载。建议加载尺寸较小的 Resource 图片时将 syncLoad 设为 true，因为耗时较短，在主线程上执行即可

```typescript
ImageKnifeComponent({
        imageKnifeOption:{
          loadSrc:$r("app.media.pngSample"),
          placeholderSrc:$r("app.media.loading")
        },syncLoad:true
      })
```

### 10. ImageKnifeAnimatorComponent 示例

```typescript
ImageKnifeAnimatorComponent({
        imageKnifeOption: {
          loadSrc:"https://gd-hbimg.huaban.com/e0a25a7cab0d7c2431978726971d61720732728a315ae-57EskW_fw658",
          placeholderSrc:$r('app.media.loading'),
          errorholderSrc:$r('app.media.failed')
        },animatorOption:this.animatorOption
      }).width(300).height(300).backgroundColor(Color.Orange).margin({top:30})
```

### 11. 加载图片回调信息数据 示例

```typescript
ImageKnifeComponent({ imageKnifeOption:  {
                loadSrc: $r('app.media.pngSample'),
                objectFit: ImageFit.Contain,
                onLoadListener: {
                  onLoadStart: (req) => {
                    let startCallBackData = JSON.stringify(req?.imageKnifeData);
                  },
                  onLoadFailed: (res, req) => {
                    let failedBackData = res + ";" + JSON.stringify(req?.imageKnifeData);
                  },
                  onLoadSuccess: (data, imageData, req) => {
                    let successBackData = JSON.stringify(req?.imageKnifeData);
                  },
                  onLoadCancel: (res, req) => {
                    let cancelBackData = res + ";" + JSON.stringify(req?.imageKnifeData);
                  }
                },
                border: { radius: 50 },
                onComplete: (event) => {
                  if (event && event.loadingStatus == 0) {
                    let render_success = JSON.stringify(Date.now())
                  }
                }
              }
}).width(100).height(100)
```

### 12. 图片降采样 示例

```typescript
ImageKnifeComponent({
        imageKnifeOption:{
          loadSrc:$r("app.media.pngSample"),
          placeholderSrc:$r('app.media.loading'),
          errorholderSrc:$r('app.media.failed'),
          downsampleOf: DownsampleStrategy.NONE
        }
      }).width(300).height(300)
```

### 13. rcp 自定义网络请求

```typescript
ImageKnifeComponent({
    imageKnifeOption:{
        loadSrc:"http//xx.xx",
        customGetImage:custom
     }
})
// 自定义下载方法
@Concurrent
async function custom(context: Context, src: string | PixelMap | Resource,headers?: Record<string,Object>): Promise<ArrayBuffer | undefined> {
  return new Promise((resolve,reject)=>{
    if (typeof src == "string") {
      let session = GetSession.session
      let req = new rcp.Request(src,"GET");
      session.fetch(req).then((response)=>{
        if(response.statusCode == 200) {
          let buffer = response.body
          resolve(buffer)
        } else {
          reject("rcp code:"+response.statusCode)
        }
      }).catch((err:BusinessError)=>{
        reject("error rcp src:"+src+",err:"+JSON.stringify(err))
      })
    }
  })
}
```

## 复用场景

在 aboutToRecycle 生命周期清空组件内容；通过 watch 监听触发图片的加载。

## 接口说明

### ImageKnife 组件

| 组件名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| ImageKnifeComponent | ImageKnifeOption | 图片显示组件 |
| ImageKnifeAnimatorComponent | ImageKnifeOption、AnimatorOption | 动图控制组件 |

### AnimatorOption 参数列表

| 参数名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| state | AnimationStatus | 播放状态（可选） |
| iterations | number | 播放次数（可选） |
| reverse | boolean | 播放顺序（可选） |
| onStart | ()=>void | 动画开始播放时触发（可选） |
| onFinish | ()=>void | 动画播放完成时或者停止播放时触发（可选） |
| onPause | ()=>void | 动画暂停播放时触发（可选） |
| onCancel | ()=>void | 动画返回最初状态时触发（可选） |
| onRepeat | ()=>void | 动画重复播放时触发（可选） |

### ImageKnifeOption 参数列表

| 参数名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| loadSrc | string、PixelMap、Resource | 主图展示 |
| placeholderSrc | PixelMap、Resource | 占位图图展示（可选） |
| errorholderSrc | PixelMap、Resource | 错误图展示（可选） |
| objectFit | ImageFit | 主图填充效果（可选） |
| placeholderObjectFit | ImageFit | 占位图填充效果（可选） |
| errorholderObjectFit | ImageFit | 错误图填充效果（可选） |
| writeCacheStrategy | CacheStrategyType | 写入缓存策略 (可选) |
| onlyRetrieveFromCache | boolean | 是否跳过网络和本地请求（可选） |
| customGetImage | customGetImage?:(context: Context, src: string、PixelMap、Resource ,headers?: Record<string, Object>) => Promise<ArrayBuffer、undefined> | 自定义下载图片（可选） |
| border | BorderOptions | 边框圆角（可选） |
| priority | taskpool.Priority | 加载优先级（可选） |
| context | common.UIAbilityContext | 上下文（可选） |
| progressListener | (progress: number)=>void | 进度（可选） |
| signature | String | 自定义缓存关键字（可选） |
| headerOption | Array | 设置请求头（可选） |
| transformation | PixelMapTransformation | 图片变换（可选） |
| drawingColorFilter | ColorFilter、drawing.ColorFilter | 颜色滤镜效果（可选） |
| onComplete | (event:EventImage、undefined) => void | 图片成功回调事件 (可选) |
| onLoadListener | onLoadStart?: (req?: ImageKnifeRequest) => void,onLoadSuccess?: (data: string | PixelMap | undefined, imageData: ImageKnifeData, req?: ImageKnifeRequest) => void,onLoadFailed?: (err: string, req?: ImageKnifeRequest) => void,onLoadCancel?: (res: string, req?: ImageKnifeRequest) => void | 监听图片加载成功与失败 |
| downsampleOf | DownsampleStrategy | 降采样（可选） |
| httpOption | HttpRequestOption | 网络请求配置（可选） |
| pixelName | string | 位图命名（可选） |
| dynamicRangeMode | DynamicRangeMode | 期望展示的图像动态范围（可选） |

### 降采样类型

| 类型 | 相关描述 |
| :--- | :--- |
| NONE | 不进行降采样 |
| AT_MOST | 请求尺寸大于实际尺寸不进行放大 |
| FIT_CENTER_MEMORY | 两边自适应内存优先 |
| FIT_CENTER_QUALITY | 两边自适应质量优先 |
| CENTER_INSIDE_MEMORY | 宽高缩放比最大的比例，进行缩放适配内存优先 |
| CENTER_INSIDE_QUALITY | 宽高缩放比最大的比例，进行缩放适配质量优先 |
| AT_LEAST | 根据宽高的最小的比例，进行适配 |

### ImageKnife 接口

| 参数名称 | 入参内容 | 功能简介 |
| :--- | :--- | :--- |
| initMemoryCache | newMemoryCache: IMemoryCache | 自定义内存缓存策略 |
| initFileCache | context: Context, size: number, memory: number | 初始化文件缓存数量和大小 |
| reload | request: ImageKnifeRequest | 图片重新加载 |
| preLoad | loadSrc: string I ImageKnifeOption | 预加载返回图片请求 request |
| cancel | request: ImageKnifeRequest | 取消图片请求 |
| preLoadCache | loadSrc: string I ImageKnifeOption | 预加载并返回文件缓存路径 |
| getCacheImage | loadSrc: string, cacheType: CacheStrategy = CacheStrategy.Default, signature?: string) | 从内存或文件缓存中获取资源 |
| getCacheImageSync | loadSrc: string, cacheType: CacheStrategy = CacheStrategy.Default, signature?: string) | 从内存或文件缓存中获取资源同步接口 |
| addHeader | key: string, value: Object | 全局添加 http 请求头 |
| setHeaderOptions | Array | 全局设置 http 请求头 |
| deleteHeader | key: string | 全局删除 http 请求头 |
| setCustomGetImage | customGetImage?: (context: Context, src: string、PixelMap、Resource ,headers?: Record<string, Object>) => Promise<ArrayBuffer、undefined> | 全局设置自定义下载 |
| setEngineKeyImpl | IEngineKey | 全局配置缓存 key 生成策略 |
| setMaxRequests | concurrency: number | 设置默认并发数量 |
| setConnectTimeout | timeout: number | 设置连接超时时长 |
| setReadTimeout | timeout: number | 设置读取超时时长 |
| putCacheImage | url: string, pixelMap: PixelMap, cacheType: CacheStrategy = CacheStrategy.Default, signature?: string | 写入内存磁盘缓存 |
| removeMemoryCache | url: string、ImageKnifeOption | 清理指定内存缓存 |
| removeFileCache | url: string、ImageKnifeOption | 清理指定磁盘缓存 |
| removeAllMemoryCache | - | 清理所有内存缓存 |
| removeAllFileCache | - | 清理所有磁盘缓存 |
| getCacheLimitSize | cacheType?: CacheStrategy | 获取指定缓存的上限大小 |
| getCurrentCacheNum | cacheType?: CacheStrategy | 获取指定缓存的当前缓存图片个数 |
| getCurrentCacheSize | cacheType?: CacheStrategy | 获取指定缓存的当前大小 |

### 回调接口说明

| 回调接口 | 回调字段 | 回调描述 |
| :--- | :--- | :--- |
| onLoadStart | req: ImageKnifeRequest | req 返回字段中包含了图片请求的信息，如图片的 url 及其组件的宽高，同时 ImageKnifeRequest 包含了 ImageKnifeData，其中包含此次请求的开始及其检查内存缓存的时间点 |
| onLoadSuccess | data: string、PixelMap、undefined, imageData: ImageKnifeData, req?: ImageKnifeRequest | data:加载成功的结果数据；imageData：图片的存入缓存中的信息 ，req：图片请求的信息，同时其中的 ImageKnifeData，包含此次请求中图片的原始大小、图片的解码大小、格式、图片帧、请求结束时间、磁盘检查时间、网络请求开始结束、图片解码开始结束等时间点 |
| onLoadFailed | err: string, req?: ImageKnifeRequest | err:错误信息描述；req：图片请求的信息，同时其中的 ImageKnifeData，包含此次请求错误信息（ErrorInfo，TimeInfo），ErrorInfo 其中包含了，错误阶段、错误码及其网络请求的错误码；TimeInfo 中包含请求结束时间、磁盘检查时间、网络请求开始结束、图片解码开始结束等时间点 |
| onLoadCancel | reason: string, req?: ImageKnifeRequest | reason:取消回调原因；req：图片请求的信息，同时其中的 ImageKnifeData，包含此次请求错误信息（ErrorInfo，TimeInfo），ErrorInfo 其中包含了，错误阶段、错误码及其网络请求的错误码；TimeInfo 中包含请求结束时间、磁盘检查时间、网络请求开始结束、图片解码开始结束及其请求取消等时间点 |

### 图形变换类型（需要为 GPUImage 添加依赖项）

| 类型 | 相关描述 |
| :--- | :--- |
| BlurTransformation | 模糊处理 |
| BrightnessTransformation | 亮度滤波器 |
| CropSquareTransformation | 正方形剪裁 |
| CropTransformation | 自定义矩形剪裁 |
| GrayScaleTransformation | 灰度级滤波器 |
| InvertTransformation | 反转滤波器 |
| KuwaharaTransformation | 桑原滤波器（使用 GPUIImage） |
| MaskTransformation | 遮罩 |
| PixelationTransformation | 像素化滤波器（使用 GPUIImage） |
| SepiaTransformation | 乌墨色滤波器（使用 GPUIImage） |
| SketchTransformation | 素描滤波器（使用 GPUIImage） |
| SwirlTransformation | 扭曲滤波器（使用 GPUIImage） |
| ToonTransformation | 动画滤波器（使用 GPUIImage） |
| VignetterTransformation | 装饰滤波器（使用 GPUIImage） |

## 下载安装 GPUImage 依赖

### 方法一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

```bash
ohpm install @ohos/gpu_transform
```

### 方法二

在工程的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": {
  "@ohos/gpu_transform": "^1.0.2"
}
```

## 约束与限制

在下述版本验证通过：DevEco Studio 5.1.0 Release（5.1.0.849）, SDK: API18 Release(5.1.0.849)

## 目录结构

```text
/ImageKnife        # 项目根目录
├── entry          # 示例代码文件夹
├── library        # ImageKnife 库文件夹
│   ├── src/main/ets   
│   │   ├── 3rd_party  # MD5 哈希算法实现
│   │   ├── cache      # 缓存相关实现
│   │   ├── components # 组件实现
│   │   ├── downsampling # 图片降采样
│   │   ├── key        # 缓存键生成
│   │   ├── loaderStrategy # 图片加载策略
│   │   ├── model      # 数据模型
│   │   ├── parseStrategy # 图片解析策略
│   │   ├── queue      # 请求队列
│   │   ├── transform  # 图片变换
│   │   ├── utils      # 工具类
│   │   ├── ImageKnife.ets # 核心类
│   │   ├── ImageKnifeDispatcher.ets # 请求调度器
│   │   └── ImageKnifeLoader.ets # 图片加载器
│   └── index.ets  # 导出库中 API
├── sharedlibrary  # 用于验证 ImageKnife 库跨模块读取图片功能
├── gpu_transform  # GPU 变换相关模块
├── README.md      # 英文安装使用说明
└── README_zh.md   # 中文安装使用说明
```

## 关于混淆

代码混淆，请查看代码混淆简介。如果希望 imageknife 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/imageknife
```

## 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

## 更新记录

### 3.2.8

- Modify the optimization level of dynamic libraries

### 3.2.8-rc.3

- Add an interface for synchronizing image cache resource retrieval

### 3.2.8-rc.2

- Adapt the getImagePropertySync synchronization interface

### 3.2.8-rc.1

- Network requests add skip certificate validation

### 3.2.8-rc.0

- Fix bug: Custom requests can only set network diagrams.

### 3.2.7

- Fix bug: The request for the placeholder map failed, causing the main image to not be displayed
- Fix bug: Occupation map request failed, repeated request
- Add HDR effect to the image
- Added network custom DNS

### 3.2.7-rc.2

- Fix ImageKnifeAnimator component unable to load

### 3.2.7-rc.1

- Replace abandoned interfaces
- Change the transmission of PixelMap to sendableImage. PixelMap in the emit interface

### 3.2.7-rc.0

- Add image naming function

### 3.2.6

- Add and adapt ImageKnifeComponentV2
- Add and adapt ImageKnifeAnimatorComponentV2
- Fix string type placeholder not displaying
- Fix string type errorholder not displaying
- Only the main image enters the queue for processing

### 3.2.6-rc.0

- ImageKnife Option does not initiate a request when the attribute content remains unchanged during loading
- Fix custom network causing local images to fail to load

### 3.2.5

- Fix image retry function failure

### 3.2.4

- Repeated requests to destroy other components with different IDs or versions in the state of proxies are issued

### 3.2.4-rc.1

- Use system components to load placeholders instead
- Duplicate Request Merge: Merge all duplicate requests into one request

### 3.2.4-rc.0

- Fix preloadCache interface setting ImageKnife Option callback failure
- The images that failed during the decoding phase were fixed and stored in the file cache
- Add hiTrace to each loading step
- Type does not support adding request header information to error logs

### 3.2.3

- File cache storage failed, recreate cache directory

### 3.2.3-rc.0

- Fix the placeholder map error and set ImageFit Auto is invalid
- Add global setting network timeout duration interface
- Fix file cache quantity exceeding lru quantity

### 3.2.2

- Cancel threads when destroying components
- Modify the error callback component ID and version log
- Request for main image not entering queue without value transmission

### 3.2.2-rc.2

- Requests that do not display a placeholder map in the queue, the placeholder map issues a request to read memory
- Release showPixelMap callback when destroying ImageKnife Component
- Fix memory leaks caused by arrayBuffer

### 3.2.2-rc.1

- Support EXIF metadata carried by images as display orientation

### 3.2.2-rc.0

- Add ImageKnifeComponent to destroy network request interruption
- Code refactoring during the download of image resources stage

### 3.2.1

- Release official version

### 3.2.1-rc.0

- Fix bug: CropTransformation is used to crop the original image
- Fix bug: After calling the clear all file cache interfaces, the file cache becomes invalid 
- Optimize the efficiency of file cache initialization.
- Add protection at the location where loadSrc is passed in the pixelmap type

### 3.2.0

- When successfully requesting the network, return the httpcode as well
- Fix bug: Network error code httpCode returns no data
- Modify implementation of ImageFit.Auto: do not modify image height
- Modify memory cache limit and file cache limit
- Fix record decodeEndTime in imageKinfaData
- Add image buffersize in memory cache
- Optimize the magic number of heif format image files
- Fix bug: The width and height of the downsampling component are inconsistent with the image resolution unit

### 3.2.0-rc.6

- Support LogUtil to turn off log
- Support set network request readTimeout and connectTimeout through ImageKnifeOption

### 3.2.0-rc.5

- Enhance: ImageFit.Auto support adaptive height after component width change
- Fix bug: call onLoadStart 2 times(import from 3.2.0-rc.0)
- Change the initial value of the PixelMap component of ImageKnife to ImageContent EMPTY
- Clear memory cache, cancel pixel map release
- Loading process log modification
- Change the network request readTimeout to 30s

### 3.2.0-rc.4

- Support ICO format images
- Fix bug: call reload problem in onLoadFailed
- Provide default downsampling strategy to prevent slow loading for large images

### 3.2.0-rc.3

- Fix bug: PixelMap size exceeds the maximum value of memory cache and is not cached
- Dealing with exception scenarios where imageSource.getImageInfo return undefined
- Fix inability to parse Resource format images of other modules
- Improve the error logs
- Fix callback onLoadFailed when taskpool exception occurs
- ImageKnife AnimatorComponent component adds rounded corner function

### 3.2.0-rc.2

- Added callback information for image loading
- Added the interface for obtaining the upper limit and size of the current cache and the number of images corresponding to the current cache
- HTTPS custom certificate verification
- Add downsampling function to reduces memory cache consumption

### 3.2.0-rc.1

- Change the queue from Stack to Queue
- ShowPixelMap callback PixelMap assigns value to Image component to synchronize

### 3.2.0-rc.0

- Rollback the old version V1 decorator. V2 decorator will be provided in version 4.x
- The sub-thread network request is changed to asynchronous, thereby increasing the number of concurrent sub-thread network requests
- Set the concurrency through the setMaxRequests interface under the ImageKnife class
- aboutToRecycle life cycle clear image content
- Fixed bug for receive only the first onLoadStart for concurrent identical requests
- Modify the condition for determining whether to queue to be greater than or equal to maxRequests

### 3.1.1-rc.1

- Photo reduction sampling

### 3.1.1-rc.0

- 重构代码：抽取 ImageKnifeDispatcher 子线程 requestJob 相关代码到 ImageKnifeLoader 中，降低函数复杂度

### 3.1.0

- 部分静态 webp 图片有 delay 属性导致识别成动图，改用 getFrameCount 识别
- 修复加载错误图后未去请求排队队列中的请求
- 子线程本地 Resource 参数类型转换成 number
- 修改使用 hilog 记录日志，默认打开 debug 级别的日志
- file 格式图片，fd 同步 close
- 解码 pixelMap 默认不可编辑，图形变化可编辑
- 修改网络请求超时设置

### 3.1.0-rc.2

- 修复宽高不等 svg 图片显示有毛边

### 3.1.0-rc.1

- ImageKnifeAnimatorComponent 新增开始、结束、暂停的回调事件
- 文件缓存数量负数和超过 INT 最大值时默认为 INT 最大值

### 3.1.0-rc.0

- ComponentV2 装饰器适配
- imageKnifeOption={...}用法改为 new ImageKnifeOption({...})
- animatorOption={...}用法改为 new AnimatorOption({...})

### 3.0.3

- Released version 3.0.3

### 3.0.3-rc.0

- Custom network method to add request header parameters

### 3.0.2

- Added new image reloading interface reload
- Added return request preload interface preload
- Added cancel request interface cancel

### 3.0.2-rc.2

- ImageKnifeAnimatorComponent 新增开始、结束、暂停的回调事件
- 文件缓存数量负数和超过 INT 最大值时默认为 INT 最大值
- 修复宽高不等 svg 图片显示有毛边
- 部分静态 webp 图片有 delay 属性导致识别成动图，改用 getFrameCount 识别
- 修复加载错误图后未去请求排队队列中的请求
- 子线程本地 Resource 参数类型转换成 number
- 修改使用 hilog 记录日志，默认打开 debug 级别的日志
- 解码 pixelMap 默认不可编辑，图形变化可编辑
- 修改网络请求超时设置
- 重构代码：抽取 ImageKnifeDispatcher 子线程 requestJob 相关代码到 ImageKnifeLoader 中，降低函数复杂度

### 3.0.2-rc.1

- release 打包关闭混淆

### 3.0.2-rc.0

- FileUtil.readFile 接口和 file 格式图片同步关闭 fd

### 3.0.1

- 修复 animatorOption 属性设置初始化值失效
- 网络请求 code 为 206、204 时返回 arraybuffer
- ImageKnifeComponent 显示非必要文件缓存初始化
- 修复 webp 静态图无法设置图形变换

### 3.0.1-rc.2

- 修复自定义下载失败无失败回调
- 增加全局配置自定义下载接口
- 修复主图相同，错误图不同导致只显示一个错误图
- heic 格式图片文件魔数从第五位开始匹配

### 3.0.1-rc.1

- 新增 ImageKnifeAnimatorComponent 控制动图组件
- 修复部分 heif 图无法解码

### 3.0.1-rc.0

- 文件缓存设置最大缓存数量改为无限制

### 3.0.0

- 修复图形变换的闪退问题
- 自定义下载 customGetImage 改为仅主图支持
- 修改网络请求 requestInStream 配置优先返回 arraybuffer
- 新增 ColorFilter 属性

### 3.0.0-rc.9

- 修复 Resource 类型$r(变量无法) 加载
- 成功回调增加图片格式
- Image 组件增加 onComplete 回调
- 修复 404 链接无返回错误信息
- onLoadListener 增加请求取消回调

### 3.0.0-rc.8

- svg 解码单位改为 px
- 修复预加载接口 preLoadCache 传 ImageKnifeOption 失效
- 文件缓存初始化接口新增目录参数
- 占位图从内存获取提前到判断队列前面
- 图片改为不可拖拽
- 修复 getCacheImage 默认内存获取后不返回数据
- 成功回调返回 GIF 图宽高

### 3.0.0-rc.7

- 修复成功回调获取不到宽高
- 新增 svg 图片解码
- 新增媒体图片 file://格式
- 修复头像超过设备高度图片闪动问题 - 消息列表底部头像闪动问题

### 3.0.0-rc.6

- 支持多种组合变换
- 支持全局配置是否在子线程请求加载图片，默认在子线程
- 文件缓存初始化增加默认值
- 预加载接口新增返回加载错误信息
- 加载队列改为使用堆 Stack
- fileType 图片格式新增 heic 格式

### 3.0.0-rc.5

- 图片加载事件增加请求开始的回调，以及修复有缓存时，没有回调的 bug
- 修复对已销毁组件不再下发请求的逻辑
- 加载图片流程添加日志
- 子线程写入文件缓存获取 buffer 优化
- 成功回调增加返回图片分辨率宽高
- 内存缓存时将 pixelMap 进行 release 释放
- 提供清理缓存能力

### 3.0.0-rc.4

- 支持 hsp 多包图片资源
- 新增 putCache 写入缓存接口
- 修复入参为 pixelMap 图片不显示问题
- 网络请求减少拼接操作，修复网络加载速度慢
- 提供图片加载成功/失败的事件

### 3.0.0-rc.3

- 将请求默认并行从 64 调整到 8，减少对 taskpool execute 内存消耗
- 补充 option 参数：placeholderObjectFit，errorholderObjectFit 分别支持占位图填充效果和错误图填充效果

### 3.0.0-rc.2

- 新增支持使用一个或多个图片变换，如模糊，高亮等

### 3.0.0-rc.1

- 新增从内存或文件缓存获取图片数据接口 getCacheImage
- 新增图片预加载 preLoadCache 并返回文件缓存路径
- ImageKnifeOption 新增 writeCacheStrategy 存入策略 (只存入内存或文件缓存)
- ImageKnifeOption 新增 onlyRetrieveFromCache 仅用缓存加载
- 新增单个和全局请求头
- 补齐自定 key 特性
- 获取组件宽高改用 onSizeChange （需要 API12）

### 3.0.0-rc.0

- 使用 Image 组件替换 Canvas 组件渲染，并重构大部分的实现逻辑，提升渲染性能

#### 较 2.x 版本增强点：

- 使用 Image 组件代替 Canvas 组件渲染
- 重构 Dispatch 分发逻辑，支持控制并发请求数，支持请求排队队列的优先级
- 支持通过 initMemoryCache 自定义策略内存缓存策略和大小。
- 支持 option 自定义实现图片获取/网络下载
- 继承 Image 的能力，支持 option 传入 border，设置边框，圆角
- 继承 Image 的能力，支持 option 传入 objectFit 设置图片缩放
- 修复发送消息时最近的两条消息头像闪动的问题

#### 缺失特性

- 不支持 drawLifeCycle 接口，通过 canvas 自会图片
- mainScaleType，border 等参数，新版本与系统 Image 保持一致
- gif/webp 动图播放与控制
- signature 自定义 key 的实现
- 支持进行图片变换：支持图像像素源图片变换效果。
- 抗锯齿相关参数

### 2.2.0-rc.2

- ImageKnife 支持 heic 图片修改 demo，按钮控制组件是否展示
- ImageKnife 控制可视化区域图片

### 2.2.0-rc.1

- 修改 ImageKnife 跳过网络，点击默认，图片没有传入宽高，无显示 bug
- ImageKnife 支持根据自定义 key 获取已缓存的图片
- ImageKnife 加载图片支持自定义网络栈和图片加载组件
- 适配复用场景触发懒加载 onDataReloaded
- ImageKnife 控制重要图片请求加载优先级

### 2.2.0-rc.0

- 修复自定义 DataFetch 接口实现不生效问题
- 修改磁盘缓存到子线程
- 更新 SDK 到 API12
- 适配 Sendable 内存共享优化
- 修改全局请求头覆盖 request 请求头
- imageKnife 支持 heic 测试 demo 独立页面展示
- drawLifeCycle 支持 gif 图

### 2.1.2

- 修改 ImageKnife 跳过网络，从内存中获取图片 cacheType 参数未使用 bug
- 新增 WEBP 图片解析能力。
- 新增 gif 图片支持暂停播放功能

### 2.1.2-rc.12

- 新增 gif 播放次数功能
- 新增磁盘预加载返回文件路径接口 prefetchToDiskCache
- 新增跳过网络判断缓存或者磁盘中是否存在图片接口 isUrlExist
- 删除多余操作磁盘记录读写
- 清除定时器改为 Gif 图时清除
- uuid 改为 util.generateRandomUUID()

### 2.1.2-rc.11

- 修复设置磁盘容量最大值出现闪退
- 修复概率出现 jscrash 问题
- 修复进度条问题
- 修复单帧 gif 图片加载失败
- removeRunning 删除 running 队列 log 设置开关
- ImageKnife 新增图片宽高自适应功能
- 修复 onlyRetrieveFromCache 属性 (仅磁盘和内存获取资源) 失效
- 修改拼写错误
- 新增多线程优先级
- 修复复用场景下图片闪动以及概率错位
- 获取组件宽高改为使用 CanvasRenderingContext2D 对象获取宽高，并修复改变字体大小导致部分图片消失
- 修复获取不到磁盘缓存文件问题
- 修复获取不到网络请求错误回调问题

### 2.1.2-rc.10

- 修复部分 gif 图片识别成静态图
- 修复同一张图片发送多次请求
- 复用场景缓存到树 aboutToRecycle 清理定时器

### 2.1.2-rc.9

- 使用 taskpool 实现多线程加载图片资源
- 修复部分 gif 图片识别成静态图
- 修复同一张图片发送多次请求
- disAppear 生命周期清空定时器只在 gif 图片时执行

### 2.1.2-rc.8

- onAreaChange 绘制图片改为 component Util 绘制

### 2.1.2-rc.7

- 修复图片圆角图形变换导致抗锯齿、ScaleType 失效
- 修复使用模糊化出现图片变模糊和变形

### 2.1.2-rc.6

- 修复手机调节显示大小时图片消失
- imageKnife 防盗链，header 请求头属性设置
- pngWorker 线程改为 taskpool
- 修复正方形裁剪有些图片裁剪创建 pixelMap 失败

### 2.1.2-rc.5

- moduleContext 新增缓存策略，缓存上限 5，缓存策略 Lru
- 适配 DevEco Studio 4.1（4.1.3.415）--SDK:API11（ 4.1.0.56）

### 2.1.2-rc.4

- canvas 新增抗锯齿
- 修复图片缩放时出现重影

### 2.1.2-rc.3

- svg 图片解码改为 imageSource 解码

### 2.1.2-rc.2

- HSP 兼容性优化
- 暴露 DetachFromLayout 接口
- 修复无法识别部分 svg 图片的类型

### 2.1.2-rc.1

- 修复断网状态下错误占位图不显示
- 适配 IDE4.1(4.1.3.322) 和 SDK API11(4.1.0.36)

### 2.1.2-rc.0

- 开放.jpg .png .gif 的 taskpool 解码能力

### 2.1.1

- 屏蔽了 taskpool 解码能力
- 2.1.1 正式版本发布

### 2.1.1-rc.5

- .jpg .png .gif 解码功能使用 taskpool 实现
- 修复了内存缓存张数设置为 1 时 gif 图片消失的问题
- 新增内存缓存策略，新增缓存张数，缓存大小设置接口
- 磁盘存缓存 setAsync 改成同步
- 部分 release 释放放在异步
- requestInStream 的回调改成异步
- 修复 tasktool 出现 crash 问题
- imageKnife 依赖更名为 library
- 解决外部定时器失效的问题

### 2.1.1-rc.4

- 删除 pako 源码依赖，使用 ohpm 依赖
- 删除 gif 软解码相关依赖库，包括 gifuct-js 和 jsBinarySchemaParser
- 新增 ImageKnife 在 HSP 场景中的使用案例展示
- 更改 ImageKnifeOption：
  - 新增可选参数 context,HSP 场景中在 shard library 中使用必须要传递当前 library 的 context 对象（例如:getContext(this).createModuleContext('library') as common.UIAbilityContext）才能保证后续程序正常获取 shared library 中的 Resource 资源
- 更改 RequestOption:
  - 新增接口 setModuleContext(moduleCtx:common.UIAbilityContext) 在 HSP 场景中必须调用该接口传入正确的 context 对象，保证 HSP 场景下正确访问资源
  - 新增接口 getModuleContext():common.UIAbilityContext | undefined

### 2.1.1-rc.3

- 门面类 ImageKnife 新增 pauseRequests 接口，全局暂停请求
- 门面类 ImageKnife 新增 resumeRequests 接口，全局恢复暂停

### 2.1.1-rc.2

- gif 解码改为 imageSource 解码，不在对 worker 强依赖
- 下载接口修改为 http.requestInStream

### 2.1.1-rc.1

- 新增自定义 key 参数配置
- 新增 MemoryLruCache 主动调用 PixelMap 的 release 方法，释放 native 的 PixelMap 内存
- 新增 ImageSource 主动调用 release 方法释放 native 持有的 ImageSource 内存

### 2.1.1-rc.0

- 修复不兼容 API9 的问题

### 2.1.0

- ArkTs 语法适配：
  - globalThis.ImageKnife 方式已经不可使用
  - 提供了 ImageKnifeGlobal 对象单例全局可访问
  - 访问 ImageKnife 对象需要使用 ImageKnifeGlobal.getInstance().getImageKnife()
- 裁剪组件暴露 PixelMapCrop 组件和配置类 Options，配置类 Options 不再需要声明 PixelMapCrop.Options 中的 PixelMapCrop 命名空间
- 适配 DevEco Studio 版本：4.0(4.0.3.512), SDK: API10 (4.0.10.9)

### 2.0.5-rc.0

- 修复若干问题：
  - 优化了内存缓存策略，修复了内存缓存策略给布尔值不生效的问题

### 2.0.4

- 修复若干问题：
  - 修复了 pngj 测试页面，快速点击导致应用闪退的问题

### 2.0.3

- 修复若干问题：
  - 修复了部分 url 测试，多次点击加载 gif 动画重影的问题
  - 优化了 gif 测试中的测试图片，加强了测试的直观性
  - 解决 gif 图片只有 1 帧时因帧时间延时时间为 NaN 时导致图片帧不显示的问题

### 2.0.2

- 修复若干问题：
  - 修复 ImageKnife 绘制部分复杂 gif 图片，gif 图片闪屏显示的问题
  - 适配 DevEco Studio 版本：4.0 Canary2(4.0.3.312), SDK: API10 (4.0.9.3)

### 2.0.1

- 修复若干问题：
  - 修复 ImageKnifeDrawFactory 中的 setOval 和 setRect 的中心点取值错误，导致部分圆角绘制失效的问题。
  - 修复因重复下载导致的漏加载的问题。
- 新增用例看护已修复的问题

### 2.0.0

- 包管理工具由 npm 切换为 ohpm。
- 适配 DevEco Studio: 3.1Beta2(3.1.0.400)。
- 适配 SDK: API9 Release(3.2.11.9)。
- 新增开发者可对图片缓存进行全局配置能力。
- 新增对 OpenHarmony 图库的 Uri 数据加载的能力（需要申请图库访问权限和文件读取权限，动态申请图库访问权限）。
- 修复若干问题：
  - ImageKnifeOption 的 loadSrc 为 undefined，导致的 crash 问题。
  - ImageKnifeComponent 直接绘制 GIF 图片格式第几帧的时候，无法绘制问题。

### 1.0.6

- 适配 DevEco Studio 3.1Beta1 及以上版本。
- 适配 OpenHarmony SDK API version 9 及以上版本。
- 以下变换支持通过 GPU 进行图片变换，默认未开启，开启需要自行调用接口.enableGPU()。
  - 支持模糊图片变换
  - 支持亮度滤波器
  - 支持颜色反转滤波器
  - 支持对比度滤波器
  - 支持灰色滤波器
  - 支持桑原滤波器
  - 支持马赛克滤波器
  - 支持乌墨色滤波器
  - 支持素描滤波器
  - 支持扭曲滤波器
  - 支持动画滤波器
  - 支持装饰滤波器

### 1.0.5

- 自定义组件已支持通用属性和通用事件绑定，因此 ImageKnifeComponent 将删除相关内容，相关内容由用户自定义实现，提高扩展能力。
- ImageKnifeOption 支持列表绑定。
- ImageKnifeOption 。
- 新增
  - 1.onClick 事件属性
- 删除
  - 1.size(设置大小)
  - 2.sizeAnimated 显式动画
  - 3.backgroundColor 背景色
  - 4.margin 组件外间距 等属性，删除的属性将由通用属性提供支持，可支持在 ImageKnifeComponent 自定义组件上链式调用

### 1.0.4

- 渲染显示部分使用 Canvas 组件替代 Image 组件。
- 重构渲染封装层 ImageKnifeComponent 自定义组件。
- 新增 GIF 图片解析能力。
- 新增 SVG 图片解析能力。
- RequestOption 删除 addRetryListener 接口，重试图层监听请使用 retryholder 接口。

### 1.0.3

- 适配 OpenHarmony API9 Stage 模型。

### 1.0.2

- 支持用户自定义扩展变换接口。

### 1.0.1

- 由 gradle 工程整改为 hvigor 工程。

### 1.0.0

专门为 OpenHarmony 打造的一款图像加载缓存库，致力于更高效、更轻便、更简单：

- 支持内存缓存，使用 LRUCache 算法，对图片数据进行内存缓存。
- 支持磁盘缓存，对于下载图片会保存一份至磁盘当中。
- 支持进行图片变换。
- 支持用户配置参数使用:(例如：配置是否开启一级内存缓存，配置磁盘缓存策略，配置仅使用缓存加载数据，配置图片变换效果，配置占位图，配置加载失败占位图等)。
- 推荐使用 ImageKnifeComponent 组件配合 ImageKnifeOption 参数来实现功能。
- 支持用户自定义配置实现能力参考 ImageKnifeComponent 组件中对于入参 ImageKnifeOption 的处理。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 隐私政策

不涉及 SDK 合规使用指南 不涉及

## 兼容性

| HarmonyOS 版本 | 5.0.1 |
| :--- | :--- |
| Created with Pixso. | |

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. | |

| 元服务 | |
| :--- | :--- |
| Created with Pixso. | |

| 设备类型 | 手机 |
| :--- | :--- |
| Created with Pixso. | |

| 平板 | |
| :--- | :--- |
| Created with Pixso. | |

| PC | |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.5 |
| :--- | :--- |
| Created with Pixso. | |

## 安装方式

```bash
ohpm install @ohos/imageknife
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b9a0ed5d65fe43b5925b0cfb52ffb887/PLATFORM?origin=template