# 贷款信息表单提交组件

## 简介

本组件为贷款信息表单提交组件，可进行贷款所需的用户信息的收集包括姓名、身份证号、性别、银行卡的填写与拍照识别卡号等，可以通过回调拿到这些信息。用户姓名为使用组件时传入的值，不可编辑；当证件类型选择为身份证时，证件号码由使用组件时传入，不可编辑；当证件类型选择为护照时，证件号码可编辑。

## 详细介绍

### 简介

本组件为贷款信息表单提交组件，可进行贷款所需的用户信息的收集包括姓名、身份证号、性别、银行卡的填写与拍照识别卡号等，可以通过回调拿到这些信息。用户姓名为使用组件时传入的值，不可编辑；当证件类型选择为身份证时，证件号码由使用组件时传入，不可编辑；当证件类型选择为护照时，证件号码可编辑。

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 快速入门

1. **安装组件**
   - 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
   - 如果是从生态市场下载组件，请参考以下步骤安装组件。
     a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
     b. 在项目根目录 `build-profile.json5` 添加 `module_loan_form` 模块。
     
     ```json5
     // 项目根目录下 build-profile.json5 填写 module_loan_form 路径。其中 XXX 为组件存放的目录名
     "modules": [
       {
         "name": "module_loan_form",
         "srcPath": "./XXX/module_loan_form"
       }
     ]
     ```

     c. 在项目根目录 `oh-package.json5` 中添加依赖。
     
     ```json5
     // 在项目根目录 oh-package.json5 中添加依赖
     "dependencies": {
       "module_loan_form": "file:./XXX/module_loan_form",
     }
     ```

2. **引入组件和识别的结果数据类型**
   
   ```arkts
   import { LoanForm, LoanFormVM } from 'module_loan_form'
   ```

3. **调用组件**
   - 详见示例代码。详细参数配置说明参见 API 参考。
   
   ```arkts
   LoanForm()
   ```

## API 参考

### 接口

#### LoanForm(options: LoanFormOptions)

贷款信息表单组件。

##### LoanFormOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| idCardName | string | 是 | 外部需要传入的姓名 |
| idCardNumber | string | 是 | 外部需要传入的身份证号码 |
| maxLoanAmount | number | 否 | 当前可贷款的最大金额（用户填写的贷款金额超出此数值后会提示） |
| LoanFormCallBack | `(loanFormVMData: LoanFormVM) => void` | 是 | 身份证正反面识别信息结果的回调函数 |

#### LoanFormVM 数据说明

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| userRealName | string | 姓名 |
| idNumber | string | 身份证号码 |
| passPortNumber | string | 护照号 |
| bankAccountNumber | string | 银行卡号 |
| selectBankBrand | string | 收款银行 |
| marryType | string | 婚姻状况 |
| ensureType | string | 担保类型 |
| myLoanAmount | string | 用户申请金额 |
| loanTerms | string | 贷款期数 |
| repaymentMethod | string | 还款方式 |

## 示例代码

```arkts
import { LoanForm, LoanFormVM } from 'module_loan_form'

@Entry
@ComponentV2
struct Index {
  @Local myFormInfo: LoanFormVM | undefined = undefined
  build() {
    Column() {
      LoanForm({
        idCardName: '张三',
        idCardNumber: '412725185310105555',
        maxLoanAmount: 200000,
        LoanFormCallBack: (loanFormVMData: LoanFormVM) => {
          console.log('LoanFormCallBack', JSON.stringify(loanFormVMData))
          this.myFormInfo = loanFormVMData
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2026-01-06 | 下载该版本修复银行卡弹框内容展示不全问题 |
| 1.0.0 | 2025-12-15 | 下载该版本初始版本 |

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9974a069aa144bb7951cd9555460d12e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%B4%B7%E6%AC%BE%E4%BF%A1%E6%81%AF%E8%A1%A8%E5%8D%95%E6%8F%90%E4%BA%A4%E7%BB%84%E4%BB%B6/module_loan_form1.0.1.zip