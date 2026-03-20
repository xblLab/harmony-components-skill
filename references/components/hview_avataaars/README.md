# hview/avataaars 个人头像生成组件

## 简介

Avataaas 生成一个精美的个人头像

## 详细介绍

### 简介

精美的个人头像生成，HarmonyOS API 12+
Including in ohos
Avataaars can be installed from ohpm:

```bash
ohpm install @hview/avataaars
```

Then it can be used in your script like so:

```typescript
import { Avataaars } from '@hview/avataaars'
```

```typescript
@Entry
@Component
struct SomeEntryPage {
  build() {
    RelativeContainer() {
      Avataaars()
        .id('HelloWorld')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}
```

### 配色方案

**Avataaars 固定的配色**

- 皮肤颜色 (SkinColors)
- 头发、胡子颜色 (HairColors)
- 帽子、衣服颜色 (HatAndShirtColors)

以上配色通过枚举类抛出。

### 属性介绍

**Avataaars 组件 State 和 Prop 属性介绍**

| 属性 | 描述 | 类型 | 默认值 |
| :--- | :--- | :--- | :--- |
| boxSize | 容器盒子大小 | Length | 300 |
| isCircle | 是否需要圆形背景 | boolean | true |
| circleColor | 圆形背景颜色 | Resource Color | #6FB8E0 |
| skin | 皮肤颜色 | SkinColors、ISkin、'random' | random |
| cloth | 衣服 | Clothes、ICloth、'random' | random |
| graphic | 体恤衫图案 | Graphics、IGraphic、'random' | random |
| eye | 眼睛 | Eyes、IEye、'random' | random |
| eyebrow | 眉毛 | EyeBrows、IEyeBrow、'random' | random |
| mouth | 嘴巴 | Mouthes、IMouth、'random' | random |
| facialHair | 胡子 | FacialHairs、IFacialHair、'random' | random |
| top | 头顶 (帽子、头发) | Tops、ITop、'random' | random |
| accessory | 装饰品 (眼镜) | Accessories、IAccessory、'random' | random |
| clothColor | 衣服颜色 | HatAndShirtColors、IHatAndShirtColor、'random' | random |
| facialHairColor | 胡子颜色 | HairColors、IHairColor、'random' | random |
| hairColor | 头发颜色 | HairColors、IHairColor、'random' | random |
| hatColor | 帽子颜色 | HatAndShirtColors、IHatAndShirtColor、'random' | random |

### 示例

### 许可证协议

MIT

### 更新记录

[v1.0.0]
feat

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @hview/avataaars
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/312b9411906c4a92a19e1e6bd5400dce/PLATFORM?origin=template