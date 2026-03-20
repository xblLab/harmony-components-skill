# customdecoration 自定义装饰组件

## 简介

本示例介绍通过自定义装饰器在自定义组件中自动添加 inspector (布局回调) 方法并进行调用。

## 详细介绍

### 自定义装饰器介绍

本示例介绍通过自定义装饰器在自定义组件中自动添加 inspector (布局回调) 方法并进行调用。

### 效果图预览

不涉及

### 使用说明

在自定义组件上添加自定义装饰器 `@CallbackObserver`，并根据参数设置对应的方法名和需要绑定的组件的 ID。编译工程，可以根据自定义装饰器生成方法并调用。

#### 具体使用方法

1. 在工程的 `hvigor-config.json5` 中配置插件。

```json5
{
  ...
  "dependencies": {
    ...
    "@app/ets-decoration": "file:../libs/autobuilddecoration-1.0.0.tgz"
  }
}
```

2. 在需要使用自定义装饰器的模块的 `hvigorfile.ts` 中添加依赖和文件路径。

```typescript
import { harTasks } from '@ohos/hvigor-ohos-plugin';
import { DecorationPluginConfig, etsDecorationPlugin } from '@app/ets-decoration';

const config: PluginConfig = {
  scanFiles: [""],
}
export default {
  system: harTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: [etsDecorationPlugin(config)]         /* Custom plugin to extend the functionality of Hvigor. */
}
```

3. 在自定义组件上添加自定义装饰器 `@CallbackObserver`，并设置对应的方法名和组件 ID。

```typescript
@CallbackObserver({
 onDraw: 'onDraw',
 onLayout: 'onLayout',
 offDraw: 'offDraw',
 offLayout: 'offLayout',
 bindId: 'text'
})
@Component
export struct MainPage {
 build() {
   Column() {
     Text("Hello World")
       .id('text')
   }
 }
}
```

4. 编译工程，即可生成对应的方法和调用代码。

### 实现思路

1. 在 ArkTS 侧实现自定义装饰器，并配置需要的参数。

```typescript
// 自定义装饰器
export function AutoAddInspector(param: InspectorParam) {
  return Object;
}
// 装饰器参数
export interface InspectorParam {
  // inspector 中 onDraw 需要配置的回调方法
  onDraw?: string;
  // inspector 中 onLayout 需要配置的回调方法
  onLayout?: string;
  // inspector 中 offDraw 需要配置的回调方法
  offDraw?: string;
  // inspector 中 offLayout 需要配置的回调方法
  offLayout?: string;
  // 需要绑定的组件的 ID
  bindId?:string;
}
```

2. 通过 `hvigorfile.ts` 中的配置，将使用自定义装饰器的文件路径传到插件中。

```typescript
import { DecorationPluginConfig, etsDecorationPlugin } from '@app/ets-decoration-generator';

const config: DecorationPluginConfig = {
    // 配置自定义装饰器的文件路径
    scanFiles: ["src/main/ets/components/MainPage"],
}

export default {
    system: harTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
    plugins:[etsDecorationPlugin(config)]         /* Custom plugin to extend the functionality of Hvigor. */
}
```

3. 将传入的文件解析为 TypeScript 抽象语法树，得到所有的节点信息。详细代码可参考 Index.ts。

```typescript
start() {
  // 读取文件
  const sourceCode = readFileSync(this.sourcePath, "utf-8");
  // 解析文件，生成节点树信息
  const sourceFile = ts.createSourceFile(this.sourcePath, sourceCode, ts.ScriptTarget.ES2021, false);
  // 遍历节点信息
  ts.forEachChild(sourceFile, (node: ts.Node) => {
    // 解析节点
    console.log(JSON.stringify(node));
    this.resolveNode(node);
  });
}
```

4. 遍历节点，获取自定义装饰器中配置的参数，将方法名存入到列表中。

```typescript
// 解析装饰器
resolveDecoration(node: ts.Node) {
  ...
  if ((propertie.name as ts.StringLiteral).text !== 'bindId') {
    // 如果参数名不是“bindId”，则放入需要创建的方法列表中
    let methodInfo: MethodInfo = new MethodInfo();
    methodInfo.name = (propertie.name as ts.StringLiteral).text;
    methodInfo.value = (propertie.initializer as ts.StringLiteral).text;
    decoratorInfo.methods.push(methodInfo);
    this.methodArray.push((propertie.initializer as ts.StringLiteral).text);
  } else {
    // 如果参数名是“buildId”，则设置到对应的变量中
    decoratorInfo.bindId = (propertie.initializer as ts.StringLiteral).text;
  }
  ...
  this.decorationInfos.push(decoratorInfo);
  ...      
}
```

5. 遍历节点，记录 `aboutToAppear()` 方法的位置，并和第 4 步中存储的列表进行比较，过滤已经存在的方法，防止生成同名方法。

```typescript
// 解析装饰器装饰的自定义组件（从“{”到“}”）
resolveBlock(node: ts.Node) {
  ...
  // 自定义组件中已经存在的方法列表
  const methodNameArray: string[] = [];
  statements.forEach((statement: ts.Statement) => {
    ...
    const identifier = callExpression.expression as Identifier;
    methodNameArray.push(identifier.escapedText.toString());
    // 查找是否已经存在 aboutToAppear 方法
    if (identifier.escapedText === 'aboutToAppear') {
      this.aboutToAppearExist = true;
      this.positionOfAboutToAppear = statement.pos;
    }
    ...
  })
  // 过滤已经存在的装饰器中的方法
  const temp = this.methodArray.filter((value: string, index: number) => {
    return !methodNameArray.includes(value);
  })
  this.methodArray = temp;
  // 记录自定义组件的结束位置
  this.positionOfBlockEnd = node.end;
  }
}
```

6. 根据解析结果，生成方法代码和相关调用代码，并写入原文件中。

```typescript
function pluginExec(config: DecorationPluginConfig) {
  ...
  // 开始解析文件
  analyzer.start();
  // 如果解析的文件中存在装饰器，则将结果保存到列表中
  if (analyzer.routerAnnotationExisted) {
    // 如果有需要创建的方法
    if (analyzer.methodArray.length > 0) {
      ...
      // 装饰器中如果设置了 bindId，则添加 listener 变量，并在 aboutToAppear 中调用监听方法
      // aboutToAppear 方法是否已存在 
      if (analyzer.aboutToAppearExist) {
        // 如果已经存在 aboutToAppear，则根据 aboutToAppear 方法的位置拆分结构体，并将需要生成的代码添加到对应的位置
        ...
      } else {
        // 如果不存在 aboutToAppear 方法，则创建 aboutToAppear 方法，并添加调用代码
        ...
      }
      // 根据模板创建装饰器中配置的方法
      ...
      // 将生成的代码写入文件中
      writeFileSync(sourcePath, fileContent, { encoding: "utf8" })
    }
  }
  ...
}
```

## 工程结构 & 模块类型

```text
customdecoration                               // har 类型
|---components
|   |---CallbackObserver.ets                   // 自定义装饰器
|   |---MainPage.ets                           // UI 页面
```

## 参考资料

- 自动生成代码插件实现
- 开发 hvigor 插件

## 更新记录

1.0.0 (2025-09-03)

## 权限与隐私

暂无

## 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 隐私政策

不涉及

## SDK 合规使用指南

不涉及

## 兼容性

HarmonyOS 版本 5.0.0

## 设备与应用信息

- 应用类型：应用
- 元服务：
- 设备类型：手机
- PC：
- DevEcoStudio 版本：DevEco Studio 5.0.0

Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f497bc831973477cb551753657e055c1/PLATFORM?origin=template