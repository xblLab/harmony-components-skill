# 商品搜索组件

## 简介

本模板提供商品搜索组件，可以查看并编辑搜索历史，查看并刷新推荐关键词，查看热搜榜。

## 详细介绍

### 简介

本模板提供商品搜索组件，可以查看并编辑搜索历史，查看并刷新推荐关键词，查看热搜榜。

### 约束与限制

#### 环境

*   DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上
*   HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上
*   设备类型：华为手机（包括双折叠和阔折叠）
*   系统版本：HarmonyOS 5.0.1(13) 及以上

#### 权限

*   网络权限：ohos.permission.INTERNET

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_product_search` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_product_search 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_product_search",
    "srcPath": "./XXX/module_product_search"
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
  "module_product_search": "file:./XXX/module_product_search"
}
```

引入组件。

```typescript
import { SearchView } from 'module_product_search';
```

## API 参考

### ProductShare(options: ProductShareOptions)

#### ProductDetailOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| defaultSearch | string | 否 | 进入页面时搜索框显示的关键字，默认为空 |
| routerStackNavPathStack | NavPathStack | 否 | 路由框架提供的导航控制器，不传则无法通过返回按钮回退上一页面 |

### 事件

支持以下事件：

*   **handleSearch**
    *   `handleSearch: (value: string) => void`
    *   点击搜索按钮后触发该事件

### 示例代码

```typescript
import { SearchView } from 'module_product_search';

@Entry
@ComponentV2
export struct PreviewPage2 {
  stack: NavPathStack = new NavPathStack();

  @Builder
  pageMap(name: string) {
    if (name === 'search') {
      SearchPage();
    }
  }

  build() {
    Navigation(this.stack) {
      Button('点击进入搜索页面')
        .onClick(() => {
          this.stack.pushPath({ name: 'search' });
        });
    }
    .navDestination(this.pageMap);
  }
}

@ComponentV2
export struct SearchPage {
  stack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      SearchView({
        routerStack: this.stack,
        handleSearch: (value) => {
          this.getUIContext().getPromptAction().showToast({
            message: '提交了搜索关键字：' + value,
          });
        },
      });
    }
    .hideTitleBar(true)
    .onReady((context) => {
      this.stack = context.pathStack;
    });
  }
}
```

## 更新记录

### 1.0.2 (2026-01-13)

Created with Pixso.

下载该版本废弃 API 整改

### 1.0.1 (2025-09-10)

Created with Pixso.

下载该版本 README 更新

### 1.0.0 (2025-08-29)

Created with Pixso.

下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络。 | 允许使用 Internet 网络。 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1 <br> Created with Pixso. <br> 5.0.2 <br> Created with Pixso. <br> 5.0.3 <br> Created with Pixso. <br> 5.0.4 <br> Created with Pixso. <br> 5.0.5 <br> Created with Pixso. <br> 5.1.0 <br> Created with Pixso. <br> 5.1.1 <br> Created with Pixso. <br> 6.0.0 <br> Created with Pixso. <br> 6.0.1 <br> Created with Pixso. |
| **应用类型** | 应用 <br> Created with Pixso. <br> 元服务 <br> Created with Pixso. |
| **设备类型** | 手机 <br> Created with Pixso. <br> 平板 <br> Created with Pixso. <br> PC <br> Created with Pixso. |
| **DevEcoStudio 版本** | DevEco Studio 5.0.1 <br> Created with Pixso. <br> DevEco Studio 5.0.2 <br> Created with Pixso. <br> DevEco Studio 5.0.3 <br> Created with Pixso. <br> DevEco Studio 5.0.4 <br> Created with Pixso. <br> DevEco Studio 5.0.5 <br> Created with Pixso. <br> DevEco Studio 5.1.0 <br> Created with Pixso. <br> DevEco Studio 5.1.1 <br> Created with Pixso. <br> DevEco Studio 6.0.0 <br> Created with Pixso. <br> DevEco Studio 6.0.1 <br> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c2b342f4094c4c799226b47efc87e92d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%93%81%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/module_product_search1.0.2.zip