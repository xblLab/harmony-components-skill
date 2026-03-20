# zdb 数据库管理组件

## 简介

数据库操作工具类

## 详细介绍

### 介绍

ZDbUtil 是一款数据库操作工具库

通过注解类和字段，与数据库的表进行关联
支持状态管理（V1）中被@Observed 装饰的类
支持状态管理（V2）中被@ObservedV2 装饰的类
支持存放复杂类型的数据，通过 json 格式进行存储
支持一对一/一对多查询
数据库升级

### 下载安装

在每个 har/hsp 模块中，通过 ohpm 工具下载安装库：

```bash
ohpm install @hzw/zdb
```

### 注解

#### Table

**表**

**参数**
*   `name`: 表名，默认为类名

#### Column

**列**

**参数:**
*   `name`: 列名，默认为字段名称
*   `type`: 列类型，查看 ColumnType
    *   Integer: 整型
    *   Text: 文本类型
    *   Boolean: 布尔类型
    *   Real: 浮点类型
*   `primaryKey`: 是否主键
*   `autoIncrement`: 是否自增
*   `notNull`: 是否为空
*   `unique`: 是否唯一

#### OneToOne

联表查询，一对一

**参数:**
*   `joinTable`: 关联表的类
*   `relatedIdProperty`: 关联 id 属性名，该属性是主表关联类的字段

#### OneToMany

一对多，使用方法参考一对多查询

**参数:**
*   `placeHolderTable`: 占位类，查询的时候通过 include 把占位类替换为联动表对应实体类
*   `relatedIdProperty`: 关联 id 属性名，该属性是主表关联类的字段

#### ObjToJson

以 json 形式存储复杂对象

**参数:**
*   `cls`: 复杂对象的类信息

### 使用方法

定义实体类
只要添加了@Table 注解，@Column 注解
在初始化数据库时，会自动创建表，并添加列。

```typescript
import { Column, ColumnType, ObjToJson, OneToOne, Table } from '@hzw/zdb';

// 作业本
export class StudentHomeworkBook {
  // 书本名
  name?: string
}

// 父亲
export class StudentFather {
  // 名字
  name?: string
  // 父亲
  @ObjToJson({ cls: StudentFather })
  father?: StudentFather | undefined
}

// 分类
@Table()
export class StudentClassify {
  // id
  @Column({ type: ColumnType.Integer, primaryKey: true, autoIncrement: true })
  id?: number
  // 名称
  @Column({ type: ColumnType.Text })
  name?: string
  // 创建时间
  @Column({ type: ColumnType.Integer })
  createTime?: number
  // 更新时间
  @Column({ type: ColumnType.Integer })
  editTime?: number | undefined
}

// 学生
@Table()
export class StudentInfo {
  // id
  @Column({ type: ColumnType.Integer, primaryKey: true, autoIncrement: true })
  id?: number | undefined
  // 标题
  @Column({ type: ColumnType.Text })
  title?: string | undefined
  // 创建时间
  @Column({ type: ColumnType.Integer })
  createTime?: number | undefined
  // 成绩
  @Column({ type: ColumnType.Real })
  score?: number | undefined
  // 是否管理员
  @Column({ type: ColumnType.Boolean })
  isManager?: boolean | undefined
  // 分类 id
  @Column({ type: ColumnType.Integer })
  classifyId?: number | undefined
  // 分类
  @OneToOne({ joinTable: StudentClassify, relatedIdProperty: "classifyId" })
  classify?: StudentClassify | undefined
  // 名下作业本
  @ObjToJson({ cls: StudentHomeworkBook })
  homeworkBookList?: StudentHomeworkBook[] | undefined
  // 父亲
  @ObjToJson({ cls: StudentFather })
  father?: StudentFather | undefined
}
```

初始化数据库并根据被@Table 注解的类创建表

```typescript
ZDbUtil.initDatabase({
  context: this.context
})
```

定义数据库表操作类
建议用一个数据库管理类来管理所有的表操作类，具体参考示例创建数据库管理实例

```typescript
studentInfoDao = ZBaseDao.get(StudentInfo)
```

使用后，可以通过该实例 studentInfoDao 对表进行增删改查操作。
也可以直接使用 ZDbUtil 传入对应的表关联类来进行表的增删改查操作。

### 查数据

更多条件查询查看请查看 SQL 查询构建器方法速查表

#### 使用 ZBaseDao 表操作实例

```typescript
// 查询多条数据
studentInfoDao.querySqlBuilder()
// ...其他条件查询
  .limitAs(this.pageSize)
  .offsetAs(this.page * this.pageSize)
  .query()
  .then((data) => {
  })
```

```typescript
// 根据 id 查询单条数据
studentInfoDao.querySqlBuilder()
  .queryOneById(id)
  .then((data) => {
    this.item = data;
  })
```

#### 直接使用 ZDbUtil

```typescript
// 查询多条数据
// 传入被@Table 注解的类
ZDbUtil.querySqlBuilder(StudentInfoV1)
// ...其他条件查询
  .limitAs(this.pageSize)
  .offsetAs(this.page * this.pageSize)
  .query()
  .then((data) => {
  })
```

```typescript
// 根据 id 查询单条数据
ZDbUtil.querySqlBuilder(StudentInfoV1)
  .queryOneById(id)
  .then((data) => {
    this.item = data;
  })
```

以下是查询构建类核心方法的功能表格，包含方法名、功能描述，便于快速查阅和使用：

#### SQL 查询构建器方法速查表

| 方法名 | 功能描述 |
| :--- | :--- |
| `equalTo(field, value)` | 添加 字段 = 值 条件 |
| `notEqualTo(field, value)` | 添加 字段 <> 值 条件 |
| `notEqualToWithOrIsNull(field, value)` | 添加 (字段 <> 值 OR 字段 IS NULL) 条件（值不等或字段为空） |
| `and()` | 添加逻辑与（AND）连接符 |
| `or()` | 添加逻辑或（OR）连接符 |
| `beginWrap()` | 开始包裹条件（生成左括号 (） |
| `endWrap()` | 结束包裹条件（生成右括号 )） |
| `contains(field, value)` | 添加 字段包含值 条件（基于 INSTR 函数） |
| `beginsWith(field, value)` | 添加 字段以值开头 条件（LIKE '值%'） |
| `endsWith(field, value)` | 添加 字段以值结尾 条件（LIKE '%值'） |
| `like(field, value)` | 添加 字段模糊匹配值 条件（LIKE '%值%'） |
| `glob(field, value)` | 添加 字段按通配符匹配值 条件（GLOB 操作符，区分大小写） |
| `notContains(field, value)` | 添加 字段不包含值 条件（INSTR 结果为 0） |
| `notLike(field, value)` | 添加 字段不模糊匹配值 条件（NOT LIKE '%值%'） |
| `greaterThan(field, value)` | 添加 字段 > 值 条件 |
| `lessThan(field, value)` | 添加 字段 < 值 条件 |
| `greaterThanOrEqualTo(field, value)` | 添加 字段 >= 值 条件 |
| `lessThanOrEqualTo(field, value)` | 添加 字段 <= 值 条件 |
| `between(field, low, high)` | 添加 字段 BETWEEN 低值 AND 高值 条件 |
| `notBetween(field, low, high)` | 添加 字段 NOT BETWEEN 低值 AND 高值 条件 |
| `in(field, values)` | 添加 字段 IN (值列表) 条件 |
| `notIn(field, values)` | 添加 字段 NOT IN (值列表) 条件 |
| `isNull(field)` | 添加 字段 IS NULL 条件 |
| `isNotNull(field)` | 添加 字段 IS NOT NULL 条件 |
| `orderByAsc(field)` | 添加 ORDER BY 字段 ASC 排序（升序） |
| `orderByDesc(field)` | 添加 ORDER BY 字段 DESC 排序（降序） |
| `orderByAscCaseStart()` | 在 ORDER BY 中使用 CASE 自定义排序 |
| `orderByAscCaseEnd()` | 添加 ELSE xxx END 条件，用在 orderByAscCaseStart() 后 |
| `distinct(values)` | 添加 DISTINCT 去重（指定去重字段） |
| `limitAs(value)` | 添加 LIMIT 值 限制返回行数 |
| `offsetAs(rowOffset)` | 添加 OFFSET 值 跳过指定行数 |
| `groupBy(fields)` | 添加 GROUP BY 字段 分组 |
| `indexedBy(field)` | 添加 INDEXED BY 字段 索引提示（优化查询） |

**说明**

*   **逻辑组合**: and()/or() 需配合 beginWrap()/endWrap() 使用，或直接链式调用（如 a.and().b.or().c 会自动生成 a AND b OR c）。
*   **调用顺序**: orderByAsc()/orderByDesc()/limitAs()/offsetAs() 放在其他条件的后面使用

通过此表可快速定位所需方法，结合链式调用实现复杂查询条件的动态拼接。

### 示例

多个分组排序，使用 orderByAscCaseStart 开始分组排序，然后添加条件进行分组，最后使用 orderByAscCaseEnd 结束分组排序

#### 使用 ZBaseDao 表操作实例

```typescript
studentInfoDao.querySqlBuilder()
  .orderByAscCaseStart() // 先根据 isManager 进行分组排序
  .equalTo("isManager", true) // 管理员分为一组
  .orderByAscCaseEnd() // 剩余分为一组
  .orderByAscCaseStart() // 再根据 score 进行分组排序
  .greaterThan("grade", 4) // 年级 4 以上分为一组
  .greaterThan("grade", 3) // 年级 3 以上分为一组
  .orderByAscCaseEnd() // 剩余分为一组
  .orderByAsc("score") // 组内成绩排序
  .query()
  .then((data) => {
    this.list = data;
  })
```

#### 直接使用 ZDbUtil

```typescript
ZDbUtil.querySqlBuilder(StudentInfoV1)
  .orderByAscCaseStart() // 先根据 isManager 进行分组排序
  .equalTo("isManager", true) // 管理员分为一组
  .orderByAscCaseEnd() // 剩余分为一组
  .orderByAscCaseStart() // 再根据 score 进行分组排序
  .greaterThan("grade", 4) // 年级 4 以上分为一组
  .greaterThan("grade", 3) // 年级 3 以上分为一组
  .orderByAscCaseEnd() // 剩余分为一组
  .orderByAsc("score") // 组内成绩排序
  .query()
  .then((data) => {
    this.list = data;
  })
```

### 一对多查询

定义一对多的表关联类的占位类

```typescript
// 学生占位类
export class StudentInfoPlaceholder {
}
```

实体类一对多字段用@OneToMany 注解，并传入一个 占位类 和 关联表的相关类字段

```typescript
// 分类
@Table()
export class StudentClassify {
  // 省略...

  // 该分类下的学员
  @OneToMany({ placeHolderTable: StudentInfoPlaceholder, relatedIdProperty: "classifyId" })
  user?: StudentInfo[];
}
```

查询方法调用 include，传入 真正的关联类 ，替换 占位类

#### 使用 ZBaseDao 表操作实例

```typescript
studentClassifyDao.querySqlBuilder()
// 显式加载一对多的表关联类，只有调用该方法，一对多查询才会生效
  .include(StudentInfo, StudentInfoPlaceholder)
  .query()
  .then((data) => {
    this.classifyList = data;
  })
```

#### 直接使用 ZDbUtil

```typescript
ZDbUtil.querySqlBuilder(StudentClassify)
// 显式加载一对多的表关联类，只有调用该方法，一对多查询才会生效
  .include(StudentInfo, StudentInfoPlaceholder)
  .query()
  .then((data) => {
    this.classifyList = data;
  })
```

### 插入/更新数据

#### 使用 ZBaseDao 表操作实例

```typescript
studentInfoDao.insertOrReplace(data).then(() => {
  promptAction.showToast({ message: "添加成功" });
})
```

#### 直接使用 ZDbUtil

```typescript
// data 类型确定，且被@Table 注解，直接插入/更新数据

ZDbUtil.insertOrReplace(data).then(() => {
  promptAction.showToast({ message: "添加成功" });
})

// data 类型是 Object，通过传入被@Table 注解的类，插入/更新数据

// 插入/更新数据
// 第一个参数为插入/更新的数据
// 第二个参数为被@Table 注解的类，数据将会被插入/更新到与注解类关联的表中
ZDbUtil.insertOrReplaceByCls(data, StudentClassify).then(() => {
  promptAction.showToast({ message: "添加成功" });
})
```

### 批量插入/更新数据

#### 使用 ZBaseDao 表操作实例

```typescript
studentInfoDao.batchInsert(data).then(() => {
  promptAction.showToast({ message: "添加成功" });
})
```

#### 直接使用 ZDbUtil

```typescript
// data 类型确定，且被@Table 注解，直接插入/更新数据

ZDbUtil.batchInsert(data).then(() => {
  promptAction.showToast({ message: "添加成功" });
})

//data 类型是 Object，通过传入被@Table 注解的类，插入/更新数据

// 批量插入/更新数据
// 第一个参数为插入/更新的数据
// 第二个参数为被@Table 注解的类，数据将会被插入/更新到与注解类关联的表中
ZDbUtil.batchInsertByCls(data, StudentClassify).then(() => {
  promptAction.showToast({ message: "添加成功" });
})
```

### 更新数据

#### 更新符合条件的数据

##### 使用 ZBaseDao 表操作实例

```typescript
// 找出 title = this.updateTitle 的数据，把 score 更新为 this.updateScoreByTitle
studentInfoDao.updateSqlBuilder()
  .set("score", Number(this.updateScoreByTitle))
  .equalTo("title", this.updateTitle)
  .update()
  .then((num) => {
    promptAction.showToast({ message: `修改${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

##### 直接使用 ZDbUtil

```typescript
// 找出 title = this.updateTitle 的数据，把 score 更新为 this.updateScoreByTitle
ZDbUtil.updateSqlBuilder(StudentInfoV1)
  .set("score", Number(this.updateScoreByTitle))
  .equalTo("title", this.updateTitle)
  .update()
  .then((num) => {
    promptAction.showToast({ message: `修改${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

#### 对主键对应的数据进行更新

##### 使用 ZBaseDao 表操作实例

```typescript
// 找出主键为 this.updateId 的数据，把 score 更新为 this.updateScoreById
studentInfoDao.updateSqlBuilder()
  .set("score", Number(this.updateScoreById))
  .updateOneById(Number(this.updateId))
  .then((num) => {
    promptAction.showToast({ message: `修改${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

##### 直接使用 ZDbUtil

```typescript
// 找出主键为 this.updateId 的数据，把 score 更新为 this.updateScoreById
ZDbUtil.updateSqlBuilder(StudentInfoV1)
  .set("score", Number(this.updateScoreById))
  .updateOneById(Number(this.updateId))
  .then((num) => {
    promptAction.showToast({ message: `修改${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

### 删除数据

#### 使用 ZBaseDao 表操作实例

```typescript
studentInfoDao.delete(item).then(() => {
  promptAction.showToast({ message: "删除成功" });
})
```

#### 直接使用 ZDbUtil

```typescript
// data 类型确定，且被@Table 注解，直接删除数据

ZDbUtil.delete(item).then(() => {
  promptAction.showToast({ message: "删除成功" });
})

// data 类型是 Object，通过传入被@Table 注解的类，删除数据

ZDbUtil.deleteByCls(data, StudentInfo).then(() => {
  promptAction.showToast({ message: "删除成功" });
})
```

### 批量删除指定条件数据

#### 删除指定条件的数据

##### 使用 ZBaseDao 表操作实例

```typescript
// 删除 title = this.deleteTitle 的数据
studentInfoDao.deleteSqlBuilder()
  .equalTo("title", this.deleteTitle)
  .delete()
  .then((num) => {
    promptAction.showToast({ message: `删除${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

##### 直接使用 ZDbUtil

```typescript
// 删除 title = this.deleteTitle 的数据
ZDbUtil.deleteSqlBuilder(StudentInfoV1)
  .equalTo("title", this.deleteTitle)
  .delete()
  .then((num) => {
    promptAction.showToast({ message: `删除${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

#### 删除指定 id 数据

##### 使用 ZBaseDao 表操作实例

```typescript
// 删除主键为 this.deleteId 的数据
studentInfoDao.deleteSqlBuilder()
  .deleteOneById(Number(this.deleteId))
  .then((num) => {
    promptAction.showToast({ message: `删除${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

##### 直接使用 ZDbUtil

```typescript
// 删除主键为 this.deleteId 的数据
ZDbUtil.deleteSqlBuilder(StudentInfoV1)
  .deleteOneById(Number(this.deleteId))
  .then((num) => {
    promptAction.showToast({ message: `删除${num}条，返回手动刷新数据` });
  })
  .catch((err: BusinessError) => {
    promptAction.showToast({ message: `删除失败:${err}` });
  })
```

### 清空数据

清空与之关联的表的所有数据

#### 使用 ZBaseDao 表操作实例

```typescript
studentInfoDao.clear().then(() => {
  promptAction.showToast({ message: "清空成功" });
})
```

#### 直接使用 ZDbUtil

```typescript
// 传入@Table 注解的类
ZDbUtil.clear(StudentInfo).then(() => {
  promptAction.showToast({ message: "清空成功" });
})
```

### 创建数据库管理实例

使用 ZBaseDao 管理表关联的类，用于操作表，再用一个管理类 DatabaseManager 管理所有表操作类 ZBaseDao，使用如下：

```typescript
// 数据库管理类
export class DatabaseManager {
  readonly studentClassifyDao = ZBaseDao.get(StudentClassify)
  readonly studentInfoDao = ZBaseDao.get(StudentInfo)
  // ...

  /**
   * 数据库管理实例
   */
  private static _instance: DatabaseManager | null = null

  static instance(): DatabaseManager {
    if (DatabaseManager._instance == null) {
      DatabaseManager._instance = new DatabaseManager()
    }
    return DatabaseManager._instance
  }
}

// 获取表操作实例

studentInfoDao = DatabaseManager.instance().studentInfoDao

// 操作表（这里不一一展示）
// 查询
studentInfoDao.querySqlBuilder()
// ...其他条件查询
  .limitAs(this.pageSize)
  .offsetAs(this.page * this.pageSize)
  .query()
  .then((data) => {
  })

// ...
```

### 开启打印 sql 相关日志

```typescript
ZDbUtil.sqlLogEnable(true)
```

或初始化数据库方法中 sqlLogEnable 参数设为 true

```typescript
ZDbUtil.initDatabase({
  // ...
  sqlLogEnable: true,
})
```

### 升级数据库版本

自动升级，需要配置 changeByUpdate 参数为 true，以及设置数据库版本 dbVersion

```typescript
ZDbUtil.initDatabase({
  // ...
  // 是否升级数据库版修改数据库结构（开启后，如果类修改了，需要升级数据库版本 dbVersion）
  changeByUpdate: true,
  // 数据库版本
  dbVersion: 2,
})
```

手动升级，需要配置 changeByUpdate 参数为 true，以及设置数据库版本 dbVersion，并配置数据库版本迁移 migrations

```typescript
ZDbUtil.initDatabase({
  // ..
  // 是否升级数据库版修改数据库结构（开启后，如果类修改了，需要升级数据库版本 dbVersion）
  changeByUpdate: true,
  // 数据库版本
  dbVersion: 7,
  // 数据库版本迁移
  migrations: [
    new Migration(5, 6)
      .addColumn(StudentInfo, 'isManager2', ColumnType.Text) // 添加列
      .delColumn(StudentInfo, 'age'), // 删除列
    new Migration(6, 7)
      .alterColumnType(StudentInfo, 'isManager2', ColumnType.Boolean) // 修改列类型
      .alterColumnName(StudentInfo, 'isManager2', 'isManager'), // 修改列名
    new Migration(7, 8)
      .addCustomSql(StudentInfo, 'alter table student_info add column isManager2 text;'),// 自定义 sql,
  ],
})

## 更新记录

[v1.0.32] 2026.02
新增

新增对象与数据库支持的基础类型之间的自定义双向转换，注解@Convert 和转换接口 PropertyConverter 配合使用

[v1.0.31] 2026.02
新增

新增基本聚合查询 count()、sum()、avg()、max()、min()

[v1.0.30] 2025.01
新增

新增方法 batchInsertReturnId，批量插入/更新数据，同时返回的对象携带 id，插入速度比 batchInsert 慢

[v1.0.28] 2025.12
新增

兼容最低 HarmonyOS API 版本到 12

[v1.0.27] 2025.12
新增

在 QuerySqlBuilder 中新增 queryFirst 方法用于查询首条记录
插入{}时异常捕获机制
优化部分逻辑

[v1.0.26] 2025.10
新增

新增索引

[v1.0.25] 2025.08
新增

移除不必要的泛型参数，例如 ZBaseDao.get<StudentClassify>(StudentClassify) 中的<StudentClassify>可以省略

[v1.0.24] 2025.08
优化

优化使用体验

[v1.0.23] 2025.08
新增

新增表操作类 ZBaseDao，聚合表相关操作

[v1.0.22] 2025.08
新增

新增利用 case 进行分组排序

[v1.0.21] 2025.08
新增

自动/手动升级数据库

[v1.0.20] 2025.07
修复

修复条件查询多次调用排序问题失效问题

[v1.0.19] 2025.07
修复

修复一对多问题

[v1.0.18] 2025.07
新增

新增更新构造器，通过该构造器可以进行更复杂的更新
新增删除构造器，通过该构造器可以进行更复杂的删除

[v1.0.17] 2025.07
优化

优化一对多查询
调整初始化，新增初始化成功回调

[v1.0.16] 2025.07
优化

优化插入和查询速度
@Id 功能合并到@Column
新增打印数据库操作日志，需手动打开

[v1.0.15] 2025.07

插入单个时自动给插入的对象添加的 id 属性添加主键值

[v1.0.14] 2025.07

修复一对多查询

[v1.0.13] 2025.06
新增

新增一对多查询

修复

修复查询使用 in 和 notIn 查询条件错误查询问题

[v1.0.12] 2025.06
新增

新增根据 id 查询单条数据

[v1.0.11] 2025.06
新增

新增自定义表名和列名
对在数据库是关键字的表字段进行特殊处理
统一了错误处理和日志记录

[v1.0.10] 2025.06
修复

不被@Column 注解的字段不做处理

[v1.0.9] 2025.05
修复

修复数据库初始化不成功问题

[v1.0.8] 2025.04
新增

支持存放复杂对象（数据库中以 JSON 的形式存储）

[v1.0.7] 2025.04
新增

支持浮点类型

[v1.0.6] 2025.04
新增

新增批量插入方法
优化元数据管理

[v1.0.5] 2025.03

调整细节

[v1.0.4] 2025.02
修改

新增元数据信息工具类 ZReflect，去除 reflect-metadata 第三方库

[v1.0.1] 2025.02
新增

提供简单易用的数据库操作工具类

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

隐私政策不涉及 SDK 合规使用指南 不涉及

Created with Pixso.

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用 |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @hzw/zdb
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/815a4aefc64e41f59b98b677ffa777eb/PLATFORM?origin=template