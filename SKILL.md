---
name: harmony-components
description: 鸿蒙官方组件的检索与集成。当用户需要集成地图、图表、表单、导航等鸿蒙组件时，根据需求检索索引并指导安装与使用。
license: Apache-2.0
---

# Harmony Components

鸿蒙官方组件的检索与集成 Skill。通过轻量索引按需加载组件文档，指导用户完成组件安装与使用。

## 何时使用

- 用户提及地图、图表、表单、鸿蒙组件、HarmonyOS 组件等场景
- 用户需要集成鸿蒙官方组件到项目中
- 用户询问某类功能对应的组件选型

## 工作流程

1. **检索**：读取 `references/index.json`，根据用户需求做关键词匹配，选出 top 3–5 候选
2. **加载详情**：读取 `references/components/<id>/README.md` 获取组件详细说明
3. **安装**：若用户确认安装，在 HarmonyOS 项目根目录执行：
   ```bash
   bash <skill_path>/scripts/install.sh <component_id>
   ```
   或指定项目路径：
   ```bash
   bash <skill_path>/scripts/install.sh <component_id> /path/to/harmony-project
   ```

## 重要说明

- 安装脚本需在 HarmonyOS 项目根目录执行，或传入项目路径作为第二参数
- 组件会安装到项目的 `components/` 目录，并自动更新 `oh-package.json5`
- 安装完成后用户需执行 `ohpm install`
