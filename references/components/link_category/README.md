# 分类列表组件

## 简介

本组件提供了分类展示菜谱列表的相关功能。

## 详细介绍

### 简介

本组件提供了分类展示菜谱列表的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

无

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。

b. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `link_category` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 link_category 路径。其中 xxx 为组件存在的目录名
{
  "modules": [
    {
      "name": "base_ui",
      "srcPath": "./xxx/base_ui"
    },
    {
      "name": "link_category",
      "srcPath": "./xxx/link_category"
    }
  ]
}
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
{
  "dependencies": {
    "link_category": "file:./xxx/link_category"
  }
}
```

引入组件。

```arkts
import { LinkCategory } from 'link_category';
```

调用组件，详细参数配置说明参见 API 参考。

```arkts
LinkCategory({
  recipeCategoryList: this.vm.recipeCategoryList,
  currentIndex: this.vm.currentIndex,
  onRecipeClick: (listItem) => {
    // 跳转详情页
  },
  changeCurrentIndex: (index: number) => {
    // 点击分类标签切换 index 事件
  },
})
```

### API 参考

#### 接口

`LinkCategory(options?: LinkCategoryOptions)`

按分类展示菜谱列表组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | LinkCategoryOptions | 否 | 按分类展示菜谱列表的参数。 |

##### LinkCategoryOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| recipeCategoryList | RecipeCategory[] | 否 | 今日摄入卡路里 |
| currentIndex | number | 是 | 左侧分类列表选中序号 |

##### RecipeCategory 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 菜谱分类序号 |
| name | string | 是 | 菜谱分类名称 |
| recipeList | RecipeBriefInfo[] | 是 | 菜谱分类里的菜谱 |

##### RecipeBriefInfo 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 菜谱序号 |
| title | string | 是 | 菜谱名称 |
| description | string | 否 | 菜谱描述 |
| category | string | 否 | 菜谱分类 |
| cookingTime | number | 否 | 菜谱制作时间 |
| difficulty | string | 否 | 菜谱难度 |
| authorId | number | 否 | 作者 id 序号 |
| author | string | 否 | 作者名称 |
| authorAvatar | string | 否 | 作者头像 |
| thumbnail | string | 是 | 菜谱缩略图 |
| views | number | 否 | 浏览数 |
| likes | number | 否 | 收藏数 |

#### 事件

支持以下事件：

- **onRecipeClick**
  - `onRecipeClick(callback: (recipeDetail: RecipeBriefInfo) => void)`
  - 点击菜谱触发事件
- **changeCurrentIndex**
  - `changeCurrentIndex(callback: (currentIndex: number) => void)`
  - 点击菜谱分类触发事件

### 示例代码

```arkts
import { promptAction } from '@kit.ArkUI';
import { LinkCategory, RecipeBriefInfo, RecipeCategory } from 'link_category';

@Entry
@ComponentV2
struct Index {
   @Local currentIndex: number = 1
   @Local recipeCategoryList: RecipeCategory[] = [{
      id: 1,
      name: '热门菜肴',
      recipeList: [{ id: 1, title: '西红柿炒鸡蛋', thumbnail: 'startIcon' } as RecipeBriefInfo,
         { id: 2, title: '可乐鸡翅', thumbnail: 'startIcon' } as RecipeBriefInfo,
         { id: 3, title: '宫保鸡丁', thumbnail: 'startIcon' } as RecipeBriefInfo],
   }, {
      id: 2,
      name: '家常菜',
      recipeList: [{ id: 1, title: '红烧肉', thumbnail: 'startIcon' } as RecipeBriefInfo,
         { id: 2, title: '回锅肉', thumbnail: 'startIcon' } as RecipeBriefInfo,
         { id: 3, title: '清蒸鱼', thumbnail: 'startIcon' } as RecipeBriefInfo],
   }];

   build() {
      RelativeContainer() {
         LinkCategory({
            recipeCategoryList: this.recipeCategoryList,
            currentIndex: this.currentIndex,
            onRecipeClick: (listItem) => {
               // 跳转详情页
               promptAction.showToast({ message: '跳转详情页' })
            },
            changeCurrentIndex: (index: number) => {
               // 点击分类标签切换 index 事件
               this.currentIndex = index
            },
         })
      }
      .height('100%')
      .width('100%')
      .padding({ top: 45 })
   }
}
```

### 更新记录

- **1.0.4** (2026-01-14)
  - 下载该版本适配折叠屏
- **1.0.3** (2025-11-07)
  - 下载该版本更新修改 readme 内容
- **1.0.2** (2025-09-11)
  - 下载该版本更新 readme 内容
- **1.0.1** (2025-08-29)
  - 下载该版本优化目录结构
- **1.0.0** (2025-07-10)
  - 下载该版本本组件提供了分类展示菜谱列表的相关功能

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/24aa0824f0434ffc922ed393aeaf730d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%88%86%E7%B1%BB%E5%88%97%E8%A1%A8%E7%BB%84%E4%BB%B6/link_category1.0.4.zip