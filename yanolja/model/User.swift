//
//  User.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation

//                {
//                    "username": "seob1377@gmail.com",
//                    "password": "qwer1234",
//                    "password2": "qwer1234",
//                    "is_superuser": false,
//                    "is_staff": false,
//                    "is_active": false,
//                    "phone_number": "01011112222",
//                    "groups": [],
//                    "user_permissions": []
//            }


class UserInfo {
    
    var username : String? 
    var phone_number : String?
    var token: String?
    var isLogin : Bool?
    
    func parse(_ object : AnyObject) {
        
        let global = Global()
        
        
        self.username = global.getStringValue(object, key: "username")
        self.phone_number = global.getStringValue(object, key: "phone_number")
        self.token = global.getStringValue(object, key: "token")
    }
}

