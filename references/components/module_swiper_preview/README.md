# 图片轮播预览组件

## 简介

本组件提供了图片轮播的功能，点击图片可以打开大图预览页面，可捏合缩放图片，点击预览页面关闭大图预览。

## 详细介绍

### 简介

本组件提供了图片轮播的功能，点击图片可以打开大图预览页面，可捏合缩放图片，点击预览页面关闭大图预览。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.0 Release 及以上

#### 权限

访问网络图片时需开启：
- **网络权限**：`ohos.permission.INTERNET`

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_swiper_preview` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_swiper_preview 路径。其中 XXX 为组件存放的目录名
"modules": [
   {
   "name": "module_swiper_preview",
   "srcPath": "./XXX/module_swiper_preview"
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名
"dependencies": {
   "module_swiper_preview": "file:./XXX/module_swiper_preview"
}
```

引入组件句柄。

```typescript
import { SwiperPicsPreview } from 'module_swiper_preview';
```

图片轮播展示。详细入参配置说明参见 API 参考。

```typescript
SwiperPicsPreview({
   pics: this.pics,
   iHeight: 120,
   pad: 16,
   out: 50,
 })
```

### API 参考

#### 子组件

无

#### 接口

`SwiperPicsPreview(options?: SwiperPicsPreviewOptions)`

图片轮播预览组件。

**参数：**

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | SwiperPicsPreviewOptions | 否 | 配置图片轮播预览组件的参数。 |

**SwiperPicsPreviewOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pics | ResourceStr[] | 是 | 轮播图片数组 |
| index | number | 否 | 初始图片索引 |
| iHeight | number | 否 | 轮播高度 |
| radius | Length | 否 | 轮播图片圆角 |
| space | string \| number | 否 | 轮播图片间隙 |
| out | Length | 否 | 露出前后项宽度 |
| pad | number \| undefined | 否 | undefined 时轮播居中，设置时代表首尾项的边距 |

### 示例代码

本示例实现图片的轮播展示，点击对应图片可进行大图预览。

```typescript
import { SwiperPicsPreview } from 'module_swiper_preview';

@Entry
@ComponentV2
struct Index {
 @Local pics: ResourceStr[] = [
   'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park0.jpg?token=a7fb227d-3a1b-44b6-9f8a-51a804a8fffa',
   'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park1.jpg?token=0d21ef96-c1b5-4123-bf48-7a55c3a479d0',
   'https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/ic_park2.jpg?token=6a616aa4-edbc-417b-8b3f-48053cdaf9ee',
 ]

 build() {
   Column() {
     SwiperPicsPreview({
       pics: this.pics,
       iHeight: 160,
       out: 50,
       pad: 16,
     })
   }
   .justifyContent(FlexAlign.Center)
   .width('100%')
   .height('100%')
 }
}
```

### 更新记录

- **1.0.1** (2025-11-25)
  - 下载该版本调整 readme 内容。
- **1.0.0** (2025-11-03)
  - 下载该版本初始版本。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 分类 | 支持版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/837a09d81125410999a8c128ca619c2b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9B%BE%E7%89%87%E8%BD%AE%E6%92%AD%E9%A2%84%E8%A7%88%E7%BB%84%E4%BB%B6/module_swiper_preview1.0.1.zip