# 应用密码设置组件

## 简介

本组件提供了密码设置功能，密码已进行持久化存储。

## 详细介绍

### 简介

本组件提供了密码设置功能，密码已进行持久化存储。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 6.0.0(20) 及以上

#### 权限

无

#### 使用

**安装组件**

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `secretlock` 模块。

```json5
// build-profile.json5
"modules": [
   {
      "name": "secretlock",
      "srcPath": "./XXX/secretlock"
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 填写 secretlock 路径。其中 XXX 为组件存放的目录名
"dependencies": {
   "secretlock": "./XXX/secretlock"
}
```

**引入组件**

```typescript
import { SecretLock, SecretLockSwitch } from 'secretlock';
```

**调用组件**

详细参数配置说明参见 API 参考。

```typescript
SecretLockSwitch({
  appPathStack: this.appPathStack
});
```

可以在应用入口处调用，关闭进程重新进入应用后会跳转到密码绘制页面。

```typescript
@Local secretLock: SecretLock = PersistenceV2.connect(SecretLock, () => new SecretLock())!;

aboutToAppear(): void {
 if (this.secretLock.gesture) {
   const params: Record<string, boolean | NavPathStack> = { 'fromEntrance': true, 'appPathStack': this.appPathStack };
   this.appPathStack.pushPathByName('DrawLock', params);
 }
}
```

### API 参考

#### 子组件

无

#### 接口

`SecretLockSwitch(appPathStack: NavPathStack)`

应用密码设置组件。

#### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| appPathStack | NavPathStack | 是 | 页面路由栈 |

#### 示例代码

**权限配置**

已在 `module.json5` 中添加如下权限：

```json5
"requestPermissions": [
   {
     "name": "ohos.permission.ACCESS_BIOMETRIC" //允许应用使用生物特征识别能力进行身份认证。
   }
 ]
```

**Index.ets**

```typescript
import { SecretLock, SecretLockSwitch } from 'secretlock';
import { PersistenceV2 } from '@kit.ArkUI';

@Entry
@ComponentV2
export struct Index {
   @Provider('appPathStack') appPathStack: NavPathStack = new NavPathStack();

   @Local secretLock: SecretLock = PersistenceV2.connect(SecretLock, () => new SecretLock())!;

   aboutToAppear(): void {
      if (this.secretLock.gesture) {
        const params: Record<string, Object> = { 'fromEntrance': true, 'appPathStack': this.appPathStack };
        this.appPathStack.pushPathByName('DrawLock', params);
      }
   }

   build() {
      Navigation(this.appPathStack){
         Column(){
            SecretLockSwitch({
               appPathStack: this.appPathStack
            })
         }
         .width('100%')
         .height('100%')
         .padding({left: 16, right: 16})
      }
      .hideTitleBar(true)
      .mode(NavigationMode.Stack)
      .backgroundColor('#F1F3F5')
   }
}
```

## 更新记录

| 版本 | 日期 | 描述 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.3 | 2025-12-29 | 修改 ReadMe | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%94%E7%94%A8%E5%AF%86%E7%A0%81%E8%AE%BE%E7%BD%AE%E7%BB%84%E4%BB%B6/secretlock1.0.3.zip) |
| 1.0.2 | 2025-11-07 | 修改 ReadMe | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%94%E7%94%A8%E5%AF%86%E7%A0%81%E8%AE%BE%E7%BD%AE%E7%BB%84%E4%BB%B6/secretlock1.0.3.zip) |
| 1.0.1 | 2025-08-29 | 背景色修改，适配深色模式左右边距修改，由组件控制变更为外部页面控制 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%94%E7%94%A8%E5%AF%86%E7%A0%81%E8%AE%BE%E7%BD%AE%E7%BB%84%E4%BB%B6/secretlock1.0.3.zip) |
| 1.0.0 | 2025-07-04 | 本组件提供了密码设置功能，密码已进行持久化存储。 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%94%E7%94%A8%E5%AF%86%E7%A0%81%E8%AE%BE%E7%BD%AE%E7%BB%84%E4%BB%B6/secretlock1.0.3.zip) |

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 6.0.0 <br> 6.0.1 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEco Studio 版本** | DevEco Studio 6.0.0 <br> DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1f6a460f6806457c8d631f5e07f599d7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BA%94%E7%94%A8%E5%AF%86%E7%A0%81%E8%AE%BE%E7%BD%AE%E7%BB%84%E4%BB%B6/secretlock1.0.3.zip