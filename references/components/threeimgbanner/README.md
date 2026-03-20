# 三图 Banner 轮播滑动展示组件

## 简介

三图 Banner 轮播滑动展示组件可同时出现的 3 张轮播图，可滑动一张张滑动到屏幕内，可通过回调函数拿到轮播图当前元素信息和下标索引以配合业务需求，如展会，电影等，并带动相关业务的信息同步切换展示。

## 详细介绍

### 使用

#### 安装

```bash
ohpm install threeimgbanner
```

#### 导入模块

```typescript
import { CardInfo, threeImgBanner } from 'threeimgbanner';
```

#### 引用模块组件

```typescript
threeImgBanner({
    initCardsList:  this.initCardsList,
    currentIndex:1,
    onClickCustom:(param)=>{
        console.log('pkl--切换到了'+param.title+'图片')
    },
    onChnageCustom:(index)=>{
        console.log('pkl--切换到了第'+index+'张图片')
    }
})
```

如果项目已配置了证书和签名信息，运行前可能需要做如下配置，若运行不报错可忽视，报错时请参考下文注意事项。

需要在工程级 `build-profile.json5` 添加 `"useNormalizedOHMUrl"` 为 `true` 如下代码：

```json5
"products": [
    {
      "name": "default",
      "signingConfig": "default",
      "compatibleSdkVersion": "5.0.1(12)",
      "runtimeOS": "HarmonyOS",
      //必须添加的代码
      "buildOption": {
        "strictMode": {
          "useNormalizedOHMUrl": true
        }
      }
    }
  ],
```

## API 参数

**threeImgBanner(options: threeImgBannerOptions)**

**threeImgBannerOptions 数据类型介绍**

| 参数说明 | 类型 |
| :--- | :--- |
| `initCardsList` | 你的 banner 数组 `CardInfo[]` |
| `currentIndex` | 你的 banner 数组的下标索引，默认为 1，可配置此项打开时默认的选中图片 `number` |
| `onClickCustom` | 点击图片回调，可回调 banner 数组中的整个元素 `(param: CardInfo) => void` |
| `isUseDeviceWidth` | 是否使用设备的宽度，默认为 `true`，及该轮播图的宽度为设备屏幕宽度，若传入 `false`，请传入 `fatherWidth` 数值单位为 vp `boolean` |
| `fatherWidth` | 当不使用屏幕宽度时，父容器宽度位为 vp，若为适配折叠设备请将监听断点宽度传入 `fatherWidth` `number` |
| `CustomHeight` | 容器高度，默认为 200 最佳，单位为 vp，想要自定义请结合 `radioImg` 调节，因为图片宽度永远等于屏幕或自定义的 `fatherWidth` 宽度 `number` |
| `radioImg` | 图片宽高比，默认为 3/4，因为宽度一定，所以图片高度为屏幕宽度的 `radioImg` 倍，推荐可选为 1/1 或 3/4 `number` |
| `onChnageCustom` | 滑动切换时的回调，可回调切换到的图片下标索引 `(index:number)=>void` |

## CardInfo 对象介绍

| 参数说明 | 类型 |
| :--- | :--- |
| `src` | 图片资源 `ResourceStr` |
| `url` | 跳转路径，网络路径或本地路径 `string` |
| `title` | 标题 `string` |

## 详细引用介绍

```typescript
threeImgBanner({
       
  initCardsList:  this.initCardsList, //你的 banner 数组
        
  currentIndex:1, //你的 banner 数组的下标索引，默认为 1，可配置此项打开时默认的选中图片
        
  onClickCustom:(param)=>{ 
    //点击图片回调，可回调 banner 数组中的整个元素
        console.log('pkl--切换到了'+param.title+'图片')
      },
  
  isUseDeviceWidth:false,//isUseDeviceWidth 是否使用设备的宽度，默认为 true，及该轮播图的宽度为设备屏幕宽度，若传入 false，请传入 fatherWidth 数值单位为 vp;
  
  fatherWidth:200, //当不使用屏幕宽度时，父容器宽度位为 vp，若为适配折叠设备请将监听断点宽度传入 fatherWidth
  
  CustomHeight:180, //容器高度，默认为 200 最佳，单位为 vp，想要自定义请结合 radioImg 调节，因为图片宽度永远等于屏幕或自定义的 fatherWidth 宽度
  
  radioImg:1/1,  //图片宽高比默认为 3/4，因为宽度一定，所以图片高度为屏幕宽度的 radioImg 倍，推荐可选为 1/1 或 3/4
  
  onChnageCustom:(index)=>{
         //滑动切换时的回调，可回调切换到的图片下标索引
        console.log('pkl--切换到了第'+index+'张图片')
     }
      })
```

## 注意事项

1. 如果导入引用后，运行报错 `[***] not supported when useNormalizedOHMUrl is not true`

   需要在工程 `build-profile.json5` 添加 `"useNormalizedOHMUrl"` 为 `true` 如下代码：

   ```json5
       "products": [
           {
             "name": "default",
             "signingConfig": "default",
             "compatibleSdkVersion": "5.0.1(12)",
             "runtimeOS": "HarmonyOS",
             //必须添加的代码
             "buildOption": {
               "strictMode": {
                 "useNormalizedOHMUrl": true
               }
             }
           }
         ],
   ```

2. 该 banner 轮播图默认使用屏幕宽度，如果业务需求需要自定义宽度，请传入 `fatherWidth` 数值单位为 vp；并将 `isUseDeviceWidth` 设置为 `false`。`fatherWidth` 和 `isUseDeviceWidth=false` 需要同时成对出现。

## git 仓库

https://gitee.com/kylepeng2208/three-imgs-banner.git

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

**1.0.1 (2025-11-14)**
展示同时出现的 3 张轮播图，可滑动一张张滑动到屏幕内，可配置回调拿到轮播图当前元素信息和下标索引。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.1 <br> 5.0.2 <br> 5.0.3 <br> 5.0.4 <br> 5.0.5 <br> 5.1.0 <br> 5.1.1 |
| **应用类型** | 应用 <br> 元服务 |
| **设备类型** | 手机 <br> 平板 <br> PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.1 <br> DevEco Studio 5.0.2 <br> DevEco Studio 5.0.3 <br> DevEco Studio 5.0.4 <br> DevEco Studio 5.0.5 <br> DevEco Studio 5.1.0 <br> DevEco Studio 5.1.1 |

## 安装方式

```bash
ohpm install threeimgbanner
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/1ad7aab28cb94a6bb202b83b5f6363a5/b098cd357fa14bc8a1870ef975357acf?origin=template