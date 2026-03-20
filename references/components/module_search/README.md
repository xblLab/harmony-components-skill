# 带返回按钮的搜索组件

## 简介

本组件提供搜索组件，展示热门搜索词，支持根据名称搜索家政服务。

## 详细介绍

### 简介

本组件提供搜索组件，展示热门搜索词，支持根据名称搜索家政服务。

### 图片展示

搜索前搜索后

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 快速入门

安装组件。

> 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
> 如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_search`、`module_base` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_search、module_base 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_search",
    "srcPath": "./XXX/module_search"
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
  "module_search": "file:./XXX/module_search"
}
```

引入组件。

```typescript
import { UISearch, UISearchController } from 'module_search';
```

调用组件，详细参数配置说明参见 API 参考。

## API 参考

### 接口

#### UISearch(option: UISearchOptions)

搜索选择组件

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UISearchOptions | 是 | 配置搜索选择组件的参数。 |

##### UISearchOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| recommendList | string[] | 否 | 热门搜索 |
| list | IGoodInfo[] | 是 | 搜索结果列表 |
| controller | UISearchController | 是 | 搜索控制器 |

#### UISearchController

搜索组件的控制器。

##### constructor

```typescript
constructor()
```

UISearchController 的构造函数。

##### onBackPressed

```typescript
onBackPressed(): boolean
```

触发组件内部返回事件。

## 示例代码

```typescript
import { router } from '@kit.ArkUI';
import { IGoodInfo, TypeGood } from 'module_base';
import { UISearch, UISearchController } from 'module_search';

const LIST: IGoodInfo[] = [
  {
    type: TypeGood.PAY,
    classId: '1',
    id: '1',
    title: '日常保洁',
    subTitle: '高温消毒｜除尘除垢',
    image: 'resourceImage://ic_placeholder_img',
    intro: [],
    price: 119,
    vipPrice: 41,
    soldNum: 800,
    serviceContentList: [],
    serviceDetailList: [],
    servicePipeList: [],
    feeList: [],
    qaList: [],
  },
];

@Entry
@ComponentV2
struct SearchSample {
  @Local list: IGoodInfo[] = [];
  controller: UISearchController = new UISearchController();

  onBackPress(): boolean | void {
    return this.controller.onBackPressed();
  }

  build() {
    NavDestination() {
      Column() {
        UISearch({
          recommendList: ['日常保洁', '开荒清洁', '住家保姆', '金牌月嫂'],
          list: this.list,
          controller: this.controller,
          query: (content) => {
            return Promise.resolve().then(() => {
              this.list = LIST;
            });
          },
          jumpDetail: (v: IGoodInfo) => {
            this.getUIContext().getPromptAction().showToast({ message: '跳转详情页' });
          },
          goBack: () => {
            router.back();
          },
        })
      }
      .width('100%')
      .height('100%')
      .padding(10)
    }
    .title('搜索组件')
  }
}
```

## 更新记录

- **1.0.1 (2025-10-31)**
  - 下载该版本
  - 优化 README
- **1.0.0 (2025-08-29)**
  - 下载该版本
  - 初始版本

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### SDK 合规使用指南

- 不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1f0179a55f30491f92fa01fe55f6979b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%B8%A6%E8%BF%94%E5%9B%9E%E6%8C%89%E9%92%AE%E7%9A%84%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/module_search1.0.1.zip