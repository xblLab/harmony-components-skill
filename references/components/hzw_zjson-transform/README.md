# zjson transform 字符串处理组件

## 简介

ZJsonUtil 是一款专为 JSON 和对象之间的转换设计的工具类，旨在将 JSON 或普通对象转换为具体类型的类实例。

## 详细介绍

### 概述
ZJsonUtil 是一款专为 JSON 和对象之间的转换设计的工具类，旨在将 JSON 或普通对象转换为具体类型的类实例。它具备以下特点：

- **兼容性**：支持被 `@Observed` 和 `@ObservedV2` 修饰的类对象。
- **深拷贝**：在转换过程中确保对象的深拷贝，避免引用问题。
- **自定义实现**：最初依赖于 `reflect-metadata` 和 `class-transformer` 库来处理元数据和对象转换，现在自己实现，不依赖第三方库。

### 主要功能
- **JSON 转换**：将 JSON 字符串转换为指定类型的类实例。
- **对象转换**：将普通 Object 对象转换为指定类型的类实例。
- **嵌套对象支持**：能够处理复杂的嵌套对象结构，确保所有层级都能正确转换。
- **类型安全**：通过系统提供类型检查，确保转换结果的准确性。

### 使用场景
适用于需要频繁进行 JSON 和对象转换的项目，特别是在需要处理复杂对象结构和确保类型安全的场景中。

### 支持字段映射
（详见下方注解说明）

## 下载安装

在每个 har/hsp 模块中，通过 ohpm 工具下载安装库：

```bash
ohpm install @hzw/zjson-transform
```

## 注解说明

### `@Type()`

- **功能**：指定嵌套对象的类型元数据
- **参数**：转换目标类
- **示例**：`@Type(() => Father)` 指定 father 字段使用 Father 类进行转换

### `@FieldMapping()`

- **功能**：字段映射配置
- **参数**：
  - `targetFieldName`：目标字段名
  - `mapFields`：源字段名列表（支持多字段映射）
- **示例**：`@FieldMapping({ targetFieldName: 'mother', mapFields: ['mon'] })`
  - 将 mon 字段映射到 mother 字段

## 使用方法

### 实体定义

#### 普通类

```typescript
export class Father {
  id?: number
  name?: string
}

export class Mother {
  id?: number
  name?: string
}

export class Son {
  id?: number
  name?: string
  age?: number
  @Type(() => Father)
  father?: Father | undefined
  @Type(() => Mother)
  @FieldMapping({ targetFieldName: 'mother', mapFields: ['mon'] })
  mother?: Father | undefined
  @FieldMapping({ targetFieldName: 'showTxt', mapFields: ['txt1', 'txt2'] })
  showTxt?: string | undefined
}
```

#### V1 类

```typescript
export class FatherV1 {
  id?: number
  name?: string
}

export class MotherV1 {
  id?: number
  name?: string
}

export class SonV1 {
  id?: number
  name?: string
  age?: number
  @Type(() => FatherV1)
  father?: FatherV1 | undefined
  @Type(() => MotherV1)
  @FieldMapping({ targetFieldName: 'mother', mapFields: ['mon'] })
  mother?: FatherV1 | undefined
  @FieldMapping({ targetFieldName: 'showTxt', mapFields: ['txt1', 'txt2'] })
  showTxt?: string | undefined
}
```

#### V2 类

```typescript
@ObservedV2
export class FatherV2 {
  @Trace id?: number
  @Trace name?: string
}

@ObservedV2
export class MotherV2 {
  @Trace id?: number
  @Trace name?: string
}

@ObservedV2
export class SonV2 {
  @Trace id?: number
  @Trace name?: string
  @Trace age?: number
  @Type(() => FatherV2)
  @Trace father?: FatherV2 | undefined
  @Type(() => MotherV2)
  @FieldMapping({ targetFieldName: 'mother', mapFields: ['mon'] })
  @Trace mother?: MotherV2 | undefined
  @FieldMapping({ targetFieldName: 'showTxt', mapFields: ['txt1', 'txt2'] })
  @Trace showTxt?: string | undefined
}
```

### 转换

#### JSON 字符串 转 具体类型的对象

```typescript
const jsonStr = '{"id":1,"name":"儿子","txt1":"txt1","father":{"id":1,"name":"父亲"},"mon":{"id":1,"name":"母亲"}}'
const sonBeanVVV = ZJsonUtil.toBean(Son, jsonStr)
const sonBeanVV1 = ZJsonUtil.toBean(SonV1, jsonStr)
const sonBeanVV2 = ZJsonUtil.toBean(SonV2, jsonStr)
```

#### Object 对象 转 具体类型的对象

```typescript
const father: Father = {
  id: 1,
  name: '父亲',
}
const son: Son = {
  id: 1,
  name: '儿子',
  father: father,
}
const sonBean2 = ZJsonUtil.toBean(Son, son)
```

#### JSON 字符串 转 Object 对象

```typescript
const sonObject = ZJsonUtil.toObject(jsonStr)
```

#### 任意对象 转 JSON 字符串

```typescript
const sonJson = ZJsonUtil.toJson(son)

// @ObservedV2 注解的对象（V2 状态）转 json 字符串
// 先拿到 V2 的对象
const sonBeanV2 = ZJsonUtil.toBean(SonV2, son)

// 拿到的字段键值包含__ob_
const sonObjectV2_1 = ZJsonUtil.toJson(sonBeanV2)
// 输出如下：{"__ob_id":1,"__ob_name":"儿子","__ob_father":{"__ob_id":1,"__ob_name":"父亲"}}

// 拿到的字段键值包含不包含
const sonObjectV2_2 = ZJsonUtil.toJsonCompat(sonBeanV2)
// 输出如下：{"id":1,"name":"儿子","father":{"id":1,"name":"父亲"}}
```

#### JSON 字符串转 Object 对象数组

```typescript
const jsonListErr = 'xxx'
const jsonList =
  '[{"id":1,"name":"儿子","father":{"id":1,"name":"父亲"},"mon":{"id":1,"name":"母亲"},"txt1":"txt1"},{"id":2,"name":"女儿","father":{"id":1,"name":"父亲"}}]'
const objectUndefined = ZJsonUtil.toObjectList(jsonListErr) // undefined
const objectList = ZJsonUtil.toObjectList(jsonList)
```

#### JSON 字符串转具体类型对象数组

```typescript
const beanUndefined = ZJsonUtil.toBeanList(Son, jsonListErr) // undefined
const beanList = ZJsonUtil.toBeanList(Son, jsonList)
```

#### Object 数组对象转具体类型对象数组

```typescript
const father2: Father = {
  id: 1,
  name: '父亲',
}
const sonListErr: Son = {}
const sonList: Son[] = [
  {
    id: 1,
    name: '儿子',
    father: father2,
  },
  {
    id: 2,
    name: '女儿',
    father: father2,
  },
]
const bean2Undefined = ZJsonUtil.toBeanList(Son, sonListErr) // undefined
const bean2List = ZJsonUtil.toBeanList(Son, sonList)
```

## 属性/接口说明

### ZJsonUtil 核心方法

#### `toBean(targetClass: new () => T, source: any): T`

- **功能**：将 JSON 或普通对象转换为指定类型的类实例
- **参数**：
  - `targetClass`：目标类类型
  - `source`：源数据（可以是 JSON 字符串或 Object）
- **返回**：完全深拷贝的类实例
- **示例**：`const sonBean = ZJsonUtil.toBean(Son, jsonStr)`

#### `toObject(source: any): any`

- **功能**：将 JSON 字符串转换为普通 Object 对象
- **参数**：JSON 字符串
- **返回**：解析后的 JavaScript 对象

#### `toJson(source: any): string`

- **功能**：将任意对象转换为 JSON 字符串
- **注意**：处理 `@ObservedV2` 对象时会保留 `__ob_` 前缀字段

#### `toJsonCompat(source: any): string`

- **功能**：生成兼容性 JSON 字符串（自动过滤 `@ObservedV2` 的特殊字段）
- **示例**：`ZJsonUtil.toJsonCompat(sonBeanV2)`

#### `toBeanList(targetClass: new () => T, source: any): T[] | undefined`

- **功能**：转换对象数组
- **参数**：
  - `targetClass`：目标类类型
  - `source`：源数据（JSON 数组字符串或 Object 数组）
- **返回**：完全深拷贝的类实例数组

#### `toObjectList(source: any): any[] | undefined`

- **功能**：将 JSON 数组字符串转换为普通 Object 数组
- **参数**：JSON 数组字符串
- **返回**：解析后的 Object 对象数组

## 更新记录

### [v1.0.8] 2026.2
- **修复**
  - 修复 V2 对象存在 `@Computed` 和 `@Monitor` 时转换异常问题

### [v1.0.7] 2025.11
- **修复**
  - 对象字符串数组字段转换问题

### [v1.0.6] 2025.8
- **新增**
  - 兼容 5.0.0(12)

### [v1.0.5] 2025.8
- **新增**
  - `toBean(cls, data)` 中的可以省略

### [v1.0.4] 2025.8
- **新增**
  - 新增转换方法
  - 优化部分元数据存储方式

### [v1.0.3] 2025.04
- **优化**
  - 重构元数据存储方式

### [v1.0.2] 2025.04
- **新增**
  - 新增字段映射

### [v1.0.1] 2025.02
- **新增**
  - 新增转对象数组方法

## 兼容性/权限信息

| 项目 | 详情 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @hzw/zjson-transform
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/88c162390c294e1497294698e92e62c9/PLATFORM?origin=template