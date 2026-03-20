# 级联选择器 UICascader

## 简介

UICascader 是基于 open harmony 基础组件开发的级联选择器组件，支持多级选择、传入所选项回显等功能。

## 详细介绍

### 简介

UICascader 是基于 open harmony 基础组件开发的级联选择器组件，支持多级选择、传入所选项回显等功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 使用

**安装组件。**

```bash
ohpm install @hw-agconnect/ui-cascader
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-cascader@1.0.0
```

**引入组件。**

```typescript
import { UICascader, CascaderController, TreeNode } from '@hw-agconnect/ui-cascader';
```

**调用组件，详细参数配置说明参见 API 参考。**

```typescript
UICascader({
   controller: this.cascaderController,
   localData: this.localData,
   selectedValue: this.selectValue,
})
```

## API 参考

### 子组件

无

### 接口

`UICascader(options: UICascaderOptions)`
级联选择器组件。

#### UICascaderOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UICascaderOptions | 是 | 配置级联选择器组件的参数。 |
| controller | CascaderController | 是 | 级联选择器绑定控制器。 |
| selectedValue | `(string \| number)[]` | 是 | 所选项的值，初始传入值则按数组第 0 项开始匹配，若第 n 项匹配不上，取前 n-1 项数据。 |
| localData | `TreeNode[]` | 是 | 可选项数据。 |
| clearIcon | `boolean` | 否 | 是否显示清除按钮，默认为 true。 |
| popupTitle | `ResourceStr` | 否 | 弹窗标题，默认为“请选择”。 |
| placeholder | `ResourceStr` | 否 | 输入框提示，默认为“请选择”。 |
| tabFontSize | `string \| number \| Resource` | 否 | tab 栏字体大小。 |
| pickerFontSize | `string \| number \| Resource` | 否 | 选项字体大小。 |
| themeColor | `ResourceColor` | 否 | 主题色。 |
| dialogHeight | `Length \| SheetSize` | 否 | 弹出窗口高度，默认为 SheetSize.MEDIUM，最大高度为 SheetSize.LARGE，距离信号栏 8vp，高度设置超出按最大高度生效。 |
| onChange | `(selectValue: Array<string \| number>) => void` | 否 | 选择全部完成后触发。 |
| onNodeClick | `(node: TreeNode) => void` | 否 | 选择单项后触发。 |
| onPopupOpened | `() => void` | 否 | 弹窗打开时触发。 |
| onPopupClosed | `callback: () => void` | 否 | 弹窗关闭时触发。 |

#### TreeNode 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| text | `string` | 是 | 可选项文字描述。 |
| value | `string \| number` | 是 | 可选项值。 |
| disable | `boolean` | 否 | 是否禁用该选项。 |
| children | `TreeNode[]` | 否 | 子选项列表。 |
| parentVal | `string \| number` | 否 | 父节点值。 |
| isEnd | `boolean` | 否 | 是否为结束节点。 |

#### SheetSize 对象说明

| 名称 | 参数描述 |
| :--- | :--- |
| MEDIUM | 指定半模态高度为屏幕高度一半。<br>元服务 API：从 API version 11 开始，该接口支持在元服务中使用。 |
| LARGE | 指定半模态高度几乎为屏幕高度。<br>元服务 API：从 API version 11 开始，该接口支持在元服务中使用。 |
| FIT_CONTENT | 指定半模态高度为适应内容的高度。<br>元服务 API：从 API version 12 开始，该接口支持在元服务中使用。 |

#### CascaderController 对象说明

| 方法 | 说明 |
| :--- | :--- |
| show | 打开弹窗 |
| hide | 关闭弹窗 |
| clear | 清除选择 |

## 示例代码

### 示例 1

```typescript
import { UICascader, CascaderController, TreeNode } from '@hw-agconnect/ui-cascader';

@Entry
@ComponentV2
struct CascaderDemo {
  @Local selectValue: string[] | number[] = [] // 所选择数据
  @Local clearIcon: boolean = true // 是否显示清除按钮
  @Local themeColor: ResourceColor = Color.Blue // 主题色
  // 可选项数据
  @Local localData: TreeNode[] = [{
    text: '一年级',
    value: '1-0',
    children: [{
      text: '1.1 班',
      value: '1-1',
      children: [
        {
          text: '1.1 班 1 组',
          value: '1-1-1',
          children: [
            {
              text: '1 大组',
              value: '1-1-1-1',
              children: [
                {
                  text: '1 中组',
                  value: '1-1-1-1-1',
                  children: [
                    {
                      text: '1 小组',
                      value: '1-11',
                      children: [
                        {
                          text: '1 大队',
                          value: '1-12',
                        },
                      ],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    }, {
      text: '1.2 班',
      value: '1-2',
    }],
  },
    {
      text: '二年级',
      value: '2-0',
      children: [{
        text: '2.1 班',
        value: '2-1',
      },
        {
          text: '2.2 班',
          value: '2-2',
        }],
    },
    {
      text: '三年级',
      value: '3-0',
      disable: true,
    }, {
      text: '四年级',
      value: '4-0',
      disable: true,
    }, {
      text: '五年级',
      value: '5-0',
      disable: true,
    }, {
      text: '六年级',
      value: '6-0',
      disable: true,
    }, {
      text: '七年级',
      value: '7-0',
      disable: true,
    }, {
      text: '八年级',
      value: '8-0',
      disable: true,
    }, {
      text: '九年级',
      value: '9-0',
      disable: true,
    }, {
      text: '十年级',
      value: '10-0',
      disable: true,
    }, {
      text: '十一年级',
      value: '11-0',
      disable: true,
    }, {
      text: '十二年级',
      value: '12-0',
      disable: true,
    }, {
      text: '十三年级',
      value: '13-0',
      disable: true,
    }, {
      text: '十四年级',
      value: '14-0',
      disable: true,
    }, {
      text: '十五年级',
      value: '15-0',
      disable: true,
    }, {
      text: '十六年级',
      value: '16-0',
      disable: true,
    }, {
      text: '十七年级',
      value: '17-0',
      disable: true,
    }, {
      text: '十八年级',
      value: '18-0',
      disable: true,
    }, {
      text: '十九年级',
      value: '19-0',
      disable: true,
    }]
  private cascaderController: CascaderController = new CascaderController()

  build() {
    Column() {
      Column() {
        Row() {
          Button('清空选择数据').onClick(() => {
            if (this.cascaderController !== null) {
              this.cascaderController.clear()
            }
          })
          Button('打开弹窗').onClick(() => {
            if (this.cascaderController !== null) {
              this.cascaderController.show()
            }
          })
          Button('关闭弹窗').onClick(() => {
            if (this.cascaderController !== null) {
              this.cascaderController.hide()
            }
          })
        }.height(40).justifyContent(FlexAlign.SpaceBetween)

        UICascader({
          controller: this.cascaderController,
          localData: this.localData,
          selectedValue: this.selectValue,
          clearIcon: this.clearIcon,
          // 选择全部完成的回调，selectValue 为选择的选项
          onChange: (selectValue: (string | number)[]) => {

          },
          // 节点被点击时的回调，node 为点击的节点数据
          onNodeClick: (node: TreeNode) => {

          },
          // 弹窗打开时的回调
          onPopupOpened: () => {

          },
          // 弹窗关闭时的回调
          onPopupClosed: () => {

          },
        });
      }
    }
  }
}
```

## 更新记录

- **2.0.1 (2025-12-12)**
  - 下载该版本
  - 内部资源更新：修复 onChange 事件返回值异常的问题。
- **2.0.0 (2025-10-21)**
  - 下载该版本
  - 从 2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.0 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。
- **1.0.0 (2025-09-30)**
  - 下载该版本
  - 初始版本

## 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 <br> 5.0.1 <br> 5.0.2 <br> 5.0.3 <br> 5.0.4 <br> 5.0.5 <br> 5.1.0 <br> 5.1.1 <br> 6.0.0 <br> 6.0.1 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 <br> DevEco Studio 5.0.1 <br> DevEco Studio 5.0.2 <br> DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 <br> DevEco Studio 6.0.0 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-cascader
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3c0c8b42d9344a819a21c2b1e5d80f4e/2adce9bbd4cb42d58a87e6add45594b3?origin=template