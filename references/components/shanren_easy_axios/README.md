# shanren/easy_axios 请求工具组件

## 简介

本模块是对 Axios 简单封装，使其调用更便利。

## 详细介绍

### 简介

本模块是对 Axios 简单封装，使其调用更便利。

### Request & Plugin

#### 安装

```bash
ohpm install @shanren/easy_axios
```

#### Required Permissions

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 暂无 | 暂无 |

#### 例子

```typescript
export class HeaderPlugin implements Plugin {
    request(config: NetworkingRequestConfig): NetworkingRequestConfig {
        config.baseURL = 'https://xxxx.com'
        config.headers['Content-Type'] = 'application/json'
        config.headers['Accept-Language'] = 'zh_CN_#Hans'
        config.headers['platform'] = 'HM'
        return config
    }

    requestCatch(error: NetworkingError): Error {
        return error
    }

    onResponse(response: NetworkingResponse): NetworkingResponse {
        return response
    }

    onResponseCatch(error: NetworkingError): Error {
        return error
    }
}

export const defaultRequest = new Request([new HeaderPlugin(), new LogPlugin()])

defaultRequest.send<T>({
    method: 'post',
    url:'/xxxx/xxx/xx/x',
    data: {
        xxx: 123,
        yyy: 123,
    },
    headers: { "Accept": "application/json" }
})
```

#### 许可证协议

Apache 2.0

#### 更新记录

**[v1.0.1] 2026-01**

局部功能优化：

- LogPlugin 优化日志输出
- Request 支持自定义 config

**[v1.0.0] 2024-10**

基于 [axios] 封装，已支持：

- Request
- Plugin

#### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | 无 |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.0 |

#### 权限与隐私

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

## 安装方式

```bash
ohpm install @shanren/easy_axios
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ebdb4260369b4b08ba5adff36a4a7ad9/PLATFORM?origin=template