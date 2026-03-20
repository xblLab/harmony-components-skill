# 商品评价组件

## 简介

本组件提供商品评价功能，支持评定星级、填写评价、上传图片。

## 详细介绍

### 简介

本组件提供商品评价功能，支持评定星级、填写评价、上传图片。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.1 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.1 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

无

#### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_product_review` 模块。

> // 项目根目录下 build-profile.json5 填写 module_product_review 路径。其中 XXX 为组件存放的目录名

```json5
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_product_review",
    "srcPath": "./XXX/module_product_review"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

> // 在项目根目录 oh-package.json5 中添加依赖

```json5
"dependencies": {
  "module_product_review": "file:./XXX/module_product_review"
}
```

引入组件。

```typescript
import { ProductReviewCreation } from 'module_product_review';
```

### API 参考

#### 接口

`ProductReviewCreation(options: ProductReviewCreationOptions)`

商品评价组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ProductReviewCreationOptions | 否 | 配置商品评价组件的参数。 |

**ProductReviewCreationOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| skuList | OrderSkuItem[] | 否 | 待评价的商品列表 |
| handleSubmit(value: ReviewDraft) => void | Function | 否 | 点击提交后的回调事件 |

**OrderSkuItem 类型说明**

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| productId | string | 是 | 商品 ID |
| skuCode | string | 是 | 商品 SKU 编码 |
| skuDesc | string | 是 | 商品 SKU 描述 |
| count | number | 是 | 商品数量 |
| bannerResourceStr | ResourceStr | 是 | 商品轮播图 |
| title | string | 是 | 商品标题 |
| serviceDesc | string | 是 | 商品服务描述 |
| dashPrice | number | 是 | 商品原价 |
| price | number | 是 | 商品价格 |

**ReviewDraft 类型说明**

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| shipmentRating | number | 是 | 物流评分 |
| serviceRating | number | 是 | 服务评分 |
| feedback | string | 是 | 用户反馈内容 |
| date | number | 是 | 评论日期（时间戳） |
| reviewList | SkuReview[] | 是 | 商品评论列表 |

**SkuReview 类型说明**

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| productId | string | 是 | 商品 ID |
| skuCode | string | 是 | 商品 SKU 编码 |
| skuDesc | string | 是 | 商品 SKU 描述 |
| rating | number | 是 | 商品评分 |
| content | string | 是 | 商品评论内容 |
| mediaList | ReviewMediaItem[] | 是 | 评论媒体列表 |

**ReviewMediaItem 类型说明**

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| uri | ResourceStr | 是 | 媒体资源 uri |
| type | ReviewMediaType | 是 | 媒体类型 |

**ReviewMediaType 枚举说明**

| 字段名 | 说明 |
| :--- | :--- |
| IMAGE | 图片类型 |
| VIDEO | 视频类型 |

### 示例代码

```typescript
import { OrderSkuItem, ProductReviewCreation } from 'module_product_review';

const list: OrderSkuItem[] = [
  {
    productId: 'product_10001',
    skuCode: 'sku_100001',
    skuDesc: '粉色;160/80A',
    count: 1,
    banner: $r('app.media.mock_spec_pink'),
    title: '时尚轻商务系列针织打底纯羊毛内搭',
    serviceDesc: '运费险｜7 天无理由',
    price: 188,
    dashPrice: 200,
  },
  {
    productId: 'product_10001',
    skuCode: 'sku_100002',
    skuDesc: '白色;160/80A',
    count: 1,
    banner: $r('app.media.mock_spec_white'),
    title: '时尚轻商务系列针织打底纯羊毛内搭',
    serviceDesc: '运费险｜7 天无理由',
    price: 188,
    dashPrice: 200,
  },
]

@Entry
@ComponentV2
struct ProductReview {
  @Local stack: NavPathStack = new NavPathStack()

  @Builder
  pageMap(name: string) {
    if (name === 'Review1') {
      Review1()
    } else if (name === 'Review2') {
      Review2()
    }
  }

  build() {
    Navigation(this.stack) {
      Column({ space: 16 }) {
        Button('评价一件商品').onClick(() => {
          this.stack.pushPath({ name: 'Review1' })
        })
        Button('评价多件商品').onClick(() => {
          this.stack.pushPath({ name: 'Review2' })
        })
      }
    }
    .height('100%')
    .width('100%')
    .hideTitleBar(true)
    .navDestination(this.pageMap)
  }
}

@ComponentV2
struct Review1 {
  build() {
    NavDestination() {
      ProductReviewCreation({
        skuList: list.slice(0, 1),
        handleSubmit: (draft) => {
          console.log(JSON.stringify(draft))
          this.getUIContext().getPromptAction().showToast({ message: '提交成功！' })
        },
      })
    }
    .title('评价一件商品', { backgroundColor: Color.White })
  }
}

@ComponentV2
struct Review2 {
  build() {
    NavDestination() {
      ProductReviewCreation({
        skuList: list,
        handleSubmit: (draft) => {
          console.log(JSON.stringify(draft))
          this.getUIContext().getPromptAction().showToast({ message: '提交成功！' })
        },
      })
    }
    .title('评价多件商品', { backgroundColor: Color.White })
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.1 | 2026-01-13 | - | 下载该版本 |
| 1.0.0 | 2025-10-31 | 废弃 API 整改 | 下载该版本 |
| 初始版本 | - | - | 下载该版本 |

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 权限名称：无<br>权限说明：无<br>使用目的：无 |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8a68e6ea38424e8c93af6d1f26270e98/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E8%AF%84%E4%BB%B7%E7%BB%84%E4%BB%B6/module_product_review1.0.1.zip