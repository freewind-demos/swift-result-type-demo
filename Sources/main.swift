// swift-result-type-demo.swift

import Foundation

// ============ Result 基本用法 ============
enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

// 使用 Result 的函数
func fetchData(from url: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
    if url.isEmpty {
        completion(.failure(.badURL))
        return
    }

    if url.contains("error") {
        completion(.failure(.noData))
        return
    }

    completion(.success("数据内容"))
}

// 处理 Result
fetchData(from: "https://example.com") { result in
    switch result {
    case .success(let data):
        print("成功: \(data)")
    case .failure(let error):
        switch error {
        case .badURL:
            print("错误: 无效URL")
        case .noData:
            print("错误: 无数据")
        case .decodingError:
            print("错误: 解码失败")
        }
    }
}

// ============ Result 的便捷方法 ============
let success: Result<Int, Error> = .success(100)
let failure: Result<Int, Error> = .failure(NetworkError.noData)

// get() - 获取值或抛出错误
do {
    let value = try success.get()
    print("值: \(value)")
} catch {
    print("错误: \(error)")
}

// map - 转换成功值
let mapped = success.map { $0 * 2 }
print("map: \(mapped)")

// flatMap - 链式转换
let flatMapped = success.flatMap { value -> Result<String, Error> in
    if value > 50 {
        return .success("大数值")
    }
    return .failure(NetworkError.noData)
}

// ============ 异步 Result ============
func fetchAsync() async -> Result<String, Error> {
    try? await Task.sleep(nanoseconds: 100_000_000)
    return .success("异步数据")
}

Task {
    let result = await fetchAsync()
    print("异步结果: \(result)")
}

// ============ Result 作为返回类型 ============
func divide(_ a: Int, _ b: Int) -> Result<Int, Error> {
    guard b != 0 else {
        return .failure(NSError(domain: "Math", code: 1, userInfo: [NSLocalizedDescriptionKey: "除数不能为零"]))
    }
    return .success(a / b)
}

let divResult = divide(10, 2)
print("10 / 2 = \(divResult)")

let divResult2 = divide(10, 0)
print("10 / 0 = \(divResult2)")

// ============ Dictionary tryValues ============
func getUser(id: Int) -> Result<String, Error> {
    let users = [1: "Tom", 2: "Jerry"]
    guard let name = users[id] else {
        return .failure(NSError(domain: "User", code: 404, userInfo: [NSLocalizedDescriptionKey: "用户不存在"]))
    }
    return .success(name)
}

print(getUser(id: 1))
print(getUser(id: 999))
