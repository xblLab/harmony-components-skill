# 触感震动全局控制组件

## 简介

一款适用于 HarmonyOS 5.0 以上的轻量震动工具类，支持自定义震动时长、倍数调节、全局开关控制，适配系统能力检测与错误处理，满足 APP 交互反馈、提醒、全局开关等震动场景需求。

## 详细介绍

鸿蒙震动工具类（Vibrate Utils）是一款适用于 HarmonyOS 5.0 以上方舟开发框架（ArkUI）的轻量震动工具类，支持自定义震动时长、倍数调节、全局开关控制，适配系统能力检测与错误处理，满足 APP 交互反馈、提醒、全局开关等震动场景需求。

### 核心特性

- 🎯 **多类型震动**：支持瞬时震（50ms）、标准震（300ms）、长时震（1000ms）三种预设类型
- 🔢 **倍数调节**：支持 1-1800 倍时长放大，超出范围自动截断为 1800
- 🚀 **全局开关**：通过持久化存储（PersistenceV2）控制震动总开关，灵活开启/关闭
- 🛡️ **系统适配**：自动检测系统能力（SystemCapability.Sensors.MiscDevice），无兼容风险
- 🚨 **错误处理**：完善的异常捕获与日志输出，便于问题排查
- 📱 **合规管控**：震动类型归属 alarm 类别，符合系统开关管控规范

## 安装与集成

### 组件安装

```bash
ohpm install tactilevibration
```

组件安装成功后确保根目录 `oh-package.json5` 中将项目应用开发环境依赖设置完成：

```json5
{
  "devDependencies": {
    "tactilevibration": "file:./tactilevibration"
  }
}
```

### 权限配置

项目震动权限授权，`module.json5`：

```json5
{
  "module": {
    "requestPermissions": [{
      "name": "ohos.permission.VIBRATE"
    }]
  }
}
```

在需要使用震动或全局开关的页面/组件中直接导入：

```typescript
import { Vibration, VSwitch } from 'tactilevibration';
```

## 快速使用

### 1. 基础使用（默认瞬时震）

```typescript
// 触发默认瞬时震（50ms，默认倍数 1）
Vibration();
```

### 2. 指定震动类型

```typescript
// 瞬时震（50ms，默认倍数 1）
Vibration('short');
// 标准震（300ms，默认倍数 1）
Vibration('centre');
// 长时震（1000ms，默认倍数 1）
Vibration('long');
```

### 3. 自定义震动时长（倍数调节）

```typescript
// 瞬时震 × 2 → 100ms
Vibration('short', 2);
// 标准震 × 5 → 1500ms
Vibration('centre', 5);
// 长时震 × 3 → 3000ms（倍数超出 1800 会自动截断为 1800）
Vibration('long', 3);
```

### 4. 控制震动总开关

工具类通过 PersistenceV2 持久化存储开关状态，可通过以下方式修改：

```typescript
import { PersistenceV2 } from '@kit.ArkUI'
import { Vibration, VSwitch } from 'tactilevibration'

// 连接开关状态存储
const vSwitch = PersistenceV2.connect(VSwitch, () => new VSwitch());

// 关闭震动（修改后所有震动调用均无效）
vSwitch.isValue = false;

// 开启震动（默认开启）
vSwitch.isValue = true;
```

## 测试示例代码

以下是完整的测试页面示例，可直接创建组件运行，验证震动功能与开关控制效果：

```typescript
import { Vibration, VSwitch } from 'tactilevibration'
import { PersistenceV2 } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Test {
  // 震动开关状态持久化（与工具类共享同一状态）
  @Local Switch: VSwitch = PersistenceV2.connect(VSwitch, () => new VSwitch())!

  build() {
    Column({ space: 20 }) {
      Text('触感震动测试 - 瞬时震（50ms）').fontSize(20) // 瞬时震测试按钮
        .onClick(() => {
          Vibration() // 默认触感效果瞬时震
        })
      Text('触感震动测试 - 标准震（300ms）').fontSize(20) // 标准震测试按钮
        .onClick(() => {
          Vibration('centre') // 标准震
        })
      Text('触感震动测试 - 长时震（1000ms）').fontSize(20) // 长时震测试按钮
        .onClick(() => {
          Vibration('long') // 长时震
        })
      // 倍数震动测试（示例：长时震×3 → 3000ms）
      Text('触发长时震×3（3000ms）').fontSize(30)
        .onClick(() => {
          Vibration('long', 3); // 长时震 +3 倍时长
        })

      Row() { // 震动总开关
        Text('全局震动开关：')
        // 同步 isValue 切换震动开关状态
        Toggle({ type: ToggleType.Switch, isOn: $$this.Switch.isValue }) // $$同步开关状态到持久化存储
          .onChange((isOn: boolean) => {
            console.info(`震动总开关已${isOn ? '开启' : '关闭'}`);
          })
      }
    }
    .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
  }
}
```

## 测试步骤

1. 创建测试组件（如 `VibrationTestPage.ets`），复制上述代码
2. 调整 `import { Vibration, VSwitch } from 'tactilevibration'` 中的导入路径为工具类实际路径
3. 在 APP 路由中配置该页面，运行项目
4. **交互测试：**
   - 点击不同震动按钮，验证对应震动效果
   - 切换全局开关，验证关闭后震动是否失效
   - 查看日志控制台，确认无错误输出（成功日志：Succeed in starting vibration）

## API 文档

## 注意事项

- **系统兼容性**：仅支持具备 SystemCapability.Sensors.MiscDevice 能力的鸿蒙设备，低版本设备会自动忽略震动调用
- **时长限制**：最大震动时长 = 预设时长 × 1800（如长时震最大 1800×1000ms = 30 分钟）
- **权限说明**：无需额外申请权限，震动管控遵循系统 alarm 类别开关（用户可在系统设置中关闭）
- **测试注意**：部分模拟器可能不支持震动效果，建议使用真实鸿蒙设备测试
- **开关同步**：测试页面与工具类共享同一持久化开关状态，修改后全局生效

## 许可证

本工具类基于 MIT 许可证开源，可自由用于商业和非商业项目，如需修改或二次分发，请保留原作者版权信息。

## 更新记录

- **1.0.1** (2025-11-18)
  - 本组件为工具类组件提供了开发中常用的触感震动、长时震动和全局开关等功能。
  - 修复了在部分场景下震动效果异常的问题。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.VIBRATE | 设备震动必要授权 | 开启设备震动功能 |

使用隐私政策：不涉及 SDK 合规使用指南：鸿蒙震动工具类使用指南.docx

## 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install tactilevibration
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ef4416639dc842a8ab0eeebc50e8f499/946d959ea3124e859cc3a53975c884f6?origin=template

---

Created with Pixso.