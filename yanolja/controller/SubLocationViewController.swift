//
//  SubLocationViewController.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SubLocationViewController: BaseViewController {

    @IBOutlet weak var subLocationTable: UITableView!
    var subPensionData = Array<PensionList>()
    var subPensionNum = 0
    var subPensionLocation = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "MainTableViewCell", bundle: nil)
        self.subLocationTable.register(nib, forCellReuseIdentifier: "MainTableViewCell")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        pensionDetailDataArray.removeAll()
        
        let idx = subPensionData[row].pensionPk
        let sublocationNum = subPensionData[row].pensionSubLocation
        
        m_appDelegate.m_pensionInfo.pk = idx
        m_appDelegate.m_pensionInfo.sublocation = sublocationNum
        
        //fetchPensionDetail(subLocation: sublocationNum, pk: idx)
        
        self.pushVC("PensionDetailViewController", storyboard: "Main", animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.rowHeight = 280
    }
}

extension SubLocationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subPensionNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        tableView.rowHeight = 280
        var nprice = 0
        var dprice = 0
        nprice = subPensionData[indexPath.row].pensionLowestPrice / 100 * subPensionData[indexPath.row].pensionDiscountRate
        dprice = subPensionData[indexPath.row].pensionLowestPrice  + nprice
        
        let url = URL(string: subPensionData[indexPath.row].pensionImage)!
        if let data = try? Data(contentsOf: url){
            cell.ImageView.image = UIImage(data: data)
        }
        else{
            cell.ImageView.image = UIImage(named: "bg02")
        }
        
        cell.ImageView.contentMode = .scaleToFill
        cell.TitleLabel.text = subPensionData[indexPath.row].pensionName
        cell.DiscountLabel.text = "\(subPensionData[indexPath.row].pensionDiscountRate) %"
        cell.PriceLabel.text = "\(Global().getFormattedPrice(subPensionData[indexPath.row].pensionLowestPrice)!)원~"
        
        cell.nPriceLabel.text = "\(Global().getFormattedPrice(dprice)!)원"

        return cell
    }
}
