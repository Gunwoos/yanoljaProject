//
//  DetailTableViewCell.swift
//  yanolja
//
//  Created by seob on 2018. 8. 12..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import SVProgressHUD
 
class DetailTableViewCell: UITableViewCell ,UIScrollViewDelegate {
    @IBOutlet weak var NpriceLabel: UILabel! //원가
    @IBOutlet weak var PriceLabel: UILabel! //할인가
    
    @IBOutlet weak var DiscountLabel: UILabel! //할인율
    @IBOutlet weak var TitleLabel: UILabel! //제목
    @IBOutlet weak var scrollView: UIScrollView!
    let pageControl = UIPageControl()
    var imageArr: [UIImage] = []
    
    var m_nPageNum : Int = 1
    var m_shopInfo = ShopInfo()
    var m_arrImageURL : NSMutableArray! = nil
    var TopImage: [String] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeImageData()
        setUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func makeImageData(){
        
         for rooms in pensionDetailDataArray[0].pensionRoom {
            for dic in rooms.roomImages {
                if let downloadImageRoom = dic["room_image"] {
            
                    TopImage.append(downloadImageRoom)
                }
            }
        }
        
        for dict in pensionDetailDataArray[0].pensionImages {
           
            if let downloadImage = dict["pension_image"] {
             
                TopImage.append(downloadImage)
            }
        }
        
        for i in TopImage {
            m_shopInfo.photo.append(i)
        }
        
        self.m_arrImageURL = NSMutableArray()
        for _ in 0..<self.m_shopInfo.photo.count {
            self.m_arrImageURL.add("")
        }
        
    }
    
    func setUI() {
        let height = 345 * scrollView.frame.width / 544
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        for i in 0 ..< m_shopInfo.photo.count {
            addPageToScrollView(with: i)
            // m_shopInfo.photo.forEach(addPageToScrollView(with: i))
        }
        
        pageControl.frame = CGRect(
            x: self.frame.midX - 20, y: height - 30, width: 40, height: 20
        )
        self.addSubview(pageControl)
    }
    
    private func addPageToScrollView(with i: Int) {
        let height = 345 * scrollView.frame.width / 544
        let pageFrame = CGRect(
            origin: CGPoint(x: scrollView.contentSize.width, y: 0),
            size: CGSize(width: scrollView.frame.width, height: height)
        )
     
        let imageButtonView = UIButton(frame: pageFrame)
        imageButtonView.contentMode = .scaleAspectFill
        imageButtonView.sd_setImage(with: URL(string: self.m_shopInfo.photo[i]), for: .normal)
        scrollView.addSubview(imageButtonView)
        
        scrollView.contentSize.width += self.frame.width
        pageControl.numberOfPages += 1
    }
}

extension DetailTableViewCell {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}
