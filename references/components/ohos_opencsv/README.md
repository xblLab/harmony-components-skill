# ohos/opencsv 文件解析组件

## 简介

文件是一个字符序列，可以由任意数目的记录组成，记录间以某种换行符分割。

## 详细介绍

### 简介

CSV 文件：Comma-Separated Values，中文叫逗号分隔值或者字符分割值，其文件以纯文本的形式存储表格数据。该文件是一个字符序列，可以由任意数目的记录组成，记录间以某种换行符分割。每条记录由字段组成，字段间的分隔符是其它字符或者字符串。所有的记录都有完全相同的字段序列，相当于一个结构化表的纯文本形式。

用文本文件、excel 或者类似与文本文件的编辑器都可以打开 CSV 文件。

### 下载安装

```bash
ohpm install @ohos/opencsv
```

### 使用说明

#### 写入数据

```typescript
import { getPath, openSync,CSVWriter } from '@ohos/opencsv';
getPath().then((path) => {
  let fd = openSync(path,'test.csv'/* csv 文件名 */,0o2 | 0o100, 0o666);
  let writer = new CSVWriter(fd);
  writer.writeNext([1,'张三',18], true); // 写入数据
  writer.writeNext([2,'李四',19], true);
  writer.writeNext([3,'王五',20], true);
  writer.writeNext([4,'赵六',21], true);
  writer.close(); // 写入关闭
})
```

#### 读取数据

```typescript
import { getPath, openSync,CSVReaderBuilder,CSVParser } from '@ohos/opencsv';
getPath().then((path) => {
   let rd = openSync(path, 'test.csv'/* csv 文件名 */, 0o2)
   let readerBuilder: CSVReaderBuilder = new CSVReaderBuilder(rd)
   let readerbuildcsv = readerBuilder
         .withCSVParser(new CSVParser())
         .buildCSVReader()
   let lines: Array<Array<string>> = null;
   lines = readerbuildcsv.readAll() // 读取 csv 文件中所有数据
   console.log(lines)
   /* [
    *  [1,'张三',18]
    *  [2,'李四',19]
    *  [3,'王五',20]
    *  [4,'赵六',21]
    *               ]
    */
   readerbuildcsv.close() //读取关闭
})
```

#### 指定编码读取数据

指定编码读取数据，包含的编码格式详见。

```typescript
import { getPath, openSync,CSVReaderBuilder,CSVParser } from '@ohos/opencsv';
getPath().then((path) => {
   let rd = openSync(path, 'test.csv'/* csv 文件名 */, 0o2)
   let readerBuilder: CSVReaderBuilder = new CSVReaderBuilder(rd, "gbk")
   let readerbuildcsv = readerBuilder
         .withCSVParser(new CSVParser())
         .buildCSVReader()
   let lines: Array<Array<string>> = null;
   lines = readerbuildcsv.readAll() // 读取 csv 文件中所有数据
   console.log(lines)
   /* [
    *  [1,'张三',18]
    *  [2,'李四',19]
    *  [3,'王五',20]
    *  [4,'赵六',21]
    *               ]
    */
   readerbuildcsv.close() //读取关闭
})
```

### 接口说明

#### 1. 写入一条数据

```typescript
async writeNext(nextLine: Array<string>, appleQuotesToAll: boolean): Promise<void>;
```

| 参数名 | 类型 | 必填 | 说明 | 返回值 |
| :--- | :--- | :--- | :--- | :--- |
| nextLine | Array<string> | 是 | 写入一条数据 | 无 |

#### 2. 写入多条数据

```typescript
writeAll(allLines: Array<Array<string>>, appleQuotesToAll: boolean): void;
```

| 参数名 | 类型 | 必填 | 说明 | 返回值 |
| :--- | :--- | :--- | :--- | :--- |
| allLines | Array<Array<string>> | 是 | 写入多条数据 | 无 |

#### 3. 读取下一条数据

```typescript
readNext(): Array<string>
```

| 参数名 | 类型 | 必填 | 说明 | 返回值 |
| :--- | :--- | :--- | :--- | :--- |
| 无 | 无 | 否 | 读取下一条数据 | Array<string> |

#### 4. 读取所有数据

```typescript
readAll(): Array<Array<string>>
```

| 参数名 | 类型 | 必填 | 说明 | 返回值 |
| :--- | :--- | :--- | :--- | :--- |
| 无 | 无 | 否 | 读取多条数据 | Array<Array<string>> |

### 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 OpenCSV 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/opencsv
```

### 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66)
- DevEco Studio (4.1.1.500) --SDK:API11 (4.1.7.3)

### 目录结构

```text
|---- opencsv 
|     |---- entry  # 示例代码文件夹
|     |---- library  # opencsv 库文件夹
|           |---- Index.ets  # 对外接口
|     |---- README.md  # 安装使用方法                     
```

### 开源协议

Apache License 2.0

### 更新记录

#### 2.0.3

- Fix the issue in README where OpenCSV provides incorrect methods for reading data.
- Add sample demo.

#### 2.0.3-rc.0

- Supports reading CSV files with a specified encoding format.
- Fix the problem that the api version needs to be greater than 14.

#### 2.0.2

- Release the official version.
- Need Api Version 14 higher.

#### 2.0.2-rc.0

- fix: Parsing CSV, fields with line breaks cannot be parsed correctly.
- Fix the compile errors in the library module that occurred after upgrading the SDK version.
- Need Api Version 14 higher.

#### 2.0.1

- refactor: replace export * with named exports.

#### 2.0.0

- 修复 writeNext 方法缺少 async 修饰符的问题，以确保正确处理异步操作。

#### 2.0.0-rc.0

- 包管理工具由 npm 切换为 ohpm
- 读取和写入 CSV 文件
- 支持数据绑定 ,数据校验
- 支持自定义分隔符
- 支持数据导入导出

### 权限与隐私及兼容性

| 项目 | 详情 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性 - HarmonyOS 版本** | 5.0.2 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.2 |

## 安装方式

```bash
ohpm install @ohos/opencsv
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d8e120bf4724447a962a2ccc862da840/PLATFORM?origin=template