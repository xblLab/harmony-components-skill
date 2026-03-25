# multitype 列表布局组件

## 简介

更轻松、更灵活地为 List 创建多种类型布局，支持设置布局数据源与布局样式。

## 详细介绍

### 简介

更轻松、更灵活地为 List 创建多种类型布局。

### 效果展示

（此处预留效果展示区域）

### 下载安装

```bash
ohpm install @ohos/multitype
```

### 使用说明

#### MultiType 引用及使用

```typescript
import {MultiTypeAdapter} from '@ohos/multitype'

class itemsType {
  itemType: number = 0
  id: number = 0
}

//自定义 item 内容
@Builder MyListItem(arr: itemsType[], index: number) {
  Column() {
    Text('title: ' + arr[index].id).fontSize(16).padding({ left: 15, right: 15, top: 15 })
  }.width('100%').alignItems((arr[index].itemType == 1) ? HorizontalAlign.Start : HorizontalAlign.End)
}

//页面中使用
build() {
  Column() {
    ...
    MultiTypeAdapter({
      array: this.items,
      child: (arr: itemsType[], index: number) => {
        this.MyListItem(arr, index)
      }
    })
  }.height('94%').width('100%')
}
```

### 接口说明

**MultiTypeAdapter({})**

- 参数 1：array List 的数据源
- 参数 2：child Item 的样式

### 约束与限制

在下述版本验证通过：

- DevEco Studio 版本：4.1 Canary(4.1.3.317)
- OpenHarmony SDK: API11 (4.1.0.36)

### 目录结构

```text
|---- MultiType
|     |---- entry  # 示例代码文件夹
|     |---- library  # multiType 库文件夹
|	    |----src
         |----main
             |----ets
                 |----components/MainPage
                     |----MultiTypeAdapter.ets #核心封装逻辑
|       |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法       
|     |---- README_zh.md  # 安装使用方法               
```

### 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 MultiType 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/multitype
```

## 更新记录

- **2.0.5**
  - Release version 2.0.5
- **2.0.5-rc.0**
  - Attributes support dynamic changes
- **2.0.4**
  - Modify compile build warning prompt
  - Support dynamic data
- **2.0.4-rc.0**
  - Code obfuscation
- **2.0.3**
  - Chore: Added supported device types
- **2.0.2**
  - 适配 DevEco Studio 版本：4.1 Canary(4.1.3.317)，OpenHarmony SDK:API11 (4.1.0.36)
  - ArkTS 语法适配
- **v2.0.1**
  - 完善 3.1 Beta2（3.1.0.400）的适配
- **v2.0.0**
  - 包管理工具由 npm 切换为 ohpm
  - 适配 DevEco Studio 版本：3.1 Beta2（3.1.0.400），OpenHarmony SDK:API9（3.2.11.9）
- **v1.0.6**
  - 适配 DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）
- **v1.0.5**
  - 新增一些可自定义的对外属性
- **v1.0.3**
  - api8 升级到 api9
- **v1.0.0**
  - 详细功能：
    1. 自定义 List 容器实现 ListItem 多类型布局
  - 不支持功能：
    1. List 适配器功能
    2. 注册 ViewHolder
  - 由于 ets 中 List 渲染机制及方式不同故无法实现

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1 |
| **应用类型** | 应用 |
| **元服务** | 是 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | 5.0.1 |

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 安装方式

```bash
ohpm install @ohos/multitype
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/45655a68d2314ddaa1677293b42c54d4/PLATFORM?origin=template