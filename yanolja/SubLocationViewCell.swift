//
//  SubLocationViewCell.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

protocol SubLocationCellDelegate:class{
    
}

class SubLocationCell: UITableViewCell {
    
    weak var delegate: SubLocationCellDelegate?
    
    @IBOutlet weak var pensionImage: UIImageView!
    @IBOutlet weak var pensionName: UILabel!
    @IBOutlet weak var pensionPrice: UILabel!
    @IBOutlet weak var pensionDiscountRate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    
}
