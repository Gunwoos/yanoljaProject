//
//  CheckBookingViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class CheckBookingViewController: UIViewController {

    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var SecondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.FirstView.alpha = 0.0
        self.SecondView.alpha = 1
    }
    
    @IBAction func ShowControllDidTap(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            UIView.animate(withDuration: 0.2) {
                self.FirstView.alpha = 0.0
                self.SecondView.alpha = 1
            }
        }else{
            UIView.animate(withDuration: 0.2) {
                self.FirstView.alpha = 1
                self.SecondView.alpha = 0
            }
        }
    }

}
