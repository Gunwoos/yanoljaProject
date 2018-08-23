//
//  ThemeViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 24..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var PopContent: UILabel!
    @IBOutlet weak var PopTitle: UILabel!
    
    @IBAction func unwindDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
 

}
