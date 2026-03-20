# 朗读组件

## 简介

本组件支持新闻类文章阅读。

## 详细介绍

### 简介

本组件支持新闻类文章阅读。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

- **网络权限**：ohos.permission.INTERNET

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_text_reader` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_text_reader 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_text_reader",
    "srcPath": "./XXX/module_text_reader"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_text_reader": "file:./XXX/module_text_reader"
}
```

#### 引入组件

```typescript
import { ReadNewsComponent } from 'module_text_reader';
```

### API 参考

#### 接口

`ReadNewsComponent(option: ReadNewsComponentOptions)`

文本阅读组件的参数。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ReadNewsComponentOptions | 否 | 配置文本阅读组件的参数。 |

**ReadNewsComponentOptions 对象说明：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| currentId | string | 是 | 数据源 id |
| body | string | - | 当前阅读文本 |
| title | string | - | 当前文本标题 |
| author | string | - | 当前文本作者 |
| date | string | - | 当前文本日期 |
| bundleName | string | - | 项目包名 |
| coverImage | string | - | 当前阅读器封面 |

#### 事件

支持以下事件：

- **stateChange**
  - `stateChange: () => void = () => {}`
  - 阅读器状态切换的回调

#### 示例代码

```typescript
import { ReadNewsComponent } from 'module_text_reader';

@Entry
@ComponentV2
export struct Index {
  build() {
    Column(){
      ReadNewsComponent({
        author: '1 号选手',
        date: '2025-8-4 10:26',
        title: '住建部称住宅层高标准将提至不低于 3 米，层高低的房子不值钱了？',
        coverImage: 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/news-hnp2d/news_1.jpg',
        bundleName: '综合新闻模板',
        currentId: 'article_6',
        body: '住建部称住宅层高标准将提至不低于 3 米，层高低的房子不值钱了？在十四届全国人大三次会议民生主题记者会上，住房城乡建设部部长倪虹表示，要加快建设“好房子”，并将住宅层高标准提高到不低于 3 米。这一政策不仅顺应了百姓对居住品质日益提高的需求，更标志着我国住宅建设从“住有所居”迈向“宜居优居”的新阶段。提高住宅的层高，可以显著提升居住空间的舒适度，增加净空高度，缓解大户型的空间压抑感，同时也为建筑立面增大开窗采光面积提供了可能性，有利于自然通风，让室内阳光更加充足，让居住环境更加健康舒适。随着人们对居住品质追求的不断提升，地暖、新风系统、中央空调等设备逐渐成为改善型住宅的“标配”。“3 米层高”，能为这些设备提供充足的安装空间，确保设备高效运行，进一步提升室内环境的舒适度。可以说，“将住宅层高标准提高到不低于 3 米”，是通过政策引领推动技术创新的重要举措，将鼓励开发企业、设计师探索更人性化的居住空间解决方案，进而推动住宅品质的提升。事实上，层高对于房子价值的影响，不能一概而论。房子的价值，受到地段、配套、交通、环境等多种因素的综合影响。即使层高较低，但如果房子位于城市核心地段，周边配套设施完善，交通便利，环境优美，那么其价值依然可能较高。',
      })
    }
  }
}
```

### 更新记录

**1.0.0 (2025-08-30)**

Created with Pixso.

### 下载信息

- **下载该版本**：初始版本

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.2 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.3 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.4 (Created with Pixso.) |
| HarmonyOS 版本 | 5.0.5 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.0 (Created with Pixso.) |
| HarmonyOS 版本 | 5.1.1 (Created with Pixso.) |
| HarmonyOS 版本 | 6.0.0 (Created with Pixso.) |
| 应用类型 | 应用 (Created with Pixso.) |
| 元服务 | 元服务 (Created with Pixso.) |
| 设备类型 | 手机 (Created with Pixso.) |
| 设备类型 | 平板 (Created with Pixso.) |
| 设备类型 | PC (Created with Pixso.) |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.0.4 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.0.5 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.1.0 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 5.1.1 (Created with Pixso.) |
| DevEco Studio 版本 | DevEco Studio 6.0.0 (Created with Pixso.) |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/31f22335804a4cd5a6290a7ecec90699/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%9C%97%E8%AF%BB%E7%BB%84%E4%BB%B6/module_text_reader1.0.0.zip