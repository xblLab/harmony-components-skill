# 商城优惠券组件

## 简介

本模块提供了优惠券的浏览与选择的能力，可以帮助开发者快速集成优惠券的相关业务。

## 详细介绍

### 简介

本组件提供了优惠券的浏览与选择的能力，可以帮助开发者快速集成优惠券的相关业务。

### 浏览选择

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_coupons` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_coupons 路径。其中 XXX 为组件存放的目录名
"modules": [
   {
   "name": "module_coupons",
   "srcPath": "./XXX/module_coupons"
   }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 中添加依赖
"dependencies": {
   "module_coupons": "file:./XXX/module_coupons"
}
```

#### 引入组件句柄

```typescript
import { Coupons, MyCouponsView } from 'module_coupons';
```

#### 浏览优惠券

浏览优惠券。详细入参配置说明参见 API 参考。

```typescript
MyCouponsView({
   useNow: couponId => {
      Logger.info(TAG, couponId);
      emitter.emit(EmitterConstants.TO_HOME);
      RouterModule.pop();
   },
})
```

#### 选择优惠券

选择优惠券。详细入参配置说明参见 API 参考。

```typescript
Coupons.select({
   totalMoney: this.totalMoney,
   selectId: this.couponId,
   confirm: params => {
      this.couponId = params.selectId;
      this.reduce = params.reduce;
   },
});
```

### API 参考

#### 子组件

无

#### Coupons

优惠券管理类。

##### 方法入参说明

| 方法 | 说明 |
| :--- | :--- |
| `select(params: SelectCouponParams)` | 开启选择优惠券半模态弹窗 |
| `close()` | 关闭选择优惠券半模态弹窗 |

##### SelectCouponParams

选择优惠券入参类型。

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `totalMoney` | `number` | 是 | 订单总金额 |
| `selectId` | `string` | 是 | 已选优惠券 ID |
| `confirm(params: OnPopParams) => void` | `function` | 否 | 确定按钮执行回调 |

##### OnPopParams

确定按钮回调传递数据类型。

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `reduce` | `number` | 是 | 减免金额，为空时为 0 |
| `selectId` | `string` | 是 | 选择优惠券 ID，为空时为空字符串 |

#### MyCouponsView

浏览我的优惠券组件。

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `useNow(couponId: string) => void` | `function` | 否 | 立即使用按钮，执行回调事件。传递当前优惠券 ID |

#### TabComp

自定义带导航条动画的 Tab 组件。

| 参数 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| `tabBar` | `string[]` | 是 | 页签名数组 |
| `index` | `number` | 否 | 初始 Tab 页索引，支持!!双向绑定 |
| `contentUi(index: number) => void` | `function` | 否 | 自定义内容区域 |
| `tabBarUi() => void` | `function` | 否 | 页签居左时，自定义尾部页签区域 |
| `top` | `boolean` | 否 | 页签所处位置：默认居顶 |
| `start` | `boolean` | 否 | 页签对齐方式：默认居中 |
| `friction` | `number \| Resource` | 否 | 页签居左可滚动时，设置的摩擦系数 |
| `space` | `number` | 否 | 页签间隙 |
| `offsetLeft` | `number` | 否 | 页签左边距 |
| `offsetRight` | `number` | 否 | 页签右边距 |
| `activeColor` | `ResourceColor` | 否 | 选中文字颜色，包括导航条 |
| `frozenColor` | `ResourceColor` | 否 | 正常文字颜色 |
| `activeSize` | `string \| number \| Resource` | 否 | 选中文字大小 |
| `frozenSize` | `string \| number \| Resource` | 否 | 正常文字大小 |
| `activeWeight` | `number \| string \| FontWeight` | 否 | 选中文字粗细 |
| `frozenWeight` | `number \| string \| FontWeight` | 否 | 正常文字粗细 |
| `tabBarBgColor` | `ResourceColor` | 否 | 页签区背景颜色 |
| `tabContentBgColor` | `ResourceColor` | 否 | 内容背景颜色 |
| `animationDuration` | `number` | 否 | 动画时长 |
| `tabBarHeightLength` | `number` | 否 | 导航区高度 |
| `lineHeightLength` | `number` | 否 | 导航条高度 |
| `relativeY` | `number` | 否 | 条形相对页签的垂直位置 |

### 示例代码

#### 浏览优惠券

本示例通过 `MyCouponsView` 组件搭建我的优惠券页面。

```typescript
import { MyCouponsView } from 'module_coupons';

@Entry
@ComponentV2
struct CouponsShow {
  build() {
    Navigation() {
      MyCouponsView({
        useNow: (couponId) => {
          console.log('[CouponDetail]', couponId);
        },
      })
    }
    .titleMode(NavigationTitleMode.Mini)
    .title('我的优惠券')
    .mode(NavigationMode.Stack)
  }
}
```

#### 选择优惠券

本示例通过 `Coupons.select` 方法拉起半模态、实现优惠券的选择。

```typescript
import { Coupons } from 'module_coupons';

@Entry
@ComponentV2
struct CouponsSelect {
  @Local totalMoney: number = 1000;
  @Local selectId: string = '';
  @Local reduce: number = 0;

  build() {
    Navigation() {
      Column({ space: 20 }) {
        Text('订单金额：' + this.totalMoney).fontSize(18)
        Row() {
          Text('优惠券减免：').fontSize(18)
          Text(this.reduce !== 0 ? this.reduce.toString() : '去选择')
            .fontSize(18)
            .decoration({ type: TextDecorationType.Underline })
            .onClick(() => {
              Coupons.select({
                totalMoney: this.totalMoney,
                selectId: this.selectId,
                confirm: (params) => {
                  this.selectId = params.selectId;
                  this.reduce = params.reduce;
                },
              })
            })
        }
      }
      .padding({ top: 30 })
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
    }
    .titleMode(NavigationTitleMode.Mini)
    .title('选择优惠券')
    .mode(NavigationMode.Stack)
  }
}
```

#### 自定义 Tab

本示例通过 `TabComp` 组件快速搭建自定义 Tab。

```typescript
import { TabComp } from 'module_coupons'

@Entry
@ComponentV2
struct CouponsTab {
  @Local index: number = 1;

  build() {
    Navigation() {
      TabComp({
        tabBar: ['页签 0', '页签 1', '页签 2', '页签 3'],
        index: this.index!!,
        space: 30,
        contentUi: (index) => {
          this.contentBuilder(index)
        },
      })
    }
    .titleMode(NavigationTitleMode.Mini)
    .title('自定义 Tab')
    .mode(NavigationMode.Stack)
  }

  @Builder
  contentBuilder(index: number) {
    Column() {
      Text('自定义内容' + index).fontSize(20)
    }.height('100%').justifyContent(FlexAlign.Center)
  }
}
```

### 更新记录

| 版本 | 日期 | 说明 | 操作 |
| :--- | :--- | :--- | :--- |
| 1.0.2 | 2026-01-13 | 废弃 API 整改 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%9F%8E%E4%BC%98%E6%83%A0%E5%88%B8%E7%BB%84%E4%BB%B6/module_coupons1.0.2.zip) |
| 1.0.1 | 2025-10-31 | README 更新 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%9F%8E%E4%BC%98%E6%83%A0%E5%88%B8%E7%BB%84%E4%BB%B6/module_coupons1.0.2.zip) |
| 1.0.0 | 2025-08-29 | 初始版本 | [下载该版本](https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%9F%8E%E4%BC%98%E6%83%A0%E5%88%B8%E7%BB%84%E4%BB%B6/module_coupons1.0.2.zip) |

### 权限与隐私

| 基本信息 | 详情 |
| :--- | :--- |
| 权限名称 | `ohos.permission.INTERNET` |
| 权限说明 | 允许使用 Internet 网络。 |
| 使用目的 | 允许使用 Internet 网络。 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 类别 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9117c66c114e4788a134650be80f2cd2/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%95%86%E5%9F%8E%E4%BC%98%E6%83%A0%E5%88%B8%E7%BB%84%E4%BB%B6/module_coupons1.0.2.zip