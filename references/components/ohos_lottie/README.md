# lottie 动画组件

## 简介

lottie 是一个适用于 OpenHarmony 的动画库，它可以使用 Bodymovin 解析以 json 格式导出的 Adobe After Effects 动画，并在移动设备上进行本地渲染。

## 详细介绍

### 简介

lottie 是一个适用于 OpenHarmony 的动画库，它可以解析 Adobe After Effects 软件通过 Bodymovin 插件导出的 json 格式的动画，并在移动设备上进行本地渲染。

### 下载安装

```bash
ohpm install @ohos/lottie
```

### 使用示例

#### 完整示例

```typescript
import lottie, { AnimationItem } from '@ohos/lottie';

@Entry
@Component
struct Index {
  // 构建上下文
  private renderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings);
  private animateItem: AnimationItem | null = null;
  private animateName: string = 'animation'; 

  // 页面销毁时释放动画资源
  aboutToDisappear(): void {
    console.info('aboutToDisappear');
    lottie.destroy();
  }

  build() {
    Row() {
      // 关联画布
      Canvas(this.canvasRenderingContext)
        .width(200)
        .height(200)
        .backgroundColor(Color.Gray)
        .onReady(() => {
          // 加载动画
          if (this.animateItem != null) {
            // 可在此生命回调周期中加载动画，可以保证动画尺寸正确
            this.animateItem?.resize();
          } else {
            // 抗锯齿的设置
            this.canvasRenderingContext.imageSmoothingEnabled = true;
            this.canvasRenderingContext.imageSmoothingQuality = 'medium';
            this.loadAnimation();
          }
        })
    }
  }

  loadAnimation() {
    this.animateItem = lottie.loadAnimation({
      container: this.canvasRenderingContext,
      renderer: 'canvas', // canvas 渲染模式
      loop: true,
      autoplay: false,
      name: this.animateName,
      contentMode: 'Contain',
      path: 'common/animation.json',
    });
    // 因为动画是异步加载，所以对 animateItem 的操作需要放在动画加载完成回调里操作
    this.animateItem.addEventListener('DOMLoaded', (args: Object): void => {
      this.animateItem.changeColor([225, 25, 100, 1]);
      this.animateItem.play();
    });
  }

  destroy() {
    this.animateItem.removeEventListener('DOMLoaded');
    lottie.destroy(this.animateName);
    this.animateItem = null;
  }
}
```

## 注意事项

1. 建议在 canvas 的 `onReady` 方法中加载动画，并在加载该动画之前先调用 `lottie.destroy(name)` 方法，以确保动画不会重复加载。
2. 建议对动画 `animateItem` 的操作放在 `addEventListener` 的 `'DOMLoaded'` 回调监听中，确保在完全构建并解析完成后，再执行与动画相关的操作，从而避免潜在的加载顺序问题。因为如果是同一个代码块，动画的加载是异步加载的。
3. 建议添加动画抗锯齿，如示例代码 67 到 68 行，以减少动画边缘的锯齿状现象，使动画画面更加平滑细腻，实现更佳的动画效果。
4. 动画的销毁，推荐使用 `lottie.destroy(name)` 方法，相较于直接使用 `animateItem.destroy()`，性能更友好。
5. 建议在页面销毁或卸载时，将页面上所有的动画进行销毁，确保页面资源得到妥善管理和释放。
6. 混淆模式编译报错，建议在对应的模块下的 `obfuscation-rules.txt` 文件添加配置：`-keep ./oh_modules/@ohos/lottie`。
7. 建议 canvas 的宽高比例与动画的宽高比例保持一致。例如动画的宽高比是 1000 * 2000（即 1:2 的比例），那么可以将 canvas 的宽高设置为 200 * 400，同样保持 1:2 的比例。建议 canvas 的宽高不要大于动画的原始宽高。
8. 注意：加载外部资源图片时，若采用指定路径的方式：`imagePath:'lottie/images/'`，外部资源图片的路径是指 rawfile 目录下的或者沙箱里 file 目录下的路径。
9. Lottie 的 JSON 文件中引用的外部图片资源，需要存放在 rawfile 目录下。例如 json 文件中 `"u":"images/"`，则在 rawfile 目录下创建一个名为 images 的文件夹，存放图片。

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Developer Beta3(5.0.3.524), SDK: API12(5.0.0.25)。
- DevEco Studio: NEXT Developer Beta1(5.0.3.122), SDK: API12(5.0.0.18)。

## 目录结构

```text
/lottie        # 项目根目录
├── entry      # 示例代码文件夹
├── library    # lottie 库文件夹
│    └─ src/main/js   # 核心代码，包含 json 解析，动画绘制，操作动画
│          └─ 3rd_party    
│          └─ animation    
│          └─ effects      
│          └─ elements      
│          └─ modules
│          └─ renderers    
│          └─ utils
│          └─ EffectsManager.js  
│          └─ main.js
│          └─ mask.js
│       └─index.d.ts                
├── README.md     # 安装使用方法    
├── README_zh.md  # 安装使用方法                    
```

## 不支持能力

- 不支持 HTML 渲染方式
- 不支持 SVG 渲染中 filter 效果
- 不支持动画中 masks,mattes 部分特性
- 不支持亮度遮罩模式，即：tt=3
- 不支持组件控制动画显示、隐藏
- 不支持注册动画
- 不支持查找动画
- 不支持更新动画数据
- 不支持部分效果
- 不支持含有表达式的动画

## 贡献代码

使用过程中发现任何问题都可以提交 Issue，当然，也非常欢迎提交 PR。

## 开源协议

本项目遵循 MIT License。

## 更新记录

### v2.0.29

Release version 2.0.29.

### v2.0.29-rc.2

fix: Fix the memory leak issue where Canvas shadow resources are not cleaned up in a timely manner when destroying Lottie animations.

### v2.0.29-rc.1

fix: Fix the issue of probabilistic crashes caused by missing linear keyframe attributes in animation elements.

### v2.0.29-rc.0

fix: Fix the issue that Lottie animations can only load resources within the root directory subfolder of the rawfile, and cannot recognize animation resource files in the root directory.

### v2.0.28

fix: Fixed the issue of abnormal line break height in animated fonts.
fix: Fixed the playback exception issue caused by the internal asynchronous logic directly calling the complete method when resetting the animation playback count to 0.

### v2.0.27

fix: Fix the issue where ImageSource instances are not actively released.

### v2.0.26

Release version 2.0.26.

### v2.0.26-rc.1

fix: Fix the issue where Lottie animation cannot load and play. zip format resources containing network image URI.

### v2.0.26-rc.0

fix: Fix the memory leak issue of Lottie animation component still holding AnimationManager object after AnimationItem is destroyed.

### v2.0.25

feature: Provide parameter interface to support whether the font size of animated text content changes with the system font size.

### v2.0.25-rc.2

fix: Fixed the issue where the playback logic got stuck in a dead loop and caused the application to crash when this.totalFrameworks was set to 0 due to abnormal animation data.

### v2.0.25-rc.1

fix: Fix the issue where error callbacks do not trigger when loading animations using the animationData method.

### v2.0.25-rc.0

fix: Fixed the possibility of probabilistic crashes caused by abnormal animation data by adding type checking logic.

### v2.0.24

Release version 2.0.24.

### v2.0.24-rc.1

feature: Supports synchronous clearing of all caches, including the current animation cache.
fix: Fix the issue of some animation content displaying abnormally outside the designated area.
fix: Fix the network image loading issue caused by the failure to create multiple layers of directories in the sandbox.

### v2.0.24-rc.0

fix: Fix the issue where the current animation frame number is abnormal when setting animation color dynamically.
fix: Fixed the issue of frame index out-of-bounds in reverse playback or nested animations in goToAndStop.
fix: Fix the issue where changeColor fails to modify the current frame color in transparency scenarios.
fix: Optimize the logic of the filling mode.

### v2.0.23

Release version 2.0.23.

### v2.0.23-rc.2

fix: Optimize the code by replacing deprecated interfaces with the latest and standardized ones.

### v2.0.23-rc.1

fix: Support the loading function of animation files in .zip and .lottie formats in the rawfile directory.

### v2.0.23-rc.0

feature: Support the loading function of animation files in .zip and .lottie formats in the rawfile directory.

### v2.0.22

fix: Fixed the animation crashing issue caused by the failure to read AbilityInfo.name in specific scenarios.

### v2.0.21

Release version 2.0.21.

### v2.0.21-rc.1

fix: Fix the complete callback exception caused by calling the playSegments method and enhance the fault-tolerant handling mechanism for illegal numbers NaN.

### v2.0.21-rc.0

fix: Fix the issue of abnormal animation playback in sub window scenes.

### v2.0.20

Release version 2.0.20.

### v2.0.20-rc.3

fix: Optimized the code for dynamically modifying the colors of each layer in Lottie animation, improving its performance, readability, and maintainability.
fix: Add a condition to determine whether the context2D object has the getJsonData method to avoid calling an error when the method does not exist.

### v2.0.20-rc.2

fix: Fix the issue in the HSP module where animations cannot be played due to the input of context context.

### v2.0.20-rc.1

fix: Optimize the loading logic of ZIP format network animation resources and fix some resource loading failures caused by format parsing exceptions.
fix: Fixed the issue where dynamically modifying the current frame color during animation pause was ineffective.

### v2.0.20-rc.0

fix: Fix and enhance the compatibility of loading. jpg/. jpg network animation images with enhanced animations.
fix: Fix the feature support issue where the animation playback frame rate can be set higher than the animation resource frame rate.

### v2.0.19

fix: Fixed the issue of process freezing caused by the while loop condition not being met, by adding a protection mechanism that forces the loop to exit when it reaches 2000 executions.

### v2.0.18

fix: Fixed the issue where Lottie's call to the goToAndStop interface resulted in the animation not correctly jumping to the last frame due to the total number of frames passed in.

### v2.0.18-rc.1

fix: Fix the compatibility issue of Lottie animation playback in some API 13 mirrored versions, targeting scenes where the canvas2d.on and canvas2d.off interfaces are not provided in this version, to ensure that the animation can play normally.

### v2.0.18-rc.0

feature: Supports normal playback of animations in multi ability scenarios.

### v2.0.17

fix: Optimize the Lottie lifecycle to solve redundant drawing in complex scenes.
Release version 2.0.17

### v2.0.17-rc.3

fix: Fix getContext() in specific scenarios The problem of error reporting when obtaining the path of the sandbox file cacheDir using the method.

### v2.0.17-rc.2

fix: Fix due to this_ The type of the absoluteFramePlayed parameter is changed from number to non number, resulting in the failure of calling the. toPixed() method and causing errors.

### v2.0.17-rc.1

fix: Fixed the issue of accidentally clearing other array objects when destroying animations, resulting in the failure of loading other animations.
fix: Adjust the animation playback speed so that it can accurately control the playback rate in decimal form.
fix: Fix animation loading support for directly reading animation resource files from the sandbox through path mode for playback.

### v2.0.17-rc.0

fix: At the end of each frame of the animation, reset CanvasRendering Context2D to its default state, clear the background buffer, and improve drawing performance.
feature: Supplement log switch function interface.

### v2.0.16

Release version 2.0.16.

### v2.0.16-rc.3

fix:Fixed the issue where the animation loading execution was incomplete and destroyed, and the internal closure was not fully executed, resulting in the object being held indefinitely.

### v2.0.16-rc.2

fix:Fix the issue of abnormal font and animation effects playback size in animations.

### v2.0.16-rc.1

fix:Fixed the issue of ineffective animation gradient transparency caused by array index out of bounds.

### v2.0.16-rc.0

fix:Fixed the issue where the parent component node was hidden while the child component canvas node was visible, causing the animation to still play.

### v2.0.15

fix: Fix the issue where animations are automatically destroyed when their state is not visible in a specific scene.
fix: Fix the issue of failed dynamic modification of multiple keyframe colors in animation.

### v2.0.15-rc.1

fix: Optimized and solved the problem of keyframe colors not taking effect in dynamic replacement animations.
fix: Fixed the issue of ineffective transparency settings for dynamic gradient colors in animations.
fix: Fix the issue of incorrect text display position in animation.

### v2.0.15-rc.0

fix: Fixed the issue where one or more animations were destroyed during simultaneous loading and playback, resulting in a low probability of crashes in the application.
feature: Support specifying replacement animation images.
fix: Fix the issue of abnormal animation font playback and animation effect size.
fix: Fix the problem of reading errors in sandbox image resources caused by insufficient read permissions or missing files.

### v2.0.14

Release version 2.0.14.

### v2.0.14-rc.2

fix: Fix the issue of reading the image_stource property incorrectly when the image data is incorrect.
fix: Modify and clear cache interface, clearing all/individual caches using the same interface.

### v2.0.14-rc.1

feature:When the animation is completely invisible, the current animation will automatically pause and stop sending drawing instructions to optimize performance and reduce power consumption.

### v2.0.14-rc.0

feature:支持清除全部缓存，清除当前动画缓存。
feature:支持判断动画是否为网络播放。
feature:优化 animator 的使用方式，使用 displaySync 替代 animator 机制。
fix: 修复使用 animationData 方式加载播放网络资源图片失败的问题。

### v2.0.13

发布 2.0.13 正式版。

### v2.0.13-rc.0

fix: 修复 json 动画资源文件缺少 e 属性导致动画图片加载不出来的问题。
fix: 优化加载网络资源代码结构。

### v2.0.12

发布 2.0.12 正式版。

### v2.0.12-rc.3

fix: 修复在自动播放状态下，加载动画第一帧重复播放的问题。

### v2.0.12-rc.2

fix: 修复使用 animateItem.destroy 销毁方式，导致底层 animator 没有停止而一直在刷帧的问题。
fix: 修复动画暂停重新播放后，帧率使用默认帧率播放的问题。

### v2.0.12-rc.1

fix: 修复网络动画资源图片下载失败和字体没显示问题。

### v2.0.12-rc.0

fix: 修复部分含字体动画播放显示不全的问题。

### v2.0.11

发布 2.0.11 正式版。

### v2.0.11-rc.7

feature:支持读取指定路径下的图片资源。
fix: 修复加载多个 zip 资源导致加载异常。
fix: 修复频繁调用 goToAndPlay() 方法导致动画概率性出现播放不正常的问题。

### v2.0.11-rc.6

fix: 修复 lottie 网络资源下载异常处理。
fix: 修复 lottie 网络资源下载通知显示下载进度。
fix: 修复 lottie 动态修改动画颜色时蒙版图层不需要改动的问题。

### v2.0.11-rc.5

fix: 修复读取错误网络资源链接导致动画加载崩溃的问题。

### v2.0.11-rc.4

fix: 修复动画执行 pause 时，底层 animator 没有停止的问题。
fix：修复特殊场景下时间戳跳变引起时间差为负，导致动画播放跳到开始帧并完成播放的问题。
fix：修复下载的 zip 资源中带有文件夹导致动画加载失败。

### v2.0.11-rc.3

fix: 修复读取缓存资源，加载 zip 动画闪退的问题。

### v2.0.11-rc.2

fix: 修复动画被销毁时，重新设置当前存活 animation 的最高帧率。
feature:支持加载网络资源和通过 URI 路径方式加载动画。

### v2.0.11-rc.1

fix: 修复 lottie 跳帧不渲染的问题。

### v2.0.11-rc.0

fix: 修复图片资源默认使用图片自身宽高问题。

### v2.0.10

feature:新增支持设置 animator 的刷帧率功能。
fix: 修复无法触发'config_ready'、'data_ready'、'error'、'data_failed'监听事件问题。
fix: 使用 saveLayer 和 restoreLayer 方案替代原来的方式实现动画蒙版动效，优化动画性能。
feature:新增动画支持设置填充模式：Fill,Top,Cover,Bottom,Contain。
fix: 修复动画圆圈的虚线无法展现实际动画效果的问题。
fix: 修复图形变形没恢复导致画布重绘有残留图像的问题。
fix: 修复动画 json 资源文件含有音频和正则表达式内容，动画加载播放的失败问题。
fix: 修复加载多个动画，在特定场景下销毁个别正在播放的动画时 animator 没停止的问题。
fix: 修复在特殊情况下动画暂停再恢复，画面内容不连贯问题。
fix: 修复动画 json 有依赖图片资源不存在时，动画也可以加载播放的问题。

### v2.0.10-rc.4

feature:新增支持设置 animator 的刷帧率功能

### v2.0.10-rc.3

fix: 修复无法触发'config_ready'、'data_ready'、'error'、'data_failed'监听事件问题。
fix: 使用 saveLayer 和 restoreLayer 方案替代原来的方式实现动画蒙版动效，优化动画性能。

### v2.0.10-rc.2

feature:新增动画支持设置填充模式：Fill,Top,Cover,Bottom,Contain。
fix: 修复动画圆圈的虚线无法展现实际动画效果的问题。
fix: 修复图形变形没恢复导致画布重绘有残留图像的问题。

### v2.0.10-rc.1

fix: 修复动画 json 资源文件含有音频和正则表达式内容，动画加载播放的失败问题。
fix: 修复加载多个动画，在特定场景下销毁个别正在播放的动画时 animator 没停止的问题。

### v2.0.10-rc.0

fix: 修复在特殊情况下动画暂停再恢复，画面内容不连贯问题。
fix: 修复动画 json 有依赖图片资源不存在时，动画也可以加载播放的问题。

### v2.0.9

fix: 新增支持动画 mask 相减蒙版模式特性。
fix: 修复动画播放在折叠屏设备上出现残影的问题。

### v2.0.9-rc.0

fix: 修复动画 json 文件里缺少 e 属性值导致外部资源图片加载失败的问题。

### v2.0.8

fix: 添加传入应用包名接口，用于日志打印区分不同模块调用启动 animator 线程，packageName 可以不传。
fix: 更改 animator 的使用方式，适配 lottie 在插件模块下可以播放动画。

### v2.0.7

feature:新增支持读取沙箱路径下的图片资源。
fix: 为了适配 HSP 场景，loadAnimation 接口新增当前场景上下文 context 可选参数传入，在 HSP 场景下需要传正确的 context，非 HSP 场景不影响，context 可以不传。

### v2.0.7-rc.0

feature:新增支持更改动画颜色的透明值和关键帧渐变色颜色特性。

### v2.0.6

feature:新增支持 Canvas 渲染动画的高斯模糊动效特性。
fix: piexlmap 改成不可编辑状态，优化图形图像端读取速度。

### v2.0.5

fix: 优化性能，释放 pixel_map，防止内存泄漏。

### v2.0.5-rc.0

fix: 修复 lottie 的 registeredAnimations[i].animation 空指针报错问题。
fix: 修正替换 play 函数为 gotoFrame，防止 play 方法创建 Animator 对象，导致修改颜色后刷帧问题。

### v2.0.4

fix: 修复 lottie 播放 mask 动画多次调用 getPixelMap 方法，导致动画播放掉帧的问题。
fix: 适配 ArkTs 语法。

### v2.0.3

fix: 修复 lottie 不同版本在同一个界面启动，导致动画播放失败的问题。
fix: 修复动画销毁，重新刷新界面导致应用的崩溃问题。

### v2.0.2

feature:新增支持 Canvas 渲染中 mask 部分特性
        支持渲染本地图片，包含 base64 编码和文件路径方式。
fix: 修正圆形动画加载小球不重叠。
fix: 修正动画全部播放完后，Animator 也要停止刷帧。
updated: 适配 DevEco Studio: 4.0 Canary2(4.0.3.312)。
         适配 SDK: API10 (4.0.9.3)。

### v2.0.1

feature:新增动画动态渲染颜色能力。
fix: 修正 License 文件版权。
fix: 添加 Array.apply() 函数的参数检验，如果长度为 undefined 时，设置长度为 0。
updated: 适配 DevEco Studio: 4.0 Canary1(4.0.0.112)。
         适配 SDK: API10 (4.0.7.2)。
updated: 修改 Library 目录结构根目录名称。

### v2.0.0

feature: 动画加载代码解耦。
updated: 包管理工具由 npm 切换为 ohpm
         适配 DevEco Studio: 3.1 Beta2(3.1.0.400)
         适配 SDK: API9 Release(3.2.11.9)

### v1.1.2

fix: 未设置动画数据就直接加载动画，销毁动画时，导致的空指针异常。
fix: 修正根据路径加载不到动画数据时的处理方式，不进行构建动画配置。
fix: 删除动画加载限制，重复加载动画前需手动销毁上一个已加载动画。
fix: 补充 readme 文件内 Lottie 组件使用注意事项
     loadAnimation 使用时须在页面加载完成之后，例如 Canvas.onReady() 生命周期。
     loadAnimation 加载动画使用 path 参数设置时，需要注意 path 参数只支持 entry/src/main/ets 文件夹下的相对路径，不支持跨包设置。
     同一 Canvas 组件加载多次/不同动画资源，需要手动销毁动画 (lottie.destroy()/animationItem.destroy())，之后才可再次加载其他动画资源。

### v1.1.1

feature:补充 svg 渲染能力。
适配原库 5.10.0 版本。

不支持特性：

- 不支持 SVG 渲染中 filter 效果
- 不支持 SVG 渲染中 mask 部分特性
- 不支持渲染本地图片及网络图片资源

### v1.1.0

updated: 名称由 lottieETS 修改为 lottie。
updated: 旧的包@ohos/lottieETS 已不再维护，请使用新包@ohos/lottie。
fix:修复多次在同一画布上加载动画，导致动画重叠的问题。

不支持特性：

- 不支持 SVG、HTML 渲染方式
- 不支持组件控制动画显示、隐藏、resize
- 不支持注册动画
- 不支持查找动画
- 不支持更新动画数据
- 不支持部分效果
- 不支持含有表达式的动画

### v1.0.3

fix:修复销毁动画时未清空画布的 bug。
fix:添加对通过路径获取动画文件 json 数据的非空校验，如果未获取到将抛出异常进行提示。

### v1.0.2

适配 API9 Stage 模型。

### v1.0.1

升级 IDE 到 3.0.0.900，使项目能在该环境下运行。

### v1.0.0

适配兼容 OpenHarmony 系统，完成相关功能，具体如下：

- 动画播放、暂停、停止、切换暂停、跳到某一时刻并停止、跳到某一时刻并播放等动画基础功能。
- 播放指定片段、重置动画、设置播放速度、设置播放方向、添加监听状态、获取动画时长等扩展功能。
- canvas 渲染。

对源库改动如下：

- 删除 html 渲染。
- 删除 svg 渲染，等待后续迭代。

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/lottie
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f8096cca99ce4ed3bc3688a8b2a87b6e/PLATFORM?origin=template