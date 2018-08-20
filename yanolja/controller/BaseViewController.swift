//
//  BaseViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Toaster

class BaseViewController: UIViewController {

    let TOP_BAR_MAIN_PAGE = 0
    let TOP_BAR_SUB_PAGE = 1
    let TOP_BAR_SINGLE_PAGE = 2
    
    let globalFuncs = Global()
    
    var m_appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.onLocalNotificationReceived(_:)), name: nil, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
        
        //        m_bViewAppeared = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
        
        //        m_bViewAppeared = false
    }
    
    
    
    /**
     * Notification 수신 처리부
     */
    @objc func onLocalNotificationReceived(_ notification : Notification) {
        switch notification.name {
        case Notification.Name(NOTI_PUSH_ALARM as String) :
            let msg = notification.object as! String
            self.pushAction(msg: msg)
        default:
            break
        }
    }
    
    func pushAction(msg : String) {
        let nav : UINavigationController! = self.navigationController
        let viewVCs : [BaseViewController] = nav.viewControllers as! [BaseViewController]
        
        for vc in viewVCs {
            if self == vc {
                let title : NSString = "푸시알림"
                let alertController = UIAlertController(title: title as String, message : msg as String, preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "확인", style: .default) { (action:UIAlertAction!) in
                    self.pushVC("ALERT_LIST_VIEW", storyboard: "Home", animated: true)
                }
                
                let CancelAction = UIAlertAction(title: "취소", style: .cancel) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(OKAction)
                alertController.addAction(CancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
  
 
    
   
    func replaceVC(_ identifier : String, storyboard : String, animated : Bool) {
        let nav : UINavigationController! = self.navigationController
        let storyboard : UIStoryboard! = UIStoryboard.init(name: storyboard, bundle: nil)
        
        let vc = (storyboard.instantiateViewController(withIdentifier: identifier))
        
        nav.setViewControllers([vc], animated: animated)
    }
    
    func pushVC(_ identifier : String, storyboard : String, animated : Bool) {
        let nav : UINavigationController! = self.navigationController
        let storyboard : UIStoryboard! = UIStoryboard.init(name: storyboard, bundle: nil)
        
        let vc = (storyboard.instantiateViewController(withIdentifier: identifier))
        
        nav.pushViewController(vc, animated: animated)
    }
    
    func popVC(_ backStep : Int32 = -1) {
        let nav : UINavigationController! = self.navigationController
        
        var viewVCs : [UIViewController] = nav.viewControllers
        for _ in 1...(0 - backStep) {
            viewVCs.removeLast()
        }
        nav.setViewControllers(viewVCs, animated: true)
    }
    
    func presentVC(_ identifier : String, storyboard : String, animated : Bool) {
        let storyboard : UIStoryboard! = UIStoryboard.init(name: storyboard, bundle: nil)
        
        let vc = (storyboard.instantiateViewController(withIdentifier: identifier))
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: animated, completion: nil)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func showErrorMsg(_ result_code : Int) {
        switch result_code {
            
        case Int(RESULT_DB_ERROR):
            self.showToast(MSG_DB_ERROR)
            break
            
        case Int(RESULT_PARAM_ERROR):
            self.showToast(MSG_PARAM_ERROR)
            break
            
        case Int(RESULT_NO_INFO_ERROR):
            self.showToast(MSG_NO_INFO_ERROR)
            break
            
        case Int(RESULT_FILE_UPLOAD_ERROR):
            self.showToast(MSG_FILE_UPLOAD_ERROR)
            break
            
        case Int(RESULT_INVALID_PRIVILEGE_ERROR):
            self.showToast(MSG_INVALID_PRIVILEGE_ERROR)
            break
            
        case Int(RESULT_NO_USER_ERROR):
            self.showToast(MSG_NO_USER_ERROR)
            break
            
        case Int(RESULT_EMAIL_DUP_ERROR):
            self.showToast(MSG_EMAIL_DUP_ERROR)
            break
            
        case Int(RESULT_NICKNAME_DUP_ERROR):
            self.showToast(MSG_NICKNAME_DUP_ERROR)
            break
            
        case Int(RESULT_PHONE_DUP_ERROR):
            self.showToast(MSG_PHONE_DUP_ERROR)
            break
            
        case Int(RESULT_WRONG_PW_ERROR):
            self.showToast(MSG_WRONG_PW_ERROR)
            break
            
        case Int(RESULT_WRONG_CERT_KEY_ERROR):
            self.showToast(MSG_WRONG_CERT_KEY_ERROR)
            break
            
        case Int(RESULT_GENERATE_ID_ERROR):
            self.showToast(MSG_GENERATE_ID_ERROR)
            break
            
        case Int(RESULT_INFO_DUP_ERROR):
            self.showToast(MSG_INFO_DUP_ERROR)
            break
            
        default:
            self.showToast(MSG_NETWORK_ERROR)
        }
    }
    
    /////////////////////////////////////////////////
    // KeyboardNotifcation processing
    
    // Called when the UIKeyboardDidShowNotification is sent.
    @objc func keyboardWasShown (_ aNotification : Notification) {
        
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    @objc func keyboardWillBeHidden (_ aNotification : Notification) {
        
    }
    
    // 토스트메시지현시함수
    func showToast(_ strMsg : String?) {
        
        let style = CSToastStyle.init(defaultStyle: ())
        style?.cornerRadius = 10
        style?.verticalPadding = 15
       // style?.displayWrap = false
        
        view.makeToast(strMsg, duration: 1.0, position: CSToastPositionCenter, style: style)
        
    }
    
    func showToast(_ strMsg : String?, completion: @escaping (Bool) -> Void) {
        
        let style = CSToastStyle.init(defaultStyle: ())
        style?.cornerRadius = 15
        style?.verticalPadding = 5
        style?.displayWrap = false
        
        view.makeToast(strMsg, duration: 1, position: CSToastPositionBottom, title: nil, image: nil, style: style, completion: { (didTap) -> Void in
            completion(didTap)
        })
    }
    
    //화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
}


