# mathml-tag-names 数学公式组件

## 简介

List of known MathML tag names

## 详细介绍

基于 mathml-tag-names - npm 原库 3.0.2 版本进行适配，所有功能代码已经转换为 ArkTS 文件。

### 安装 (Install)

```bash
ohpm install mathml-tag-names
```

### 目录 (Contents)

- What is this?
- When should I use this?
- Use
- API
- mathmlTagNames
- License

### 这是什么？(What is this?)

This is a list of MathML tag names.
It includes all tag names from [MathML 1][mathml1], [MathML 2][mathml2], and
[MathML 3][mathml3].
The repo is includes scripts to regenerate the data from the specs.

### 何时使用 (When should I use this?)

### 使用方法 (Use)

```typescript
import {mathmlTagNames} from 'mathml-tag-names'

console.log(mathmlTagNames.length) // => 189

console.log(mathmlTagNames.slice(0, 10))
```

Yields:

```javascript
[
  'abs',
  'and',
  'annotation',
  'annotation-xml',
  'apply',
  'approx',
  'arccos',
  'arccosh',
  'arccot',
  'arccoth'
]
```

### API

This package exports the following identifiers: mathmlTagNames.
There is no default export.

#### mathmlTagNames

List of known (lowercase) MathML tag names (Array<string>).

### 许可证 (License)

MIT

### 更新记录

- **[v1.0.0]** 2024.10
  - 基于 mathml-tag-names 原库 3.0.2 版本进行适配
- **[v1.1.0]** 2024.11
  - 更新 homepage 和 repository 的链接

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | - |
| SDK 合规使用指南 | 不涉及 | - |

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install mathml-tag-names
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3c29fc1b5a784379af400493649e6b91/PLATFORM?origin=template