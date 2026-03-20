# 馆藏珍品组件

## 简介

本组件提供了馆藏珍品浏览、珍品详情查看的能力。

## 详细介绍

### 简介

本组件提供了馆藏珍品浏览、珍品详情查看的能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

安装组件。

> 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_page_swiper` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_page_swiper 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_page_swiper",
    "srcPath": "./XXX/module_page_swiper",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_page_swiper": "file:./XXX/module_page_swiper"
}
```

引入组件。

```typescript
import { PageSwiper } from 'module_page_swiper';
```

## API 参考

### 子组件

可以包含单个子组件

### 接口

`PageSwiper(options?: PageSwiperOptions)`

馆藏珍品组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PageSwiperOptions | 否 | 配置馆藏珍品组件的参数。 |

#### PageSwiperOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| swiperData | SwiperItem[] | 否 | 馆藏珍品信息 |
| tips | string | 否 | 滑动提示 |
| defaultIndex | number | 否 | 默认展示的项，默认值为 0 |
| sheetBg | ResourceStr | 否 | 弹出模态框背景图 |
| isShowTips | boolean | 否 | 是否默认展示滑动提示语，默认值为 true |
| pageSwiperController | PageSwiperController | 否 | 组件控制器 |
| customContent | CustomBuilder | 否 | 自定义底部插槽 |

#### SwiperItem 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| imgResourceStr | string | 是 | 图片资源 |
| name | string | 是 | 珍品名称 |
| age | string | 否 | 所属年代 |
| introduction | string | 否 | 珍品介绍 |

### PageSwiperController

PageSwiper 组件的控制器，用于控制组件进行珍品图片的放大缩小。

- **zoom**
  - `zoom(): void`
  - 放大珍品图片
- **shrink**
  - `shrink(): void`
  - 缩小珍品图片

### 事件

支持以下事件：

- **onBackgroundChange**
  - `onBackgroundChange: (isScale: boolean, index: number) => void = () => {}`
  - 珍品图片放大缩小时触发。`isScale` 为 `true` 时图片为放大，`false` 时，图片为缩小；`index` 当前图片对应的项。

### 示例代码

```typescript
import { PageSwiper, SwiperItem } from 'module_page_swiper';


@Entry
@ComponentV2
struct Index {
 @Local
 swiperData: SwiperItem[] = [
   {
     name: '偷水果的人',
     introduction: '油画（an oil painting；a painting in oils）是以用快干性的植物油' +
       '（亚麻仁油、罂粟油、核桃油等）调和颜料，在画布（亚麻布）、纸板或木板上进行制作的一个画种。作' +
       '画时使用的稀释剂为挥发性的松节油和干性的亚麻仁油等。画面所附着的颜料有较强的硬度，当画面干燥后，' +
       '能长期保持光泽。凭借颜料的遮盖力和透明性能较充分地表现描绘对象，色彩丰富，立体质感强。油画是西洋画的主要画种之一。',
     age: '19 世纪西方艺术',
     img: $r('app.media.treasure_bg1'),
   },
   {
     name: '佛教壁画',
     introduction: '始绘于前秦，延续至元代，跨越千年。内容以佛教故事为主，融合多元文化，画风从古朴到绚丽，技艺精湛，色彩斑斓，是世界艺术宝库中的璀璨明珠。',
     img: $r('app.media.treasure_bg2'),
     age: '古代佛教文化',
   },
 ];
 sheetBg: ResourceStr = $r('app.media.sheet_bg');

 build() {
   Navigation() {
     Stack() {
       PageSwiper({
         swiperData: this.swiperData,
         isShowTips: true,
         sheetBg: this.sheetBg,
         onBackgroundChange: (isScale: boolean, index: number) => {
           console.log('图片变化了');
         },
       });
     }
     .alignContent(Alignment.Top);

   }
   .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
   .hideTitleBar(true)
   .systemBarStyle({
     statusBarContentColor: '#FFFFFF',
   });
 }
}
```

## 更新记录

### 1.0.1 (2025-11-03)

- 下载该版本 readme 优化。
- Created with Pixso.

### 1.0.0 (2025-09-15)

- 下载该版本初始版本。
- Created with Pixso.

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

### HarmonyOS 版本

- 5.0.0 (Created with Pixso.)
- 5.0.1 (Created with Pixso.)
- 5.0.2 (Created with Pixso.)
- 5.0.3 (Created with Pixso.)
- 5.0.4 (Created with Pixso.)
- 5.0.5 (Created with Pixso.)

### 应用类型

- 应用 (Created with Pixso.)
- 元服务 (Created with Pixso.)

### 设备类型

- 手机 (Created with Pixso.)
- 平板 (Created with Pixso.)
- PC (Created with Pixso.)

### DevEco Studio 版本

- DevEco Studio 5.0.0 (Created with Pixso.)
- DevEco Studio 5.0.1 (Created with Pixso.)
- DevEco Studio 5.0.2 (Created with Pixso.)
- DevEco Studio 5.0.3 (Created with Pixso.)
- DevEco Studio 5.0.4 (Created with Pixso.)
- DevEco Studio 5.0.5 (Created with Pixso.)
- DevEco Studio 5.1.0 (Created with Pixso.)
- DevEco Studio 5.1.1 (Created with Pixso.)
- DevEco Studio 6.0.0 (Created with Pixso.)

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/42a7e7be1d7f42beae3b593088d18c21/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%A6%86%E8%97%8F%E7%8F%8D%E5%93%81%E7%BB%84%E4%BB%B6/module_page_swiper1.0.1.zip