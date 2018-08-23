//
//  extension.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}

extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}

extension UIView {
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil , left: NSLayoutXAxisAnchor? = nil , bottom: NSLayoutYAxisAnchor? = nil , right: NSLayoutXAxisAnchor? = nil){
        
        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil , left: NSLayoutXAxisAnchor? = nil , bottom: NSLayoutYAxisAnchor? = nil , right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0 ,leftConstant: CGFloat = 0 ,bottomConstant: CGFloat = 0 ,rightConstant: CGFloat = 0 ){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
    }
}
