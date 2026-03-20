# 多功能答题组件

## 简介

本组件提供了答题、计时器、查看答题卡以及添加笔记的功能，当前答题数据均为 mock 数据，实际开发请填充业务真实数据。

## 详细介绍

### 简介

本组件提供了答题、定时器、查看答题卡以及添加笔记的功能，当前答题数据均为 mock 数据，实际开发请填充业务真实数据。

### 功能样式

- 未答题样式
- 已答题样式
- 答题卡
- 添加笔记

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 answer_questions 模块。

```json5
// 在项目根目录 build-profile.json5 填写 answer_questions 路径。其中 XXX 为组件存放的目录名。
"modules": [
  {
    "name": "answer_questions",
    "srcPath": "./XXX/answer_questions",
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "answer_questions": "file:./XXX/answer_questions"
}
```

引入组件句柄。

```typescript
import { AnswerQuestionsPage } from 'answer_questions';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { AnswerQuestionsPage } from 'answer_questions';

@Entry
@Component
struct Index {

  build() {
    Column() {
      AnswerQuestionsPage()
    }
    .width('100%')
    .height('100%')
  }
}
```

### API 参考

#### 接口

**AnswerQuestionsPage(options: AnswerOptions)**

答题组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | AnswerOptions | 是 | 答题组件相关参数 |

**AnswerOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| quesTopicItem | ItemModel[] | 否 | 本次练习所有题目数据 |
| practiceDuration | number | 否 | 练习时长 |
| currentIndex | number | 否 | 题目下标 |
| currentModel | TopicItemModel | 否 | 当前题目 |
| rightCont | number | 否 | 正确题数 |
| errCont | number | 否 | 错误题数 |
| isCollection | boolean | 否 | 是否收藏 |
| isCloseAnswerSheet | boolean | 否 | 是否关闭答题卡 |

**TopicItemModel 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | string | 是 | 类型 |
| title | string | 是 | 标题 |
| keyID | string | 是 | 题目 ID |
| quesAnswerItem | ItemModel[] | 是 | 题目选项列表 |
| parse | string | 是 | 解析 |
| note | string | 是 | 笔记 |
| rightQues | string[] | 是 | 题目答案列表 |
| selectQues | string[] | 是 | 选中的答案列表 |
| showState | number | 是 | 答题状态：0 原始状态 1 错误 2 正确 |
| isAnswer | boolean | 是 | 是否答题 |

**AnswerItem 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| ansTitle | string | 是 | 选项标题 |
| ansID | string | 是 | 选项 ID |
| ans | string | 是 | 选项 |
| isSelect | boolean | 是 | 是否选中 |
| showState | number | 是 | 答题状态：0 原始状态 1 错误 2 正确 |

#### 事件

支持以下事件：

- **initCurrentModel**
  ```typescript
  initCurrentModel() {}
  ```
  答题数据初始化

- **answerEvent**
  ```typescript
  answerEvent(item: AnswerItem){}
  ```
  答题逻辑处理

- **onSelectIndex**
  ```typescript
  onSelectIndex(index: number) {}
  ```
  跳转到第 index 个题目

- **isCollectionEvent**
  ```typescript
  isCollectionEvent: () => void = () => { }
  ```
  是否收藏

- **confirmAddNote**
  ```typescript
  confirmAddNote: (note: string) => void = () => {}
  ```
  将添加的笔记渲染到 ux 页面

- **storageWrongClick**
  ```typescript
  storageWrongClick: () => void = () => { }
  ```
  错题记录

- **storageCollectClick**
  ```typescript
  storageCollectClick: () => void = () => { }
  ```
  收藏记录

- **viewReport**
  ```typescript
  viewReport: () => void = () => { }
  ```
  查看报告

- **onClickBack**
  ```typescript
  onClickBack: () => void = () => { }
  ```
  点击返回上一级

### 示例代码

```typescript
import { AnswerQuestionsPage } from 'answer_questions';

@Entry
@Component
struct Index {

  build() {
    Column() {
      AnswerQuestionsPage()
    }
    .width('100%')
    .height('100%')
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2025-09-25 | Created with Pixso.<br>下载该版本调整 readme 说明 |
| 1.0.0 | 2025-08-29 | Created with Pixso.<br>下载该版本初始版本 |

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | Created with Pixso. |

**隐私政策**：不涉及
**SDK 合规使用指南**：不涉及

### 兼容性

| HarmonyOS 版本 | Created with Pixso. |
| :--- | :--- |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |

| 应用类型 | Created with Pixso. |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | Created with Pixso. |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | Created with Pixso. |
| :--- | :--- |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bffa8e65e544419e87b583e140a49cc7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%A4%9A%E5%8A%9F%E8%83%BD%E7%AD%94%E9%A2%98%E7%BB%84%E4%BB%B6/answer_questions1.0.1.zip