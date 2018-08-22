//
//  SettingViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController  {
   
    @IBOutlet weak var loginButton: UIButton!
    
    let token = UserDefaults.standard.string(forKey : "token") ?? ""
    @IBAction private func loginDidTap(_ sender: UIButton){
         if token.isEmpty {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
            let navi = UINavigationController(rootViewController: vc)
            navi.isNavigationBarHidden = true
            self.navigationController?.popToViewController(navi, animated: true)
         } else{
            UserDefaults.standard.removeObject(forKey: "token")
            self.replaceVC("SettingViewController", storyboard: "Main", animated: true)
        }
    }
    
    @IBAction private func logoutDidTap(_ sender: UIButton) {
         print("\n ----------- [logoutDidTap] ----------- \n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if token.isEmpty {
            loginButton.setTitle("회원가입 및 로그인", for: .normal)
         } else {
            loginButton.setTitle("로그아웃", for: .normal)
         }
    }
    
}
