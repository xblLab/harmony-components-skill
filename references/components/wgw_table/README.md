# table 表格组件

## 简介

轻量级的表格组件

## 详细介绍

### 简介

Table 组件是一个轻量化的表格组件，主要提供以下几点功能：

- 基本的表格布局
- 单元格内容完全自定义
- 支持顶部、底部行固定，左边、右边列固定
- 支持长按拖拽改变行高/列宽

### 如何安装

```bash
ohpm i @wgw/table
```

### 如何使用

深色代码主题复制

// 完整配置

```typescript
Table({
  // 表格数据
  data: {
    rowCount: this.data.length, // 表格行数量
    columnCount: this.data.length == 0 ? 0 : this.data[0].length, // 表格列数量
    values: this.data // 表格关联数据，用于 cellRender 时传值，主要解决 this 指向问题及刷新时脏数据问题
  },
  // 单元格绘制
  cellRender: this.buildCellItem,
  // 单元格尺寸测量
  cellSizeMeasure: {
    measure: (cellData: CellData) => {
      // 返回指定行列单元格大小
      return { width: cellData.column == 0 ? 50 : 100, height: 50 }
    },
    constraints: (cellData: CellData) => {
      // 返回指定行列单元格尺寸范围，主要用于拖拽改变行高时进行限制
      return {
        minWidth: 20,
        minHeight: 20,
        maxWidth: 400,
        maxHeight: 200
      }
    }
  },
  // 表格配置
  config: {
    fixStartCount: 1, // 左边连续固定列数量
    fixTopCount: 1, // 顶部连续固定行数量
    fixEndCount: 0, // 右边连续固定列数量
    fixBottomCount: 0, // 底部连续固定行数量
    couldDragChangeWidth: (row, column) => row == 0, // 指定单元格是否可以拖拽改变列宽
    couldDragChangeHeight: (row, column) => column == 0, // 指定单元格是否可以拖拽改变行高
    nestedScroll: {
      scrollForward: NestedScrollMode.SELF_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    }, // 嵌套滚动时，指定表格滚动优先级
    resetCellSize: false, // 数据变更时，是否重置单元格大小
    rowCacheCount: 6 // 行缓存数量，用于解决快速滑动时新进入界面的行，列对齐延迟问题
  },
  tableController: this.tableController, // 表格控制器
})
```

// 控制器说明

```typescript
class TableController {
  /**
   * 水平移动距离
   */
  get offsetX(): number;

  /**
   * 纵向移动距离
   */
  get offsetY(): number;

  /**
   * 滚动到指定位置
   */
  scrollToOffset(xOffset: number, yOffset: number, smooth?: ScrollAnimationOptions | boolean);

  /**
   * 垂直方向滚动到指定位置
   * @param smooth 是否平滑的滚动
   */
  verticalScrollTo(offset: number, smooth?: ScrollAnimationOptions | boolean);

  /**
   * 水平方向滚动到指定位置
   * @param smooth 是否平滑的滚动
   */
  horizontalScrollTo(offset: number, smooth?: ScrollAnimationOptions | boolean);

  /**
   * 滚动到指定的单元格
   */
  scrollToCell(row: number, column: number, smooth?: boolean);

  /**
   * 滚动到指定的行
   */
  scrollToRow(row: number, smooth?: boolean);

  /**
   * 滚动到指定的列
   */
  scrollToColumn(column: number, smooth?: boolean);

  /**
   * 是否滑动到表格最后一行
   */
  isRowAtEnd(): boolean;

  /**
   * 是否滑动到表格最后一列
   */
  isColumnAtEnd(): boolean;

  /**
   * 获取单元格尺寸
   */
  getCellSize(row: number, column: number): CellSize;

  /**
   * 获取单元格的宽度
   */
  getCellWidth(column: number): number;

  /**
   * 获取单元格的高度
   */
  getCellHeight(row: number): number;

  /**
   * 添加纵向滑动监听
   */
  addVerticalScrollListener(listener: OnScrollCallback);

  /**
   * 移除纵向滑动监听
   */
  removeVerticalScrollListener(listener: OnScrollCallback);

  /**
   * 添加横向滑动监听
   */
  addHorizontalScrollListener(listener: OnScrollCallback);

  /**
   * 移除纵向滑动监听
   */
  removeHorizontalScrollListener(listener: OnScrollCallback);
}
```

如果仅预览效果，可直接使用 TableTestComponent 组件

### 截图展示

- 截图 1
- 截图 2
- 截图 3

### 开源协议

Apache License 2.0

### 更新记录

**1.0.1 (2025-10-20)**

暂无权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

隐私政策不涉及 SDK 合规使用指南 不涉及

#### 兼容性

HarmonyOS 版本 5.0.0

Created with Pixso.

#### 应用类型

应用

Created with Pixso.

#### 元服务

Created with Pixso.

#### 设备类型

手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

DevEcoStudio 版本 DevEco Studio 5.0.0

Created with Pixso.

## 安装方式

```bash
ohpm install @wgw/table
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/363118db863d4f7ea2a6495b21bf2fc5/PLATFORM?origin=template