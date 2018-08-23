//
//  ThemeCell.swift
//  yanolja
//
//  Created by seob on 2018. 8. 24..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
   
    @IBOutlet weak var iconImageView1: UIImageView!
    @IBOutlet weak var iconTitle1: UILabel!
    
    @IBOutlet weak var iconImageView2: UIImageView!
    @IBOutlet weak var iconTitle2: UILabel!
    
    @IBOutlet weak var iconImageView3: UIImageView!
    @IBOutlet weak var iconTitle3: UILabel!
    
    @IBOutlet weak var iconImageView4: UIImageView!
    @IBOutlet weak var iconTitle4: UILabel!
    
    @IBOutlet weak var MoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib() 
    }
    
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
