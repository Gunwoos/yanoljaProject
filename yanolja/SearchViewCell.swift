//
//  SearchViewCell.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 8..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit


protocol SearchCellDelegate:class{
    
}

class SearchViewCell: UITableViewCell {
    weak var delegate : SearchCellDelegate?
    
    @IBOutlet weak var pensionImageView: UIImageView!
    @IBOutlet weak var pensionLocation: UILabel!
    @IBOutlet weak var pensionName: UILabel!
    @IBOutlet weak var pensionRoomOfNub: UILabel!
    @IBOutlet weak var pensionPrice: UILabel!
    @IBOutlet weak var pensionDprice: UILabel!
    @IBOutlet weak var pensionDiscountRate: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
