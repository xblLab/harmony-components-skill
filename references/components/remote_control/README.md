# 万能空调遥控器组件

## 简介

本组件提供了空调遥控器创建，删除及以发射红外信号控制对应空调等功能。

## 详细介绍

### 简介

本组件提供了空调遥控器创建，删除及以发射红外信号控制对应空调等功能。

### 工程代码结构

本组件工程代码结构如下所示：
```text
remote_control/src/main/ets                       // 空调遥控器 (har)
 |- constant                                     // 模块常量定义   
 |- components                                   // 模块组件
 |- model                                        // 模型定义  
 |- util                                         // 模块工具类 
 |- http                                         // 请求定义  
 |- pages                                        // 页面
 |- viewmodel                                    // 与页面一一对应的 vm 层  
```

### 约束与限制

#### 环境

*   **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
*   **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
*   **设备类型**：华为手机（包括双折叠和阔折叠）
*   **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

*   **红外发射权限**：`ohos.permission.MANAGE_INPUT_INFRARED_EMITTER`

#### 调试

空调遥控器不能使用模拟器调试，请使用真机调试。

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1.  解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下