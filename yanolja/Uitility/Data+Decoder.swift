//
//  Data+Decoder.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation
extension Data {
    func decode<T>(_ type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Decodable {
        return try decoder.decode(type, from: self)
    }
}
