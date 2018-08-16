//
//  ButtonStyle.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit


@IBDesignable
final class ButtonStyle: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.blue.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    var borderLayer: CALayer?
    @IBInspectable var underlineWidth: CGFloat {
        get { return self.borderLayer?.borderWidth ?? 0.0 }
        set {
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(x: 0, y: frame.height + 20, width: frame.width, height: 1)
            borderLayer.borderWidth = newValue
            borderLayer.borderColor = UIColor.lightGray.cgColor
            layer.addSublayer(borderLayer)
            self.borderLayer = borderLayer
        }
    }
}
