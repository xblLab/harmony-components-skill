# fast xml parser 构建验证 XML 组件

## 简介

验证 XML、将 XML 解析为 JS 对象，或从 JS 对象构建 XML，无需基于 C/C++ 的库，也无需回调函数。

## 详细介绍

### 简介

验证 XML、将 XML 解析为 JS 对象，或从 JS 对象构建 XML，无需基于 C/C++ 的库，也无需回调函数。

### 使用

#### 作为 CLI 命令

深色代码主题复制

```bash
$ fxparser some.xml
```

#### 在一个 Node.js 项目中

深色代码主题复制

```javascript
const { XMLParser, XMLBuilder, XMLValidator} = require("fast-xml-parser");

const parser = new XMLParser();
let jObj = parser.parse(XMLdata);

const builder = new XMLBuilder();
const xmlContent = builder.build(jObj);
```

#### 在 HTML 页面中

深色代码主题复制

```html
<script src="path/to/fxp.min.js"></script>
<script>
  const parser = new fxparser.XMLParser();
  parser.parse(xmlContent);
</script>
```

### 捆绑包大小

| Bundle Name | Size |
| :--- | :--- |
| fxbuilder.min.js | 6.5K |
| fxparser.min.js | 20K |
| fxp.min.js | 26K |
| fxvalidator.min.js | 5.7K |

### 更新记录

**5.4.1 / 2026-02-25**

- fix (#785) unpairedTag node should not have tag content

**5.4.0 / 2026-02-25**

- migrate to fast-xml-builder

**5.3.9**
**5.3.9 / 2026-02-25**

- support strictReservedNames

**5.3.8**
**5.3.8 / 2026-02-25**

- support maxNestedTags 
- handle non-array input for XML builder when preserveOrder is true (By Angelo Coetzee)
- save use of js properies

**5.3.7 / 2026-02-20**

- fix typings for CJS

**5.3.6 / 2026-02-14**

- Improve security and performance of entity processing
- new options maxEntitySize, maxExpansionDepth, maxTotalExpansions, maxExpandedLength, allowedTags,tagFilter
- fast return when no edtity is present
- improvement replacement logic to reduce number of calls

**5.3.5 / 2026-02-08**

- fix: Escape regex char in entity name
- update strnum to 2.1.2
- add missing exports in CJS typings

**5.3.4 / 2026-01-30**

- fix: handle HTML numeric and hex entities when out of range

**5.3.3 / 2025-12-12**

- fix #775: transformTagName with allowBooleanAttributes adds an unnecessary attribute

**5.3.2 / 2025-11-14**

- fix for import statement for v6

**5.3.1 / 2025-11-03**

- Performance improvement for stopNodes (By Maciek Lamberski)

**5.3.0 / 2025-10-03**

- Use Uint8Array in place of Buffer in Parser

**5.2.5 / 2025-06-08**

- Inform user to use fxp-cli instead of in-built CLI feature
- Export typings  for direct use

**5.2.4 / 2025-06-06**

- fix (#747): fix EMPTY and ANY with ELEMENT in DOCTYPE

**5.2.3 / 2025-05-11**

- fix (#747): support EMPTY and ANY with ELEMENT in DOCTYPE

**5.2.2 / 2025-05-05**

- fix (#746): update strnum to fix parsing issues related to enotations

**5.2.1 / 2025-04-22**

- fix: read DOCTYPE entity value correctly
- read DOCTYPE NOTATION, ELEMENT exp but not using read values

**5.2.0 / 2025-04-03**

- feat: support metadata on nodes (#593) (By Steven R. Loomis)

**5.1.0 / 2025-04-02**

- feat: declare package as side-effect free (#738) (By Thomas Bouffard) - fix cjs build mode - fix builder return type to string

**5.0.9 / 2025-03-14**

- fix: support numeric entities with values over 0xFFFF (#726) (By Marc Durdin)
- fix: update strnum to fix parsing 0 if skiplike option is used

**5.0.8 / 2025-02-27**

- fix parsing 0 if skiplike option is used.
- updating strnum dependency

**5.0.7 / 2025-02-25**

- fix (#724) typings for cjs.

**5.0.6 / 2025-02-20**

- fix cli output (By Angel Delgado)
- remove multiple JSON parsing

**5.0.5 / 2025-02-20**

- fix parsing of string starting with 'e' or 'E' by updating strnum

**5.0.4 / 2025-02-20**

- fix CLI to support all the versions of node js when displaying library version.
- fix CJS import in v5
- by fixing webpack config

**5.0.3 / 2025-02-20**

- Using strnum ESM module
- new fixes in strum may break your experience

**5.0.2 / 2025-02-20**

- fix: include CommonJS resources in the npm package #714 (By Thomas Bouffard)
- fix: move babel deps to dev deps

**5.0.1 / 2025-02-19**

- fix syntax error for CLI command

**5.0.0 / 2025-02-19**

- ESM support
- no change in the functionality, syntax, APIs, options, or documentation.

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 基本信息 | 权限名称 权限说明 使用目的 暂无暂无暂无 |
| 隐私政策 | 不涉及 SDK 合规使用指南 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 <br> Created with Pixso. |
| 元服务 | <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| 平板 | <br> Created with Pixso. |
| PC | <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 <br> Created with Pixso. |

## 安装方式

```bash
ohpm install @ifbear/fast-xml-parser
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/32c7b0ab39ad42d19e689534aadaafa4/PLATFORM?origin=template