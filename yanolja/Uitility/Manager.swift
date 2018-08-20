//
//  Manager.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation

struct UserManager {
    private init() {}
    
    private static var _token: String?
    static var hasToken: Bool {
        guard _token == nil else { return true }
        if let token = UserDefaults.standard.string(forKey: "kToken") {
            _token = token
            return true
        }
        return false
    }
    static var token: String? {
        get { return hasToken ? "Token \(_token!)" : nil }
        set {
            _token = newValue
            UserDefaults.standard.set(newValue, forKey: "kToken")
        }
    }
    
}
