# fast_xml_parser 序列化组件

## 简介

Validate XML, Parse XML to JS Object, or Build XML from JS Object without C/C++ based libraries and no callback.

## 详细介绍

### 简介

Validate XML, Parse XML to JS Object, or Build XML from JS Object without C/C++ based libraries and no callback.

Validate XML data syntactically. Use detailed-xml-validator to verify business rules.
Parse XML to JS Objects and vice versa
Common JS, ESM, and browser compatible
Faster than any other pure JS implementation.

It can handle big files (tested up to 100mb). XML Entities, HTML entities, and DOCTYPE entites are supported. Unpaired tags (Eg <br> in HTML), stop nodes (Eg <script> in HTML) are supported. It can also preserve Order of tags in JS object

### 使用

To use as package dependency $ ohpm i fast_xml_parser
To use it on a webpage include it from a CDN Example
In a node js project
深色代码主题复制

```typescript
import { XMLParser, XMLBuilder } from 'fast_xml_parser'

const parser = new XMLParser()
const json = parser.parse('<?xml version="1.0" encoding="utf-8"?>') as string
console.log("+++++", JSON.stringify(json))
const builder = new XMLBuilder()
const xml = builder.build(json) as string
console.log("+++++", xml)
```

### 包体积

| Bundle Name | Size |
| :--- | :--- |
| fxbuilder.min.js | 6.5K |
| fxparser.min.js | 20K |
| fxp.min.js | 26K |
| fxvalidator.min.js | 5.7K |

### 性能

negative means error

#### XML Parser

Y-axis: requests per second

X-axis: File size

#### XML Builder

Y-axis: requests per second

### 协议

MIT License

### 更新记录

- **5.4.1 / 2026-02-25**
  - fix (#785) unpairedTag node should not have tag content
- **5.4.0 / 2026-02-25**
  - migrate to fast-xml-builder
- **5.3.9 / 2026-02-25**
  - support strictReservedNames
- **5.3.8 / 2026-02-25**
  - support maxNestedTags 
  - handle non-array input for XML builder when preserveOrder is true (By Angelo Coetzee)
  - save use of js properies
- **5.3.7 / 2026-02-20**
  - fix typings for CJS By Corentin Girard
- **5.3.6 / 2026-02-14**
  - Improve security and performance of entity processing
  - new options maxEntitySize, maxExpansionDepth, maxTotalExpansions, maxExpandedLength, allowedTags,tagFilter
  - fast return when no edtity is present
  - improvement replacement logic to reduce number of calls
- **5.3.5 / 2026-02-08**
  - fix: Escape regex char in entity name
  - update strnum to 2.1.2
  - add missing exports in CJS typings
- **5.3.4 / 2026-01-30**
  - fix: handle HTML numeric and hex entities when out of range
- **5.3.3 / 2025-12-12**
  - fix #775: transformTagName with allowBooleanAttributes adds an unnecessary attribute
- **5.3.2 / 2025-11-14**
  - fix for import statement for v6
- **5.3.1 / 2025-11-03**
  - Performance improvement for stopNodes (By Maciek Lamberski)
- **5.3.0 / 2025-10-03**
  - Use Uint8Array in place of Buffer in Parser
- **5.2.5 / 2025-06-08**
  - Inform user to use fxp-cli instead of in-built CLI feature
  - Export typings for direct use
- **5.2.4 / 2025-06-06**
  - fix (#747): fix EMPTY and ANY with ELEMENT in DOCTYPE
- **5.2.3 / 2025-05-11**
  - fix (#747): support EMPTY and ANY with ELEMENT in DOCTYPE
- **5.2.2 / 2025-05-05**
  - fix (#746): update strnum to fix parsing issues related to enotations
- **5.2.1 / 2025-04-22**
  - fix: read DOCTYPE entity value correctly
  - read DOCTYPE NOTATION, ELEMENT exp but not using read values
- **5.2.0 / 2025-04-03**
  - feat: support metadata on nodes (#593) (By Steven R. Loomis)

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 基本信息 | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本：5.0.0 |
| 应用类型 | 应用 |
| 元服务 | |
| 设备类型 | 手机 |
| 平板 | |
| PC | |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._
_Created with Pixso._

## 安装方式

```bash
ohpm install fast_xml_parser
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b38d61c774fe46fa99b486267b173f8e/PLATFORM?origin=template