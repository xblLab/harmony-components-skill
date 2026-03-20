# drawer 可滑动抽屉组件

## 简介

drawer 是一个支持动态设置等级的抽屉组件。

## 详细介绍

### 1. 组件简介

Drawer 是一款适用于鸿蒙应用的可滑动抽屉组件，支持多等级停留、自定义样式与手势交互，可灵活嵌入页面作为内容扩展区域。

### 2. 安装方式

通过 ohpm 包管理器快速安装，命令如下：

```bash
ohpm install @fukealine_a/drawer
```

### 3. 效果示例

Drawer 组件动态效果

### 4. 快速使用

#### 4.1 导入组件

在目标页面或文件中，导入组件核心模块：

```typescript
import { Drawer, DrawerViewModel } from '@fukealine_a/drawer';
```

#### 4.2 初始化控制实例

创建 DrawerViewModel 实例，用于控制抽屉的属性、行为与事件：

```typescript
// 初始化抽屉控制实例（建议在页面级变量中声明）
drawerViewModel: DrawerViewModel = new DrawerViewModel();
```

#### 4.3 自定义配置（可选）

在组件生命周期（如 aboutToAppear）中，根据需求调整抽屉参数。支持的配置项如下：

| 配置方法 | 功能说明 | 参数示例 |
| :--- | :--- | :--- |
| `setLevelConfig(levels: number[])` | 设置抽屉多等级停留位置，数组元素为“距离顶部的距离” | `[890, 600, 400, 200]`（单位：vp） |
| `setDrawerBackgroundColor(color: Color)` | 设置抽屉背景色 | `Color.Gray` |
| `setDrawerBorderRadius(radius: number)` | 设置抽屉顶部圆角 | `20`（单位：vp） |
| `setAlignItem(align: HorizontalAlign)` | 设置抽屉内部横轴对齐方式 | `HorizontalAlign.Center` |
| `setJustifyContent(align: FlexAlign)` | 设置抽屉内部纵轴对齐方式 | `FlexAlign.Center` |
| `setTempo(speed: number)` | 设置抽屉滑动速度（数值越大越快） | `6` |

配置示例代码：

```typescript
aboutToAppear() {
  // 多等级停留配置
  this.drawerViewModel.setLevelConfig([890, 600, 400, 200]);
  // 背景色与圆角
  this.drawerViewModel.setDrawerBackgroundColor(Color.Gray);
  this.drawerViewModel.setDrawerBorderRadius(20);
  // 滑动速度
  this.drawerViewModel.setTempo(6);
}
```

#### 4.4 嵌入页面结构

将 Drawer 组件融入页面，绑定控制实例与回调事件，示例如下：

```typescript
build() {
  Column() {
    // 页面主内容区（抽屉下方）
    Column() {
      Text('组件下方内容区')
        .alignSelf(ItemAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Orange)
    .zIndex(-1)
    .justifyContent(FlexAlign.Center)

    // 抽屉组件
    Drawer({
      vm: this.drawerViewModel, // 绑定控制实例
      slot: () => {
        this.renderDrawerContent(); // 自定义抽屉内部 UI
      },
      levelChangeEvent: (level: number) => {
        // 抽屉等级切换回调
        console.log(`等级切换监听_当前抽屉等级为：${level}`);
      }
    })
  }
}

// 自定义抽屉内部 UI
renderDrawerContent() {
  Column() {
    Text('这是抽屉内部内容')
      .fontSize(16)
  }
  .width('100%')
  .padding(20)
}
```

## 注意事项

若抽屉内部（slot）包含列表（如 List）等需要手势交互的组件，需在其手势回调中调用 stopPropagation()，防止手势冒泡影响抽屉滑动。

示例：

```typescript
List() {
  // 列表项内容
}
.onTouch((event) => {
  event.stopPropagation(); // 阻止手势冒泡
  return false;
})
```

抽屉的 zIndex 默认高于页面主内容，若需调整层级，可在页面元素中显式设置 zIndex。

## 更新记录

### v1.0.5

更新时间：2025-12-10

- 修复了缺少点击时间范围的严重 bug
- 代码优化

### v1.0.4

更新时间：2025-10-29

- 修复点击事件拦截失效问题：解决“组件点击时误触发等级切换”的交互 bug，保障点击操作与等级控制的逻辑隔离
- 优化组件内部封装：提升代码模块化程度

### v1.0.3

- 修复全屏事件监听问题：解决“设置全屏后无法接收事件”的 bug，确保全屏场景下组件功能正常响应
- 新增抽屉 zIndex 配置：支持手动设置抽屉组件的层级（zIndex），满足复杂页面中多元素的层级显示需求

### v1.0.2

- 重构松手判断逻辑：根据松手时的坐标位置智能判断抽屉行为（复归上一级 / 切换下一级），提升滑动操作的精准度与流畅性

### v1.0.1-rc0（预览版）

- 关闭代码混淆：便于开发者在预览阶段进行调试排查，降低问题定位难度

### v1.0.1

- 新增等级切换监听：支持通过回调函数实时获取抽屉切换后的当前等级，便于业务层同步处理逻辑
- 修复同等级高度切换 bug：解决“同等级下调整抽屉高度不触发归位”的问题，保障样式调整后的显示一致性
- 修复动画失效问题：处理部分场景下抽屉动画不执行的异常，提升交互视觉体验
- 优化等级数组处理：兼容等级数组的特殊配置场景，避免组件初始化时出现“超出屏幕范围”的显示异常

### v1.0.0（初始版本）

- 实现抽屉核心能力：包括多等级停留、基础样式配置、滑动交互等核心功能，满足基础业务场景需求

## 权限与隐私及兼容性

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 权限与隐私 | 基本信息 | 暂无 |
| 权限与隐私 | 权限名称 | 暂无 |
| 权限与隐私 | 权限说明 | 暂无 |
| 权限与隐私 | 使用目的 | 暂无 |
| 权限与隐私 | 隐私政策 | 不涉及 |
| 权限与隐私 | SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 | 5.0.1 |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 应用类型 | 应用 | 应用 |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 元服务 | | |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 设备类型 | 手机 | 手机 |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 设备类型 | 平板 | 平板 |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| 设备类型 | PC | PC |

Created with Pixso.

| 类别 | 项目 | 说明 |
| :--- | :--- | :--- |
| DevEcoStudio 版本 | | DevEco Studio 5.0.1 |

Created with Pixso.

## 安装方式

```bash
ohpm install @fukealine_a/drawer
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1a899d5184204d0b9bb45f015852c0f7/PLATFORM?origin=template