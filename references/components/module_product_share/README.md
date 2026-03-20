# 商品分享组件

## 简介

本模板提供系统分享功能，支持保存商品为海报，复制商品链接，拉起华为系统分享和碰一碰分享功能。

## 详细介绍

### 简介

本模板提供商品分享组件，支持保存商品为海报，复制商品链接，拉起华为系统分享和碰一碰分享功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_product_share` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_product_share 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_product_share",
    "srcPath": "./XXX/module_product_share"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
  "module_product_share": "file:./XXX/module_product_share"
}
```

### 引入组件

```typescript
import { ProductShare } from 'module_product_share';
```

### API 参考

#### ProductShare(options: ProductShareOptions)

##### ProductDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| customUI | CustomBuilder | 否 | 关联商品分享面板的自定义 UI，点击可拉起分享面板。默认为一个分享按钮 |
| panelHeight | SheetSize \| Length | 否 | 分享面板高度，默认为 300vp。 |
| productResource | ProductResource | 是 | 商品分享所需的相关素材。 |

##### ProductResource 类型说明

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| image | ResourceStr | 是 | 商品图片 |
| title | string | 是 | 商品标题 |
| price | number | 是 | 商品价格 |
| url | string | 是 | 商品链接 |

#### 示例代码

```typescript
import { ProductShare } from 'module_product_share';

@Entry
@ComponentV2
struct PreviewPage {
  build() {
    Column() {
      Column() {
        Image($r('app.media.mock_image')) // 开发者使用时替换为网络图片或自身工程内的资源
          .width(200);
        Text('高端定制夏季法式粉色上衣 2025 新款女');
      }
      .width('100%')
      .padding(16);

      ProductShare({
        productResource: {
          image: $r('app.media.mock_image'), // 开发者使用时替换为网络图片或自身工程内的资源
          title: '高端定制夏季法式粉色上衣 2025 新款女',
          price: 1099,
          url: 'http://test',
        },
      }) {
        this.shareIcon();
      };
    }
    .height('100%')
    .width('100%');
  }

  @Builder
  shareIcon() {
    Button('点击分享');
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-09-10 | Created with Pixso. |
| 1.0.0 | 2025-08-29 | Created with Pixso. |
| 初始版本 | - | Created with Pixso. |

> 注：下载该版本 README 更新。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | SDK 合规 |
| :--- | :--- |
| 不涉及 | 使用指南 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

> 注：以上兼容性信息包含 Created with Pixso. 标记项。

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0ebe7fc71e684c9ab70d8f20d090bf93/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E5%88%86%E4%BA%AB%E7%BB%84%E4%BB%B6/module_product_share1.0.1.zip