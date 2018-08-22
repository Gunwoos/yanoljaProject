//
//  SearchEmtpyRoomViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SearchEmtpyRoomViewController: UIViewController {
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var SearchOptionView: UIView!
    @IBOutlet weak var OptionSettingView:UIView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var SelectLocationButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var peopleNumberLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var EntranceDatePicker: UIDatePicker!
    
    @IBOutlet weak var OutDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView(){
        SelectLocationButton.layer.borderColor = UIColor.white.cgColor
        SelectLocationButton.layer.borderWidth = 1
        SelectLocationButton.layer.cornerRadius = 15
        SelectLocationButton.center.x = self.view.center.x
        
        plusButton.layer.borderColor = UIColor.gray.cgColor
        plusButton.layer.borderWidth = 1
        plusButton.layer.cornerRadius = 15
        
        minusButton.layer.borderColor = UIColor.gray.cgColor
        minusButton.layer.borderWidth = 1
        minusButton.layer.cornerRadius = 15
        
    }
    
    @IBAction func SelectLocationAction(_ sender: UIButton) {
    }
    
    @IBAction func SearchButtonAction(_ sender: UIButton) {
    }
    
   
    
}
