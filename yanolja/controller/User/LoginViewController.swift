//
//  LoginViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Toaster

final class LoginViewController: BaseViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpwd: UITextField!
    @IBOutlet weak var fbloginButton: FBSDKLoginButton!
    
    @IBAction func loginDidTap(_ sender: Any) {
        if let userid = username.text {
            if userid.isEmpty {
                showToast("아이디를 입력해 주세요.") 
            }else if !self.globalFuncs.checkEmail(userid) {
                showToast("이메일형식이 올바르지 않습니다.")
            }else{
                check_duplicate()
            }
        }
        
//        if let userpwd = userpwd.text {
//            if userpwd.isEmpty {
//                showToast("비밀번호를 입력해 주세요.")
//            }else if !self.globalFuncs.isPasswordValid(userpwd) {
//                showToast("비밀번호는 최소 6자리 이상입니다.")
//            }else{
//                check_duplicate()
//            }
//        }
    }
   
    @IBAction func findUserinfoDidTap(_ sender: Any){
        
    }
    
    func check_duplicate(){
        print("chech values")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "로그인"
        self.username.delegate = self
        self.userpwd.delegate = self
        self.navigationController?.isNavigationBarHidden = false
 //        //읽기권한 추가
        fbloginButton.readPermissions = ["public_profile","email","user_friends"]
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.username.becomeFirstResponder()
    } 
}



// MARK : - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if(textField.isEqual(self.username)){ //username에서 리턴키를 눌렀다면
            self.userpwd.becomeFirstResponder()//컨텐츠필드로 포커스 이동
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.userpwd.resignFirstResponder()
    }
}
