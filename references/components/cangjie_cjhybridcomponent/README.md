# cangjie/cjhybridcomponent 混合渲染组件

## 简介

Provide CJHybridComponent which interop with ArkTS component.

## 详细介绍

### 简介

Provide CJHybridComponent, developer could use CJHybridComponent to interop with ArkTS component

### 下载安装

```bash
ohpm install @cangjie/cjhybridcomponent
```

### 使用说明

在 DevEco 工程中集成使用

#### 在 oh-package.json5 中添加依赖

```json5
{
  "dependencies": {
    "cjhybridcomponent": "@cangjie/cjhybridcomponent"
  }
}
```

#### 在 ArkTS 页面中导入使用

```typescript
import { CJHybridComponent } from "cjhybridcomponent"

@Component
struct Demo {
    build() {
        Column() {
            CJHybridComponent({
                library: "xxx", // so 名称
                component: "xxxx" // 自定义组件名称
            })
        }
    }
}
```

### 许可证协议

Apache2.0

### 更新记录

1.0.0

提供 ArkTS 中加载仓颉的混合场景的能力，使用 loadNativeModule 加载 so

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.1.0 |

### 系统信息

| 项目 | 值 |
| :--- | :--- |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 |

## 安装方式

```bash
ohpm install @cangjie/cjhybridcomponent
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6728be4957ce45cb8ffcaece27af357c/PLATFORM?origin=template