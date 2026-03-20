# 常用人管理组件

## 简介

本组件提供了常用人新增、编辑、删除及以常用人单个选择、多个选择的能力。

## 详细介绍

### 简介

本组件提供了常用人新增、编辑、删除及以常用人单个选择、多个选择的能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_person_manage` 模块。
   ```json5
   // 在项目根目录 build-profile.json5 填写 module_person_manage 路径。其中 XXX 为组件存放的目录名
   "modules": [
       {
           "name": "module_person_manage",
           "srcPath": "./XXX/module_person_manage",
       }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 中添加依赖。
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "module_person_manage": "file:./XXX/module_person_manage"
   }
   ```

#### 引入组件

```typescript
import { PersonManage, SelectMode, Contact } from 'module_person_manage';
```

## API 参考

### 子组件

可以包含单个子组件。

### 接口

**PersonManage(options?: PersonManageOptions)**

常用人管理组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | PersonManageOptions | 否 | 配置常用人管理组件的参数。 |

**PersonManageOptions 对象说明：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| navPathStack | NavPathStack | 否 | Navigation 路由栈实例 |
| selectMode | SelectMode | 否 | 选择模式 |
| onSelect | `(data: Contact \| Contact[]) => void` | 否 | 选择常用人后的回调 |
| onBeforeNavigate | `() => boolean` | 否 | 页面跳转前的回调，返回 false 将取消跳转 |
| disableId | `string[]` | 否 | personID 数组，禁用多选模式下的常用人。personID 详见 Contact 属性说明。 |

### SelectMode 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| NO_SELECT | 可编辑删除，无法选择 |
| SINGLE_SELECT | 单选 |
| MORE_SELECT | 多选 |

### Contact

表示常用人数据的结构体，用于页面组件传入、组件内部管理，或作为网络接口的请求/响应格式。

| 字段名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| personID | string | 是 | 常用人唯一标识符 |
| cardType | string | 是 | 证件类型 |
| name | string | 是 | 姓名 |
| phone | string | 是 | 电话号码 |
| cardID | string | 是 | 证件号码 |

## 示例代码

```typescript
import { PersonManage, Contact, SelectMode } from 'module_person_manage';

@Entry
@ComponentV2
struct Index {
  private navPathStack: NavPathStack = new NavPathStack();

  public build(): void {
     Navigation(this.navPathStack) {
     Column() {
        PersonManage({
           navPathStack: this.navPathStack,
           selectMode: SelectMode.MORE_SELECT,
           onSelect: (data: Contact | Contact[]) => {
              console.log('常用人', data);
           },
           onBeforeNavigate: () => {
              return true;
           },
        }) {
           Button('常用人管理');
        };
     }
     .width('100%')
     .height('100%')
     .justifyContent(FlexAlign.Center);
  }
     .hideTitleBar(true);
}
```

## 更新记录

- **1.0.1 (2025-10-31)**
  - 下载该版本
  - readme 优化
  - UX 规范问题修复
- **1.0.0 (2025-08-30)**
  - 下载该版本
  - 初始版本

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 兼容性

| 项目 | 支持版本 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6002c489fcb14494a25f205548112af7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%B8%B8%E7%94%A8%E4%BA%BA%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/module_person_manage1.0.1.zip