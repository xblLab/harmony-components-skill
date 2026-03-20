# 个人中心组件

## 简介

本组件提供了个人中心的功能，包含个人简介、发布菜谱和收藏菜谱的相关功能，如果是用户信息支持展示登录和未登录状态。提供用户会员标签、开通会员和上传菜谱插槽，用于自定义相关内容。

## 详细介绍

### 简介

本组件提供了个人中心的功能，包含个人简介、发布菜谱和收藏菜谱的相关功能，如果是用户信息支持展示登录和未登录状态。提供用户会员标签、开通会员和上传菜谱插槽，用于自定义相关内容。

### 博主详情登录状态

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 权限

无

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `base_ui`、`featured_recipes` 和 `personal_homepage` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 base_ui、featured_recipes 和 personal_homepage 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "base_ui",
    "srcPath": "./xxx/base_ui",
  },
  {
    "name": "featured_recipes",
    "srcPath": "./xxx/featured_recipes",
  },
  {
    "name": "personal_homepage",
    "srcPath": "./xxx/personal_homepage",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "base_ui": "file:./xxx/base_ui",
  "featured_recipes": "file:./xxx/featured_recipes",
  "personal_homepage": "file:./xxx/personal_homepage"
}
```

### 引入组件

```typescript
import { PersonalHomepage } from 'personal_homepage';
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
PersonalHomepage({
    bloggerInfo: this.vm.bloggerInfo,
    recipeList: this.vm.recipeList,
    isSelf: true,
    isLogin: this.vm.userInfo.isLogin,
    currentIndex: this.vm.currentIndex,
    userTagBuilderParam: (): void => {
      // 用户标签插槽
    },
    membershipBuilderParam: (): void => {
      // 开通会员插槽
    },
    uploadBuilderParam: (): void => {
       // 上传菜谱插槽
    },
    onClickCb: (id: number) => {
      // 跳转菜谱详情
    },
    jumpBloggerInfo: (id: number) => {
      // 跳转博主详情
    },
    changeTabIndex: (index: number) => {
      // 切换 tab 时，更新数据
    },
    login: () => {
      // 未登录时跳转登录
    },
    jumpFollowers: () => {
      // 跳转关注页面
    },
  })
```

## API 参考

### 接口

`PersonalHomepage(options?: PersonalHomepageOptions)`

展示个人中心组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PersonalHomepageOptions | 否 | 展示个人中心的参数。 |

#### PersonalHomepageOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| bloggerInfo | BloggerInfo[] | 是 | 博主个人信息 |
| recipeList | RecipeBriefInfo[] | 是 | 菜谱列表 |
| isSelf | boolean | 否 | 是否是个人中心 |
| isLogin | boolean | 否 | 是否已登录 |
| isFollower | boolean | 否 | 是否已关注 |
| currentIndex | number | 是 | tab 栏索引 |
| isToDelete | boolean | 否 | 删除场景时是否是删除状态 |

#### BloggerInfo 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | number | 是 | 博主序号 |
| name | string | 是 | 博主名称 |
| avatarResourceStr | string | 是 | 博主头像 |
| profile | string | 是 | 博主简介 |
| sex | string | 是 | 博主性别 |
| createdAccount | string | 是 | 创建日期 |
| ipLocation | string | 是 | IP 归属地 |
| bloggerType | string | 是 | 博主标签 |
| followers | number | 是 | 关注数 |
| fans | number | 是 | 粉丝数 |
| beFavorite | number | 是 | 被收藏 |
| beFollowed | number | 是 | 被跟做 |

#### RecipeBriefInfo 对象说明

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
| onClickCb | `onClickCb(callback: (id: number) => void)` | 跳转菜谱详情 |
| jumpBloggerInfo | `jumpBloggerInfo(callback: (id: number) => void)` | 跳转博主详情 |
| changeTabIndex | `changeTabIndex(callback: (index: number) => void)` | 切换 tab 时，更新数据 |
| login | `login(callback: () => void)` | 未登录时跳转登录 |
| jumpFollowers | `jumpFollowers(callback: () => void)` | 跳转关注页面 |
| deleteRecipes | `deleteRecipes(callback: (ids: number[]) => void)` | 删除场景时，点击删除按钮触发事件 |
| changeDeleteState | `changeDeleteState(callback: (isToDelete: boolean) => void)` | 删除场景时，长按菜谱触发删除选中 |

## 示例代码

### 示例 1

```typescript
import { promptAction } from '@kit.ArkUI';
import { LazyDataSource } from 'featured_recipes';
import { BloggerInfo, PersonalHomepage, RecipeBriefInfo } from 'personal_homepage';

@Entry
@ComponentV2
struct Index {
   @Local bloggerInfo: BloggerInfo = new BloggerInfo()
   @Local currentIndex: number = 1
   @Local recipeList: LazyDataSource<RecipeBriefInfo> = new LazyDataSource();

   aboutToAppear(): void {
      this.bloggerInfo.updateData(0, '华为用户', $r('app.media.startIcon'),
      '90 后厨房魔法师｜用热腾腾的美食治愈你的胃和心❤️ 每天分享简单快手菜，新手也能秒变大厨！', '女', '2022 加入',
      'IP 属地：南京', '美食博主', 20000, 29000, 20, 1920000)
      this.recipeList.pushArrayData([{
         id: 1,
         title: '西红柿炒鸡蛋',
         authorId: 1,
         author: '美食博主',
         authorAvatar: 'startIcon',
         thumbnail: 'startIcon',
         likes: 100,
      } as RecipeBriefInfo, {
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
         PersonalHomepage({
            bloggerInfo: this.bloggerInfo,
            recipeList: this.recipeList,
            isSelf: false,
            isLogin: false,
            currentIndex: this.currentIndex,
            userTagBuilderParam: (): void => {
               // 用户标签插槽
            },
            membershipBuilderParam: (): void => {
               // 开通会员插槽
            },
            uploadBuilderParam: (): void => {
               // 上传菜谱插槽
            },
            onClickCb: (id: number) => {
               // 跳转菜谱详情
               promptAction.showToast({ message: '跳转菜谱详情' })
            },
            jumpBloggerInfo: (id: number) => {
               // 跳转博主详情
               promptAction.showToast({ message: '跳转博主详情' })
            },
            changeTabIndex: (index: number) => {
               // 切换 tab 时，更新数据
               this.currentIndex = index
            },
            login: () => {
               // 未登录时跳转登录
               promptAction.showToast({ message: '未登录时跳转登录' })
            },
            jumpFollowers: () => {
               // 跳转关注页面
               promptAction.showToast({ message: '跳转关注页面' })
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

### 1.0.4 (2026-01-14)
- 下载该版本
- 适配折叠屏

### 1.0.3 (2025-11-07)
- 下载该版本
- 更新修改 readme 内容

### 1.0.2 (2025-09-11)
- 下载该版本
- 更新 readme 内容

### 1.0.1 (2025-08-29)
- 下载该版本
- 优化目录结构

### 1.0.0 (2025-07-10)
- 下载该版本
- 本组件提供了个人中心的功能，包含个人简介、发布菜谱和收藏菜谱的相关功能，如果是用户信息支持展示登录和未登录状态。提供用户会员标签、开通会员和上传菜谱插槽，用于自定义相关内容。

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

### DevEcoStudio 版本

- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/326ed16ff62d4fbe8b35f11c70d75f1b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%AA%E4%BA%BA%E4%B8%AD%E5%BF%83%E7%BB%84%E4%BB%B6/personal_homepage1.0.4.zip