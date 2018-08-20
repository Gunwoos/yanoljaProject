//
//  SingupDetailViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
 

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
        print("check_duplicate")
        
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
}

// MARK : - UITextFieldDelegate
extension SingupDetailViewController: UITextFieldDelegate {
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
