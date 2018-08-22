//
//  SqlConnectViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
// 테스트용

import UIKit
import SQLite
import SQLite3
class SqlConnectViewController: UIViewController {
    ///Users/seob/Desktop/Git/yanoljaProject
    let db = try! Connection("/Users/seob/Desktop/Git/yanoljaProject/db.sqlite3")
    override func viewDidLoad() {
        super.viewDidLoad()
        let users = Table("location_pension")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        
        for user in try! db.prepare(users) {
            print("id: \(user[id]), name: \(String(describing: user[name]))")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
        }
    }
 

}
