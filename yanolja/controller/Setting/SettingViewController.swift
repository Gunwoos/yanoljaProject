//
//  SettingViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    @IBOutlet weak var collectionview: UICollectionView!

     var cellId = "IconCell"
    
    @IBAction private func loginDidTap(_ sender: UIButton){
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        let navi = UINavigationController(rootViewController: vc)
        navi.isNavigationBarHidden = true
        self.navigationController?.popToViewController(navi, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()  
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconCell
        return cell
    }
    
}
