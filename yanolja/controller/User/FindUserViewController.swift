//
//  FindUserViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Alamofire
import Toaster

class FindUserViewController: UIViewController {
    
    @IBAction func findUserinfoDidTap(_ sender: Any){
        print("찾기")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.title = "계정정보 찾기"
    }
    

}
