# photoview 图片显示组件

## 简介

图片缩放浏览组件，图片可缩放，平移，旋转

## 详细介绍

### 功能特性

图片缩放浏览组件，图片可缩放，平移，旋转。支持旋转、缩放、平移操作。

### 下载安装

```bash
ohpm install @ohos/photoview
```

### 使用说明

#### 生成 PhotoView

```typescript
import {PhotoView} from '@ohos/photoview';
//创建 model 对象
@Local data: PhotoView.Model = new PhotoView.Model();
```

#### 设置图片源

```typescript
aboutToAppear() {
  this.data
    .setImageResource($rawfile('wallpaper.jpg'))
    .setScale(1, false)
    .setImageFit(ImageFit.Contain)
    .setOnPhotoTapListener({
      onPhotoTap(x: number, y: number) {
      }
    })
}
```

#### 使用 PhotoView

```typescript
PhotoView({model: this.data})
```

### 接口说明

#### 设置图片资源

```typescript
public setImageResource(src: Resource)
public setImageURI(src: string)
public setImageElement(src: PixelMap)
```

#### 设置图片是否可缩放

```typescript
public setZoomable(zoomable: boolean)
```

#### 设置旋转角度

```typescript
public setRotationTo(rotationDegree: number)
public setRotationBy(rotationDegree: number)
```

#### 设置图片最大缩放比

```typescript
public setMaximumScale(maximumScale: number)
```

#### 设置图片最小缩放比

```typescript
public setMinimumScale(minimumScale: number)
```

#### 设置中间缩放比

```typescript
public setMediumScale(mediumScale: number)
```

#### 获取当前缩放比

```typescript
public getScale(): number
```

#### 单击监听器

```typescript
public setOnClickListener(listener: OnClickListener)
```

#### 长按监听器

```typescript
public setOnLongClickListener(listener: OnLongPressListener)
```

#### 双击监听器

```typescript
public setOnDoubleTapListener(onDoubleTapListener: OnDoubleTapListener)
```

#### Matrix 监听器

```typescript
public setOnMatrixChangeListener(listener: OnMatrixChangedListener)
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806
- SDK: API12 Release(5.0.0.66)

## 目录结构

```text
|---- PhotoView
   |---- entry
   |     |---- pages  # 示例代码文件夹       
   |---- library 
   |     |---- components  # 库文件夹 
   |     |     |---- PhotoView.ets  # 自定义组件                  
   |     |     |---- RectF.ets  # 区域坐标点数据封装
   |     |---- README.md  # 安装使用方法
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue 给我们，当然，我们也非常欢迎你给我们发 PR。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 2.1.1

Release the official version 2.1.1

### 2.1.1-rc.0

Added inertial swipe, two-finger zoom center point

### 2.1.0

发布 2.1.0 正式版本

### 2.1.0-rc.2

修复长按图片时长按回调不触发的问题

### 2.1.0-rc.1

修复 swiper 组件包裹时图片无法缩放的问题

### 2.1.0-rc.0

- 升级状态管理装饰器 V2
- 修复图片缩放和滑动不流畅的问题

### 2.0.0

解决 swiper 和 photoview 共用时滑动冲突问题

### 2.0.0-rc.0

- DevEco Studio 版本：4.1 Canary(4.1.3.317)
- OpenHarmony SDK: API11 (4.1.0.36)
- ArkTS 新语法适配

### 1.1.1

- 适配 DevEco Studio 3.1Beta1 及以上版本。
- 适配 OpenHarmony SDK API version 9 及以上版本。

### 1.1.0

- 名称由 PhotoView-ETS 修改为 PhotoView。
- 旧的包 photoview-ets 已不维护，请使用新包 photoview。

### 1.0.2

工程由 api8 升级到 api9

### 1.0.1

详细功能：
- 支持加载网络图片或 Resource 或 PixelMap 图片
- 支持缩放功能
- 支持平移功能
- 支持旋转

## 权限与隐私及兼容性

| 项目 | 说明 |
| :--- | :--- |
| **权限与隐私** | |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **兼容性** | |
| HarmonyOS 版本 | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | 否 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fe3bc48403844eb682791dae28bb4969/PLATFORM?origin=template