//
//  HomeTableViewCell.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit


protocol HomeCellDelegate:class{
    
}

class HomeTableViewCell: UITableViewCell {
    
    weak var delegate: HomeCellDelegate?
    
    @IBOutlet weak var pensionImage: UIImageView!
    @IBOutlet weak var pensionName: UILabel!
    @IBOutlet weak var pensionTag: UILabel!
    @IBOutlet weak var pensionPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
