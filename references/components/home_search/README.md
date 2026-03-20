# 简易搜索组件

## 简介

提供菜谱搜索功能，展示历史搜索、热门搜索和搜索后的结果。

## 详细介绍

### 简介

提供菜谱搜索功能，展示历史搜索、热门搜索和搜索后的结果。

### 搜索结果展示

（此处展示搜索结果）

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `home_search` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 home_search 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "home_search",
    "srcPath": "./xxx/home_search",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "home_search": "file:./xxx/home_search"
}
```

#### 引入组件

```typescript
import { HomeSearch } from 'home_search';
```

#### 调用组件

详细参数配置说明参见 [API 参考](#api-参考)。

```typescript
HomeSearch({
    hotInfo: this.vm.hotInfo,
    resultList: this.vm.resultList,
    paramsKeyword: this.vm.paramsKeyword,
    isShowResult: this.vm.isShowResult,
    isShowSearch: this.vm.formPage === CommonConstants.CLASSIFICATION_PAGE,
    searchDishes: (keyword: string) => {
      // 调用搜索查询事件
    },
    changeIndex: (index: number, keyword: string) => {
      // 切换搜索排序的事件
    },
    changeShowResult: (flag: boolean) => {
      // 切换展示搜索结果的事件
    },
    goRecipeDetail: (id: number) => {
      // 跳转菜谱详情事件
    },
  })
```

## API 参考

### 接口

`HomeSearch(options?: HomeSearchOptions)`

搜索菜谱组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | HomeSearchOptions | 否 | 搜索菜谱的参数 |

##### HomeSearchOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| hotInfo | string[] | 否 | 热门搜索 |
| resultList | RecipeBriefInfo[] | 否 | 搜索结果 |
| paramsKeyword | string | 否 | 默认搜索词 |
| isShowResult | boolean | 否 | 是否展示搜索结果 |
| isShowSearch | boolean | 否 | 是否展示搜索框 |

##### RecipeBriefInfo 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 菜谱序号 |
| title | string | 是 | 菜谱名称 |
| description | string | 否 | 菜谱描述 |
| category | string | 否 | 菜谱分类 |
| cookingTime | number | 否 | 菜谱制作时间 |
| difficulty | string | 否 | 菜谱难度 |
| authorId | number | 是 | 作者 id 序号 |
| author | string | 是 | 作者名称 |
| authorAvatar | string | 是 | 作者头像 |
| thumbnail | string | 是 | 菜谱缩略图 |
| views | number | 否 | 浏览数 |
| likes | number | 是 | 收藏数 |

### 事件

支持以下事件：

| 事件名 | 回调签名 | 说明 |
| :--- | :--- | :--- |
| searchDishes | `searchDishes(callback: (keyword: string) => void)` | 调用搜索查询事件 |
| changeIndex | `changeIndex(callback: (index: number, keyword: string) => void)` | 切换搜索排序的事件 |
| changeShowResult | `changeShowResult(callback: (flag: boolean) => void)` | 切换展示搜索结果的事件 |
| goRecipeDetail | `goRecipeDetail(callback: (id: number) => void)` | 跳转菜谱详情事件 |

## 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { HomeSearch, RecipeBriefInfo } from 'home_search';

@Entry
@ComponentV2
struct Index {
  @Local hotInfo: string[] = ['西红柿炒鸡蛋', '可乐鸡翅']
  @Local resultList: RecipeBriefInfo[] = [{
     id: 1,
     title: '西红柿炒鸡蛋',
     description: '西红柿炒鸡蛋',
     category: '',
     cookingTime: 0,
     difficulty: '',
     author: '美食博主',
     authorAvatar: 'startIcon',
     thumbnail: 'startIcon',
     views: 100,
     likes: 100,
  } as RecipeBriefInfo, {
     id: 2,
     title: '可乐鸡翅',
     description: '西红柿炒鸡蛋',
     category: '',
     cookingTime: 0,
     difficulty: '',
     author: '美食博主',
     authorAvatar: 'startIcon',
     thumbnail: 'startIcon',
     views: 100,
     likes: 100,
  } as RecipeBriefInfo];

  build() {
     RelativeContainer() {
        HomeSearch({
           hotInfo: this.hotInfo,
           resultList: this.resultList,
           paramsKeyword: '',
           isShowResult: true,
           isShowSearch: true,
           searchDishes: (keyword: string) => {
              // 调用搜索查询事件
              promptAction.showToast({ message: '调用搜索查询' })
           },
           changeIndex: (index: number, keyword: string) => {
              // 切换搜索排序的事件
              promptAction.showToast({ message: '切换搜索排序' })
           },
           changeShowResult: (flag: boolean) => {
              // 切换展示搜索结果的事件
              promptAction.showToast({ message: '切换展示搜索结果' })
           },
           goRecipeDetail: (id: number) => {
              // 跳转菜谱详情事件
              promptAction.showToast({ message: '跳转菜谱详情' })
           },
        })
     }
     .height('100%')
     .width('100%')
     .padding({ top: 45 })
  }
}
```

## 更新记录

- **1.0.4** (2026-01-14)
  - 适配折叠屏
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip)
- **1.0.3** (2025-12-03)
  - 适配元服务，避让胶囊区域；数据持久化修改
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip)
- **1.0.2** (2025-11-07)
  - 更新修改 readme 内容
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip)
- **1.0.1** (2025-09-11)
  - 更新 readme 内容
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip)
- **1.0.0** (2025-08-29)
  - 初始版本
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 |
| :--- |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bf1ca3f0ef0e452eb5ef8c4df34026d4/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AE%80%E6%98%93%E6%90%9C%E7%B4%A2%E7%BB%84%E4%BB%B6/home_search1.0.4.zip