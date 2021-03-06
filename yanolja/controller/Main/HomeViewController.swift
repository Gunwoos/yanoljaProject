//
//  HomeViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class LodingView: UIView {
    
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.alpha = 0.8
        let size = CGSize(width: 50, height: 50)
        activityIndicator.frame = CGRect(x: frame.midX - (size.width / 2),
                                         y: frame.midY - (size.height / 2),
                                         width: size.width,
                                         height: size.height)
        
        addSubview(activityIndicator)
        
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator.layer.cornerRadius = size.height / 2
        activityIndicator.color = UIColor.black
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeViewController: BaseViewController, HomeCellDelegate  {
  

    @IBOutlet weak var pensionTableView: UITableView!
    var lodingView: LodingView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
         let token = UserDefaults.standard.string(forKey : "token") ?? ""
        print("\n ----------- [token: \(token)] ----------- \n")
        let nib = UINib.init(nibName: "MainTableViewCell", bundle: nil)
        self.pensionTableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        setHomeTitle()
        
        
        lodingView = LodingView(frame: view.frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)
        
        fetchPensionAPI()
//        let refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
//        refreshControl.tintColor = .blue
//        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
//        pensionTableView.refreshControl = refreshControl
    }
    
    @objc func reloadData() {
        if pensionTableView.refreshControl!.isRefreshing {
            pensionTableView.refreshControl?.endRefreshing()
        }
        pensionTableView.reloadData()
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
    
    // MARK: - 펜션 정보 파싱 함수
    func fetchPensionAPI(){
 
        let url = URL(string: urlString)!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            guard 200..<400 ~= response.statusCode else {return}
            do{
                let pensionLocationParsingData = try JSONDecoder().decode([PensionLocationParsingData].self, from: data)
                
                for i in 0...pensionLocationParsingData.count-1{
                    var pension = Array<PensionLocationData.pensionSubLocation>()
                    
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
                    pensionNum = pensionNum + pensionLocation.pensionOfNum
                }
                self.fetchPensionDataAPI()
 
            } catch {
                print("error : \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }

    
    // MARK: - 모든 펜션의 기본 정보를 pensionData 에 저장
    func fetchPensionDataAPI(){
 
        for i in 0...pensionLocationData.count - 1{
            for j in 0...pensionLocationData[i].sublocations.count - 1{
                let pensionSubLocationNum = pensionUrlString +  pensionLocationData[i].sublocations[j].sublocationNum + "/"
                let pensionURL = URL(string: pensionSubLocationNum)!
                
                let pensionDataTask = URLSession.shared.dataTask(with: pensionURL) { (data, response, error) in
                    guard let response = response as? HTTPURLResponse, let data = data else { return }
                    guard 200..<400 ~= response.statusCode else {return}
                    do{
                        //print("start input data")
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
 
                        }
                        
                        DispatchQueue.global().async {
                            DispatchQueue.main.async {
                                self.lodingView.activityIndicator.stopAnimating()
                                self.lodingView.removeFromSuperview()
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


    @IBAction func SearchFaveriteRoomButtonAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func SearchRoomButtonAction(_ sender: UIBarButtonItem) {
    }
}

// MARK :- UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
      
        pensionDetailDataArray.removeAll()
        
        let idx = pensionData[row].pensionPk
        let sublocationNum = pensionData[row].pensionSubLocation
        
        m_appDelegate.m_pensionInfo.pk = idx
        m_appDelegate.m_pensionInfo.sublocation = sublocationNum
 
        //fetchPensionDetail(subLocation: sublocationNum, pk: idx)
        
         self.pushVC("PensionDetailViewController", storyboard: "Main", animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.rowHeight = 280
    }
}

// MARK :- UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pensionNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MainTableViewCell 셀 변경
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        tableView.rowHeight = 280
        var nprice = 0
        var dprice = 0
        nprice = pensionData[indexPath.row].pensionLowestPrice / 100 * pensionData[indexPath.row].pensionDiscountRate
        dprice = pensionData[indexPath.row].pensionLowestPrice  + nprice
        
        let url = URL(string: pensionData[indexPath.row].pensionImage)!
        if let data = try? Data(contentsOf: url){
            cell.ImageView.image = UIImage(data: data)
        }
        else{
            cell.ImageView.image = UIImage(named: "bg02")
        }
 
        cell.ImageView.contentMode = .scaleToFill
        cell.TitleLabel.text = pensionData[indexPath.row].pensionName
        cell.DiscountLabel.text = "\(pensionData[indexPath.row].pensionDiscountRate) %"
        cell.PriceLabel.text = "\(Global().getFormattedPrice(pensionData[indexPath.row].pensionLowestPrice)!)원~"
        
        cell.nPriceLabel.text = "\(Global().getFormattedPrice(dprice)!)원"
        
        return cell
    }
}

