//
//  DataModel.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 26/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

public struct UncertainValue<T: Decodable, U: Decodable>: Decodable {
    public var tValue: T?
    public var uValue: U?
    
    public var value: Any? {
        return tValue ?? uValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        tValue = try? container.decode(T.self)
        uValue = try? container.decode(U.self)
        if tValue == nil && uValue == nil {
            //Type mismatch
            throw DecodingError.typeMismatch(type(of: self), DecodingError.Context(codingPath: [], debugDescription: "The value is not of type \(T.self) and not even \(U.self)"))
        }
        
    }
}


class DataModel: FFObject {
    
    
    var primaryID: Int64?
    var ROWID : AnyCodable?
    
    var name : String?

    required init() {
        
    }
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    
    static func autoincrementColumn() -> String? {
        return "primaryID"
    }
    
    
}
