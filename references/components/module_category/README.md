# 左栏平铺分类组件

## 简介

本组件提供分类容器组件，左侧是分类，右侧是分类包含的条目，支持自定义条目 UI。

## 详细介绍

### 简介

本组件提供左右布局实现分类的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件：
     1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
     2. 在项目根目录 `build-profile.json5` 添加 `module_category`、`module_base` 模块。
        ```json5
        // 项目根目录下 build-profile.json5 填写 module_category、module_base 路径。其中 XXX 为组件存放的目录名
        "modules": [
          {
            "name": "module_category",
            "srcPath": "./XXX/module_category"
          },
          {
            "name": "module_base",
            "srcPath": "./XXX/module_base"
          }
        ]
        ```
     3. 在项目根目录 `oh-package.json5` 添加依赖。
        ```json5
        // XXX 为组件存放的目录名称
        "dependencies": {
          "module_base": "file:./XXX/module_base",
          "module_category": "file:./XXX/module_category"
        }
        ```

2. **引入组件**
   ```typescript
   import { CategoryController, CategoryLayout } from 'module_category';
   ```

3. **调用组件**
   详细参数配置说明参见 API 参考。

### API 参考

#### CategoryLayout(option: CategoryLayoutOptions)

分类容器组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CategoryLayoutOptions | 是 | 配置分类容器组件的参数 |

**CategoryLayoutOptions 对象说明：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| contentList | IGoodCategory | - | 内容列表数据 |
| initIndex | number | 否 | 滚轮初始索引位置 |
| controller | CategoryController | 否 | 分类控制器 |
| onScrollIndex | `(index: number) => void` | 否 | 滚动回调 |
| itemBuilderParam | `(good: IGoodInfo) => void` | 否 | 自定义每一项组件 |

**IGoodCategory 类型说明：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| categoryId | string | 是 | 分类 id，唯一索引 |
| categoryLabel | string | 是 | 分类文字描述 |
| list | IGoodInfo[] | 是 | 分类所包含的条目 |

#### CategoryController

分类组件的控制器，用于控制分类条目的滚动。同一个控制器不可以控制多个分类组件。

- **constructor**
  - `constructor()`
  - CategoryController 的构造函数。

- **scrollToIndex**
  - `scrollToIndex(index: number)`
  - 滚动到指定索引位置。

#### 示例代码

```typescript
import { IGoodCategory, IGoodInfo, TypeGood } from 'module_base';
import { CategoryController, CategoryLayout } from 'module_category';

const GOOD_SAMPLE: IGoodInfo = {
  type: TypeGood.PAY,
  classId: '1',
  id: '1',
  title: '日常保洁',
  subTitle: '高温消毒｜除尘除垢',
  image: '',
  intro: [],
  price: 119,
  vipPrice: 41,
  soldNum: 800,
  serviceContentList: [],
  serviceDetailList: [],
  servicePipeList: [],
  feeList: [],
  qaList: [],
};

const generateGood = (title: string, index: number): IGoodInfo => {
  const temp: IGoodInfo = JSON.parse(JSON.stringify(GOOD_SAMPLE));
  temp.id += index;
  temp.title = title + index
  return temp;
};

const generateGoodList = () => {
  const CATEGORY_LIST: string[] = ['日常清洁', '冰箱清洗', '家电维修', '全屋玻璃', '家电维修', '衣物整理'];
  return CATEGORY_LIST.map((v: string, index: number): IGoodCategory => {
    return {
      categoryId: index.toString(),
      categoryLabel: v,
      list: [
        generateGood(v, 1),
        generateGood(v, 2),
      ],
    };
  });
};

@Entry
@ComponentV2
struct CategorySample {
  @Local list: IGoodCategory[] = generateGoodList();
  controller: CategoryController = new CategoryController();

  @Builder
  buildItem(good: IGoodInfo) {
    Column() {
      Row({ space: 10 }) {
        Image(good.image)
          .width(60)
          .height(50)
          .borderRadius(4)
          .alt($r('app.media.ic_placeholder_img'))
        Column({ space: 10 }) {
          Text(good.title).fontSize(14).fontWeight(500).fontColor(Color.Black)
          Text(good.subTitle).fontSize(12).fontColor(Color.Grey)
        }
          .alignItems(HorizontalAlign.Start)
      }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .onClick(() => {
          this.getUIContext().getPromptAction().showToast({ message: `点击了${good.title}` });
        })

      Divider()
    }
  }

  build() {
    NavDestination() {
      Column() {
        CategoryLayout({
          contentList: this.list,
          initIndex: 0,
          controller: this.controller,
          itemBuilderParam: (good: IGoodInfo) => {
            this.buildItem(good)
          },
        })
      }
    }
      .title('分类组件')
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-10-31 | 优化 README，下载该版本 |
| 1.0.0 | 2025-08-29 | 初始版本，下载该版本 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

- 不涉及 SDK 合规使用指南

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d9b619377fc6421cb1318fca40d2847d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%B7%A6%E6%A0%8F%E5%B9%B3%E9%93%BA%E5%88%86%E7%B1%BB%E7%BB%84%E4%BB%B6/module_category1.0.1.zip