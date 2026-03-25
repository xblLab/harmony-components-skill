# aki 跨语言交互组件

## 简介

AKI (Alpha Kernel Interacting) 是一款边界性编程体验友好的 ArkTs FFI 开发框架，针对 OpenHarmony Native 开发提供 JS 与 C/C++ 跨语言访问场景解决方案。支持极简语法糖使用方式，一行代码完成 JS 与 C/C++ 的无障碍跨语言互调，所键即所得。

## 详细介绍

### AKI 简介

AKI (Alpha Kernel Interacting) 是一款边界性编程体验友好的 ArkTs FFI 开发框架，针对 OpenHarmony Native 开发提供 JS 与 C/C++ 跨语言访问场景解决方案。支持极简语法糖使用方式，一行代码完成 JS 与 C/C++ 的无障碍跨语言互调，所键即所得。

### 优势

- 极简使用，解耦 FFI 代码与业务代码，友好的边界性编程体验；
- 提供完整的数据类型转换、函数绑定、对象绑定、线程安全等特性；
- 支持 JS & C/C++ 互调；
- 支持与 Node-API 嵌套使用。

### Native C/C++ 业务代码

```cpp
#include <string>
#include <aki/jsbind.h>
 
// 类/结构体
struct Person {
   std::string SayHello();
   int age;
   std::string name;
   double weight;
};
 
// 全局函数
Person MakePerson() {
   Person person = {99, "aki", 128.8};
   return person;
}
 
// Aki JSBind 语法糖
JSBIND_GLOBAL() {
   JSBIND_FUNCTION(MakePerson);
}
JSBIND_CLASS(Person) {
   JSBIND_CONSTRUCTOR<int>();
   JSBIND_METHOD(SayHello);
   JSBIND_PROPERTY(age);
   JSBIND_PROPERTY(name);
   JSBIND_PROPERTY(weight);
}
JSBIND_ADDON(<Name>)
```

### ArkTS 风格代码

```typescript
import libaki from "lib<Name>.so"
 
// 调用 C/C++ Person 构造函数
let man = new libaki.Person(10);
 
// 访问类/结构体成员属性
console.log(man.age);
 
// 类/结构体成员函数
man.SayHello();
 
// 调用 C/C++ 全局函数
let woman = libaki.MakePerson();
 
// 极简使用，支持全类型转换
console.log(woman.name);
```

## 已测试兼容环境

- Command Line Tools 5.0.3.900 (api12): 测试通过
- DevEco Studio NEXT Release 5.0.3.900: 测试通过
- OpenHarmony(API 10) SDK (4.0.9.6): 测试通过
- DevEco Studio (4.0.0.400): 测试通过
- OpenHarmony(API 9) SDK (3.2.12.2): 测试通过
- DevEco Studio (3.1.0.500): 测试通过

## 关于混淆

代码混淆，请查看代码混淆简介。

如果希望 aki 在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/aki
```

## 快速接入

1. 依赖配置
2. 用户自定义业务
3. 使用 AKI
4. 编译构建使用

### 1 依赖配置（2 选 1）

#### 源码依赖（推荐）

指定 cpp 路径下（如：项目根路径/entry/src/main/cpp）。

```bash
cd entry/src/main/cpp
git clone https://gitcode.com/openharmony-sig/aki.git
```

CMakeLists.txt 添加依赖（假定编译动态库名为：libhello.so）：

```cmake
add_subdirectory(aki)
target_link_libraries(hello PUBLIC aki_jsbind)
```

#### ohpm har 包依赖

指定路径下（如：项目根路径/entry），输入如下命令安装 ohpm har 包依赖。

```bash
cd entry
ohpm install @ohos/aki
```

CMakeLists.txt 添加依赖（假定编译动态库名为：libhello.so）：

```cmake
set(AKI_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../../../oh_modules/@ohos/aki) # 设置 AKI 根路径
set(CMAKE_MODULE_PATH ${AKI_ROOT_PATH})
find_package(Aki REQUIRED)
 
...
 
target_link_libraries(hello PUBLIC Aki::libjsbind) # 链接二进制依赖 & 头文件
```

### 2 用户自定义业务

用户业务 C++ 代码 hello.cpp：全程无感 node-API。

```cpp
#include <string>

std::string SayHello(std::string msg)
{
 return msg + " too.";
}
```

### 3 使用 AKI

使用 JSBind 工具宏声明需要被绑定的类、函数：

```cpp
#include <aki/jsbind.h>

// Step 1 注册 AKI 插件
JSBIND_ADDON(hello) // 注册 AKI 插件名：即为编译*.so 名称，规则与 NAPI 一致

// Step 2 注册 FFI 特性
JSBIND_GLOBAL()
{
 JSBIND_FUNCTION(SayHello);
}
```

### 4 编译构建使用

OpenHarmony 工程代码调用：

```typescript
import aki from 'libhello.so' // 工程编译出来的*.so

aki.SayHello("hello world");
```

## JSBind 语法糖

| 语法糖 | AKI | 说明 |
| :--- | :--- | :--- |
| 插件注册 | JS 访问 C++ | `JSBIND_ADDON` 注册 OpenHarmony Native 插件。 [使用指导](#插件注册) |
| C++ 访问 JS | `aki::Value::FromGlobal` | 获取 JS 侧 globalThis 下的属性。 [使用指导](#c-访问-js) |
| 全局函数 | JS 访问 C++ | `JSBIND_FUNCTION` / `JSBIND_PFUNCTION` 绑定 C++ 全局方法，JS 可调用。 [使用指导](#绑定全局函数) |
| C++ 访问 JS | `aki::Value::operator()` | JS 全局方法函数调用运算符，C++ 可调用。 [使用指导](#c-访问-js) |
| 类构造函数 | JS 访问 C++ | `JSBIND_CONSTRUCTOR<>` 绑定 C++ 类构造函数，JS 可调用。构造函数可重载，需指定构造函数参数类型。 [使用指导](#类构造函数) |
| C++ 访问 JS | - | 暂不支持 |
| 类成员函数 | JS 访问 C++ | `JSBIND_METHOD` / `JSBIND_PMETHOD` 绑定 C++ 类成员函数，JS 可调用。<br>成员函数可以为：类静态函数，类成员函数，const 类成员函数。 [使用指导](#类成员函数) |
| C++ 访问 JS | `aki::Value::CallMethod` | 调用 JS 对象的成员函数。 [使用指导](#c-访问-js) |
| 类成员属性 | JS 访问 C++ | `JSBIND_PROPERTY` / `JSBIND_FIELD`<br>`JSBIND_PROPERTY` 绑定 C++ 类成员属性；`JSBIND_FIELD` 绑定 C++ 类成员属性访问器（Get/Set）。 [使用指导](#类成员属性) |
| C++ 访问 JS | `aki::Value::operator[]` | JS 对象的属性访问运算符 [使用指导](#c-访问-js) |
| 枚举类型 | JS 访问 C++ | `JSBIND_ENUM` / `JSBIND_ENUM_VALUE`<br>C/C++侧默认枚举类型为 POD 中的 int32_t，JavaScript 侧对应的枚举类型属性为 readonly。 [使用指导](#枚举类型) |
| C++ 访问 JS | - | - |

### 插件注册

#### JSBIND_ADDON

使用 `JSBIND_ADDON` 注册 OpenHarmony Native 插件，可从 JavaScript import 导入插件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| addonName | Y | 注册的 OpenHarmony native 插件名，可从 JavaScript import `lib${addonName}.so` 导入插件，插件名必须符合函数命名规则。 |

**示例：**

**C++**

```cpp
#include <string>
#include <aki/jsbind.h>

JSBIND_ADDON(addon0)
```

**JavaScript**

```typescript
import addon from 'libaddon0.so' // 插件名为：addon0
```

#### JSBIND_ADDON_X

用法与 `JSBIND_ADDON` 相似，用于支持插件名有特殊符号的场景，如包含 `'-'`。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| addonName | Y | 注册的 OpenHarmony native 插件名，可从 JavaScript import `lib${addonName}.so` 导入插件，插件名可包含特殊符号，如：`'-'`。 |
| constructorAlias | Y | 插件预构造函数名，只需填写符合函数命名规则名称即可，无其它特殊含义 |

**示例：**

**C++**

```cpp
#include <string>
#include <aki/jsbind.h>

JSBIND_ADDON(hello-world, HelloWorld)
```

**JavaScript**

```typescript
import addon from 'libhello-world.so' // 插件名为：hello-world
```

### 绑定全局函数

#### JSBIND_GLOBAL

用于圈定需要绑定的全局函数 scope。

#### JSBIND_FUNCTION(func, alias)

在 `JSBIND_GLOBAL` 作用域下使用 `JSBIND_FUNCTION` 绑定 C++ 全局函数后，可从 JavaScript 直接调用。调度线程为 JS 线程。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| func | 函数指针 | Y | 被绑定的 C++ 函数指针，当 alias 未被指定时，JavaScript 与 C++ 函数名相同。 |
| alias | string | N | 函数别名 |

**示例：**

**C++**

```cpp
#include <string>
#include <aki/jsbind.h>

std::string SayHello(std::string msg)
{
   return msg + " too.";
}

JSBIND_GLOBAL()
{
   JSBIND_FUNCTION(SayHello);
}

JSBIND_ADDON(hello);
```

**JavaScript**

```typescript
import aki from 'libhello.so' // 插件名

let message = aki.SayHello("hello world");
```

#### JSBIND_PFUNCTION(func, alias)

使用 `JSBIND_PFUNCTION` 绑定 C++ 全局函数后，从 JavaScript 使用同 Promise 方式相同的异步调用。调度线程为工作线程，由 ArkCompiler Runtime 决定。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| func | 函数指针 | Y | 被绑定的 C++ 函数指针。 |
| alias | string | N | 函数别名 |

**示例：**

**C++**

```cpp
int AsyncTaskReturnInt() {
   // Do something;
   return -1;
}

JSBIND_GLOBAL() {
   JSBIND_PFUNCTION(AsyncTaskReturnInt);
}

JSBIND_ADDON(async_tasks);
```

**JavaScript**

```typescript
import libAddon from 'libasync_tasks.so'

libAddon.AsyncTaskReturnInt().then(res => {
 console.log('[AKI] AsyncTaskReturnInt: ' + res)
});
```

### 绑定类/结构体

AKI 提供 `JSBIND_CLASS` 对 C++ 类/结构体进行绑定，在 `JSBIND_CLASS` 作用域下可绑定：类构造函数、类成员函数、类成员属性的类特性。

#### JSBIND_CLASS(class)

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| class | class/struct | Y | 被绑定的 C++ 类对象/结构体，JavaScript 与 C++ 类名相同。 |

#### 类构造函数

在 `JSBIND_CLASS` 作用域下使用绑定 C++ 类/结构体构造函数，其中为了支持多态，可通过类型模板指定构造函数参数类型。`JSBIND_CONSTRUCTOR` 需要在 `JSBIND_CLASS` 的作用域下。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| T | any | N | 构造函数参数类型，可变类型参数。 |

**示例：**

**C++**

```cpp
#include <string>
#include <aki/jsbind.h>

class TestObject {
public:
   TestObject();
   
   explicit TestObject(double) {
       // ...
   }
   
   ~TestObject() = default;
} // TestObject

JSBIND_CLASS(TestObject)
{
   JSBIND_CONSTRUCTOR<>();
   JSBIND_CONSTRUCTOR<double>();
}
JSBIND_ADDON(hello);
```

**JavaScript**

```typescript
import aki from 'libhello.so' // 插件名

var obj1 = new aki.TestObject();
var obj2 = new aki.TestObject(3.14);
```

## 混合开发

AKI 支持与 Node-API 混合开发。接口 `aki::JSBind::BindSymbols` 用于绑定使用 AKI 的 Native 符号表给指定的 napi_value 对象。

如下示例：`examples/ohos/4_hybrid_napi/entry/src/main/hello.cpp`

```cpp
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
   napi_property_descriptor desc[] = {
       ...
   };
   napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
   
   exports = aki::JSBind::BindSymbols(env, exports); // aki::JSBind::BindSymbols 函数传入 js 对象绑定符号
   return exports;
}
EXTERN_C_END
```

## Benchmark

IDE：DevEco Studio NEXT Developer Beta6 5.0.3.706
SDK：Command Line Tools 5.0.3.706

API 接口压测，当前采用了 OHOS 上单元测试框架的数据驱动能力，详见 benchmark。

| API | 调用次数 | AKI (ms) | Node-API (ms) |
| :--- | :--- | :--- | :--- |
| bool (*)() | 10000 | 0.0032 | 0.0031 |
| string (*)(string) | 10000 | 0.0058 | 0.0057 |
| void (*)( std::function ) | 10000 | 0.0667 | 0.0176 |
| void (*)( aki::Callback ) | 10000 | 0.0178 | - |
| void (*)( aki::SafetyCallback ) | 10000 | 0.0664 | - |

## 如何反馈

- issue

## 如何贡献

- 贡献代码

## 更新记录

### 1.2.25 (2025-12-08)

- fixed
  - Fix the memory leak issue in callMethod
  - Fix security compilation issues

### 1.2.24 (2025-11-19)

- fixed
  - pulish release version 1.2.24

### 1.2.24-rc.0 (2025-11-11)

- fixed
  - Fix the issue of crash by smart point.
  - Add Debug infomation.

### 1.2.23 (2025-10-14)

- fixed
  - Solve the memory leak of aki::Value by refactoring the copy constructor.
  - Add support for uint32 and uint64 types.

### 1.2.22 (2025-10-11)

- fixed
  - Resolve the memory leak caused by introducing ref in aki::Value.

### 1.2.21 (2025-10-04)

- fixed
  - Adding new debugging capabilities.
  - Complete variable validity checks.

### 1.2.21-rc.0 (2025-09-04)

- fixed
  - Add return value check for napi_open_escapable_handle_scope interface.
  - Add test details.

### 1.2.20 (2025-06-17)

- fixed
  - Fix the issue in aki::value where napi_value objects may be used outside their scope, causing a UAF (Use-After-Free) vulnerability.

### 1.2.19 (2025-06-09)

- fixed
  - Fix the issue of abnormal map element access in release mode

### 1.2.18 (2025-05-26)

- fixed
  - Fix the issue where managing user return values through scope causes null pointer exceptions when users utilize the return values.
  - Fix the null pointer exception caused by data type checks during map operations.

### 1.2.17 (2025-05-14)

- fixed
  - pulish release version 1.2.17

### 1.2.17-rc.0 (2025-04-24)

- fixed
  - Fix the issue of unmanaged object lifecycle for objects passed back to JS in callback functions.

### 1.2.16 (2025-03-25)

- fixed
  - Update the repository URLs: Replace all gitee links with gitcode.

### 1.2.15 (2024-12-30)

- fixed
  - 修改 worker 场景多次新建 worker 且绑定同一 JS 函数，运行逻辑调用该绑定的函数时，会 crash 问题
  - 删除 Callback 中通过 napi_handle_scope 管理 napi value 生命周期不合理的逻辑
  - 修改部分文件缺少版权许可信息的问题
  - 修改个别单词拼写错误的问题
  - 添加多线程场景测试 demo

### 1.2.14 (2024-9-13)

- fixed
  - 修复 NapiPMethodBinder/NapiPFunctionBinder 有返回值时导致内存泄露的问题
  - 优化 CMakeLists.txt 脚本，在源码依赖编译 release 版本的时候，限制 -s 的扩散范围，保持只在 aki 中生效

### 1.2.13 (2024-8-16)

- fixed
  - 修复线程安全函数内存泄露的问题

### 1.2.12 (2024-8-5)

- feat
  - 新增支持主线程下同一个 so 只加载一次的能力
  - 新增接口：`napi_value aki::JSBind::BindSymbols(napi_env env, napi_value exports, std::string moduleName);`
- fixed
  - 修复多线程同时操作一个全局变量导致线程 crash、崩溃栈指向 BindSymbols 的问题
  - 修复 uint32 类型导致部分应用无法使用的问题
- deprecated
  - 废弃接口：以下接口在部分场景中使用会导致应用 crash，因此将其废弃
    - `uint32_t aki::value::GetUInt()`
    - `uint64_t aki::value::GetUInt64()`

### 1.2.12-rc0 (2024-7-30)

- fixed
  - 修复多线程同时操作一个全局变量导致线程 crash 的问题
  - 修复 uint32 类型导致部分应用无法使用的问题

### 1.2.11 (2024-7-21)

- fixed
  - 更新 SDK(ohos_sdk_public 5.0.0.25)

### 1.2.10 (2024-7-17)

- fixed
  - 修复 BindSymbols 函数在部分场景只初始化一次的问题

### 1.2.9 (2024-6-29)

- fixed
  - 修复 invokeAsync 接口内存泄漏问题
  - 修复 napi_call_function 的返回值为 Array 时，对象内容为空的问题
- feat
  - 新增支持绑定 std::optional 类型
  - 优化主线程 BindSymbols 被反复加载问题
  - 新增 AsyncWorker 类

### 1.2.8 (2024-5-28)

- fixed
  - invoke 回调 JS 函数时，当函数入参为 function 时，存在内存泄漏，function 的参数无法析构
- feat
  - aki::Promise 类新增 Reject 接口
  - aki::Value 类支持创建数组
  - aki 支持在 napi_call_function 后，进行 napi_is_exception_pending 的异常判断，如果存在异常，则打印异常信息
  - 绑定类时支持类继承的特性
  - 支持枚举类的绑定
  - 支持 JS 的 null 和 C++ 的空指针自动转化
  - 支持 JS 层的 Map, HashMap, HashSet 映射 C++ 层的 Map, HashMap, HashSet
  - aki 兼容 C++11

### 1.2.8-rc.0 (2024-5-5)

- feat
  - 支持在 napi_call_function 后做 pending exception 判断

### 1.2.6 (2024-1-27)

- feat
  - value 支持 uint32_t、uint64_t
  - invoke 支持异步调用

### 1.2.5 (2023-12-12)

- fixed
  - 修复 enum 重定义问题
  - 修复 debug 模式，非线程下触发 aki::Value 默认构造 crash 问题
  - 修复 safety_callback 因生命周期管理 crash 问题
  - 修复部分编译告警问题
  - 修复 worker 场景下，多线程覆盖问题
- feat
  - 支持 aki::Value::IsObject
  - 支持 aki::Value 数组赋值

### 1.2.3 (2023-09-20)

- fixed
  - 修复异步接口 napi_value 生命周期未被 GC 托管

### 1.2.2 (2023-09-10)

- fixed
  - 修复 ArrayBuffer 在工作线程支持

### 1.2.0 (2023-08-20)

- feat
  - 支持 JS 类型 any 映射 C++ 类型 aki::Value

### 1.1.1 (2023-08-15)

- fixed
  - 修复 JSBIND_ENUM 找不到头文件问题

### 1.1.0 (2023-08-10)

- feat
  - 支持 uint8_t/int8_t/uint16_t/int16_t 转为 number
  - 支持传递对象引用
- fixed
  - 修复 callback 在 C++ 侧时，带返回值类型；
- deprecated
  - C++侧对于 std::vector 不再被解析成 JS 侧的 Uint8Array。即 std::vector 类型全部视为数组，如需使用 TypedArray，请使用 C++ 的 aki::ArrayBuffer 类型进行映射
- example
  - 3_callback 增加示例：callback 实现在 cpp 侧，并支持 callback 带返回值
  - 6_structure 更新 JSBIND_PROPERTY 用例 + 对象指针用例
  - 14_reference_and_pointer 对象引用用例
- docs
  - README.md 文档更新

### 1.0.8 (2023-07-27)

- docs
  - README.md 文档更新
- fixed
  - 修复 JSBind 绑定 std::vector 类型必现编译出错；
- example
  - 新增 arrar_to_native 数组用例

### 1.0.7 (2023-07-24)

- feat
  - 支持 JSBIND_PROPERTY，无需定义 Get/Set 函数，即可绑定类成员属性

### 1.0.6 (2023-07-16)

- feat
  - 支持传参 napi_value 类型
- fixed
  - README.md 锚点跳转

### 1.0.5 (2023-07-11)

### 1.0.4 (2023-07-10)

- fixed
  - JSBIND_PFUNCTION 绑定返回值为 void 类型函数编译报错

### 1.0.3 (2023-07-09)

- feat
  - 支持类型转换：map<std::string, T> <---> object；
- fixed
  - JSBIND_PFUNCTION 绑定返回值为 long 类型编译错误

### 1.0.2 (2023-07-06)

- feat
  - 新增枚举类型绑定特性；

### 1.0.1 (2023-07-05)

- fixed
  - 修复 PMETHOD 宏绑定异步接口返回值为类对象时编译报错；

### 1.0.0 (2023-06-29)

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

- 不涉及

### SDK 合规使用指南

- 不涉及

### 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |

### 应用类型

- 应用

### 元服务

- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.0

## 安装方式

```bash
ohpm install @ohos/aki
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/67aee12f72c84d51b4ffc447eb9c8593/PLATFORM?origin=template