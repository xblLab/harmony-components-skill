# 个人信息编辑组件

## 简介

本组件支持编辑个人信息，包括姓名、性别、手机号、生日等，以及支持查看用户协议。

## 详细介绍

### 简介

本组件支持编辑个人信息，包括姓名、性别、手机号、生日等，以及支持查看用户协议。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

#### 权限

无

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `profile_edit` 模块。
   ```json5
   // 项目根目录下 build-profile.json5 填写 profile_edit 路径。其中 XXX 为组件存放的目录名
   "modules": [
     {
       "name": "profile_edit",
       "srcPath": "./XXX/profile_edit"
     }
   ]
   ```
3. 在项目根目录 `oh-package.json5` 添加依赖。
   ```json5
   // XXX 为组件存放的目录名称
   "dependencies": {
     "profile_edit": "file:./XXX/profile_edit"
   }
   ```

引入组件。
```typescript
import { EditPersonalInfo } from 'profile_edit';
```

调用组件，详细参数配置说明参见 API 参考。

（可选）智能填充服务，需要申请接入智能填充服务。

## API 参考

### 接口

`EditPersonalInfo(option?: EditPersonalInfoOptions)`

个人信息编辑组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | EditPersonalInfoOptions | 否 | 个人信息编辑组件的参数。 |

#### EditPersonalInfoOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| btnLabel | ResourceStr | 否 | 按钮文本 |
| themeColor | ResourceColor | 否 | 主题色 |
| isNeedAgreePrivacy | boolean | 否 | 是否需要同意隐私政策 |
| confirm(value: PersonalInfo) => void | Function | 否 | 确认事件回调 |
| close() => void | Function | 否 | 取消事件回调 |

#### PersonalInfo 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| name | string | 姓名 |
| gender | string | 性别 |
| mobile | string | 手机号码 |
| birth | number | 生日 |

### 示例代码

```typescript
import { EditPersonalInfo, PersonalInfo } from 'profile_edit';

@Entry
@ComponentV2
struct Sample1 {
  @Local showSheet: boolean = false;

  build() {
    NavDestination() {
      Column() {
        Button('编辑个人信息')
          .onClick(() => {
            this.showSheet = true;
          })
          .bindSheet($$this.showSheet, this.fillInfoSheet(), {
            showClose: false,
            backgroundColor: $r('sys.color.background_secondary'),
            height: 560,
          })
      }
    }
    .hideTitleBar(true)
    .padding(16)
  }

  @Builder
  fillInfoSheet() {
    Column() {
      EditPersonalInfo({
        btnLabel: '确定',
        themeColor: $r('sys.color.brand'),
        confirm: (value: PersonalInfo) => {
          this.getUIContext().getPromptAction().showToast({ message: '提交成功' });
          this.showSheet = false;
        },
        close: () => {
          this.showSheet = false;
        },
      })
    }
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 | 下载 |
| :--- | :--- | :--- | :--- |
| 1.0.1 | 2026-01-14 | 接入智能填充服务，一多适配 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/profile_edit1.0.1.zip) |
| 1.0.0 | 2025-11-03 | 初始版本 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/profile_edit1.0.1.zip) |

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/e8a2585fa1f94d29825b2422d2cd2d76/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E7%BC%96%E8%BE%91%E7%BB%84%E4%BB%B6/profile_edit1.0.1.zip