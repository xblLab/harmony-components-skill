# TypeScript 运行工具组件

## 简介

提供共享的 TypeScript 类型和运行时工具类型。

## 详细介绍

### 安装

```bash
ohpm install @ohos/smithy-types
```

### 使用

该包主要用于生成的客户端内部使用。一些公共组件具有独立的应用程序。

#### 场景：Removing | undefined from input and output structures

Generated shapes' members are unioned with undefined for input shapes, and are ? (optional) for output shapes.

for inputs, this defers the validation to the service.
for outputs, this strongly suggests that you should runtime-check the output data.

如果你想跳过这些步骤，可以使用 `AssertiveClient` 或 `UncheckedClient` 类型助手。以 AWS S3 为例：

```typescript
import { S3 } from "@ohos/aws-sdk-client-s3";
import type { AssertiveClient, UncheckedClient } from "@ohos/smithy-types";

const s3a = new S3({}) as AssertiveClient<S3>;
const s3b = new S3({}) as UncheckedClient<S3>;

// AssertiveClient enforces required inputs are not undefined
// and required outputs are not undefined.
const get = await s3a.getObject({
  Bucket: "",
  // @ts-expect-error (undefined not assignable to string)
  Key: undefined,
});

// UncheckedClient makes output fields non-nullable.
// You should still perform type checks as you deem
// necessary, but the SDK will no longer prompt you
// with nullability errors.
const body = await (
  await s3b.getObject({
    Bucket: "",
    Key: "",
  })
).Body.transformToString();
```

在使用 Command 语法对非聚合客户端应用转换时，由于输入会经过另一个类处理，因此无法进行验证。

```typescript
import { S3Client, ListBucketsCommand, GetObjectCommand, GetObjectCommandInput } from "@ohos/aws-sdk-client-s3";
import type { AssertiveClient, UncheckedClient, NoUndefined } from "@ohos/smithy-types";

const s3 = new S3Client({}) as UncheckedClient<S3Client>;

const list = await s3.send(
  new ListBucketsCommand({
    // command inputs are not validated by the type transform.
    // because this is a separate class.
  })
);

/**
 * Although less ergonomic, you can use the NoUndefined<T>
 * transform on the input type.
 */
const getObjectInput: NoUndefined<GetObjectCommandInput> = {
  Bucket: "undefined",
  // @ts-expect-error (undefined not assignable to string)
  Key: undefined,
  // optional params can still be undefined.
  SSECustomerAlgorithm: undefined,
};

const get = s3.send(new GetObjectCommand(getObjectInput));

// outputs are still transformed.
await get.Body.TransformToString();
```

#### 场景：Narrowing a smithy-types generated client's output payload blob types

This is mostly relevant to operations with streaming bodies such as within the S3Client in the AWS SDK for JavaScript v3.
Because blob payload types are platform dependent, you may wish to indicate in your application that a client is running in a specific environment. This narrows the blob payload types.

```typescript
import { GetObjectCommand, S3Client } from "@ohos/aws-sdk-client-s3";
import type { NodeJsClient, SdkStream, StreamingBlobPayloadOutputTypes } from "@ohos/smithy-types";
import type { IncomingMessage } from "node:http";

// default client init.
const s3Default = new S3Client({});

// client init with type narrowing.
const s3NarrowType = new S3Client({}) as NodeJsClient<S3Client>;

// The default type of blob payloads is a wide union type including multiple possible
// request handlers.
const body1: StreamingBlobPayloadOutputTypes = (await s3Default.send(new GetObjectCommand({ Key: "", Bucket: "" })))
  .Body!;

// This is of the narrower type SdkStream<IncomingMessage> representing
// blob payload responses using specifically the node:http request handler.
const body2: SdkStream<IncomingMessage> = (await s3NarrowType.send(new GetObjectCommand({ Key: "", Bucket: "" })))
  .Body!;
```

### 更新记录

| 版本 | 描述 |
| :--- | :--- |
| 1.0.1 | Update the smithy_types version number and release the production version |
| 1.0.1-rc.1 | add { path: string } to NodeJsRuntimeStreamingBlobPayloadInputTypes |
| 1.0.0 | adapted for openharmony |

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.2 |
| 应用类型 | 应用、元服务 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 |

## 安装方式

```bash
ohpm install @ohos/smithy-types
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d03d42f287dc4ca895797f019f72e1db/PLATFORM?origin=template