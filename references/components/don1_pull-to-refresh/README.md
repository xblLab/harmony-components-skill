# pull to refresh 上拉加载下拉刷新组件

## 简介

PullToRefresh 是一款基于 ArkUI 实现的上拉加载、下拉刷新组件。

## 详细介绍

### 简介

上拉加载与下拉刷新组件。

### 安装

```bash
ohpm i @don1/pull-to-refresh
```

### 使用

```typescript
LoadRefresh({
  isLoading: $isLoading,
  isRefreshing: $isRefreshing,
  isFinished: $isFinished,
  onLoadMore: () => {
    // 上拉加载逻辑
  },
  onRefresh: () => {
    // 下拉刷新逻辑
  }
}) {
  ForEach(列表数据源，(item: 数据类型) => {
    ListItem() {
      // 布局
    }
  })
}
```

### License

MIT

### 更新记录

- **[v1.0.0] 2024-12**：实现上拉加载与下拉刷新组件
- **[v1.0.1] 2024-12**：加入返回顶部功能

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用 |
| 元服务 | 不涉及 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @don1/pull-to-refresh
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/58ffc9a930fb41d8b3357dd5ee151bb5/PLATFORM?origin=template