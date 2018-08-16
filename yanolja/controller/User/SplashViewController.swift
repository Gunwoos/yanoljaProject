//
//  SplashViewController.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
/*
 로그인 메인 스플래쉬
 **/
final class SplashViewController: UIViewController ,  UICollectionViewDelegate ,
UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let closebutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icons8-delete-filled-50"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isOpaque = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginDidTap), for: .touchUpInside)
        return button
    }()
    
    let signupbutton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isOpaque = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(singupDidTap), for: .touchUpInside)
        return button
    }()
    
    let pages: [Page] = {
        let firstPage = Page(title: "야놀자 펜션", message: "야놀자 펜션과 함께 지금 펜션 여행을 떠나보세요!", imageName: "bg01")
        let secondPage = Page(title: "야놀자 펜션", message: "객실에서 부대시설까지 고퀄리티 사진을 감상하세요.", imageName: "bg02")
        let thirdPage = Page(title: "야놀자 펜션", message: "숙박권,마일리지,쿠폰등 다양한 최강혜택을 만나세요.", imageName: "bg03")
        return [firstPage, secondPage,thirdPage]
    }()
    
    
    @objc func closeDidTap(){
        print("\n ----------- [closeDidTap] ----------- \n")
        dismiss(animated: true, completion: nil)
        //self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginDidTap(){
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func singupDidTap(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignupViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let callId = "callId"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(PageCell.self, forCellWithReuseIdentifier: callId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    /**************************************************************
     comment
     로그인, 회원가입 및 콜렉션뷰 레이아웃 셋팅
     **************************************************************/
    
    func setupLayout(){
        
        
        view.addSubview(collectionView)
        view.addSubview(closebutton)
        view.addSubview(loginButton)
        view.addSubview(signupbutton)
        
        
        let margins = self.view.safeAreaLayoutGuide
        // 오른쪽 상단 닫기버튼
        closebutton.anchorWithConstantsToTop(
            top: margins.topAnchor,
            left: nil,
            bottom: nil,
            right: margins.trailingAnchor,
            topConstant: 20,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: -20
        )
        closebutton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closebutton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // 로그인버튼
        loginButton.anchorWithConstantsToTop(
            top: nil,
            left: margins.leadingAnchor,
            bottom: margins.bottomAnchor,
            right: nil,
            topConstant: 0,
            leftConstant: 50,
            bottomConstant: -50,
            rightConstant: 0
        )
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // 회원가입버튼
        signupbutton.anchorWithConstantsToTop(
            top: nil,
            left: nil,
            bottom: margins.bottomAnchor,
            right: margins.trailingAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: -50,
            rightConstant: -50
        )
        signupbutton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signupbutton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // 백그라운드 이미지 콜렉션 뷰
        collectionView.anchorToTop(
            top: margins.topAnchor,
            left: margins.leadingAnchor,
            bottom: margins.bottomAnchor,
            right: margins.trailingAnchor
        )
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: callId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: callId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
