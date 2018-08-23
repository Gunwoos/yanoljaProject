//
//  LocationViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var groupingTableView: UIView!
    @IBOutlet weak var LocationTableView: UITableView!
    @IBOutlet weak var subLocationTableView: UITableView!
    var LocationRowNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setView(){
        let titleString = "지역"
        let label = UILabel()
        label.text = titleString
        label.sizeToFit()
        
        self.navigationItem.titleView = label
        
        LocationTableView.frame = CGRect(
            x: LocationTableView.frame.origin.x,
            y: LocationTableView.frame.origin.y,
            width: self.view.frame.width/3,
            height: LocationTableView.frame.height
        )
        subLocationTableView.frame = CGRect(
            x: self.view.frame.width/3,
            y: subLocationTableView.frame.origin.y,
            width: (self.view.frame.width/3)*2,
            height: subLocationTableView.frame.height
        )
        

    }
}

extension LocationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == LocationTableView{
            LocationRowNum = indexPath.row
            subLocationTableView.reloadData()
        }
        if tableView == subLocationTableView{
//            let subLocationVC = SubLocationViewController()
//            
//            present(subLocationVC, animated: true) {
//                subLocationVC.subPensionLocation = pensionLocationData[self.LocationRowNum].sublocations[indexPath.row].sublocationNum
//            }

        }
    }
    
}
extension LocationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == LocationTableView{
            return pensionLocationData.count
        }
        if tableView == subLocationTableView{
            return pensionLocationData[LocationRowNum].sublocations.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == LocationTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableCell", for: indexPath)
            cell.textLabel?.text = pensionLocationData[indexPath.row].name
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            return cell
        }
        if tableView == subLocationTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubLocationTableCell", for: indexPath)
            cell.textLabel?.text = pensionLocationData[LocationRowNum].sublocations[indexPath.row].name
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
}
