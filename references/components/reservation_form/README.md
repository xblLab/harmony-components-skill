# 预约表单组件

## 简介

本组件支持填写预约表单信息，包括预约时间、预约联系人等。

## 详细介绍

### 简介

本组件支持填写预约表单信息，包括预约时间、预约联系人等。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.3 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.3 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

### 快速入门

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 reservation_form 模块。

```json5
// 项目根目录下 build-profile.json5 填写 reservation_form 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "reservation_form",
    "srcPath": "./XXX/reservation_form"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "reservation_form": "file:./XXX/reservation_form"
}
```

引入组件。

```typescript
import { ReservationForm } from 'reservation_form';
```

调用组件，详细参数配置说明参见 API 参考。

### API 参考

#### 接口

`ReservationForm(option?: ReservationFormOptions)`

预约管理卡片组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | ReservationFormOptions | 否 | 配置预约管理卡片组件的参数。 |

#### ReservationFormOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| projectName | string | 否 | 预约项目名称 |
| themeColor | string | 否 | 主题色，十六进制，带# |
| btnLabel | ResourceStr | 否 | 提交按钮文字 |
| isSubmitLoading | boolean | 否 | 提交按钮 loading 防暴力点击 |
| submitForm | `(formData: IFormData) => void` | 否 | 提交表单事件回调 |

#### IFormData 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| name | string | 联系人姓名 |
| phone | string | 联系人手机号 |
| reserveTime | string | 预约时间，时间戳类型 |
| remarks | string | 预约备注 |
| number | string | 预约人数 |

### 示例代码

```typescript
import { ReservationForm, IFormData } from 'reservation_form';

@Entry
@ComponentV2
struct Sample1 {
  @Local isSubmitLoading: boolean = false;

  build() {
    NavDestination() {
      Column() {
        ReservationForm({
          projectName: '猫眼美甲',
          btnLabel: '立即预约',
          isSubmitLoading: this.isSubmitLoading,
          submitForm: (formData: IFormData) => {
            console.log('form data: ' + JSON.stringify(formData));
            this.isSubmitLoading = true;
            setTimeout(() => {
              this.isSubmitLoading = false;
              this.getUIContext().getPromptAction().showToast({ message: '提交成功' });
            }, 200);
          },
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .title('预约', { backgroundColor: Color.White })
  }
}
```

### 更新记录

- **1.0.0 (2025-11-03)**
  - 下载该版本
  - 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3 <br> 5.0.4 <br> 5.0.5 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7d98335121d34ab9ac16222e95ad81b7/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%A2%84%E7%BA%A6%E8%A1%A8%E5%8D%95%E7%BB%84%E4%BB%B6/reservation_form1.0.0.zip