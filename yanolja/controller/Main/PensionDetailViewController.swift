//
//  PensionDetailViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 12..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit


class PensionDetailViewController: BaseViewController {
 
    
    @IBOutlet var DetailTableView: UITableView!
    
    var sectionNum = 0
    var cellNum = 0
    let TopCellId = "DetailTableViewCell"
    let PensionInfoCellId = "PensionInfoCell"
    let EnterCellId = "PensionCheckOutCell"
    let ThemeCellId = "ThemeCell"
    
     override func viewDidLoad() {
        super.viewDidLoad()
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
          
        
 
        let TopCellNib = UINib.init(nibName: TopCellId, bundle: nil)
        DetailTableView.register(TopCellNib, forCellReuseIdentifier: TopCellId)
        
        let InfoNib = UINib.init(nibName: PensionInfoCellId, bundle: nil)
        DetailTableView.register(InfoNib, forCellReuseIdentifier: PensionInfoCellId)
        
        let EnterNib = UINib.init(nibName: EnterCellId, bundle: nil)
        DetailTableView.register(EnterNib, forCellReuseIdentifier: EnterCellId)
  
        let ThemeNib = UINib.init(nibName: ThemeCellId , bundle: nil)
        DetailTableView.register(ThemeNib, forCellReuseIdentifier: ThemeCellId)
        
        let idx = m_appDelegate.m_pensionInfo.pk
        let sub_locationNum =  m_appDelegate.m_pensionInfo.sublocation
        fetchPensionDetail(subLocation: sub_locationNum!, pk: idx)
        view.addSubview(DetailTableView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
  

   private func fetchPensionDetail(subLocation: String, pk: Int){
        if pensionData.count == pensionNum{
            let pensionDetailURLString = pensionUrlString + subLocation + "/" + String(pk) + "/"
            let pensionDetailURL = URL(string: pensionDetailURLString)!

            let pensionDetailDataTask = URLSession.shared.dataTask(with: pensionDetailURL){ (data, response, error ) in
                guard let response = response as? HTTPURLResponse, let data = data else{
                    print("error : response, data error")
                    return
                }
                guard 200..<400 ~= response.statusCode else {
                    print("sever error : \(pensionDetailURLString) ")
                    return
                }
                do{
                    let pensionDetail = try JSONDecoder().decode(PensionDetailParsing.self, from: data)
                    var pensionRoomListData = Array<pensionDetailData.pensionRoomDetail>()

                    for i in 0...pensionDetail.pensionRoom.count-1{
                        let pensionRoomData = pensionDetailData.pensionRoomDetail.init(
                            roomPk: pensionDetail.pensionRoom[i].roomPk,
                            roomName: pensionDetail.pensionRoom[i].roomName,
                            roomSize: pensionDetail.pensionRoom[i].roomSize,
                            roomNormalNumPeople: pensionDetail.pensionRoom[i].roomNormalNumPeople,
                            roomMaxNumPeople: pensionDetail.pensionRoom[i].roomMaxNumPeople,
                            roomPrice: pensionDetail.pensionRoom[i].roomPrice,
                            roomStructure: pensionDetail.pensionRoom[i].roomStructure,
                            roomEquipments: pensionDetail.pensionRoom[i].roomEquipments,
                            roomImages: pensionDetail.pensionRoom[i].roomImages
                        )
                        pensionRoomListData.append(pensionRoomData)
                    }

                    let pension = pensionDetailData.init(
                        pk: pensionDetail.pk,
                        pensionName: pensionDetail.pensionName,
                        pensionImage: pensionDetail.pensionImage,
                        pensionPrice: pensionDetail.pensionPrice,
                        pensionDiscountRate: pensionDetail.pensionDiscountRate,
                        pensionLatitude: pensionDetail.pensionLatitude,
                        pensionLongitude: pensionDetail.pensionLongitude,
                        pensionAddress:  pensionDetail.pensionAddress,
                        pensionCheckInTime: pensionDetail.pensionCheckInTime,
                        pensionCheckOutTime: pensionDetail.pensionCheckOutTime,
                        pensionPickUp: pensionDetail.pensionPickUp,
                        pensionRoomNumber: pensionDetail.pensionRoomNumber,
                        pensionInfo: pensionDetail.pensionInfo,
                        pensionTheme: pensionDetail.pensionTheme,
                        pensionCheckInOutDetail: pensionDetail.pensionCheckInOutDetail,
                        pensionPickUpDetail: pensionDetail.pensionPickUpDetail,
                        pensionGretting: pensionDetail.pensionGretting,
                        pensionPrecations: pensionDetail.pensionPrecations,
                        pensionImages: pensionDetail.pensionImages,
                        pensionRoom: pensionRoomListData
                    )
                    self.sectionNum = 5
                    self.cellNum = 1
                    pensionDetailDataArray.append(pension)
                      DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            self.DetailTableView.reloadData()
                        }
                    }

                } catch {
                    print("error : \(error.localizedDescription)")
                    print("error url : \(pensionDetailURLString)")
                }
            }
            pensionDetailDataTask.resume()
        }
    }

 
}


// MARK: UITableViewDataSource
extension PensionDetailViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNum
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return cellNum
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        var height: CGFloat = 44;
            if (indexPath.row == 0) {
                height = 300
                return height
            }
            else
            {
                height = 200
                return height
            }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCellId, for: indexPath) as! DetailTableViewCell
         
            tableView.rowHeight = 300
  
            var nprice = 0
            var dprice = 0
            nprice = pensionDetailDataArray[0].pensionPrice / 100 * pensionDetailDataArray[0].pensionDiscountRate
            dprice = pensionDetailDataArray[0].pensionPrice + nprice
        
            cell.TitleLabel.text = pensionDetailDataArray[0].pensionName //제목
            cell.DiscountLabel.text =  "\(pensionDetailDataArray[0].pensionDiscountRate) %" //할인율
            cell.PriceLabel.text = "\(Global().getFormattedPrice(pensionDetailDataArray[0].pensionPrice)!)원~" //할인가
            cell.NpriceLabel.text = "\(Global().getFormattedPrice(dprice)!)원" // 원가
            return cell
            
        }  else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ThemeCellId, for: indexPath) as! ThemeCell
            tableView.rowHeight = 200
            let theme = pensionDetailDataArray[0].pensionTheme
            var themeArr  : [String] = []
            theme.split(separator:",").map{ themeArr.append(String($0)) }
            for i in themeArr {
                if let icon = cell.iconName[i] {
                    cell.iconImageView1.image = UIImage(named: icon)
                   // cell.iconTitle1.text = cell.iconName[0]
                }
                
              
                
//                if let icon = cell.iconName[2] {
//                    cell.iconImageView3.image = UIImage(named: icon)
//                    cell.iconTitle3.text = cell.iconName[0]
//                }
//                if let icon = cell.iconName[3] {
//                    cell.iconImageView4.image = UIImage(named: icon)
//                    cell.iconTitle4.text = cell.iconName[0]
//                }
            }
            

           // print(pensionDetailDataArray[0].pensionTheme)
            return cell
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: EnterCellId, for: indexPath) as! PensionCheckOutCell
            tableView.rowHeight = 200
            
            cell.StartLabel.text = pensionDetailDataArray[0].pensionCheckInTime
            cell.EndLabel.text = pensionDetailDataArray[0].pensionCheckOutTime
            cell.DetailLabel.text = pensionDetailDataArray[0].pensionCheckInOutDetail
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PensionInfoCellId, for: indexPath) as! PensionInfoCell
            tableView.rowHeight = 200
            
            cell.InfoTitle.text = "소개 및 인사말"
            cell.DetailLabel.text = pensionDetailDataArray[0].pensionGretting
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PensionInfoCellId, for: indexPath) as! PensionInfoCell
            tableView.rowHeight = 200
            
            cell.InfoTitle.text = "픽업 안내"
            cell.DetailLabel.text = pensionDetailDataArray[0].pensionPickUpDetail
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.rowHeight = 0
    }
}
extension PensionDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // print(scrollView.bounds)
    }
}
