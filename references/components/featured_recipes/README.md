# 菜谱瀑布流组件

## 简介

本组件提供了展示菜谱列表搜瀑布流的相关功能。

## 详细介绍

### 简介

本组件提供了展示菜谱列表搜瀑布流的相关功能。

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

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
b. 在项目根目录 `build-profile.json5` 并添加 `base_ui` 和 `featured_recipes` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui 和 featured_recipes 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "featured_recipes",
    "srcPath": "./xxx/featured_recipes",
  }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "featured_recipes": "file:./xxx/featured_recipes"
}
```

#### 引入组件

```typescript
import { FeaturedRecipes } from 'featured_recipes';
```

#### 调用组件

调用组件，详细参数配置说明参见 API 参考。

```typescript
FeaturedRecipes({
   dishesList: this.vm.dishesList,
   showTitle: true,
   onClickCb: (id: number) => {
     // 点击跳转菜谱详情
   },
   jumpBloggerInfo: (id: number) => {
     // 点击跳转菜谱作者主页
   },
 })
```

## API 参考

### 接口

`FeaturedRecipes(options?: FeaturedRecipesOptions)`

展示菜谱列表搜瀑布流组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | FeaturedRecipesOptions | 否 | 展示菜谱列表搜瀑布流的参数。 |

##### FeaturedRecipesOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| dishesList | LazyDataSource<RecipeBriefInfo> | 否 | 菜谱懒加载列表 |
| showTitle | boolean | 否 | 是否展示标题 |
| canDelete | boolean | 否 | 是否可以删除 |
| isToDelete | boolean | 否 | 是否是删除状态 |

##### LazyDataSource 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| dataArray | RecipeBriefInfo[] | 是 | 菜谱列表 |

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

| 事件名 | 回调函数签名 | 说明 |
| :--- | :--- | :--- |
| onClickCb | `onClickCb(callback: (id: number) => void)` | 点击跳转菜谱详情 |
| jumpBloggerInfo | `jumpBloggerInfo(callback: (id: number) => void)` | 点击跳转菜谱作者主页 |
| deleteRecipes | `deleteRecipes(callback: (ids: number[]) => void)` | 点击删除菜谱事件 |
| changeSelect | `changeSelect(callback: (id: number, flag: boolean) => void)` | 删除时点击修改选中菜谱事件 |
| changeDeleteState | `changeDeleteState(callback: (isToDelete: boolean) => void)` | 长按菜谱时触发删除状态变更 |

## 示例代码

```typescript
import { promptAction } from '@kit.ArkUI';
import { FeaturedRecipes, LazyDataSource, RecipeBriefInfo } from 'featured_recipes';

@Entry
@ComponentV2
struct Index {
   @Local dishesList: LazyDataSource<RecipeBriefInfo> = new LazyDataSource();

   aboutToAppear(): void {
      this.dishesList.pushArrayData([{
         id: 1,
         title: '西红柿炒鸡蛋',
         authorId: 1,
         author: '美食博主',
         authorAvatar: 'startIcon',
         thumbnail: 'startIcon',
         likes: 100,
      } as RecipeBriefInfo,
         {
            id: 2,
            title: '可乐鸡翅',
            authorId: 1,
            author: '美食博主',
            authorAvatar: 'startIcon',
            thumbnail: 'startIcon',
            likes: 100,
         } as RecipeBriefInfo])
   }

   build() {
      RelativeContainer() {
         FeaturedRecipes({
            dishesList: this.dishesList,
            showTitle: true,
            onClickCb: (id: number) => {
               // 点击跳转菜谱详情
               promptAction.showToast({ message: '跳转菜谱详情' })
            },
            jumpBloggerInfo: (id: number) => {
               // 点击跳转菜谱作者主页
               promptAction.showToast({ message: '跳转菜谱作者主页' })
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

- **1.0.5** (2026-01-14): 瀑布流增加下拉加载和上拉刷新；新增折叠屏适配
- **1.0.4** (2025-12-03): 适配平板兼容性；适配元服务，避让胶囊区域；页面自适应修改
- **1.0.3** (2025-11-07): 更新修改 readme 内容
- **1.0.2** (2025-10-31): 更新 readme 内容
- **1.0.1** (2025-08-29): 优化目录结构
- **1.0.0** (2025-07-10): 本组件提供了展示菜谱列表搜瀑布流的相关功能

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

- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8859f8aef4994387b5707bfc3e71b289/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%8F%9C%E8%B0%B1%E7%80%91%E5%B8%83%E6%B5%81%E7%BB%84%E4%BB%B6/featured_recipes1.0.5.zip