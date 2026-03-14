# Swift Result 类型 Demo

## 简介

展示 Swift Result 类型的用法：优雅处理成功和失败。

## 启动和使用

```bash
cd swift-result-type-demo
swift run
```

## 教程

### Result 类型

```swift
enum Result<Success, Failure: Error>
```

### 常用方法

- `get()`: 获取值或抛出错误
- `map`: 转换成功值
- `flatMap`: 链式转换

### 优势

- 明确表示成功/失败
- 避免异常控制流
