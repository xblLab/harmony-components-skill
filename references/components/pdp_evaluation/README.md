# evaluation 口语评测引擎组件

## 简介

口语评测引擎

## 详细介绍

### 简介

Evaluation2.0 是基于声通封装的仅供书本库@pdp/book 使用的评测引擎库。

### 如何安装

```bash
ohpm install @pdp/evaluation
```

### 如何使用

备注：在使用之前请先申请麦克风权限，使用以下方法申请：

```typescript
const grant = await EvaluationManager.requestPermission()
if (grant) {
  // 获取到权限
}
```

#### 1、初始化

```typescript
evaluationManager = new EvaluationManager()
```

#### 2、设置评测回调

```typescript
evaluationManager.callBack = (async (result?: EvaluationResult|null)=>{
  // 在此处理评测结果
})
```

#### 3、开始评测

```typescript
// 指定评测文字及评测类型
evaluationManager.start('这是评测文字', CoreType.cn_phrases)
```

#### 4、结束评测

```typescript
// 在调用该方法后，会进行第二步的评测回调
evaluationManager.stop()
```

### 更新记录

- **2.0.8**
  - 修复数字为中文拼音评测 bug
- **2.0.7**
  - 录音器
- **2.0.6**
  - 本地音频评测支持 pcm 格式
- **2.0.5**
  - 评测支持本地音频
- **2.0.4**
  - 评测结果返回评测时长
- **2.0.3**
  - 修复评测音标大小写敏感问题，首次安装英文支持离线评测失败修复
- **2.0.2**
  - 支持 2.0 之前版本评测本地数据
- **2.0.1**
  - 修复评测多次初始化问题
- **2.0.0**
  - 评测引擎替换
- **1.1.3**
- **1.1.2**
  - 添加评测总结果流畅度
- **1.1.1**
  - 修复评测总结果分数不准确问题
- **1.1.0**
  - 修复连续重复调用导致 crash 的线上问题
  - 增加流程监控日志
  - 修复 wav 格式的录音文件在 Windows 机器无法播放的问题
- **1.0.0**
  - 支持中文、英文、拼音、音标、自然拼读评测

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

- **HarmonyOS 版本**: 5.0.0

### 其他信息

- **应用类型**: 应用
- **元服务**: 
- **设备类型**: 手机、平板、PC
- **DevEcoStudio 版本**: DevEco Studio 5.0.0

## 安装方式

```bash
ohpm install @pdp/evaluation
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3e7414ed398247d4a2e078fde40b8fd1/PLATFORM?origin=template