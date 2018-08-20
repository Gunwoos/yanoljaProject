//
//  ServiceResult.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation
enum Result<T> {
    case success(T)
    case error(Error)
}

enum ServiceError: Error {
    case invalidToken
    case invalidURL
    case parsingError
}

enum PostError: Error {
    case missingParameter(param: String)
    case encodingError
}

enum AuthError: Error {
    case invalidUsername
    case invalidPassword
}
