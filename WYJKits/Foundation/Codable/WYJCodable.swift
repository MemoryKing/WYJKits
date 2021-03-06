/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import Foundation

public enum WYJCodableError: Error {
    ///json转model失败
    case jsonToModelFail
    ///json转data失败
    case jsonToDataFail
    ///字典转json失败
    case dicToJsonFail
    ///json转数组失败
    case jsonToArrFail
    ///model转json失败
    case modelToJsonFail
}


public protocol WYJCodable: Codable {
    init(from decoder: Any?) throws
    init(from decoder: String?) throws
    init(from decoder: Dictionary<String,Any>?) throws
}
public extension WYJCodable {
    init(from decoder: Any?) throws {
        self = try Self.yi_init(decoder)
    }
    init(from decoder: String?) throws {
        self = try Self.yi_init(jsons: decoder)
    }
    init(from decoder: Dictionary<String,Any>?) throws {
        self = try Self.yi_init(dictionary: decoder)
    }
}
public extension WYJCodable {
    
    ///模型转字典
    func toDictionary() -> [String:Any] {
        let mirro = Mirror(reflecting: self)
        var dict = [String:Any]()
        for case let (key?, value) in mirro.children {
            dict[key] = value
        }
        return dict
    }
    
    ///model 转 json
    func toJSON() throws -> String {
        if let jsonData = try? JSONEncoder().encode(self) {
            if let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonString
            }
        }
        throw WYJCodableError.dicToJsonFail
    }

    static func yi_init<T : WYJCodable>(_ t: Any?) throws -> T {
        switch t {
            case let dic as Dictionary<String, Any>:
                guard let JSONString = dic.yi.toJSONString() else {
                    throw WYJCodableError.dicToJsonFail
                }
                guard let jsonData = JSONString.data(using: .utf8) else {
                    throw WYJCodableError.jsonToDataFail
                }
                let decoder = JSONDecoder()
                do {
                    let obj = try decoder.decode(T.self, from: jsonData)
                    return obj
                }catch {
                    WYJLog(error)
                }
            case let json as String:
                guard let jsonData = json.data(using: .utf8) else {
                    throw WYJCodableError.jsonToDataFail
                }
                let decoder = JSONDecoder()
                do {
                    let obj = try decoder.decode(T.self, from: jsonData)
                    return obj
                }catch {
                    WYJLog(error)
                }
            default:
            break
        }
        throw WYJCodableError.jsonToModelFail
    }
    
    ///dic 转 model
    static func yi_init<T : WYJCodable>(dictionary dic: Dictionary<String, Any>?) throws -> T {
        
        guard let JSONString = dic?.yi.toJSONString() else {
            throw WYJCodableError.dicToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            throw WYJCodableError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        do {
            let obj = try decoder.decode(T.self, from: jsonData)
            return obj
        }catch {
            WYJLog(error)
        }
        throw WYJCodableError.jsonToModelFail
    }
    ///jsonstring 转 model
    static func yi_init<T : WYJCodable>(jsons json: String?) throws -> T {
        
        guard let jsonData = json?.data(using: .utf8) else {
            throw WYJCodableError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        do {
            let obj = try decoder.decode(T.self, from: jsonData)
            return obj
        }catch {
            WYJLog(error)
        }
        throw WYJCodableError.jsonToModelFail
    }
}


