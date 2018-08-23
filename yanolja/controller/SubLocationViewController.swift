//
//  SubLocationViewController.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SubLocationViewController: UIViewController {

    @IBOutlet weak var subLocationTable: UITableView!
    var subPensionData = Array<PensionList>()
    var subPensionNum = 0
    var subPensionLocation = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setData(sublocation: subPensionLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    func setData(sublocation: String){
        print("setData")
        print("\(sublocation)")
        for i in 0...pensionLocationData.count-1{
            for j in 0...pensionLocationData[i].sublocations.count-1{
                if pensionLocationData[i].sublocations[j].sublocationNum == sublocation{
                    let titleString = pensionLocationData[i].sublocations[j].name
                    let label = UILabel()
                    label.text = titleString
                    label.sizeToFit()
                    
                    self.navigationItem.titleView = label
                }
            }
        }
        
        for i in 0...pensionData.count-1{
            if pensionData[i].pensionSubLocation == sublocation{
                subPensionData.append(pensionData[i])
                subPensionNum = subPensionNum + 1
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSubLocationPensionForMapKit"{
            let subLocationMapViewController = segue.destination as! SubLocationMapViewController
            subLocationMapViewController.subPensionData = self.subPensionData
        }
        
    }

}

extension SubLocationViewController: UITableViewDelegate{
    
}

extension SubLocationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subPensionNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subLocationCell", for: indexPath) as! SubLocationCell
        tableView.rowHeight = 200
        
        let url = URL(string: subPensionData[indexPath.row].pensionImage)!
        if let data = try? Data(contentsOf: url){
            cell.pensionImage.image = UIImage(data: data)
        }
        else{
            cell.pensionImage.image = UIImage(named: "bg02")
        }
        cell.pensionImage.contentMode = .scaleToFill
        cell.pensionName.text = subPensionData[indexPath.row].pensionName
        cell.pensionPrice.text = String(subPensionData[indexPath.row].pensionLowestPrice)
        cell.pensionDiscountRate.text = String(subPensionData[indexPath.row].pensionDiscountRate)

        return cell
    }
}
