//
//  Constants.swift
//  yanolja
//
//  Created by seob on 2018. 8. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://api.pmb.kr/"
    
    enum Auth {
        static let signUp = API.baseURL + "members/signup/"
        static let signIn = API.baseURL + "members/login/"
        static let memberDetail = API.baseURL + "members/detail/"
    }
}
