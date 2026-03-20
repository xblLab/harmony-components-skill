# SVGA 动画播放组件

## 简介

SVGA HarmonyOS 版播放器

## 详细介绍

### 简介

SVGA 是一种轻量级的动画格式，相比 GIF 和 APNG 格式，它支持更多的动画特性，如透明度、缩放和旋转等，同时文件体积更小，播放性能更好。本库提供了完整的 SVGA 动画播放支持，适用于 HarmonyOS Next。

### 安装

```bash
ohpm install @tb-open/svga
```

### 基本使用

#### 配置

```typescript
import { AbilityStage } from "@kit.AbilityKit";
import { Logger, LogLevel, Svga } from "svga";

export class AppAbility extends AbilityStage {
    onCreate(): void {
        // 初始化
        Svga.init(this.context)
        // 默认 128M，App 可自行调整。
        Svga.setCacheSize(512 * 1024 * 1024)
        Svga.setLogLevel(LogLevel.DEBUG)
        
        // 如 UI 中不再使用到 svga，可以使用 clearCache()
        // Svga.clearCache()
    }
}
```

#### 引入依赖

```typescript
import { SvgaPlayer, SvgaPlayerV2, SvgaController } from '@tb-open/svga';
```

#### 简单使用

```typescript
// 声明式 UI 1.0 版本组件
SvgaPlayer({
  url: $r('app.media.example_animation'),
  controller: this.controller
})
  .width(300)
  .height(150)

// 声明式 UI 2.0 版本组件
SvgaPlayerV2({
  url: $r('app.media.example_animation'),
  controller: this.controller
})
  .width(300)
  .height(150)
```

#### 创建控制器

```typescript
private controller: SvgaController = new SvgaController({
  loops: 3,                    // 播放 3 次
  fillMode: 'forwards',        // 播放结束后停留在最后一帧
  pageUpdateMode: 'pause',     // 页面切换时暂停动画
  autoRelease: true,           // 页面销毁时自动释放资源
  clearsAfterStop: true        // 停止播放后清理资源
});
```

#### 加载资源

url 支持以下三种类型的资源：

*   应用资源：`$r('app.media.example_animation')`
*   远程 URL：`'https://example.com/animation.svga'`
*   沙箱路径：完整的文件系统路径

```typescript
// 在组件的 onReady 生命周期中加载
aboutToAppear() {
  // 通过组件属性加载，自动播放
  
  // 或者使用 controller 手动加载
  this.controller.load($r('app.media.example_animation'), true); // 第二个参数为是否自动播放
}
```

### 控制器 API 详解

#### 播放控制

```typescript
// 开始播放
controller.startAnimation();

// 从指定帧开始播放
controller.stepToFrame(10, true);  // 从第 10 帧开始播放

// 从指定百分比位置开始播放
controller.stepToPercentage(0.5, true); // 从 50% 进度开始播放

// 倒序播放
controller.startAnimation(true);

// 播放指定范围
controller.startAnimationWithRange({ location: 10, length: 30 }); // 播放 10-40 帧

// 暂停播放
controller.pauseAnimation();

// 停止播放
controller.stopAnimation(true); // 参数为是否清理资源
```

#### 动态替换内容

```typescript
// 替换图片
controller.setImage($r('app.media.custom_image'), 'image_key');

// 替换文本 - 简单方式
controller.setText('替换文本', 'text_key');

// 替换文本 - 高级方式
controller.setText({
  text: '替换文本',
  size: '18px',
  family: 'HarmonyOS Sans',
  color: '#FF0000',
  weight: 'bold',
  offset: { x: 0, y: 0 }
}, 'text_key');

// 清理所有动态替换的内容
controller.clearDynamicObjects();
```

#### 事件监听

```typescript
// 播放完成回调
controller.onFinished(() => {
  console.info('动画播放完成');
});

// 帧变化回调
controller.onFrame((frame) => {
  console.info(`当前帧：${frame}`);
});

// 进度变化回调
controller.onPercentage((percent) => {
  console.info(`当前进度：${percent * 100}%`);
});

// 错误处理回调
controller.onError((error) => {
  console.error('SVGA 错误:', error);
  // 根据错误码进行不同处理
  switch (error.code) {
    case SvgaErrorCode.NETWORK_ERROR:
      promptAction.showToast({ message: '网络连接失败' });
      break;
    case SvgaErrorCode.FILE_NOT_FOUND:
      promptAction.showToast({ message: '动画文件不存在' });
      break;
    default:
      promptAction.showToast({ message: error.message });
  }
});
```

### 资源释放

```typescript
// 手动释放资源
controller.release();
```

### 错误处理和日志系统

#### 错误处理

SVGA 库提供了完善的错误处理机制，所有错误都通过回调函数传递给用户处理：

```typescript
import { SvgaController, SvgaErrorCode } from '@tb-open/svga';

const controller = new SvgaController();

// 设置错误处理回调
controller.onError((error) => {
  console.error('SVGA 错误:', error);

  // 根据错误码进行处理
  switch (error.code) {
    case SvgaErrorCode.NETWORK_ERROR:
      // 网络错误处理
      break;
    case SvgaErrorCode.FILE_NOT_FOUND:
      // 文件不存在处理
      break;
    case SvgaErrorCode.PLAYER_NOT_READY:
      // 播放器未准备就绪处理
      break;
    default:
      // 其他错误处理
      break;
  }
});
```

#### 日志配置

可以配置日志系统的行为：

```typescript
import { Logger, LogLevel } from '@tb-open/svga';

// 设置日志级别
Logger.setLogLevel(LogLevel.INFO);

// 详细配置
Logger.setConfig({
  level: LogLevel.DEBUG,
  enableConsole: true,        // 开发环境启用
  enablePerformance: true,    // 启用性能监控
  maxLogLength: 1000,         // 日志长度限制
  enableStackTrace: true      // 包含堆栈信息
});

// 生产环境配置
if (process.env.NODE_ENV === 'production') {
  Logger.setLogLevel(LogLevel.ERROR);
  Logger.setConfig({
    enableConsole: false,
    enablePerformance: false
  });
}
```

详细的错误处理指南请参考：错误处理指南

### 属性说明

| 参数 | 作用 | 类型 | 默认值 |
| :--- | :--- | :--- | :--- |
| pageUpdateMode | 页面切换时播放器处理模式 | `'pause' \| 'play' \| 'release'` | `'pause'` |
| loops | 动画播放次数 | `number` | `Infinity` |
| autoRelease | 页面销毁时是否自动清理资源 | `boolean` | `true` |
| clearsAfterStop | 播放完成是否自动释放资源 | `boolean` | `true` |
| fillMode | 播放完成后停留位置 | `'forwards' \| 'backwards'` | `'forwards'` |
| contentMode | 内容填充模式 | `'AspectFit' \| 'Fill' \| 'AspectFill'` | `'AspectFit'` |

### 高级用法

#### 设置内容填充模式

```typescript
controller.setContentMode('AspectFill'); // 设置为填满模式
```

#### 设置播放速率

```typescript
// 设置 2 倍速播放，需要在开始播放前设置
controller.setCurRate(2.0);
```

#### 设置循环次数

```typescript
// 设置循环播放 5 次，需要在开始播放前设置
controller.setLoops(5);
```

### 最佳实践

为提高性能，建议在组件的 `aboutToDisappear` 生命周期中释放资源：

```typescript
aboutToDisappear() {
  this.controller.release();
}
```

当需要频繁切换页面时，建议设置适当的 `pageUpdateMode`：

*   短暂离开页面后会返回：使用 `'pause'` 模式
*   彻底离开不再返回：使用 `'release'` 模式

对于大尺寸动画，建议设置适当的 `contentMode` 以获得最佳显示效果。

当动画包含音频时，请确保用户体验良好，避免意外的音频播放。

### 更新记录

*   **[V0.0.1]** 2024-06-14: 项目初步完成 不支持 1.x 版本
*   **[V0.0.2]** 2024-08-11: 适配 api12 中 api 调整
*   **[V0.0.3]** 2024-09-02: 内存问题修复。解压过程优化。前后台切换自动暂停和播放。
*   **[V0.04]** 2024-09-05: 播放次数设置等，优化初始化速度
*   **[V1.0.0]** 2024-09-23: 重大修改 并解决 issue 问题。（使用方式不兼容之前小版本，请注意修改）
*   **[V1.0.1]** 2024-09-24: 背景色去除 绘制问题调整
*   **[V1.0.2]** 2024-09-25: navigation 路由管理页面切换回来后错误的释放播放器的问题修复
*   **[V1.0.3]** 2024-09-26: 打包时去掉代码混淆
*   **[V1.0.4]** 2024-09-26: 修改绘制区域缩放 和 暂停后续播的不连续问题
*   **[V1.0.5]** 2024-10-17: 修复了 fill 填充时展示问题，切换资源时复用上次的缩放模式问题
*   **[V1.0.6]** 2024-10-23: 修复了延时播放时获取的页面 name 错误的问题
*   **[V1.0.7]** 2024-10-23: 释放资源时 先释放动画 避免绘制问题
*   **[V1.0.8]** 2024-10-23: 修改组件所在页面 pagename 的获取方式，增加索引判断，避免误销毁
*   **[V1.0.9]** 2024-10-28: valueAnimator 类调整 解决 fillmode 无效的问题
*   **[V1.1.0]** 2024-11-27: valueAnimator 类调整 增加动画状态控制 解决播放完成后调用 play 方法还能重复播放的问题
*   **[V1.1.1]** 2024-11-28: 设置动态图片支持 imageSource, 设置动态文字支持设置 weight
*   **[V1.2.0]** 2024-12-04:
    1. 资源解析时图片在 native 侧转为 pixelMap，音频文件为原始 ArrayBuffer
    2. 增加数据缓存，在同一页面中多次渲染同一资源时提升后续的加载速度，并解决同屏同时播放相同资源时的资源复用
    3. load 方法 由回调函数改为 promise 不兼容老版本中设置成功、失败回调的方式
    4. 音频播放 取消缓存音频文件 直接使用缓冲区进行
    5. 已知问题修复
*   **[V1.2.1]** 2024-12-04: 1.2.0 遗漏了缓存的清理问题修复
*   **[V1.2.2]** 2024-12-05: hsp 包中使用 load 方法未写明返回值类型导致的编译错误问题修改
*   **[V1.2.3]** 2024-12-05: hsp 包中使用 load 方法未写明返回值类型导致的编译错误问题修改
*   **[V1.2.4]** 2024-12-10: c++ 解析资源漏参的问题解决
*   **[V1.2.5]** 2024-12-10: 修改网络资源过大时获取失败的问题，放大到 100 * 1024 * 1024。
*   **[V1.2.6]** 2024-12-19: 提升解析速度及修复解析参数错误问题
*   **[V1.2.7]** 2024-12-19: 渲染参数解析问题修复
*   **[V1.2.8]** 2024-12-25: 兼容 1.x 版本
*   **[V1.3.0]** 2025-04-17: 1，解决类型导出不完整的问题。2，动态图片参数增加 pixelmap
*   **[V1.3.1]** 2025-04-17: 合并 v1 和 v2 版本，导出 SvgaPlayer 组件 v1 版本；导出 SvgaPlayerV2 组件 v2 版本
*   **[V1.3.2]** 2025-04-18: 修改 Player、Parser 的初始化时机，在 controller 初始化时初始化 Player、Parser
*   **[V1.3.3]** 2025-05-23: 移除无用的资源管理类，现在无需缓存音频文件
*   **[V1.3.4]** 2025-05-28: 修改了页面切换以及前后台切换的监听，修复了清除动态资源对图片不生效的问题
*   **[V1.3.5]** 2025-06-15: 移除了错误弹框，采用回调函数的方式将错误处理交出去。可以在 controller 或者 svgaplayer 组件传值的方式传递 onError (同时传递时以 controller 中为准)。完善了日志系统
*   **[V1.3.6]** 2025-09-02: 1.0 版本解析错误问题修改
*   **[V1.3.7]** 2025-11-10: 1，解决 native 侧 pixelmap 未及时释放导致的内存泄漏问题。2，创建图片的逻辑放到反序列化操作后，避免多线程访问时 env 的问题。3，优化缓存处理
*   **[V1.3.8]** 2025-11-11: 修复 1.3.7 版本构建问题
*   **[V1.3.9]** 2025-11-11: 修复沙盒资源未正常处理文件长度的问题
*   **[V1.4.0]** 2025-11-25: 修复第一帧播放时画布未正确设置尺寸导致的渲染位置变化的问题。
*   **[V1.4.1]** 2026-02-04: 1，重构动画实现方案，解决帧回调不准确的问题。2，优化资源缓存和 cpp 中的 pixelmap 未释放导致的泄漏问题
*   **[V1.4.2]** 2026-02-04: 修复使用本地资源时 异常导致的 file 未关闭的错误
*   **[V1.4.3]** 2026-02-27: 低 api 版本，应许多朋友要求，降回 api15

## 权限与隐私及兼容性

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5 |
| 应用类型 | 应用 |
| 元服务 | 元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 |

## 安装方式

```bash
ohpm install @tb-open/svga
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/06b4c56a4a2049ddb66430ebbd163f80/PLATFORM?origin=template