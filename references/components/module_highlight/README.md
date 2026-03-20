# 高亮组件

## 简介

本组件支持根据关键词实现文本高亮。

## 详细介绍

### 简介

本组件支持根据关键词实现文本高亮。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.1(13) 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_highlight` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_highlight 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_highlight",
    "srcPath": "./XXX/module_highlight"
  }
]
```

c. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_highlight": "file:./XXX/module_highlight"
}
```

#### 引入组件

```typescript
import { Highlight } from 'module_highlight';
```

### API 参考

#### 接口

`Highlight(option: HighlightOptions)`

文本高亮组件的参数

#### 文本高亮组件的参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | HighlightOptions | 否 | 配置文本高亮组件的参数。 |

**HighlightOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| keywords | string[] | 否 | 高亮关键字 |
| sourceString | string | 否 | 源文本 |
| textColor | ResourceColor | 否 | 文字颜色，默认 sys.color.font_primary |
| highLightColor | ResourceColor | 否 | 高亮文字颜色，默认 sys.color.font_primary |
| textFontSize | string \| number | 否 | 文字大小 |
| textFontWeight | FontWeight | 否 | 高亮文本 weight |
| highLightFontSize | string \| number | 否 | 高亮文字大小 |
| maxLines | number | 否 | 最大行数 |
| overflowText | Overflow | 否 | 超出隐藏 |

### 示例代码

```typescript
import { Highlight } from 'module_highlight'

@Entry
@ComponentV2
export struct Index {
  build() {
    Column() {
      Highlight({
        keywords: ['旅行'],
        sourceString: '假期的旅行碎片已加载完毕～。旅行哪里是逃离呀，分明是让你在人山人海里，重新找到自己的位置',
        highLightColor: '#E84026',
        textColor: $r('sys.color.font_primary'),
      })
    }
  }
}
```

### 更新记录

- **1.0.0** (2025-08-30)
  - 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 基本信息

| 兼容性 | HarmonyOS 版本 |
| :--- | :--- |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |

| 应用类型 | 应用 |
| :--- | :--- |
| 元服务 | |

| 设备类型 | 手机 |
| :--- | :--- |
| 平板 | |
| PC | |

| DevEco Studio 版本 | DevEco Studio 5.0.3 |
| :--- | :--- |
| DevEco Studio 5.0.4 | |
| DevEco Studio 5.0.5 | |
| DevEco Studio 5.1.0 | |
| DevEco Studio 5.1.1 | |
| DevEco Studio 6.0.0 | |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1d9b317b90504ecaa7add3adf1c3f32a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%AB%98%E4%BA%AE%E7%BB%84%E4%BB%B6/module_highlight1.0.0.zip