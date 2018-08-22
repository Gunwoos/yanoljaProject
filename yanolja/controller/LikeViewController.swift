//
//  LikeViewController.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController {

    @IBOutlet weak var likedPensionTableView: UITableView!
    
    @IBOutlet weak var likedPensionView:UIView!
    
    var likedPensionNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView(){
        let titleString = "가고싶어요"
        let label = UILabel()
        label.text = titleString
        label.sizeToFit()
        
        self.navigationItem.titleView = label
        
        if likedPensionNum == 0{
            print("no liked pension")
            likedPensionView.isHidden = false
            likedPensionTableView.isHidden = true
            
            likedPensionView.backgroundColor = UIColor.lightGray
        }
        else{
            print("one more than liked Pension")
            likedPensionView.isHidden = true
            likedPensionTableView.isHidden = false
        }
        
    }

}
extension LikeViewController: UITableViewDelegate{
    
}
extension LikeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPensionNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
}

