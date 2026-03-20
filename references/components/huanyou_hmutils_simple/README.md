# huanyou/hmutils_simple 开发工具组件

## 简介

一个适用于 HarmonyOS 开发的工具库，提供日志记录、路由、数据持久化和通用常量等基本工具。

## 详细介绍

### 简介

@huanyou/hmutils_simple 是一个为鸿蒙应用开发提供的基础工具库，包含日志记录、路由管理、数据持久化和常用常量等核心功能。遵循的 HarmonyOS API 标准和最佳实践。

### 特性

- **API 支持** - 基于 HarmonyOS 5.0+ API 构建
- **日志工具** - 集成 hilog 的简单强大的日志系统
- **路由模块** - 基于 NavPathStack 的增强导航栈管理
- **首选项工具** - 基于 preferences API 的简单数据持久化
- **通用枚举** - 预定义的路由和存储键枚举
- **零依赖** - 轻量级，无外部依赖
- **类型安全** - 完整的 TypeScript/ArkTS 支持

### 安装

使用 ohpm 安装

```bash
ohpm install @huanyou/hmutils_simple
```

## 快速开始

### 1. 在 EntryAbility 中初始化

```typescript
import { PreferenceUtil } from '@huanyou/hmutils_simple';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 为 PreferenceUtil 初始化全局上下文
    PreferenceUtil.initGlobalContext(this.context);
  }
}
```

### 2. 使用日志工具

```typescript
import { Logger } from '@huanyou/hmutils_simple';

// 记录日志
Logger.debug('调试信息');
Logger.info('普通信息');
Logger.warn('警告信息');
Logger.error('错误信息');
```

### 3. 使用路由模块

```typescript
import { RouterModule, RouterMap } from '@huanyou/hmutils_simple';

// 跳转到新页面
RouterModule.push(RouterMap.HOME_PAGE, { id: 123 });

// 替换当前页面
RouterModule.replace(RouterMap.LOGIN_PAGE);

// 返回上一页
RouterModule.pop();

// 获取导航参数
const params = RouterModule.getNavParam<{ id: number }>(RouterMap.HOME_PAGE);
```

### 4. 使用首选项工具

```typescript
import { PreferenceUtil, AppStorageMap } from '@huanyou/hmutils_simple';

// 保存数据
PreferenceUtil.getInstance().put(AppStorageMap.TOKEN, 'your-token');

// 获取数据
const token = PreferenceUtil.getInstance().get(AppStorageMap.TOKEN, '');

// 数组操作
PreferenceUtil.getInstance().putToArray('favorites', 'item-id');
PreferenceUtil.getInstance().removeFromArray('favorites', 'item-id');
```

## API 文档

### Logger

基于 hilog 集成的静态日志类。

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| `debug` | `...args: string[]` | `void` | 可变字符串参数记录调试级别日志 |
| `info` | `...args: string[]` | `void` | 可变字符串参数记录信息级别日志 |
| `warn` | `...args: string[]` | `void` | 可变字符串参数记录警告级别日志 |
| `error` | `...args: string[]` | `void` | 可变字符串参数记录错误级别日志 |

#### 示例

```typescript
Logger.info('用户已登录', 'userId: 123');
Logger.error('网络错误', JSON.stringify(error));
```

### RouterModule

基于 NavPathStack 的增强导航管理。

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| `getStack` | `-` | `NavPathStack` | 获取导航栈实例 |
| `push` | `url: string, param?: object, onPop?: Callback, animated?: boolean` | `void` | 推送新页面到栈 |
| `replace` | `url: string, param?: object` | `void` | 替换当前页面 |
| `pop` | `result?: Object, animated?: boolean` | `void` | 弹出当前页面 |
| `popToName` | `name: string, animated?: boolean` | `void` | 返回到指定名称的页面 |
| `clear` | `animated?: boolean` | `void` | 清空栈中所有页面 |
| `getNavParam` | `url: string` | `T | undefined` | 获取导航参数 |
| `size` | `-` | `number` | 获取栈大小 |

#### 示例

```typescript
// 带回调的页面跳转
RouterModule.push(RouterMap.DETAIL_PAGE,
  { id: 123 },
  (result) => {
    console.log('页面返回:', result);
  }
);

// 替换页面
RouterModule.replace(RouterMap.LOGIN_PAGE);

// 返回到指定页面
RouterModule.popToName(RouterMap.HOME_PAGE);
```

### PreferenceUtil

支持全局上下文的数据持久化工具。

#### 静态方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| `initGlobalContext` | `context: Context` | `void` | 初始化全局上下文（在 EntryAbility 中调用） |
| `getInstance` | `context?: Context, fileName?: string` | `PreferenceUtil` | 获取单例实例 |

#### 实例方法

| 方法 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| `put` | `key: string, value: object | string` | `void` | 保存键值对 |
| `get` | `key: string, defaultValue?: object | string` | `object | string | undefined` | 根据键获取值 |
| `putToArray` | `key: string, value: string` | `void` | 向数组添加值 |
| `removeFromArray` | `key: string, value: string` | `void` | 从数组移除值 |

#### 示例

```typescript
// 在 EntryAbility 中初始化
PreferenceUtil.initGlobalContext(this.context);

// 在组件中使用（无需传入 context）
const prefs = PreferenceUtil.getInstance();
prefs.put('username', 'John');
const username = prefs.get('username', '');

// 使用自定义文件
const customPrefs = PreferenceUtil.getInstance(context, 'custom_data');
```

### 通用枚举

#### AppStorageMap

预定义的数据存储键：

```typescript
enum AppStorageMap {
  USER_INFO = 'userInfo',
  TOKEN = 'token',
  PRIVACY_POLICY_KEY = 'privacyPolicyKey'
}
```

#### RouterMap

预定义的路由名称：

```typescript
enum RouterMap {
  LAUNCH_PAGE = 'LaunchPage',
  MAIN_PAGE = 'MainPage',
  HOME_PAGE = 'HomePage',
  LOGIN_PAGE = 'LoginPage',
  // ... 更多路由
}
```

## 最佳实践

### 1. 上下文管理

始终在 EntryAbility 中初始化 PreferenceUtil：

```typescript
onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  PreferenceUtil.initGlobalContext(this.context);
  // 其他初始化代码...
}
```

### 2. 类型安全

为导航参数使用泛型类型：

```typescript
interface DetailParams {
  id: number;
  title: string;
}

RouterModule.push(RouterMap.DETAIL_PAGE, { id: 123, title: '标题' });
const params = RouterModule.getNavParam<DetailParams>(RouterMap.DETAIL_PAGE);
```

### 3. 错误处理

所有 RouterModule 方法都内置了错误处理和日志记录：

```typescript
RouterModule.push(RouterMap.HOME_PAGE); // 错误会自动记录
```

### 4. Preferences 组织

为不同类型的数据使用不同的 preference 文件：

```typescript
const userPrefs = PreferenceUtil.getInstance(context, 'user_data');
const appPrefs = PreferenceUtil.getInstance(context, 'app_settings');
```

## 从旧 API 迁移

本库使用 HarmonyOS API。如果你正在从旧版本迁移：

`getContext()` → `getUIContext().getHostContext()`

旧版（已废弃）：

```typescript
const context = getContext(this) as common.UIAbilityContext;
```

新版（当前）：

```typescript
const context = this.getUIContext().getHostContext() as common.UIAbilityContext;
```

## 系统要求

- HarmonyOS 5.0 或更高版本
- API Version 12+
- DevEco Studio 5.0 或更高版本

## 兼容性

| HarmonyOS 版本 | 支持状态 |
| :--- | :--- |
| 5.0+ | ✅ |
| 4.0 | ⚠️（部分支持） |
| 3.x | ❌ |

## 贡献

欢迎贡献！请随时提交 Pull Request。

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 许可证

Apache License 2.0

## 更新记录

### 1.0.0 - 2025-10-29

#### 新增

- 基础工具库首次发布
- 集成 hilog 的日志工具（Logger）
  - 支持 debug、info、warn、error 四种日志级别
  - 可配置领域（domain）和前缀（prefix）
  - 简洁的可变参数调用接口
- 增强型导航管理路由模块（RouterModule）
  - 基于 NavPathStack API 开发
  - 支持页面入栈（push）、替换（replace）、出栈（pop）操作
  - 带类型安全的导航参数管理
  - 内置错误处理与日志记录
  - 栈大小管理功能
- 数据持久化工具（PreferenceUtil）
  - 支持全局上下文，简化使用流程
  - 单例模式设计，基于文件隔离存储
  - 数组操作方法（putToArray、removeFromArray）
  - 自动错误处理机制
  - 支持自定义偏好设置文件
- 通用枚举类型
  - 存储键值枚举（AppStorageMap）
  - 路由定义枚举（RouterMap）
- 完整支持 TypeScript/ArkTS
- 双语详细文档（英文 / 中文）

#### 变更

- 无（首次发布）

#### 弃用

- 无（首次发布）

#### 移除

- 无（首次发布）

#### 修复

- 无（首次发布）

#### 安全相关

- 采用 HarmonyOS 5.0+ API
- 移除已弃用的 `getContext()` API 调用
- 实现规范的上下文管理机制

### API 迁移说明

#### 从已弃用 API 迁移

本版本使用 HarmonyOS API，移除所有已弃用的 API 调用：

旧 API（已弃用）：

```typescript
const context = getContext() as common.UIAbilityContext;
```

新 API（当前）：

```typescript
// 在 UI 组件中
const context = this.getUIContext().getHostContext() as common.UIAbilityContext;

// 在工具类中
PreferenceUtil.initGlobalContext(context); // 初始化一次
PreferenceUtil.getInstance(); // 全局任意位置调用
```

### 升级指南

#### 从预发布版本升级至 1.0.0

本版本为首次公开发布，暂无从先前版本的升级路径。

#### 破坏性变更

- 无（首次发布）

#### 已知问题

- 暂无已上报问题

## 路线图

### 1.1.0 版本（计划中）

- 新增网络工具模块
- 新增存储加密支持
- 新增更多通用工具（日期、字符串等）
- 路由模块（RouterModule）性能优化
- 新增单元测试

### 1.2.0 版本（计划中）

- 新增国际化（i18n）支持
- 新增主题管理工具
- 新增权限辅助工具
- 增强日志工具（Logger），支持文件输出

### 2.0.0 版本（未来规划）

- 基于社区反馈重构核心 API
- 支持 HarmonyOS NEXT 新特性
- 增强 TypeScript 严格模式支持

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## SDK 合规使用指南

不涉及

## 项目信息

| 字段 | 值 |
| :--- | :--- |
| **应用类型** | 应用 |
| **元服务** | 否 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 6.0.0 |
| **HarmonyOS 版本** | 6.0.0 |

## 安装方式

```bash
ohpm install @huanyou/hmutils_simple
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cb0e2fa85b1642188041b9cf84198171/PLATFORM?origin=template