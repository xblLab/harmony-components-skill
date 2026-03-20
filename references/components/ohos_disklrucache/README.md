# disklrucache 磁盘缓存组件

## 简介

专门为 OpenHarmony 打造的一款磁盘缓存库，通过 LRU 算法进行磁盘数据存取。

本项目基于开源库 DiskLruCache 进行 OpenHarmony 的自研版本：

- 支持应用内存空间存储文件。
- 支持存储 ArrayBuffer 数据类型和 File 文件路径。
- 支持存储容量的动态设置。

## 安装方式

```bash
ohpm install @ohos/disklrucache
```

## 使用说明

### 步骤 1

在 `index.ets` 页面中导入：

```typescript
import { DiskLruCache } from '@ohos/disklrucache'
```

### 步骤 2

在 build 中声明对象：

```typescript
testDiskLruCache: DiskLruCache = undefined
```

在使用之前初始化对象，首先在 Ability 或者 Application 使用 `GlobalContext.getContext.setObject("context", this.context)` 注册 context。

```typescript
import Ability from '@ohos.application.Ability'

export default class MainAbility extends Ability {
    onCreate(want, launchParam) {
        GlobalContext.getContext.setObject("context", this.context)
    }
}
```

然后在页面中创建对象：

```typescript
// 使用应用缓存路径创建文件夹名称为 diskLruCache，设置磁盘缓存大小为 3M(可选参数，默认设置缓存大小为 300M，最大设置不能超过 300M)
this.testDiskLruCache = DiskLruCache.create(GlobalContext.getContext.getObject("context"), 3 * 1024 * 1024)
```

### 步骤 3

在 build 中添加按钮，将图片文件存入磁盘缓存。同步设置字符串缓存数据。

**同步设置字符串磁盘缓存数据：**

```typescript
let data: string = "Hello World Simple Example.";
this.testDiskLruCache.set('test', data);
```

**同步读取字符串磁盘缓存数据：**

```typescript
let data: ArrayBuffer = this.testDiskLruCache.get('test');
console.log(String.fromCharCode.apply(null, new Uint8Array(data)));
```

**同步设置文件磁盘缓存数据：**

```typescript
import fs from '@ohos.file.fs';

let path = '/data/storage/el2/base/com.example.disklrucache/entry/files/testFile.txt';
let fd = fs.openSync(path, 0o2);
let length = fs.statSync(path).size;
let data = new ArrayBuffer(length);
fs.readSync(fd, data);
this.testDiskLruCache.set('testFile', data);
```

**同步读取文件磁盘缓存数据：**

```typescript
let data: ArrayBuffer = this.testDiskLruCache.get('testFile');
```

**异步设置字符串磁盘缓存数据和异步获取字符串磁盘缓存数据：**

```typescript
let value: string = "Hello World Simple Example.";
this.testDiskLruCache.setAsync('test', value).then(() => {
    this.testDiskLruCache.getAsync('test').then((data) => {
        console.log(String.fromCharCode.apply(null, new Uint8Array(data)));
    })
}).catch((err) => {
    console.log('err =' + err);
})
```

**异步设置文件磁盘缓存数据和异步获取文件磁盘缓存数据：**

```typescript
import fs from '@ohos.file.fs';

let path = '/data/storage/el2/base/com.example.disklrucache/entry/files/testFile.txt';
let file = fs.openSync(path, 0o2);
let length = fs.statSync(path).size;
let value = new ArrayBuffer(length);
fs.readSync(file.fd, data);
this.testDiskLruCache.setAsync('test', value).then(() => {
    this.testDiskLruCache.getAsync('test').then((data) => {
        console.log(String.fromCharCode.apply(null, new Uint8Array(data)));
    })
}).catch((err) => {
    console.log('err =' + err);
})
```

### 步骤 4

更多细节设置请参考 `index.ets` 示例文件。

## 接口说明

| 方法名 | 入参 | 返回类型 | 描述 |
| :--- | :--- | :--- | :--- |
| `create` | `context`, `maxSize?: number` | `DiskLruCache` | 构造器创建对象，设置磁盘缓存路径，磁盘缓存大小 |
| `setMaxSize` | `max: number` | `void` | 重置磁盘缓存大小 |
| `set` | `key: string`, `content: ArrayBuffer \| string` | `void` | 磁盘缓存存入数据 |
| `setAsync` | `key: string`, `content: ArrayBuffer \| string` | `Promise` | 异步磁盘缓存存入数据 |
| `get` | `key: string` | `ArrayBuffer` | 磁盘缓存获取 ArrayBuffer |
| `getAsync` | `key: string` | `Promise` | 异步磁盘缓存获取 ArrayBuffer |
| `getFileToPath` | `key: string` | `string` | 磁盘缓存获取文件路径 |
| `getFileToPathAsync` | `key: string` | `Promise` | 异步磁盘缓存获取文件路径 |
| `getPath` | - | `string` | 获取缓存路径 |
| `deleteCacheDataByKey` | `key: string` | `DiskCacheEntry` | 删除当前缓存 key 对应的 DiskCacheEntry |
| `cleanCacheData` | - | - | 清除所有磁盘缓存数据 |

## 关于混淆

代码混淆，请查看代码混淆简介。如果希望 disklrucache 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/disklrucache
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release(5.0.0.66)
- DevEco Studio: 4.0(4.0.3.512), SDK: API10（4.0.10.9）
- DevEco Studio: 3.1 Beta2(3.1.0.400), SDK: API9 Release(3.2.11.9)

## 目录结构

```text
/disklrucache/src/
- main/ets/components
    - cache               # 缓存相关内容
       - CustomMap.ets       # 自定义 Map 封装
       - DiskCacheEntry.ets  # 磁盘缓存 entry
       - DiskLruCache.ets    # 磁盘 LRU 缓存策略
       - FileReader.ets      # 文件读取相关
       - FileUtils.ets       # 文件工具类       
/entry/src/
- main/ets     
    - pages               # 测试 page 页面列表
       - index.ets           # 测试磁盘缓存页面
```

## 贡献代码

使用过程中发现任何问题都可以提 issue，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

## 版本与兼容性

### 更新记录

- **2.0.3** (2025-09-16)

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| **应用类型** | 应用 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3 |
| **兼容性** | HarmonyOS 版本 5.0.0 |

### 权限与隐私

| 项目 | 说明 |
| :--- | :--- |
| **权限** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/86ce7f8ad12f489e88f6363759d3d1a9/PLATFORM?origin=template