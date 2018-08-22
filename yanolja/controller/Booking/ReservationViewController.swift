//
//  ReservationViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Toaster
class ReservationViewController: BaseViewController {

    @IBOutlet weak var reserNumber: TextFieldStyle!
    @IBOutlet weak var reserUser: TextFieldStyle!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad() 
        reserNumber.delegate = self
        reserUser.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reserUser.becomeFirstResponder()
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
        if let username = reserUser.text {
            if username.isEmpty {
                showToast("예야작를 입력해 주세요.")
                reserUser.becomeFirstResponder()
                return
            }
        }
        
        if let reservationNumber = reserNumber.text {
            if reservationNumber.isEmpty {
                showToast("예약번호를 입력해 주세요.")
                reserNumber.becomeFirstResponder()
                return
            }
        }
        
        check_duplicate()
    }
    
    private func check_duplicate(){
        
    }
}

// MARK : - UITextFieldDelegate
extension ReservationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.reserNumber.resignFirstResponder()
    }
}
