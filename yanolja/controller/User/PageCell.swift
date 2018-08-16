//
//  PageCell.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else { return }
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 1, alpha: 1)
            
            let attributedText = NSMutableAttributedString(
                string: page.title,
                attributes: [
                    NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium) ,
                    NSAttributedStringKey.foregroundColor : color
                ])
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14) ,
                NSAttributedStringKey.foregroundColor : color
                ]))
            
            let paregraphStyle = NSMutableParagraphStyle()
            paregraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paregraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .yellow
        view.image = UIImage(named: "bg01")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "test"
        tv.isEditable = false
        tv.isOpaque = false
        tv.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    
    func setupView(){
        addSubview(imageView)
        addSubview(textView)
        let guides = self.safeAreaLayoutGuide
        imageView.anchorToTop(
            top: guides.topAnchor,
            left: guides.leadingAnchor,
            bottom: guides.bottomAnchor,
            right: guides.trailingAnchor
        )
        
        textView.anchorWithConstantsToTop(
            top: guides.topAnchor,
            left: guides.leadingAnchor,
            bottom: guides.bottomAnchor,
            right: guides.trailingAnchor,
            topConstant: 100,
            leftConstant: 20,
            bottomConstant: -50,
            rightConstant: -20
        )
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
