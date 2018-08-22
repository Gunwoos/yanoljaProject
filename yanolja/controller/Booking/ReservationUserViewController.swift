//
//  ReservationUserViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Toaster

class ReservationUserViewController: BaseViewController {

    
    @IBOutlet weak var reserUserName: TextFieldStyle!
    @IBOutlet weak var reserUserBrith: TextFieldStyle!
    @IBOutlet weak var reserUserPhone: TextFieldStyle!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        reserUserName.delegate = self
        reserUserBrith.delegate = self
        reserUserPhone.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reserUserName.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeObservers()
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
    
    @IBAction func CheckRoomDidTap(_ sender: Any) {
        if let username = reserUserName.text {
            if username.isEmpty {
                showToast("예약자를 입력해 주세요.")
                reserUserName.becomeFirstResponder()
                return
            }
        }
        
        if let reservationNumber = reserUserBrith.text {
            if reservationNumber.isEmpty {
                showToast("생년월일을 입력해 주세요.")
                reserUserBrith.becomeFirstResponder()
                return
            }
        }
        
        if let reservationNumber = reserUserPhone.text {
            if reservationNumber.isEmpty {
                showToast("휴대폰번호를 입력해 주세요.")
                reserUserPhone.becomeFirstResponder()
                return
            }
        }
        
        check_duplicate()
    }
    
    private func check_duplicate(){
        
    }
}

// MARK : - UITextFieldDelegate
extension ReservationUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.reserUserName.resignFirstResponder()
    }
}
