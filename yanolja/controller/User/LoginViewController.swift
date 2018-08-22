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
import Alamofire

final class LoginViewController: BaseViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpwd: UITextField!
    @IBOutlet weak var fbloginButton: FBSDKLoginButton!
   // var authService: AuthServiceType?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.username.delegate = self
        self.userpwd.delegate = self
        
        self.navigationController?.isNavigationBarHidden = false
 //        //읽기권한 추가
        fbloginButton.readPermissions = ["public_profile","email","user_friends"]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gusture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.username.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "로그인"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        addObservers()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeObservers()
    }
    
    
    @objc func didTapView(gusture: UITapGestureRecognizer){
        //This should hide keyboard for the view
        view.endEditing(true)
    }
    //add notification
    func addObservers(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo , let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollview.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        scrollview.contentInset = UIEdgeInsets.zero
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - loginDidTap
    @IBAction func loginDidTap(_ sender: Any) {
        if let userid = username.text {
            if userid.isEmpty {
                showToast("이메일을 입력해 주세요.")
                username.becomeFirstResponder()
                return
            }else if !self.globalFuncs.checkEmail(userid) {
                showToast("이메일형식이 올바르지 않습니다.")
                username.becomeFirstResponder()
                return
            }
        }
        
        if let user_password = userpwd.text {
            if user_password.isEmpty {
                showToast("비밀번호를 입력해 주세요.")
                userpwd.becomeFirstResponder()
                return
            }else if user_password.count < 6 {
                showToast("비밀번호는 최소 6자리 이상입니다.")
                userpwd.becomeFirstResponder()
                return
            }
        }
        
        check_duplicate()
    }
    
   private func check_duplicate(){
        guard let username = username.text,
            let password = userpwd.text
            else { return }
        
        let params: Parameters = [
            "username": username,
            "password": password
        ]
        // let url = API.Auth.signIn
        let signInURL = API.Auth.signIn
        
        
        Alamofire
            .request(signInURL, method: .post, parameters: params)
            .validate(statusCode: 200..<400)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("successed : ",value)
                    let get = try! JSONDecoder().decode(GetUserInfo.self, from: value)
                    self.m_appDelegate.setUserToken(get.token)
                    //메인페이지로 이동
                    self.pushVC("HomeViewController", storyboard: "Main", animated: true)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}



// MARK : - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
         return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.userpwd.resignFirstResponder()
    }
}
