# 新闻发布组件

## 简介

本组件支持新闻发布，包括富文本编辑。

## 详细介绍

### 简介

本组件支持新闻发布，包括富文本编辑。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_articlepost` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_articlepost 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_articlepost",
    "srcPath": "./XXX/module_articlepost"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_articlepost": "file:./XXX/module_articlepost"
}
```

引入组件。

```typescript
import { ArticlePost } from 'module_articlepost';
```

调用组件，详细组件调用参见示例代码。

```typescript
import { ArticlePost } from 'module_articlepost'

@Entry
@ComponentV2
struct Index {
  build() {
    Column(){
      ArticlePost({
        ...
      })
    }
  }
}
```

## API 参考

### 接口

`ArticlePost(option: ArticlePostOptions)`

新闻发布组件的参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ArticlePostOptions | 否 | 新闻发布组件的参数。 |

**ArticlePostOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fontSizeRatio | string | 是 | 字体缩放倍率 |
| darkMode | string | 是 | 深色模式 |

### 事件

支持以下事件：

- **onTitleChange**
  ```typescript
  onTitleChange: (value: string) => void = () => {}
  ```
  标题输入回调

- **onContentChange**
  ```typescript
  onContentChange: (value: string) => void = () => {}
  ```
  富文本输入回调

## 示例代码

```typescript
import { ArticlePost } from 'module_articlepost'

@Entry
@ComponentV2
struct Index {
  build() {
    Column(){
      ArticlePost({
        fontSizeRatio: 1,
        darkMode:false,
        onTitleChange: (value: string) => {
          console.log('标题输入'+ value)
        },
        onContentChange: (value: string) => {
          console.log('富文本输入'+ value)
        },
      })
    }
  }
}
```

## 更新记录

### 1.0.0 (2025-09-10)

- 下载该版本
- 初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络。 | 允许使用 Internet 网络。 |

### 隐私政策

- **隐私政策**：不涉及 SDK 合规
- **使用指南**：不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c82f7f5660d24e78829b0d69e2089f4b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%96%B0%E9%97%BB%E5%8F%91%E5%B8%83%E7%BB%84%E4%BB%B6/module_articlepost1.0.0.zip