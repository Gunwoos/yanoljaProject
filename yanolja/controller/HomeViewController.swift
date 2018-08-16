//
//  HomeViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeCellDelegate{
    
    @IBOutlet weak var pensionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHomeTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func setHomeTitle(){
        let titleString = "Yanolja Pension"
        let attributedString = NSMutableAttributedString(string: titleString)
        let range = (titleString as NSString).range(of: "Pension")
        attributedString.addAttributes(
            [.foregroundColor: UIColor.red.withAlphaComponent(0.5)],
            range: range
        )
        let label = UILabel()
        label.attributedText = attributedString
        label.sizeToFit()
        
        //self.navigationItem.titleView = label
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
    }
    
    @IBAction func SearchFaveriteRoomButtonAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func SearchRoomButtonAction(_ sender: UIBarButtonItem) {
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pensionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! HomeTableViewCell
        cell.pensionImage.image = #imageLiteral(resourceName: "Kermit_Sick")
        cell.pensionImage.contentMode = .scaleToFill
        cell.pensionName.text = pensionData[indexPath.row].pensionName
        cell.pensionTag.text = "simple Tag"
        cell.pensionPrice.text = String(pensionData[indexPath.row].pensionLowestPrice)
        
        return cell
    }
}

