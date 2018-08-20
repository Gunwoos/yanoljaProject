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
    var rowNum = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHomeTitle()
        fetchPensionAPI()
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
    func fetchPensionAPI(){
        let url = URL(string: urlString)!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            guard 200..<400 ~= response.statusCode else {return}
            do{
                let pensionLocationParsingData = try JSONDecoder().decode([PensionLocationParsingData].self, from: data)
                var pension = Array<PensionLocationData.pensionSubLocation>()
                
                for i in 0...pensionLocationParsingData.count-1{
                    print("\(pensionLocationParsingData[i].name), \(pensionLocationParsingData[i].pensionOfNum)")
                    
                    for j in 0...pensionLocationParsingData[i].sublocations.count-1{
                        
                        let pensionSub = PensionLocationData.pensionSubLocation.init(
                            name: pensionLocationParsingData[i].sublocations[j].name,
                            pensionOfNum: pensionLocationParsingData[i].sublocations[j].pensionOfNum,
                            sublocationNum: pensionLocationParsingData[i].sublocations[j].sublocationNum
                        )
                        pension.append(pensionSub)
                        
                    }
                    let pensionLocation = PensionLocationData.init(
                        name: pensionLocationParsingData[i].name,
                        pensionOfNum: pensionLocationParsingData[i].pensionOfNum,
                        sublocations: pension
                    )
                    pensionLocationData.append(pensionLocation)
                    
                    let pensionUrlString = "https://www.pmb.kr/location/"
                    
                    for i in 0...pensionLocationData.count-1{
                        for j in 0...pensionLocationData[i].sublocations.count-1{
                            let pensionSubLocationNum = pensionUrlString +  pensionLocationData[i].sublocations[j].sublocationNum + "/"
                            let pensionURL = URL(string: pensionSubLocationNum)!
                            
                            let pensionDataTask = URLSession.shared.dataTask(with: pensionURL) { (data, response, error) in
                                guard let response = response as? HTTPURLResponse, let data = data else { return }
                                guard 200..<400 ~= response.statusCode else {return}
                                do{
                                    print("start input data")
                                    let pensionList = try JSONDecoder().decode([PensionData].self, from: data)
                                    for k in 0...pensionList.count-1{
                                        let Pension = PensionList.init(
                                            pensionPk: pensionList[k].pensionPk,
                                            pensionName: pensionList[k].pensionName,
                                            pensionImage: pensionList[k].pensionImage,
                                            pensionLowestPrice: pensionList[k].pensionLowestPrice,
                                            pensionDiscountRate: pensionList[k].pensionDiscountRate,
                                            pensionLatitude: pensionList[k].pensionLatitude,
                                            pensionLongitude: pensionList[k].pensionLongitude,
                                            pensionSubLocation: pensionLocationData[i].sublocations[j].sublocationNum
                                        )
                                        pensionData.append(Pension)
                                        self.rowNum = self.rowNum + 1
                                    }
        
                                    DispatchQueue.global().async {
                                        DispatchQueue.main.async {
                                            self.pensionTableView.reloadData()
                                        }
                                    }
                                } catch {
                                    print("error : \(error.localizedDescription)")
                                }
                            }
                            pensionDataTask.resume()
                        }
                    }
                }
            } catch {
                print("error : \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }

    @IBAction func SearchFaveriteRoomButtonAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func SearchRoomButtonAction(_ sender: UIBarButtonItem) {
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! HomeTableViewCell
 

        
        let url = URL(string: pensionData[indexPath.row].pensionImage)!
        if let data = try? Data(contentsOf: url){
            cell.pensionImage.image = UIImage(data: data)
        }
        else{
            cell.pensionImage.image = UIImage(named: "bg02")
        }
 
        cell.pensionImage.contentMode = .scaleToFill
        cell.pensionName.text = pensionData[indexPath.row].pensionName
        cell.pensionTag.text = "simple Tag"
        cell.pensionPrice.text = String(pensionData[indexPath.row].pensionLowestPrice)
        
        return cell
    }
}

