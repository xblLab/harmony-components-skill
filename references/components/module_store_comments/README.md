# 店铺评价组件

## 简介

本组件为店铺评价组件，可查看评价列表并发表匿名评价。

## 详细介绍

### 简介

本组件为店铺评价组件，可查看评价列表并发表匿名评价。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.4(16) 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_ui_base` 和 `module_store_comments` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_module_ui_base 和 module_store_comments 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_ui_base",
    "srcPath": "./XXX/module_ui_base"
  },
  {
    "name": "module_store_comments",
    "srcPath": "./XXX/module_store_comments"  
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
  "module_store_comments": "file:./XXX/module_store_comments",
}
```

#### 引入组件

```typescript
import { CommentListView } from 'module_store_comments';
```

调用组件，详见示例代码。详细参数配置说明参见 API 参考。

### API 参考

#### CommentListView(options: CommentListViewOptions)

**CommentListViewOptions 对象说明**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| stackNavPath | Stack | 否 | 使用评价组件的页面的路由栈，不传参可能会导致路由跳转异常 |

### 示例代码

```typescript
import { CommentListView } from 'module_store_comments'

@Entry
@ComponentV2
struct StoreCommentPreview {
  @Local stack: NavPathStack = new NavPathStack()

  @Builder
  pageMap(name: string) {
    if (name === 'CommentList') {
      CommentView()
    }
  }

  build() {
    Navigation(this.stack) {
      Button('查看评论列表').onClick(() => {
        this.stack.pushPath({ name: 'CommentList' })
      })
    }
    .navDestination(this.pageMap)
  }
}

@ComponentV2
struct CommentView {
  @Local stack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      CommentListView({
        stack: this.stack,
      })
    }
    .onReady((context) => {
      this.stack = context.pathStack
    })
    .title('评论列表')
  }
}
```

## 更新记录

- **1.0.1** (2025-11-07)
  - 修改 README
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%97%E9%93%BA%E8%AF%84%E4%BB%B7%E7%BB%84%E4%BB%B6/module_store_comments1.0.1.zip)
- **1.0.0** (2025-11-03)
  - 初始版本
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%97%E9%93%BA%E8%AF%84%E4%BB%B7%E7%BB%84%E4%BB%B6/module_store_comments1.0.1.zip)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 其他说明

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7fa47eadfe654fab9af028aeb51e1e50/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%97%E9%93%BA%E8%AF%84%E4%BB%B7%E7%BB%84%E4%BB%B6/module_store_comments1.0.1.zip