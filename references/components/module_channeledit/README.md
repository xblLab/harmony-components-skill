# 频道编辑组件

## 简介

本组件支持添加分类、拖拽分类排序等。

## 详细介绍

### 简介

本组件支持添加分类、拖拽分类排序等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_channeledit` 模块。
   > 项目根目录下 `build-profile.json5` 填写 `module_channeledit` 路径。其中 XXX 为组件存放的目录名。

   ```json5
   "modules": [
     {
       "name": "module_channeledit",
       "srcPath": "./XXX/module_channeledit"
     }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 添加依赖。
   > XXX 为组件存放的目录名称。

   ```json5
   "dependencies": {
     "module_channeledit": "file:./XXX/module_channeledit"
   }
   ```

引入组件。

```typescript
import { ChannelEdit } from 'module_channeledit';
```

### API 参考

#### 接口

**ChannelEdit(option: ChannelEditOptions)**

频道编辑组件参数。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ChannelEditOptions | 否 | 频道编辑组件参数 |

**ChannelEditOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| channelsList | TabInfo[] | 否 | 数据源 |
| currentIndex | number | 否 | 当前选择的索引 |
| fontSizeRatio | number | 否 | 文字缩放倍率 |

**TabInfo 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 数据源枚举 id |
| textResource | string | 是 | 数据源文本 |
| selected | boolean | 是 | 是否被选中 |
| order | number | 是 | 顺序 |
| disabled | boolean | 是 | 是否被禁用 |
| visibility | Visibility | 是 | 是否显示 |

#### 事件

支持以下事件：

- **onSave**
  ```typescript
  onSave: (select: TabInfo[], unselect: TabInfo[]) => void
  ```
  拖拽，删除增加的回调

- **onChange**
  ```typescript
  onChange: (index: number, item: TabInfo) => void
  ```
  顶部栏切换的回调

#### 示例代码

```typescript
import { ChannelEdit, TabInfo } from 'module_channeledit';

@Entry
@ComponentV2
export struct Index {
  @Local currentIndex: number = 1
  @Local channelsList: TabInfo[] = [{
    'text': '关注',
    'id': 'follow',
    'selected': true,
    'order': 1,
    'disabled': true,
  }, {
    'text': '推荐',
    'id': 'recommend',
    'selected': true,
    'order': 2,
    'disabled': true,
  }, {
    'text': '热榜',
    'id': 'hotService',
    'selected': true,
    'order': 3,
    'disabled': true,
  }, {
    'text': '南京',
    'id': 'location',
    'selected': true,
    'order': 4,
  }, {
    'text': '金融',
    'id': 'finance',
    'selected': true,
    'order': 5,
  }, {
    'text': '体育',
    'id': 'sports',
    'selected': true,
    'order': 6,
  }, {
    'text': '民生',
    'id': 'people',
    'selected': false,
    'order': 6,
  }, {
    'text': '科普',
    'id': 'science',
    'selected': false,
    'order': 6,
  }, {
    'text': '娱乐',
    'id': 'fun',
    'selected': false,
    'order': 6,
  }, {
    'text': '夜读',
    'id': 'read',
    'selected': false,
    'order': 6,
  }, {
    'text': '汽车',
    'id': 'car',
    'selected': false,
    'order': 6,
  }, {
    'text': 'V 观',
    'id': 'view',
    'selected': false,
    'order': 6,
  }]

  build() {
    Column() {
      ChannelEdit({
        channelsList: this.channelsList,
        fontSizeRatio: 1,
        currentIndex: this.currentIndex,
        onChange: (index: number, item: TabInfo) => {
          this.currentIndex = index
          console.log('index', index)
        },
        onSave: () => {
          console.log('save')
        },
      })
    }
  }
}
```

## 更新记录

### 1.0.0 (2025-11-03)

- 初始版本

## 权限与隐私

- **基本信息**
  - 权限名称：无
  - 权限说明：无
  - 使用目的：无
- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e654c20435614aab9f8372256faa0539/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%A2%91%E9%81%93%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/module_channeledit1.0.0.zip