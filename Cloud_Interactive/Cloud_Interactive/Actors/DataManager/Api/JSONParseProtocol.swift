//
//  JSONParseProtocol.swift
//  Cloud_Interactive
//
//  Created by YuCheng on 2021/2/2.
//

import Foundation


public protocol JSONEmptyRepresentable {
  associatedtype CodingKeyType: CodingKey
}

extension KeyedDecodingContainer {
  public func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable & JSONEmptyRepresentable {
    if contains(key) {
      let container = try nestedContainer(keyedBy: type.CodingKeyType.self,
                                          forKey: key)
      if container.allKeys.isEmpty {
        return nil
      }
    } else {
      return nil
    }
    return try decode(T.self, forKey: key)
  }
}
