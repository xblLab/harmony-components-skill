# 一键搜题组件

## 简介

本组件提供了一键搜题页面的模板，本身集成语音输入，拍照识别，粘贴和清除功能，提供搜索和退出回调方法。

## 详细介绍

### 简介

本组件提供了一键搜题页面的模板，本身集成语音输入，拍照识别，粘贴和清除功能，提供搜索和退出回调方法。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `search_question` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 search_question 路径。其中 XXX 为组件存放的目录名。
"modules": [
{
"name": "search_question",
"srcPath": "./XXX/search_question",
}
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "search_question": "file:./XXX/search_question"
  }
```

引入一键搜题组件句柄。

```typescript
import { SearchQuestionPage } from 'search_question';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { SearchQuestionPage } from 'search_question';

@Entry
@Component
struct Index {
  build() {
    Column() {
      SearchQuestionPage({
        //返回搜索框中的 data 值
        search: (data) => {
          console.log("点击搜索按钮")
        },
        back: () => {
          console.log("点击返回按钮回调事件")
        },
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

### API 参考

#### SearchQuestionPage()

一键搜题组件组件。

**事件**

支持以下事件：

- **search**
  - `search: () => void = () => {}`
  - 点击搜索的事件
- **back**
  - `back: () => void = () => {}`
  - 点击返回的事件。

### 示例代码

```typescript
import { SearchQuestionPage } from 'search_question';

@Entry
@Component
struct Index {
 build() {
   Column() {
     SearchQuestionPage({
       //返回搜索框中的 data 值
       search: (data) => {
         this.getUIContext().getPromptAction().showToast({ message: '点击搜索事件', duration: 2000 });
         console.info("点击搜索按钮")
       },
       back: () => {
         this.getUIContext().getPromptAction().showToast({ message: '返回事件', duration: 2000 });
         console.info("点击返回按钮回调事件")
       },
     })
   }
   .width('100%')
   .height('100%')
 }
}
```

### 更新记录

- **1.0.3 (2026-01-06)**
  - 修正示例代码 UX 问题
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E6%90%9C%E9%A2%98%E7%BB%84%E4%BB%B6/search_question1.0.3.zip)
- **1.0.2 (2025-09-25)**
  - 调整 readme 说明
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E6%90%9C%E9%A2%98%E7%BB%84%E4%BB%B6/search_question1.0.2.zip)
- **1.0.1 (2025-08-29)**
  - 部分文件代码抽离
  - 拷贝粘贴异常相关问题修复
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E6%90%9C%E9%A2%98%E7%BB%84%E4%BB%B6/search_question1.0.1.zip)
- **1.0.0 (2025-07-02)**
  - 本组件提供了一键搜题页面的模板，本身集成语音输入，拍照识别，粘贴和清除功能，提供搜索和退出回调方法。
  - [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E6%90%9C%E9%A2%98%E7%BB%84%E4%BB%B6/search_question1.0.0.zip)

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e094642759064bc69b9bc349b0a380d1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%80%E9%94%AE%E6%90%9C%E9%A2%98%E7%BB%84%E4%BB%B6/search_question1.0.3.zip