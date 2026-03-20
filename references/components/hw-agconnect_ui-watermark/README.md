# 水印组件 UIWaterMark

## 简介

UIWaterMark 是基于 open harmony 开发的水印组件。支持添加文字水印，调整文字大小和颜色。支持添加本地/网络图片水印，调整图片大小。支持自定义水印的通用透明度、间距以及旋转角度。可通过设置触碰类型，是否拦截点击事件。

## 详细介绍

### 简介

UIWaterMark 是基于 open harmony 开发的水印组件。支持添加文字水印，调整文字大小和颜色。支持添加本地/网络图片水印，调整图片大小。支持自定义水印的通用透明度、间距以及旋转角度。可通过设置触碰类型，是否拦截点击事件。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）和华为平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

#### 使用

**安装组件。**

```bash
ohpm install @hw-agconnect/ui-watermark
```

**引入组件。**

```typescript
import { UIWaterMark } from '@hw-agconnect/ui-watermark';
```

**调用组件，详细参数配置说明参见 API 参考。**

```typescript
UIWaterMark({ text: '水印文字' }) {
   Column() {
      Image('https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f')
   }
}
```

## API 参考

### 子组件

无

### 接口

`UIWaterMark(options?: UIWaterMarkOptions)`

水印组件。

#### 参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIWaterMarkOptions | 否 | 配置水印组件的参数。 |

#### UIWaterMarkOptions 对象说明

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| text | string | 否 | 水印文字内容，默认为：“水印文字”。 |
| url | ResourceStr | 否 | 水印图片来源，默认为空。支持本地和网络图片，后者时需开启网络权限下载网络资源。优先级高于文字水印。 |
| behavior | HitTestMode | 否 | 触摸测试效果。默认为：HitTestMode.Transparent，不阻塞点击事件。可设置为 HitTestMode.Block，拦截点击事件。 |
| bgColor | ResourceColor | 否 | 水印画板背景色。默认为：Color.Transparent。 |
| font | string | 否 | 水印文字样式，默认为：“normal normal sans-serif”。详细说明参见属性 Font。 |
| fontSize | number | 否 | 水印文字大小，默认为：14vp。 |
| fontColor | string | 否 | 水印文字颜色，默认为：“#000000”。 |
| iWidth | number | 否 | 水印图片宽度，默认为：100vp。水印图片宽高保持原比例。 |
| cOpacity | number | 否 | 水印通用透明度，默认为：0.3。 |
| cSpaceX | number | 否 | 水印通用水平间距，默认为：40vp。 |
| cSpaceY | number | 否 | 水印通用垂直间距，默认为：40vp。 |
| cRotate | number | 否 | 水印通用旋转角度，默认为：315° |
| content | CustomBuilder | 否 | 水印遮罩主体内容。 |

## 示例代码

### 示例 1

本示例展示了文字水印的基本用法。

```typescript
import { UIWaterMark } from '@hw-agconnect/ui-watermark';

@Entry
@ComponentV2
struct TextWaterMark {
  build() {
    NavDestination() {
      UIWaterMark({
        text: '自定义文字',
        fontSize: 18,
        font: 'italic bold monospace',
        fontColor: '#ff4200ff',
        cOpacity: 0.3,
        cSpaceX: 40,
        cSpaceY: 60,
      }) {
        Image('https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f')
          .alt($r('app.media.startIcon'))
      }
    }
    .title('自定义文字水印')
  }
}
```

### 示例 2

本示例展示了图片水印的基本用法。

```typescript
import { UIWaterMark } from '@hw-agconnect/ui-watermark';

@Entry
@ComponentV2
struct ImageWaterMark {
  build() {
    NavDestination() {
      UIWaterMark({
        url: $r('sys.media.balloon_fill'),
        iWidth: 40,
        cRotate: 0,
        cOpacity: 0.3,
        cSpaceX: 48,
        cSpaceY: 100,
      }) {
        Image('https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f')
          .alt($r('app.media.startIcon'))
      }
    }
    .title('图片水印')
  }
}
```

### 示例 3

本示例展示了水印组件的拦截开关。

```typescript
import { UIWaterMark } from '@hw-agconnect/ui-watermark';

@Entry
@ComponentV2
struct ClickWaterMark {
  @Local blocked: boolean = false;
  @Local text: string = '测试文字'
  @Local count: number = 1

  build() {
    NavDestination() {
      Row() {
        Text('开启拦截：  ')
        Toggle({ type: ToggleType.Switch, isOn: $$this.blocked })
      }.padding({ left: 16 })

      Column() {
        UIWaterMark({
          behavior: !this.blocked ? HitTestMode.Transparent : HitTestMode.Block,
          cOpacity: 0.5,
          fontColor: '#007dff',
          text: this.text,
        }) {
          Stack() {
            Image('https://agc-storage-drcn.platform.dbankcloud.cn/v0/cloud-urahf/%E8%92%99%E7%89%88(2).png?token=7177b033-345b-4801-8a33-f7b58dd5265f')
              .alt($r('app.media.startIcon'))

            Button('测试点击').onClick(() => {
              this.getUIContext().showAlertDialog({ alignment: DialogAlignment.Center, message: '点击！' });
              this.text = '新的文字' + this.count
              this.count++
            })
          }
        }
      }
      .layoutWeight(1)
    }
    .title('水印组件事件拦截')
  }
}
```

## 更新记录与兼容性

### 更新记录

- **1.0.0 (2026-01-27)**
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
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-watermark
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/49130205d3b7403ab43e591c8f3c48f4/2adce9bbd4cb42d58a87e6add45594b3?origin=template