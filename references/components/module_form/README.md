# 表单组件

## 简介

本组件提供表单组件。

## 详细介绍

### 简介

本组件提供以表单形式录入信息的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

#### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 `module_form` 模块。

深色代码主题复制
```json5
// 项目根目录下 build-profile.json5 填写 module_form 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_form",
    "srcPath": "./XXX/module_form"
  }
]
```

c. 在项目根目录 `oh-package.json5` 添加依赖。

深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_form": "file:./XXX/module_form"
}
```

引入组件。

深色代码主题复制
```typescript
import { FormItem, FormType } from 'module_form';
```

配置华为账号服务。如需使用选择头像功能，将 Client ID 配置到 entry 模块下的 `src/main/module.json5` 文件，详细参考：配置签名和指纹和配置 Client ID。

如需使用选择地点功能，请开通地图服务。

调用组件，详细参数配置说明参见 API 参考。

### API 参考

#### 接口

**FormItem(option: FormItemOptions)**

表单组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | FormItemOptions | 是 | 配置表单组件的参数。 |

**FormItemOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| param | IFormItem | 是 | 表单单元基本参数 |
| value | ResourceStr | 否 | 文本值，支持双向绑定 |
| numberV | number | 否 | 数字值，支持双向绑定 |
| dateV | Date\|null | 否 | 日期值，支持双向绑定 |
| formContent | () => void | 否 | 自定义内容区 |

**IFormItem 类型说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| type | FormType | 是 | 表单类型 |
| label | string | 是 | 标签文本 |
| required | boolean | 否 | 是否必填项 |
| last | boolean | 否 | 是否末尾项 |
| inputType | InputType | 否 | 输入框类型 |

**FormType 枚举说明**

| 名称 | 说明 |
| :--- | :--- |
| INPUT | 基础输入框 |
| GENDER | 性别选择 |
| DATE | 日期选择 |
| AVATAR | 头像 |
| ADDRESS | 地点选择 |
| TEXT | 文本只读 |
| OTHER | 其他 |

### 示例代码

深色代码主题复制
```typescript
import { FormItem, FormType } from 'module_form'

@Entry
@ComponentV2
struct FormSample {
  @Local avatarUrl: string = '';
  @Local name: string = '';
  @Local gender: number = 0;
  @Local phone: string = '';
  @Local birthDate: Date | null = null;
  @Local addr: string = '';

  build() {
    NavDestination() {
      Column() {
        Column() {
          FormItem({
            param: {
              type: FormType.AVATAR,
              label: '头像',
            },
            value: this.avatarUrl!!,
          })
          FormItem({
            param: {
              type: FormType.INPUT,
              label: '昵称',
            },
            value: this.name!!,
          })
          FormItem({
            param: {
              type: FormType.GENDER,
              label: '性别',
            },
            numberV: this.gender!!,
          })
          FormItem({
            param: {
              type: FormType.INPUT,
              inputType: InputType.PhoneNumber,
              label: '手机号',
            },
            value: this.phone!!,
          })
          FormItem({
            param: {
              type: FormType.DATE,
              label: '生日',
            },
            dateV: this.birthDate!!,
          })

          FormItem({
            param: {
              type: FormType.ADDRESS,
              label: '所在地区',
              last: true,
            },
            value: this.addr!!,
          })
        }
        .padding(10)
        .backgroundColor(Color.White)
        .borderRadius(4)
      }
      .width('100%')
      .height('100%')
    }
    .title('表单组件')
    .backgroundColor('#F1F3F5')
  }
}
```

### 更新记录

| 版本 | 日期 | 备注 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.2 | 2026-01-21 | Created with Pixso. | 下载该版本 |
| 1.0.1 | 2025-10-31 | Created with Pixso. | 下载该版本废弃 API 整改 |
| 1.0.0 | 2025-08-29 | Created with Pixso. | 下载该版本优化 README |

### 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 类别 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 <br> Created with Pixso. |
| | 5.0.1 <br> Created with Pixso. |
| | 5.0.2 <br> Created with Pixso. |
| | 5.0.3 <br> Created with Pixso. |
| | 5.0.4 <br> Created with Pixso. |
| | 5.0.5 <br> Created with Pixso. |
| | 5.1.0 <br> Created with Pixso. |
| | 5.1.1 <br> Created with Pixso. |
| | 6.0.0 <br> Created with Pixso. |
| | 6.0.1 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| | 平板 <br> Created with Pixso. |
| | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 <br> Created with Pixso. |
| | DevEco Studio 5.0.1 <br> Created with Pixso. |
| | DevEco Studio 5.0.2 <br> Created with Pixso. |
| | DevEco Studio 5.0.3 <br> Created with Pixso. |
| | DevEco Studio 5.0.4 <br> Created with Pixso. |
| | DevEco Studio 5.0.5 <br> Created with Pixso. |
| | DevEco Studio 5.1.0 <br> Created with Pixso. |
| | DevEco Studio 5.1.1 <br> Created with Pixso. |
| | DevEco Studio 6.0.0 <br> Created with Pixso. |
| | DevEco Studio 6.0.1 <br> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/96d532267e364c7dae3686643e78227d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%A1%A8%E5%8D%95%E7%BB%84%E4%BB%B6/module_form1.0.2.zip