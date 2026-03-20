# Room 数据库组件

## 简介

持久性库在 SQLite 的基础上提供了一个抽象层，让用户能够在充分利用 SQLite 的强大功能的同时，获享更强健的数据库访问机制。

## 详细介绍

### 简介

持久性库在 SQLite 的基础上提供了一个抽象层，让用户能够在充分利用 SQLite 的强大功能的同时，获享更强健的数据库访问机制。

### 下载安装

```bash
ohpm install @mlethe/room
```

### 1. 模块 oh-package.json5 文件中引入依赖

```json5
{
 "dependencies":{
   "@mlethe/room": "version"
 }
}
```

### 使用

#### 1、创建 User 表

```typescript
import { Columns, ColumnType, Convert, Entity, PrimaryKey, Unique } from '@mlethe/room';
import { LoginWayConvert } from './LoginWayConvert';

/**
* 用户信息
*/
@Entity({ name: "user" })
export class User {
 @PrimaryKey()
 @Columns({ type: ColumnType.int })
 id: number = 0;
 /**
  * 昵称
  */
 @Unique()
 @Columns({ type: ColumnType.str })
 nickname: string = '';
 /**
  * 头像
  */
 @Columns({ type: ColumnType.str })
 avatar: string = '';
 /**
  * 登录方式
  */
 @Convert({ converter: LoginWayConvert })
 @Columns({ name: "login_way", type: ColumnType.object })
 loginWay: Array<LoginWay> = []
}

export class LoginWay {
 /**
  * 类型
  */
 type: number = 0;

 constructor(type?: number) {
   if (type) {
     this.type = type;
   }
 }
}
```

#### 2、创建 UserDao

```typescript
import { ColumnType, Dao, Delete, Insert, Update, MapInfo, OnConflictStrategy, Params, PromiseNull, Query, RawQuery, Transaction } from '@mlethe/room';
import { DemoDatabase } from '../db/DemoDatabase';
import { User } from '../entity/User';
import { HashMap } from '@kit.ArkTS';

@Dao({ database: DemoDatabase, entity: User })
export class UserDao {
 @Delete
 async delete(user: User): Promise<number> {
   return PromiseNull();
 }

 @Delete
 async deleteList(users: Array<User>): Promise<number> {
   return PromiseNull();
 }

 @Insert({ onConflict: OnConflictStrategy.REPLACE })
 async insert(user: User): Promise<number> {
   return PromiseNull();
 }

 @Insert({ onConflict: OnConflictStrategy.REPLACE })
 async insertAll(users: Array<User>): Promise<number> {
   return PromiseNull();
 }

 @Update({ onConflict: OnConflictStrategy.REPLACE })
 async update(users: User): Promise<number> {
   return PromiseNull();
 }

 @Update({ onConflict: OnConflictStrategy.REPLACE })
 async updateAll(users: Array<User>): Promise<number> {
   return PromiseNull();
 }

 @Query({ entity: User, isArray: true, sql: "SELECT * FROM user WHERE id IN(:userIds);" })
 async selectUser(@Params("userIds") userIds: Array<number>): Promise<Array<User>> {
   return PromiseNull();
 }

 @MapInfo({ keyColumn: "nickname", keyType: ColumnType.str })
 @Query({ entity: User, isArray: false, sql: "SELECT * FROM user WHERE id IN(:userIds);" })
 async selectUserMap(@Params("userIds") userIds: Array<number>): Promise<HashMap<string, User>> {
   return PromiseNull();
 }

 /**
  * 自定义 sql
  *
  * @param sql
  * @returns
  */
 @RawQuery({ entity: User, isArray: true })
 async selectUserAll(sql: string): Promise<Array<User>> {
   return PromiseNull();
 }

 /**
  * 事务
  *
  * @param user
  * @param that
  * @returns
  */
 @Transaction
 async transaction(user: User, that: UserDao): Promise<number> {
   await that.insert(user);
   user.id = 2;
   user.nickname = user.nickname + "New";
   return that.insert(user);
 }
}
```

#### 3、获取 UserDao

```typescript
import { UserDao } from '../dao/UserDao';

userDao: UserDao = Room.getDao(UserDao);
this.userDao.insert(new User(2, "李四", "url", [new LoginWay(1), new LoginWay(2)]));
```

#### 4、创建数据库管理

```typescript
import { Database, RoomDatabase } from '@mlethe/room';
import relationalStore from '@ohos.data.relationalStore';
import { User } from '../entity/User';

@Database({ entities: [User], name: "demo.db", version: 1 })
export class DemoDatabase implements RoomDatabase {
 async onCreate(db: relationalStore.RdbStore): Promise<void> {
 }

 async onUpgrade(db: relationalStore.RdbStore, oldVersion: number, newVersion: number): Promise<void> {
 }
}
```

#### 5、UIAbility 中初始化

```typescript
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { Room } from '@mlethe/room';
import { DemoDatabase } from '../db/DemoDatabase';
import BuildProfile from 'BuildProfile';

export default class EntryAbility extends UIAbility {
 onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   Room.init(this.context, DemoDatabase, BuildProfile.DEBUG)
 }

 onDestroy(): void {
   // 关闭数据库
   Room.close(DemoDatabase)
 }
}
```

#### 6、支持多数据源

```typescript
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { Room } from '@mlethe/room';
import { DemoDatabase } from '../db/DemoDatabase';
import { SecondDemoDatabase } from '../db/SecondDemoDatabase';
import BuildProfile from 'BuildProfile';

export default class EntryAbility extends UIAbility {
 onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
   // 初始化默认数据库
   Room.init(this.context, DemoDatabase, BuildProfile.DEBUG)
   // 初始化第二个数据库
   Room.init(this.context, SecondDemoDatabase, BuildProfile.DEBUG)
 }

 onDestroy(): void {
   // 关闭数据库
   Room.close(DemoDatabase)
   Room.close(SecondDemoDatabase)
 }
}
```

#### 7、创建 Converter

```typescript
import { PropertyConverter } from '@mlethe/room';
import { LoginWay } from './User';

export class LoginWayConvert extends PropertyConverter<LoginWay[]> {
 /**
  * 数据库数据转为实体对象
  *
  * @param databaseValue
  * @returns
  */
 convertToEntityProperty(databaseValue: string): LoginWay[] {
   if (databaseValue == undefined) {
     return [];
   }
   if (databaseValue.length <= 0) {
     return [];
   }
   let list: LoginWay[] | undefined = JSON.parse(databaseValue);
   if (!list) {
     return [];
   }
   return list;
 }

 /**
  * 实体对象转为数据库数据
  *
  * @param entityProperty
  * @returns
  */
 convertToDatabaseValue(entityProperty: LoginWay[]): string {
   let json = JSON.stringify(entityProperty);
   if (!json) {
     return "";
   }
   return json
 }
}
```

#### 8、HarmonyOS 多线程使用

在子线程中不用重新初始化数据库，按照以上使用方法正常使用即可。

## 更新记录

- **1.0.0** 初版
  - 发布 1.0.0 初版。
- **1.0.1**
  - reflect-metadata 引包添加。
- **1.0.2**
  - 数据库升级新增表和索引自动创建处理
- **1.0.3**
  - 数据库配置 StoreConfig 所有属性配置支持
- **1.0.4**
  - 数据库子线程管理优化
- **1.0.5**
  - 数据库子线程查询优化
- **1.0.6**
  - 数据库批量插入错误修复
- **1.0.7**
  - 数据库子线程列表数据共享处理
- **1.0.8**
  - bug 修复
- **1.0.9**
  - 数据库初始化添加异步锁
- **1.1.0**
  - 添加开源仓库地址
- **1.1.1**
  - bug 修复
  - 文档优化

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |

Created with Pixso.

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |

Created with Pixso.

## 应用类型

| 项目 | 详情 |
| :--- | :--- |
| 应用 | 应用 |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## 元服务

| 项目 | 详情 |
| :--- | :--- |
| 元服务 | 元服务 |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## 设备类型

| 项目 | 详情 |
| :--- | :--- |
| 手机 | 手机 |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## 平板

| 项目 | 详情 |
| :--- | :--- |
| 平板 | 平板 |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## PC

| 项目 | 详情 |
| :--- | :--- |
| PC | PC |

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

Created with Pixso.

## DevEcoStudio 版本

| 项目 | 详情 |
| :--- | :--- |
| DevEco Studio 版本 | DevEco Studio 5.0.1 |

Created with Pixso.

## 安装方式

```bash
ohpm install @mlethe/room
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/30be0757f1e148eba140addd949d73f8/PLATFORM?origin=template