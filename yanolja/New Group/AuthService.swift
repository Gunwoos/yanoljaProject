//
//  AuthService.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
    // 1
    enum Constants {
        static let baseURLPath = API.baseURL
        static let authenticationToken = "Basic xxx"
    }
    
    // 2
    case content
    case tags(String)
    case colors(String)
    
    // 3
    var method: HTTPMethod {
        switch self {
        case .content:
            return .post
        case .tags, .colors:
            return .get
        }
    }
    
    // 4
    var path: String {
        switch self {
        case .content:
            return "/content"
        case .tags:
            return "/tagging"
        case .colors:
            return "/colors"
        }
    }
    
    // 5
    var parameters: [String: Any] {
        switch self {
        case .tags(let contentID):
            return ["content": contentID]
        case .colors(let contentID):
            return ["content": contentID, "extract_object_colors": 0]
        default:
            return [:]
        }
    }
    
    // 6
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(Constants.authenticationToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

