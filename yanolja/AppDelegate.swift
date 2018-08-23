//
//  AppDelegate.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var m_userInfo : UserInfo = UserInfo()
    var m_pensionInfo : PensionInfo = PensionInfo()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NavigationBarSetting()

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    // 네비게이션 바 색상 기본설정
    private func NavigationBarSetting(){
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.black
        navigationBarAppearace.barTintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handled
    }
    
    
    //iOS 10 이상을 사용하는 경우 다음 코드를 사용하여 위 샘플의 마지막 호출을 변경할 수 있습니다. 이렇게 하면 더욱 다양한 옵션을 사용할 수 있습니다.
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    } 

    func setLoginType(_ type : Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(type, forKey: "type")
    }
    
    // 로그인후 토큰사용하기 위해
    func setUserToken(_ token : String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(token, forKey: "token")
    }

}

