# hadss/turbo-trans-json 通信数据处理组件

## 简介

高性能 JSON 序列化解决方案，支持复杂类型、大文件解析、JsonNode 懒加载，帮助开发者快速实现高效的数据转换。

## 详细介绍

TurboTransJSON 为高性能序列化解决方案的 JSON 实现，为开发者提供了功能完备、性能高效的 JSON 序列化框架。

### 特性

- 支持简单类型序列化
- 支持数组、Map、Set 序列化
- 支持嵌套类型、泛型、多态、联合类型
- 支持通过装饰器覆盖类和属性名称、将某个属性设为必须验证、忽略某个属性
- 支持 Sendable
- 支持状态变量 V2
- 支持自定义序列化器
- 支持大文件解析
- 支持 JsonNode 懒加载

### 依赖系统版本

- **SDK**: API 12 Release 及以上

## 快速开始

### 1. 安装依赖

使用 ohpm 安装：

```bash
ohpm install @hadss/turbo-trans-core
ohpm install @hadss/turbo-trans-json
```

### 2. 配置编译插件

#### 依赖配置

修改工程根目录下的 `hvigor/hvigor-config.json` 文件，加入序列化编译插件：

```json
{
  "modelVersion": "6.0.0",
  "dependencies": {
    "@hadss/turbo-trans-json-plugin": "latest"
    // 使用 npm 仓版本号
  }
  // ...其余配置
}
```

#### 插件配置

修改工程根目录下的 `hvigorfile.ts`，使用序列化编译插件：

```typescript
// 工程根目录/hvigorfile.ts
import { hvigor } from "@ohos/hvigor";
import { appTasks } from '@ohos/hvigor-ohos-plugin';
import { turboTransJsonPlugin } from "@hadss/turbo-trans-json-plugin";

export default {
  system: appTasks,
  plugins: [
    turboTransJsonPlugin(hvigor, {
      ignoreModuleNames: [/** 不需要扫描的模块名，如：'SomeLibModule' */],
      scanDir: ['src/main/ets'],
      deserializationMode: 'performance', // 反序列化模式，可选值：'performance' | 'strict'
    }),
  ]
}
```

#### 同步模块配置

配置插件后，建议执行同步任务以确保模块配置正确：

```bash
hvigorw jsonSync
```

该命令会扫描项目中使用 `@Serializable` 注解的模块，自动配置 `build-profile.json5` 文件并生成序列化器代码。

### 3. 标记序列化类

为需要序列化的类添加 `@Serializable` 装饰器：

```typescript
import { Serializable } from '@hadss/turbo-trans-core';

@Serializable()
export class Person {
  public gender: boolean;
  public age: number;
  public name: string;

  constructor(gender: boolean, age: number, name: string) {
    this.gender = gender;
    this.age = age;
    this.name = name;
  }
}
```

### 4. 使用 TJSON 进行序列化操作

框架提供 TJSON 默认实例实现序列化功能：

```typescript
import { TJSON } from '@hadss/turbo-trans-json';

class UserSerialization {
  toString(): string {
    const person = new Person(true, 28, 'Member 1');
    const personStr = TJSON.toString(person, Person);
    return personStr;
  }
}
```

也可以创建 TJSON 对象实现序列化功能：

```typescript
import { ITJSON, json } from '@hadss/turbo-trans-json';

class UserSerialization {
  toString(): string {
    const person = new Person(true, 28, 'Member 1');
    const myJSON: ITJSON = json();
    const personStr = myJSON.toString(person, Person);
    return personStr;
  }
}
```

### 5. 使用 TJSON 进行反序列化操作

框架提供 TJSON 默认实例实现反序列化功能：

```typescript
import { TJSON } from '@hadss/turbo-trans-json';

class UserSerialization {
  fromString(): Person {
    const personStr = `{"gender":true,"age":30,"name":"jim"}`;
    const person = TJSON.fromString<Person>(personStr, Person);
    return person;
  }
}
```

也可以创建 TJSON 对象实现反序列化功能：

```typescript
import { ITJSON, json } from '@hadss/turbo-trans-json';

class UserSerialization {
  fromString(): Person {
    const personStr = `{"gender":true,"age":30,"name":"jim"}`;
    const myJSON: ITJSON = json();
    const person = myJSON.fromString<Person>(personStr, Person);
    return person;
  }
}
```

### 6. 使用装饰器进行配置

#### @SerialName 自定义字段名

当 JSON 字段名与属性名不一致时使用：

```typescript
@Serializable()
export class Person {
  public gender: boolean;
  @SerialName({ name: 'user_age' })
  public age: number;
  @SerialName({ name: 'user_name' })
  public name: string;
}
```

使用该装饰器后，序列化时，JSON 字符串中 `'user_age'` 的值会转换成 `age` 属性的值；反序列化时，`age` 的属性会转成 JSON 字符串中 `'user_age'` 属性。

#### @Required 必须验证的字段

使用 `@Required` 装饰器之后，在反序列化时会检验该属性是否存在，不存在时会抛出异常，即使该属性存在默认值：

```typescript
@Serializable()
export class Person {
  public gender: boolean;
  @Required()
  public age: number = 18;
  @Required()
  public name: string;
}
```

#### @Transient 排除字段

使用 `@Transient` 装饰器之后，不会对该属性进行序列化和反序列化，该装饰器要求对应的属性必须要有默认值：

```typescript
@Serializable()
export class Person {
  public gender: boolean;
  public age: number;
  public name: string;
  @Transient()
  public password: string = '';
}
```

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 1.0.0-rc.2 (2026.01.15)

**Bug Fixes**

- 修复类型自引用导致的运行时栈溢出崩溃问题

### 1.0.0-rc.1 (2025.11.21)

**Features**

- 支持类中的私有成员参与序列化
- 支持解析 JSON5 格式
- 支持解析扩展数字
- 新增 `@PlainValue` 装饰器

### 1.0.0-rc.0 (2025.11.14)

**Initial**

- 初版发布

## 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| **基本信息** | 权限名称：暂无<br>权限说明：暂无<br>使用目的：暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性** | HarmonyOS 版本：5.0.0 |
| **应用类型** | 应用 |
| **元服务** | 是 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @hadss/turbo-trans-json
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/205892744eca42649d47461c9f6b642d/PLATFORM?origin=template