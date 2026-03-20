# 支持百万级节点树组件

## 简介

基于 **ArkTS** 实现的高度可配置高性能树组件（百万树节点数据不卡顿），支持：

- 懒加载（lazyForEach）
- 单选 / 多选
- 父子节点联动
- 自定义图标渲染
- 自定义节点名称
- 树样式配置
- 节点过滤
- 自动展开父节点
- 搜索高亮
- 自定义操作列插槽

适用于文件目录、组织架构、层级结构选择等业务场景。

## 详细介绍

### 功能介绍

OMTree 是基于 ArkTS 实现的高度可配置高性能树组件（百万树节点数据不卡顿），支持：

- 懒加载（lazyForEach）
- 单选 / 多选
- 父子节点联动
- 自定义图标渲染
- 自定义节点名称
- 树样式配置
- 节点过滤
- 自动展开父节点
- 搜索高亮
- 自定义操作列插槽

适用于文件目录、组织架构、层级结构选择等业务场景。

### 环境要求

- api12+

### 快速入门

```bash
ohpm install omtree
```

## 使用样例

```typescript
import { TreeApi, TreeDataSource, TreeNode, TreeOptionProp, TreeOptionType, TreeUtil, OMTree ,getTreeData1 } from 'omtree'


@Entry
@Component
struct test1{
  @State treeData:TreeDataSource = new TreeDataSource()
  @State treeOption:TreeOptionProp = new TreeOptionProp({isOption:true,optionType:TreeOptionType.Radio})
  private treeControl = new TreeApi()
  aboutToAppear(): void {
    this.getData()
  }
  // 初始化数据构造
  getData(){
    let treeNodes = getTreeData1() as TreeNode[]
    treeNodes = TreeUtil.listToTree(treeNodes)
    this.treeData.setData(treeNodes,true) // 此处将数据换成对应的业务数据即可

  }


  build() {
    Flex(){
      OMTree({
        treeData:this.treeData,
        controller:this.treeControl,
        option:this.treeOption
      }).flexGrow(1)
      Button("展开所有节点").onClick(() =>{
        this.treeControl.setAllExpandNodeState(true)
      }).width(150).fontSize(16)
      Button("关闭所有节点").onClick(() => {
        this.treeControl.setAllExpandNodeState(false)
      }).width(150).fontSize(16)
    }.margin({top:80})

  }
}
```

## 示例效果

## API 说明

### TreeApi 组件 API 操作

| 方法名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| setAllExpandNodeState | flag: boolean | void | 设置树全部展开或折叠 |
| getCheckData | 无 | number[] | 获取选中节点的 ID 数组 |
| getHalfCheckData | 无 | number[] | 获取半选中节点 ID 数组 |
| getCheckTreeNode | 无 | TreeNode[] | 获取选中节点（TreeNode 结构） |
| getCheckTreeNodeNameAndId | 无 | NameAndId[] | 获取选中节点的名称与 id |
| isExpand | node: TreeNode | boolean | ⚠️ 已废弃，OMTree 可直接读取 node.isExpand |
| clearCheckData | 无 | void | 清空所有选中节点状态 |
| reflush | treeNodes: TreeNode[] | void | ⚠️ 已废弃，请使用重新设置 treeData + reload() |
| setCheck | id: number \| number[] | void | 设置节点选中 |
| getCheckDataExcludeChildren | 无 | number[] | 获取选中节点，但排除被父节点包含的子节点 |
| getCheckDataExcludeChildrenTreeNode | 无 | TreeNode[] | 上述同逻辑，但返回 TreeNode |
| getCheckDataExcludeChildrenTreeNodeNameAndId | 无 | NameAndId[] | 上述同逻辑，但返回 NameAndId |
| getCheckLeaf | 无 | number[] | 获取所有选中叶子节点（需 isLeaf 字段正确） |
| getCheckLeafTreeNode | 无 | TreeNode[] | 获取所有选中叶子节点（TreeNode） |
| getCheckLeafTreeNodeNameAndId | 无 | NameAndId[] | 获取所有选中叶子节点的名称与 id |
| toggleNodeState | id: number | void | 切换指定节点的选中状态 |
| setNodeState | id: number \| number[], state: CheckState, notEmitEvent: boolean | void | 设置节点选中状态 |
| deleteNodeById | id: number | void | 删除节点及其所有子节点 |
| deleteNodesByIds | ids: number[] | void | 删除多个节点及其所有子树 |
| getTreeNodeLength | 无 | number | 获取树节点数量 |
| setRadioSelect | id: number | void | 设置单选选中项 |
| reload | 无 | void | 重载整颗树数据 |
| flushNodeById | id: number | void | 刷新指定节点 |
| fuzzyFilterTree | keyWord: string | void | 模糊搜索树节点 |
| restSearch | 无 | void | 重置搜索结果 |
| updateTree | callBack: (data: TreeNode[]) => TreeNode[] | void | 更新整棵树数据（回调可修改整体节点） |

## TreeDataSource API 文档

```typescript
export class TreeDataSource<T = TreeNode> extends BasicDataSource<TreeNode> {
  private treeData : Array<TreeNode> = []

  public totalCount(): number {
    return this.treeData.length;
  }

  public getData(index: number): TreeNode {
    return this.treeData[index];
  }

  public addData(index: number, data: TreeNode): void {
    this.treeData.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: TreeNode): void {
    this.treeData.push(data);
    this.notifyDataAdd(this.treeData.length - 1);
  }

  public changeData(index:number, data:TreeNode){
    this.treeData.splice(index, 1, data)
    this.notifyDataChange(index)
  }

  public updateNode(index:number){
    this.notifyDataChange(index)
  }

  public setData(data: TreeNode[],handle?:boolean) {
    if(handle){
      data = TreeUtil.treeTolist(data,0)
    }
    this.treeData = data
    this.notifyDataReload()
  }

  public getTreeData(filter?:(node:TreeNode) => boolean): TreeNode[] {
    if(filter){
      return this.treeData.filter(item => filter(item))
    }else{
      return this.treeData
    }
  }
}
```

### 方法说明表

| 方法名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| totalCount() | — | number | 获取树节点总数 |
| getData(index) | index: number | TreeNode | 根据索引获取节点 |
| addData(index, data) | index: number<br>data: TreeNode | void | 在指定位置插入节点并触发新增事件 |
| pushData(data) | data: TreeNode | void | 追加节点到末尾并触发新增事件 |
| changeData(index, data) | index: number<br>data: TreeNode | void | 修改指定索引节点并触发更新事件 |
| updateNode(index) | index: number | void | 触发指定节点更新事件 |
| setData(data, handle?) | data: TreeNode[]<br>handle?: boolean | void | 设置树数据源，如果数据为树结构，需要将 handle 设置为 true 如果不是列表结构时不需要设置 |
| getTreeData(filter?) | filter?: (node: TreeNode) => boolean | TreeNode[] | 获取树数据，可选过滤函数 |

## 配置说明

### 数据结构 1

需要 `TreeDataSource.setData(data: TreeNode[],handle?:boolean)` 中 handle 为 true 的数据结构

```json
{
    "id": 1,
    "parentId": -99,
    "name": "Node 1",
    "type": 0,
    "children": [{
        "id": 8,
        "parentId": 1,
        "name": "Node 8",
        "type": 7,
        "children": [{
            "id": 1001,
            "parentId": 8,
            "name": "Node 1001",
            "type": 1000
        }]
    }]
}
```

### 数据结构 2

不需要 `TreeDataSource.setData(data: TreeNode[],handle?:boolean)` 中 handle 的参数，但此时 level 参数为必填，标识当前节点在第几个层级

```json
[{
    "id": 1,
    "parentId": -99,
    "name": "Node 1",
    "type": 0,
    "level": 0
}, {
    "id": 8,
    "parentId": 1,
    "name": "Node 8",
    "type": 7,
    "level": 1
}, {
    "id": 1001,
    "parentId": 8,
    "name": "Node 1001",
    "type": 1000,
    "level": 2
}, {
    "id": 9,
    "parentId": 1,
    "name": "Node 9",
    "type": 8,
    "level": 1
}, {
    "id": 10,
    "parentId": 1,
    "name": "Node 10",
    "type": 9,
    "level": 1
}]
```

## 📘 使用示例

```typescript
import { TreeApi, TreeDataSource, TreeNode, TreeOptionProp, TreeOptionType, TreeUtil, OMTree ,getTreeData1 } from 'omtree'


@Entry
@Component
struct test1{
  @State treeData:TreeDataSource = new TreeDataSource()
  @State treeOption:TreeOptionProp = new TreeOptionProp({isOption:true,optionType:TreeOptionType.Radio})
  private treeControl = new TreeApi()
  aboutToAppear(): void {
    this.getData()
  }
  // 初始化数据构造
  getData(){
    let treeNodes = getTreeData1() as TreeNode[]
    treeNodes = TreeUtil.listToTree(treeNodes)
    this.treeData.setData(treeNodes,true) // 此处将数据换成对应的业务数据即可

  }


  build() {
    Flex(){
      OMTree({
        treeData:this.treeData,
        controller:this.treeControl,
        option:this.treeOption
      }).flexGrow(1)
      Button("展开所有节点").onClick(() =>{
        this.treeControl.setAllExpandNodeState(true)
      }).width(150).fontSize(16)
      Button("关闭所有节点").onClick(() => {
        this.treeControl.setAllExpandNodeState(false)
      }).width(150).fontSize(16)
    }.margin({top:80})

  }
}
```

## 📑 Props 树组件配置项

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| treeData | TreeDataSource | ✔ | 树数据源，支持 lazyForEach 接口数据 |
| option | TreeOptionProp | ✔ | 节点操作项配置（是否显示单选/多选等） |
| controller | TreeApi | ✘ | 树组件操作 API |
| isAllExpand | boolean | ✘ | 是否展开全部节点 |
| style | TreeStyleProp | ✘ | 树样式配置（滚动条等） |
| selectChildIds | number[] | ✘ | 若传入子节点 ID，会自动打开其父节点 |
| customIconBuilder | (node:TreeNode) => void | ✘ | 自定义图标插槽 |
| customNodeNameBuilder | (node:TreeNode) => void | ✘ | 自定义节点名称插槽 |
| customOptionBuilder | (node:TreeNode) => void | ✘ | 自定义操作插槽 |
| emitCallback | (emitData:TreeEventParam) => void | ✘ | 树事件回调 |
| filter | (node:TreeNode) => boolean | ✘ | 过滤节点 |

## ⚙️ TreeOptionProp 树配置说明

```typescript
export interface TreeOptionPropData {
  isOption: boolean // 是否有操作选项
  optionType?: TreeOptionType.Radio | TreeOptionType.Checkbox //  树节点操作类型，必须 isOption 为 true 时生效
  relationshipOperateType?: CheckboxRelationshipOperate // 复选框父子节点操作关联配置
}
```

## 类型说明

### TreeNode（示例）

```typescript
interface TreeNode {
  id: number;
  parentId: number | null;
  name: string;
  isLeaf?: boolean;
  isExpand?: boolean;
  children?: TreeNode[];  
  [key: string]: any;
}
```

## 🎨 TreeStyleProp 树节点样式配置

```typescript
@Observed
export class TreeStyleProp {
  scrollBar: number = BarState.Auto // 滚动条配置
}
```

## 📚 类型定义（完整）

### TreeNodeData 树节点数据结构

```typescript
export interface TreeNodeData {
  id: number // 节点 id 
  parentId: number | null  // 父节点 id  
  name: string // 节点名字
  type: number // 节点类型，预留字段，暂时不做业务处理
  isLeaf?: boolean //  是否是叶子节点，不需要赋值，树组件构建时会赋值
  isExpand?: boolean // 是否展开
  children?: TreeNode[] | null // 子节点数据集合，若将子节点数据放到该字段下时，setData 需要将 handle 设置为 true，若只是以 id 和 parentId 为关联返回列表数据则不需要设置 handle 为 true
  data?: Object // 节点业务数据 
  level?: number // 节点层级，不需要赋值，树组件构建时会赋值
  uuid?: string // 节点更新的唯一标识，不需要赋值，树组件构建时会赋值
}
```

## 🧮 枚举定义

### TreeOptionType 树节点操作类型枚举

```typescript
export enum TreeOptionType {
  Radio = 1, // 单选
  Checkbox = 2 // 复选
}
```

### CheckState 节点状态枚举

```typescript
export enum CheckState {
  NotCheck = 0, // 不选择
  HalfCheck = 1, // 半选
  Check = 2 // 选中
}
```

### OperationsType 事件枚举值

```typescript
export enum OperationsType {
  CheckBox = 'checkbox', //check 点击事件
  Item = 'item', // 点击树节点对象
  Icon = 'Icon', // 点击树节点图标事件
  expand = 'expand',// 点击节点展开和收起箭头实践
  Finish = 'finish', // 树组件数据构建完成事件
  RadioChange = 'radioChange', //  单选改变事件
  LongPressItem = 'LongPressItem' // 长按树节点事件
}
```

### CheckboxRelationshipOperate 复选框联动操作

```typescript
export enum CheckboxRelationshipOperate {
  fatherSonRelation,//父子操作关联
  fatherRelationSon, // 父节点操作联动子节点，子节点操作不联父节点
  sonRelationFather,// 子节点操作联动父节点，父节点操作不联动子节点
  notRelation,  // 父子操作不关联
  fatherRelationSonAndSonCancelFatherAllCheck, // 父节点操作关联子节点，子节点取消勾选会联动父节点的全选，但子节点的全选不会关联父节点的勾选
}
```

## 📤 事件定义

```typescript
interface TreeEventParam {
  type: OperationsType //事件类型
  node: TreeNode // 树节点对象
}
```

## 权限要求

无

## 技术支持

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 获取方式

https://gitee.com/houjianhong/omtree

## 更新记录

### 1.0.4 (2025-12-31)

### 1.0.0 (2025-11-11)

- 懒加载（lazyForEach）
- 单选 / 多选
- 父子节点联动
- 自定义图标渲染
- 自定义节点名称
- 树样式配置
- 节点过滤
- 自动展开父节点
- 搜索高亮
- 自定义操作列插槽

### 1.0.1 (2025-11-11)

- 新增外部 code 唯一值添加
- 新增签名

### 1.0.2

- 更换签名

### 1.0.3

- 更换 release 签名

### 1.0.4

- 采用最新版本组件

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

**隐私政策**：不涉及

**SDK 合规使用指南**：不涉及

**兼容性**

| HarmonyOS 版本 | 备注 |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

**应用类型**：应用

**元服务**

**设备类型**

| 设备 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

**DevEcoStudio 版本**

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install omtree
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c6f52d5ef9b74e70b6198f0239cbf4cd/DEVELOPER?origin=template