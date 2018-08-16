//
//  SingupDetailViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SingupDetailViewController: BaseViewController {

     
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpwd: UITextField!
    @IBOutlet weak var userpwd2: UITextField!
    
    @IBAction func okDidTap(_ sender: Any) {
 
        if let userid = username.text {
            if userid.isEmpty {
                showToast("이메일을 입력해 주세요.")
            }else if !self.globalFuncs.checkEmail(userid) {
                showToast("이메일형식이 올바르지 않습니다.")
            }else{
                check_duplicate()
            }
        }
        
//        if let userpwd = userpwd.text , let userpwd2 = userpwd2.text {
//            if userpwd.isEmpty {
//                showToast("비밀번호를 입력해 주세요.")
//            }else if userpwd2.isEmpty {
//                showToast("비밀번호를 입력해주세요.")
//            }else if userpwd != userpwd2 {
//                showToast("비밀번호가 일치하지 않습니다.")
//            }else{
//                check_duplicate()
//            }
//        }
    }
    
    func check_duplicate(){
        print("check_duplicate")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
