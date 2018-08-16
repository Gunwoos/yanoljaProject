//
//  SettingViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBAction private func loginDidTap(_ sender: UIButton){
        //        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        //
        //        present(vc, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        let navi = UINavigationController(rootViewController: vc)
        navi.isNavigationBarHidden = true
        self.navigationController?.popToViewController(navi, animated: true)
        //AppDelegate.instance?.presentMainLoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalTransitionStyle = .coverVertical
    }
    
    
}
