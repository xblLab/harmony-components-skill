# 标签组件 UITag

## 简介

UITag 是基于 open harmony 基础组件开发的标签组件，用于展示不同类型的标签，点击可切换选中与否的不同状态。

## 详细介绍

### 简介

UITag 是基于 open harmony 基础组件开发的标签组件，用于展示不同类型的标签，点击可切换选中与否的不同状态。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-tag
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-tag@1.0.0
```

#### 引入组件

```typescript
import { UITag } from '@hw-agconnect/ui-tag';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UITag({
  customText: '标签',
  tagSize: TagSize.DEFAULT,
  options: [this.options],
  customBackgroundColor: 'emphasize',
  onClickEvent: () => {
    this.newClick()
  },
})
```

### API 参考

#### 子组件

无

#### 接口

`UITag(options: UITagOptions)`

标签组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UITagOptions | 否 | 配置标签组件的参数。 |

##### UITagOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| customText | ResourceStr | 否 | 标签内容，无默认值 |
| tagSize | TagSize | 否 | 标签尺寸，默认值 TagSize.DEFAULT |
| customBackgroundColor | string | 否 | 自定义背景色，默认值 $r('sys.color.ohos_id_color_emphasize') 推荐颜色参考 customBackgroundColor 推荐值 |
| enable | boolean | 否 | 是否启用标签，默认值 true |
| type | TagType | 否 | 标签类型，默认值 TagType.NORMAL |
| isCapsule | boolean | 否 | 是否为胶囊，默认值 false |
| customBorderColor | string | 否 | 自定义边框颜色，默认值$r('sys.color.ohos_id_color_emphasize') 推荐颜色参考 customBorderColor 推荐值 |
| customMargin | ResourceStr \| number | 否 | 自定义外边距，无默认值 |
| customMaxWidth | ResourceStr \| number | 否 | 自定义最大宽度，无默认值 |
| onClick | (callback: () => void) | 否 | 点击标签触发该事件 |

#### 枚举说明

##### TagSize 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| LARGE | 大尺寸 |
| DEFAULT | 正常尺寸 |
| SMALL | 小尺寸 |

##### TagType 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| NORMAL | 常规标签 |
| COLOR | 彩色标签 |
| BORDER | 边框标签 |

#### 推荐值

##### customBorderColor 推荐值

**推荐颜色**

```typescript
$r('sys.color.ohos_id_color_emphasize')
$r('sys.color.ohos_id_color_palette1')
$r('sys.color.ohos_id_color_palette2')
$r('sys.color.ohos_id_color_palette3')
$r('sys.color.ohos_id_color_palette4')
$r('sys.color.ohos_id_color_palette5')
$r('sys.color.ohos_id_color_palette6')
$r('sys.color.ohos_id_color_palette7')
$r('sys.color.ohos_id_color_palette8')
$r('sys.color.ohos_id_color_palette9')
$r('sys.color.ohos_id_color_palette10')
```

##### customBackgroundColor 推荐值

**推荐颜色**

```typescript
$r('sys.color.ohos_id_color_emphasize')
$r('sys.color.ohos_id_color_palette1')
$r('sys.color.ohos_id_color_palette2')
$r('sys.color.ohos_id_color_palette3')
$r('sys.color.ohos_id_color_palette4')
$r('sys.color.ohos_id_color_palette5')
$r('sys.color.ohos_id_color_palette6')
$r('sys.color.ohos_id_color_palette7')
$r('sys.color.ohos_id_color_palette8')
$r('sys.color.ohos_id_color_palette9')
$r('sys.color.ohos_id_color_palette_aux1)
$r('sys.color.ohos_id_color_palette_aux2')
$r('sys.color.ohos_id_color_palette_aux4')
$r('sys.color.ohos_id_color_palette_aux6')
$r('sys.color.ohos_id_color_palette_aux7')
$r('sys.color.ohos_id_color_palette_aux8')
$r('sys.color.ohos_id_color_palette_aux9')
```

### 示例代码

```typescript
import { UITag, TagSize, TagType } from '@hw-agconnect/ui-tag'

@Entry
@ComponentV2
struct TagSample {
  @Local type: number = TagType.NORMAL;

  newClick() {
    let typeArr = [TagType.NORMAL, TagType.COLOR, TagType.BORDER];
    let currentIndex = typeArr.indexOf(this.type);
    if (currentIndex !== -1) {
      this.type = typeArr[(currentIndex + 1) % typeArr.length];
    }
  }

  build() {
    Column() {
      Column() {
        Text('圆角样式')
        Row() {
          UITag({
            customText: '标签',
            tagSize: TagSize.SMALL,
          })
          UITag({
            customText: '标签',
          })
          UITag({
            customText: '标签',
            tagSize: TagSize.LARGE,
          })
        }

        Text('胶囊样式')
        Row() {
          UITag({
            isCapsule: true,
            customText: '标签',
            tagSize: TagSize.SMALL,
          })
          UITag({
            isCapsule: true,
            customText: '标签',
          })
          UITag({
            isCapsule: true,
            customText: '标签',
            tagSize: TagSize.LARGE,
          })
        }

        Text('自定义 margin：')
        Row() {
          UITag({
            customText: '标签',
            customMargin: '20',
          })
          UITag({
            customText: '标签',
            customMargin: '20',
          })
        }
      }

      Column() {
        Row() {
          Column() {
            Text('常规标签')
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
            })
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
              tagSize: TagSize.LARGE,
            })
          }

          Column() {
            Text('彩色标签')
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
              tagSize: TagSize.LARGE,
            })
          }

          Column() {
            Text('边框标签')
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
              tagSize: TagSize.LARGE,
            })
          }
        }
      }

      Column() {
        Text('点击事件')
        Row() {
          UITag({
            type: this.type,
            customText: '被点击',
            onClickEvent: () => {
              this.newClick()
            }
          })
        }
      }

      Text('标签文字过长展示：')
      Row() {
        UITag({
          customText: '默认最大宽度值测试默认啊',
        })
        UITag({
          customText: '自定义宽度',
          customMaxWidth:'50'
        })
      }

      Column() {
        Text('不可用状态')
        Row() {
          UITag({
            customText: '标签',
            enable: false,
          })
          UITag({
            customText: '标签',
            enable: false,
            type: TagType.COLOR,
          })
          UITag({
            customText: '标签',
            enable: false,
            type: TagType.BORDER,
          })
        }
      }
      Column() {
        Text('传入自定义边框颜色、自定义背景色')
        Row() {
          UITag({
            customText: '标签',
            type: TagType.BORDER,
            customBorderColor:Color.Brown
          })
          UITag({
            customText: '标签',
            type: TagType.COLOR,
            customBackgroundColor:Color.Gray
          })
        }
      }
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }
}
```

### 更新记录

#### 2.0.0 (2025-11-04)

下载该版本。从 2.0.*版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.X 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

#### 1.0.0 (2025-09-29)

下载该版本。初始版本。

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 兼容性

#### HarmonyOS 版本

- 5.0.0
- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5

#### 应用类型

- 应用
- 元服务

#### 设备类型

- 手机
- 平板
- PC

#### DevEco Studio 版本

- DevEco Studio 5.0.0
- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0

## 安装方式

```bash
ohpm install @hw-agconnect/ui-tag
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/013ca0cc3a1b45b48003f731a0064fc9/2adce9bbd4cb42d58a87e6add45594b3?origin=template