//
//  PensionDetailViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 12..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class PensionDetailViewController: UIViewController {
 
    
    @IBOutlet var DetailTableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
        
 
        
        DetailTableView.rowHeight = UITableViewAutomaticDimension
        DetailTableView.estimatedRowHeight = 200
        
        DetailTableView.reloadData()
        
        let nib = UINib.init(nibName: "DetailTableViewCell", bundle: nil)
        self.DetailTableView.register(nib, forCellReuseIdentifier: "TopImageCell")
        DetailTableView.register(DetailFooterTableViewCell.self, forCellReuseIdentifier: "DetailFooterTableViewCell")
//
//        let nib2 = UINib.init(nibName: "DetailFooterTableViewCell", bundle: nil)
//        self.DetailTableView.register(nib2, forCellReuseIdentifier: "DetailFooterTableViewCell")
        
        
        
         view.addSubview(DetailTableView)
        
    }
}


// MARK: UITableViewDataSource
extension PensionDetailViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\n ----------- [didSelectRowAt] ----------- \n")
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        var height: CGFloat = 44;
            if (indexPath.row == 0) {
                height = 300
            }
            else
            {
                height = 51
            }
            return height
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopImageCell", for: indexPath) as! DetailTableViewCell
            
            
             tableView.rowHeight = 300
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFooterTableViewCell", for: indexPath) as! DetailFooterTableViewCell
            cell.textLabel?.text = "test"
            
            tableView.rowHeight = 51
            
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
