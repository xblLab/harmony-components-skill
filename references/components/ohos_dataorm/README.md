# dataorm 数据库组件

## 简介

dataORM 是一个轻量级 ORM（对象关系映射）库，用于简化本地数据库的操作。提供了高效的数据库访问性能和低内存消耗。dataORM 支持多线程操作、链式调用、备份、升级、缓存等特性等功能。其设计理念是轻量、快速且易于使用，帮助开发者快速构建高性能的应用程序。

## 详细介绍

### 简介

dataORM 是一个轻量级 ORM（对象关系映射）库，用于简化本地数据库的操作，提供了高效的数据库访问性能和低内存消耗。dataORM 支持多线程操作、链式调用、备份、升级、缓存等特性等功能。其设计理念是轻量、快速且易于使用，帮助开发者快速构建高性能的应用程序。

### 下载安装

深色代码主题复制

```bash
ohpm install @ohos/dataorm
```

### 使用说明

#### 创建实体类，如 Note：

深色代码主题复制

```typescript
import { Id } from '@ohos/dataorm';
import { NotNull } from '@ohos/dataorm';
import { Entity, Columns } from '@ohos/dataorm';
import { Unique } from '@ohos/dataorm';
import { Index } from '@ohos/dataorm';
import { ToMany } from '@ohos/dataorm';
import { ColumnType } from '@ohos/dataorm';
import { ToOne } from '@ohos/dataorm';

@Entity('NOTE')
export class Note {
   @Id()
   @Columns({ columnName: 'ID', types: ColumnType.num })
   id: number;
   @NotNull()
   @Unique()
   @Index(true)
   @Columns({ columnName: 'TEXT', types: ColumnType.str })
   text: string;
   @Columns({ columnName: 'COMMENT', types: ColumnType.str })
   comment: string;
   @Columns({ columnName: 'DATE', types: ColumnType.str })
   date: Date;
   @Columns({ columnName: 'TYPE', types: ColumnType.str })
   type: string;
   @Columns({ columnName: 'MONEYS', types: ColumnType.real })
   moneys: number;

   //todo 类中必须在 constructor 中声明所有非静态变量，用于反射生成列
   constructor(id?: number, text?: string, comment?: string, date?: Date, types?: string, moneys?: number) {
       this.id = id;
       this.text = text;
       this.comment = comment;
       this.date = date;
       this.type = types;
       this.moneys = moneys;
   }

   getMoneys(): number {
       return this.moneys;
   }

   setMoneys(moneys: number) {
       this.moneys = moneys;
   }

   getId(): number {
       return this.id;
   }

   setId(id: number) {
       this.id = id;
   }

   getText(): string {
       return this.text;
   }

   /** Not-null value; ensure this value is available before it is saved to the database. */
   setText(text: string) {
       this.text = text;
   }

   getComment(): string {
       return this.comment;
   }

   setComment(comment: string) {
       this.comment = comment;
   }

   getDate(): Date {
       return this.date;
   }

   setDate(date: Date) {
       this.date = date;
   }

   getType(): string {
       return this.type;
   }

   setType(types: string) {
       this.type = types;
   }
}
```

#### 注解对外开放部分

Column、Entity、Id、NotNull、Unique、Index、ToMany、ToOne、JoinEntity、OrderBy、Convert、Embedded、Transient、Union。

#### 可使用注解使用示例及说明

##### （1）Id 的使用

1. 导入引用

深色代码主题复制

```typescript
import {Id} from '@ohos/dataorm'; 
```

2. 使用方式

A、

深色代码主题复制

```typescript
@Id()
id: number;
```

B、

深色代码主题复制

```typescript
@Id({ isPrimaryKey: true ,autoincrement:false})
id: number;
```

说明：在类属性中使用，定义表主键和键值是否是自增长。A 和 B 的定义方式等同，isPrimaryKey 值为 true（是表主键），autoincrement 值为 false（不为自增长）。

##### （2）Entity 的使用

1. 导入引用

深色代码主题复制

```typescript
import {Entity} from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@Entity('NOTE')
export  class Note {}
```

说明：在类头使用，定义表表名，如该示例定义为表名为 NOTE。

##### （3）Column 的使用

1. 导入引用

深色代码主题复制

```typescript
import {Columns} from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@Columns({ columnName: 'ID', types: ColumnType.num })
text: string;
```

说明：在类属性中使用，定义在表中的列名和列类型。第一个参数为列名，第二个参数为列的数据类型。

##### （4）NotNull 的使用

1. 导入引用

深色代码主题复制

```typescript
import {NotNull} from '@ohos/dataorm';
```

2. 使用方式

A、

深色代码主题复制

```typescript
@NotNull()
text: string;
```

B、

深色代码主题复制

```typescript
@NotNull(true)
text: string;
```

说明：在类属性中使用，定义在表中该列是否可空，当为 true 值时，在表中该列值为非空值。其中 A 和 B 的定义方式等同，该列为非空值。

##### （5）Unique 的使用

1. 导入引用

深色代码主题复制

```typescript
import {Unique} from '@ohos/dataorm';
```

2. 使用方式

A、

深色代码主题复制

```typescript
@Unique()
text: string;
```

B、

深色代码主题复制

```typescript
@Unique(true)
text: string;
```

说明：在类属性中使用，定义在表中该列是否是唯一值，当为 true 值时，在表中该列值为唯一值。其中 A 和 B 的定义方式等同，该列为唯一值。

##### （6）Index 的使用

1. 导入引用

深色代码主题复制

```typescript
import {Index} from '@ohos/dataorm';
```

2. 使用方式

A、

深色代码主题复制

```typescript
@Index()
text: string;
```

B、

深色代码主题复制

```typescript
@Index(true)
text: string;
```

C、

深色代码主题复制

```typescript
@Index(false)
text: string;
```

说明：在类属性中使用，定义创建索引表的列以及是否是唯一，当为 true 值时，为唯一。其中 A 定义为非唯一索引，B 的定义为唯一索引，C 定义为非唯一索引 A 和 C 的定义等同。

##### （7）ToMany 的使用

1. 导入引用

深色代码主题复制

```typescript
import {  ToMany } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@ToMany({ targetClsName: "Student", joinProperty: [{ name: "ID", referencedName: "TID" }] })
@OrderBy("NAME ASC")
students: Array<Student>
```

说明：在类属性中使用，定义了目标关系表 targetClsName，当前要查询的列 name 与外部目标表关联的列名 referencedName，其中的 name 的值是目标 referencedName 的值，返回的是目标的表的对象数组。

调用时方式

深色代码主题复制

```typescript
async queryByToManyFunctionTest() {
 this.daoSession = GlobalContext.getContext().getValue("daoSession") as DaoSession;
 this.studentDao = this.daoSession.getBaseDao(Student);
 var teacherId: string[] = ["1"]
 let data = await this.studentDao.queryToManyListByColumnName("students", teacherId)
 data.forEach(element => {
   console.info("-----tonMany-----" + JSON.stringify(element))
 });
}
```

说明：获取目标表的 Dao，调用 queryToManyListByColumnName(toManyColumnName: string, arr: string[])，传入参数 toManyColumnName 为当前表所创建类的@ToMany 下面的变量名，传入参数 arr 为关联列的查询值。

##### （8）JoinEntity 的使用

1. 导入引用

深色代码主题复制

```typescript
import { JoinEntity } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@JoinEntity({ entityName: 'JoinManyToDateEntity', targetClsName: 'DateEntity',  sourceProperty: 'ID_TO_MANY', targetProperty: 'ID_DATE' })
@OrderBy("ID DESC")
dateEntityList: Array<DateEntity>
```

说明：在类属性中使用，定义了联接表之间的关系，entityName 为链接表的实体类名称，targetClsName 目标表的实体类，sourceProperty 为连接实体中包含源 (当前) 实体 id 的属性的名称，targetProperty 为连接实体中包含目标实体 id 的属性的名称，返回的是目标的表的对象数组。

调用时方式

深色代码主题复制

```typescript
async queryByJoinEntityFunctionTest(){
 this.daoSession = GlobalContext.getContext().getValue("daoSession") as DaoSession;
 this.studentDao = this.daoSession.getBaseDao(DateEntity);
 var teacherId: string[] = ["11"]
 let data = await this.studentDao.queryToManyListByColumnName("dateEntityList", teacherId)
 data.forEach(element => {
   console.info("-----JoinEntity-----" + JSON.stringify(element))
 });
}
```

说明：获取目标表的 Dao，调用 queryToManyListByColumnName(toManyColumnName: string, arr: string[])，传入参数 toManyColumnName 为当前表所创建类的@ToMany 下面的变量名，传入参数 arr 为关联列的查询值。

##### （9）ToOne 的使用

1. 导入引用

深色代码主题复制

```typescript
import { ToOne } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@ToOne({ value: 'TID', targetObj: Teacher })
teacher: Teacher
```

说明：在类属性中使用，定义了当前表 value 为关联的列，targetObj 为关链创建的表的类。

调用时方式

A、

深色代码主题复制

```typescript
async loadDeep() {
  this.daoSession = GlobalContext.getContext().getValue("daoSession") as DaoSession;
  this.studentDao = this.daoSession.getBaseDao(Student);
  let studentId =         1
  let student: Student = await this.studentDao.loadDeep(studentId);
}
```

B、

深色代码主题复制

```typescript
async queryByToOneFunctionTest() {
  this.daoSession = GlobalContext.getContext().getValue("daoSession") as DaoSession;
  this.studentDao = this.daoSession.getBaseDao(Student);
  let columnName = this.studentDao.getPkProperty().columnName
  let entityList = await this.studentDao.queryDeep("WHERE T." + columnName + "=?", ["1"]);
  let entity3: Student = entityList[0];
}
```

说明：获取目标表的 Dao，拼接查询 Sql 作为 queryDeep(where: string, selectionArg: string[]) 的参数去查询。

##### （10）Convert 的使用

1. 导入引用

深色代码主题复制

```typescript
import { Convert } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@Convert({ converter: TypeConvert, columnType: ColumnType.str })
images: ArrayList<string>;
```

说明：在类属性中使用，将对应的属性的集合或者数组，在数据库中存储与取出的操作。
@Convert 其参数说明：
converter：继承 PropertyConverter 实体，实现其抽象方法。
columnType：对应存储到数据库中的类型。

PropertyConverter 方法介绍：

| 接口名 | 功能描述 |
| :--- | :--- |
| convertToEntityProperty(databaseValue: Q): P | 将数据库数据转化成对应的集合或者数组 |
| convertToDatabaseValue(entityProperty: P): Q | 将对象实体中集合或者数组数据转换为数据库存储的类型 |

##### （11）Transient 的使用

1. 导入引用

深色代码主题复制

```typescript
import { Transient } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@Transient()
home: string
```

说明：Transient 注解修饰的属性不会映射到数据库中。

##### （12）Embedded 的使用

1. 导入引用

深色代码主题复制

```typescript
import { Embedded } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@Embedded({ prefix: "f_", targetClass: Father })
father: Father
```

说明：Embedded 注解：数据实体嵌套的功能，其参数说明：
prefix:实体中对应数据库中列名的前缀定义。
targetClass：对应嵌套的实体。

##### （13）Union 的使用

1. 导入引用

深色代码主题复制

```typescript
import { Union } from '@ohos/dataorm';
```

2. 使用方式

深色代码主题复制

```typescript
@NotNull()
@Union()
@Columns({ columnName: "FIRST_NAME", types: ColumnType.str })
firstName: string;
```

## 配置项

### Log 配置

深色代码主题复制

```typescript
let helper: ExampleOpenHelper = new ExampleOpenHelper(this.context, "notes.db");
helper.setLogger(true)
```

### Trace 配置

深色代码主题复制

```typescript
import { DaoTraceSpace } from '@ohos/dataorm'

let helper: ExampleOpenHelper = new ExampleOpenHelper(this.context, "notes.db");
helper.setTrace({
   enabled: true, // 启用 trace
   minLevel: DaoTraceSpace.TraceLevel.INFO,  // 记录的 trace 级别，级别越低，记录越频繁
   types: new Set([DaoTraceSpace.TraceType.CRUD]) // 记录的类型
});
```

## 自动升级

当 Version 版本号大于上一个版本，表字段有变化，则会自动执行数据库升级逻辑，无变化的表结构升级时将被忽略，您可以通过调用 setAutoMigrate(false) 方法来取消自动升级 (默认关闭)。

深色代码主题复制

```typescript
let helper: ExampleOpenHelper = new ExampleOpenHelper(this.context, "notes.db");
await helper.setVersion(newVersion)
await helper.setAutoMigrate(true)
```

## 关于混淆

代码混淆，请查看代码混淆简介。
如果希望 zxing 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

深色代码主题复制

```bash
-keep
./oh_modules/@ohos/datorm
```

## 约束与限制

- DevEco Studio：NEXT Beta1-5.0.3.806，SDK：API12（5.0.0.66）。
- DevEco Studio：4.1 Release（4.1.3.317），SDK：API11（4.1.0.36）。
- DevEco Studio：4.0 Release（4.0.3.513），SDK：API10（4.0.10.10）。
- DevEco Studio：4.0 Release（4.0.3.418），OpenHarmony SDK：（4.0.10.6）。

## 目录结构

深色代码主题复制

```text
|---- dataORM  
|     |---- entry  # 示例代码文件夹
|     |---- library  # dataORM 库文件夹
|               |----annotation # 注解相关
|               |----common # 公用类包
|               |----converter # convert 注解辅助
|               |----database # 数据库相关
|               |----dbflow # 链式查询
|                   |----base # 链式封装
|                   |----listener # 监听回调
|               |----identityscope # 缓存相关
|               |----internal # 内部调用文件
|               |----query # 查询
|           |---- index.ts  # 对外接口
|     |---- README.MD  # 安装使用方法
```

## 开源协议

本项目基于 Apache License 2.0 ，请自由地享受和参与开源。

## 遗留问题

1、AbstractDao 类下的 save(entity: T)、insertOrReplace(entity: T) 接口，在 API9 中暂不支持有则更新，无则新增的能力。

## 更新记录

### 2.3.3

Released version 2.3.3

#### 2.3.3-rc.0

Resolved the issue of not being able to access the parent class metadata after entity inheritance

### 2.3.2

Released version 2.3.2

#### 2.3.2-rc.1

Fixed the issue where passing an array to inData caused an error

#### 2.3.2-rc.0

Fixed the issue where only one Index annotation would take effect when multiple Index annotations were present

### 2.3.1

Add some synchronization interfaces
Fix the problem that the api version needs to be greater than 14

#### 2.3.1-rc.3

Fix the problem of joint table query (due to system support reasons, SQL alias is used first)

Need Api Version 14 or higher

#### 2.3.1-rc.2

Fixed the problem that the indata is invalid when an empty array is passed in

Need Api Version 14 or higher

#### 2.3.1-rc.1

The judgment condition for batch deletion of empty sets is optimized

Need Api Version 14 or higher

#### 2.3.1-rc.0

Bug fix:
Remove invalid methods in deleteByKeySync
Fixed the problem that an entire table is deleted due to the import of an empty set in the batch deletion interface

Need Api Version 14 or higher

### 2.3.0

Released version 2.3.0

Need Api Version 14 or higher

#### 2.3.0-rc.1

Add some synchronization interfaces
queryBuilder.listSync
insertOrReplaceSync
deleteSync\deleteBykeySync
updateSync
saveInTxASync
loadSync\loadAllSync

Need Api Version 14 or higher

#### 2.3.0-rc.0

Fixed the issue printing log
Automatic database upgrade
Database performance optimization
Database operation and maintenance capability enhancement

Need Api Version 14 or higher

### 2.2.6

Released version 2.2.6

#### 2.2.6-rc.2

Fixed the issue where obtaining columnIndex was abnormal after modifying the data table structure, resulting in incorrect query results

#### 2.2.6-rc.1

Modify serious or fatal issues detected by CodeCheck scanning.

#### 2.2.6-rc.0

Support for entities annotated with annotations from DataORM and also annotated with @Observed.

### 2.2.5

修复 checkAddOffset 内部实现错误

### 2.2.4

发布 2.2.4 正式版，在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release(5.0.0.66) 上验证通过

### 2.2.3

修复 AbstractDao.insertOrReplace(entity: T) 插入或更新会自动修改 entity 的主键值
修复 queryRaw(where: string, ...selectionArg: string[]) 函数内部实现错误

#### 2.2.3-rc.0

支持设置联合主键 Union 功能

### 2.2.2

发布 2.2.2 正式版

#### 2.2.2-rc.3

修复 DatabaseOpenHelper.getReadableDb/getWritableDb 获取到的 Database name 是 undefined 的问题

#### 2.2.2-rc.2

删除不必要的引用

#### 2.2.2-rc.1

支持自定义数据库路径
全局变量支持多数据库场景
支持数据库降级，允许设置的版本比原版本低

#### 2.2.2-rc.0

修复重启应用后多表关系失效的问题
修复 updateInTxAsync 传入数组更新失败的问题
修复 inData、notIn 传入数组失效的问题

### 2.2.1

修复将条件语句作为条件时查询失败的问题

#### 2.2.1-rc.2

修复 in、notIn、between 条件查询失败的问题

#### 2.2.1-rc.1

修复 insertOrReplaceInTxArrAsync 批量插入更新失败，InsertPage 添加批量插入和批量更新示例

#### 2.2.1-rc.0

修复 setVersionAsync 设置版本号触发升级，保存的版本号升级报错，添加相关测试用例

### 2.2.0

新增支持以下功能：
- 支持 Convert 注解的能力
- 支持 Transient 注解的能力
- 支持 Embedded 注解的能力
- 支持 Entity 注解中，增加禁止创建表的高级标志 createInDb

优化以下功能：
- 去除在创建数据库时，全局变量的配置
- 更改 onCreate_D 及其 onUpgrade_D 方法名分别为：onCreateDatabase 及其 onUpgradeDatabase
- 去除在创建数据库时，主动调用 onCreate_D
- 优化数据库版本升级功能
- 在用 CursorQuery 查询的时候，在 CursorQuery 中新增 list 接口封装，少了 dao.convertCursor2Entity(query) 动作，可以直接调用 list 接口

### 2.1.1

修复部分接口时序错误问题

### 2.1.0

适配 ArkTS 语法
globalThis 全局设置更改单例模式 GlobalContext 设置

### 2.0.3

修复了 query aaa 按钮失效的问题
修复了 Query aaa bbb ccc 按钮失效的问题

### 2.0.2

添加复合主键功能
修改代码中的单词错误，并规范命名

### 2.0.1

修复使用 insertOrReplace() 接口的逻辑问题
修复数据库的@Columns 装饰器的 columnName 必须要和被其修饰的属性名保持一样的问题
修复 demo 添加数据之后 save 和修改的逻辑问题

### 2.0.0

适配 DevEco Studio 版本：3.1 Beta2（3.1.0.400），OpenHarmony SDK:API9（3.2.11.9）

### 1.1.4

增加支持以下功能：
1. 支持多个表之间查询的功能，也就是 join 查询（JoinEntry）
2. 支持一对多 ToMany 查询
3. 支持关系映射用来表示一个实体与另一个实体的一对一关系的查询（ToOne）
4. 关联查询的升、降序排列（OrderBy）
5. 索引表的创建

### 1.1.3

升级到 apiV9
修改数据库加密库加密方式（以前版本通过加密键值进行加密，现通过 bool 开关进行控制，值为 true 值时为加密库）
添加注解使用方式说明
修改列名和实体名称不一致数据操作异常问题

### 1.1.2

修复方法名和原生属性名冲突的问题
修复数据库备份的问题（通过库名称备份库，若存在则执行失败。示例里给的固定库名，只能生效一次）

### 1.1.1

修复 npm 引用包编译报错的问题

### 1.1.0

变更数据库备份实现方式

### 1.0.3

修复在 3.2beta 版本 Add 数据无响应的问题
添加支持数据回滚功能
插入逻辑异常抛出处理
标签处理
优化 sqlite 支持的枚举类型

### 1.0.2

api8 升级到 api9

### 1.0.1

新增以下功能：
- 数据库加密功能
- 数据库数据导入
- sql 原始语句查询

### 1.0.0

支持以下功能：
- 数据库数据插入功能
- 数据库查询功能
- 数据库编辑功能
- 数据库删除功能
- 数据库缓存功能
- 数据库实体和表列关系映射功能
- 数据库表创建、删除等 sql 语句生成
- 数据库备份功能
- 数据库升级功能
- 数据库数据操作监听

## 权限与隐私

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |

Created with Pixso.

### 应用类型

| 项目 | 内容 |
| :--- | :--- |
| 应用 | 应用 |

Created with Pixso.

### 元服务

| 项目 | 内容 |
| :--- | :--- |
| 元服务 | 元服务 |

Created with Pixso.

### 设备类型

| 项目 | 内容 |
| :--- | :--- |
| 手机 | 手机 |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| 平板 | 平板 |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| PC | PC |

Created with Pixso.

### DevEcoStudio 版本

| 项目 | 内容 |
| :--- | :--- |
| DevEco Studio 版本 | DevEco Studio 5.0.3 |

Created with Pixso.

## 安装方式

```bash
ohpm install @ohos/dataorm
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7b4595e731e949ff909112aacf5d2d21/PLATFORM?origin=template