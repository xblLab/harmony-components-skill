# Harmony Components

鸿蒙官方组件的检索与集成。通过轻量索引按需加载组件文档，指导安装与使用。

## 安装

### Claude Code

个人 skill（所有项目可用）：

```bash
git clone git@github.com:xblLab/harmony-components-skill.git ~/.claude/skills/harmony-components
```

项目 skill（仅当前项目）：

```bash
git clone git@github.com:xblLab/harmony-components-skill.git .claude/skills/harmony-components
```

验证：`claude skills list`

### Cursor

个人 skill：

```bash
git clone git@github.com:xblLab/harmony-components-skill.git ~/.cursor/skills/harmony-components
```

项目 skill：在项目根目录执行

```bash
mkdir -p .cursor/skills
git clone git@github.com:xblLab/harmony-components-skill.git .cursor/skills/harmony-components
```

## 使用

- 对话中提及地图、图表、表单、鸿蒙组件等场景时，会自动被选用
- 或主动输入 `/harmony-components` 调用
- 确认安装某组件后，在 HarmonyOS 项目根目录执行：`bash <skill_path>/scripts/install.sh <component_id>`

## 许可

Apache-2.0
