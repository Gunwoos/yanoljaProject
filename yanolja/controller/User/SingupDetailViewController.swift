//
//  SingupDetailViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Alamofire

class SingupDetailViewController: BaseViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpwd: UITextField!
    @IBOutlet weak var userpwd2: UITextField!
    @IBOutlet weak var userphone: UITextField!
    
    @IBAction func okDidTap(_ sender: Any) {
 
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
        
        if let user_password2 = userpwd2.text {
            if user_password2.isEmpty {
                showToast("비밀번호를 입력해 주세요.")
                userpwd2.becomeFirstResponder()
                return
            }else if user_password2.count < 6 {
                showToast("비밀번호는 최소 6자리 이상입니다.")
                userpwd2.becomeFirstResponder()
                return
            }else if userpwd.text != user_password2 {
                showToast("비밀번호가 일치하지 않습니다.")
                userpwd2.becomeFirstResponder()
                return
            }
        }
        
        if let phone_number = userphone.text {
            if phone_number.isEmpty {
                showToast("핸드폰번호를 입력해 주세요.")
                userphone.becomeFirstResponder()
                return
            }
        }
        
        check_duplicate()
    }
    
    func check_duplicate(){
        guard let username = username.text,
            let password = userpwd.text ,
            let phone = userphone.text
            else { return }
        
        let params: Parameters = [
            "username": username,
            "password": password,
            "password2" : password,
            "phone_number" : phone
        ]
        
        
        let signUpURL = API.Auth.signUp
        Alamofire
            .request(signUpURL, method: .post, parameters: params)
            .validate(statusCode: 200..<400)
            .responseData { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    print("successed : ",value)
                     let alertVC = UIAlertController(title: "회원가입", message: "정상적으로 회원가입 되었습니다.", preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                          self?.dismiss(animated: true, completion: nil)
                    })
                    alertVC.addAction(okAction)
                    self?.present(alertVC, animated: true, completion: nil)
 
                    //메인페이지로 이동
                    //self?.pushVC("HomeViewController", storyboard: "Main", animated: true)
                case .failure(let error):
                    print(error)
                    self?.showToast("일시적인 오류")
                    return
                }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userphone.delegate = self
        username.delegate = self
        userpwd2.delegate = self
        userpwd.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gusture:)))
        view.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeObservers()
    }
    
    // didTapView
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
    // keyboardWillShow
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo , let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollview.contentInset = contentInset
    }
    //keyboardWillHide
    func keyboardWillHide(notification: Notification){
        scrollview.contentInset = UIEdgeInsets.zero
    }
    //removeObservers
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK : - UITextFieldDelegate
extension SingupDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.userpwd.resignFirstResponder()
    }
}
