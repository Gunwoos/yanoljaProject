//
//  Shopinfo.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

/*********************************************************************
 id                     int            상점 id
 name                   String         상점이름
 photo                  String         상점이미지
 distance               String         상점까지의 거리
 address                String         상점주소
 address_detail         String         상점상세주소
 time                   String         상점오픈시간
 kind                   String         업종
 pay_sort               Int            요금방식
 park                   String         주차가능
 ad_type                Int            상점광고형태
 *********************************************************************/

class ShopInfo {
    
    var id : Int?
    var user : Int?
    var name : String?
    var photo : [String] = []
    var photo2 : String?
    var distance : Double?
    var collect : Int?
    var address : String?
    var address_detail : String?
    var time : String?
    var kind : String?
    var pay_sort : Int?
    var theme : [Int] = []
    var intro : String?
    var longitude : String?
    var latitude : String?
    var way : String?
    var phone : String?
    var m_count : Int?
    var b_count : Int?
    var p_count : Int?
    var service_time : String?
    
    var ad_type : Int?
    var ad_visit_count : Int?
    var ad_end_time : String?
    var ad_amount : Int?
    
    var atype_time : [String] = []
    var btype_time : [String] = []
    var ctype_time : [String] = []
    var time_pay : [String] = []
    var use_time : [String] = []
    var board : [BoardInfo] = []
    
    func parse(_ object : AnyObject) {
        
        let global = Global()
        
        self.id = global.getIntValue(object, key: "id")
        self.name = global.getStringValue(object, key : "name")
        self.distance = global.getDoubleValue(object, key: "distance")
        self.collect = global.getIntValue(object, key: "collect")
        self.address = global.getStringValue(object, key: "address")
        self.address_detail = global.getStringValue(object, key: "address_detail")
        self.time = global.getStringValue(object, key: "time")
        self.kind = global.getStringValue(object, key: "kind")
        self.pay_sort = global.getIntValue(object, key: "pay_sort")
        self.intro = global.getStringValue(object, key: "intro")
        self.way = global.getStringValue(object, key: "way")
        self.phone = global.getStringValue(object, key: "phone")
        self.ad_type = global.getIntValue(object, key: "type")
        self.ad_visit_count = global.getIntValue(object, key: "visit_count")
        self.ad_end_time = global.getStringValue(object, key: "end_time")
        self.ad_amount = global.getIntValue(object, key: "amount")
        self.b_count = global.getIntValue(object, key: "big_count")
        self.m_count = global.getIntValue(object, key: "mid_count")
        self.p_count = global.getIntValue(object, key: "pocket_count")
        self.photo2 = global.getStringValue(object, key: "photo")
        
        self.photo.removeAll()
        let arr_photo = object.object(forKey: "photo") as? NSArray
        if arr_photo != nil {
            for item in arr_photo! {
                let str = item as! NSString
                self.photo.append(str as String)
            }
        }
        
        self.atype_time.removeAll()
        let arr_bTime = object.object(forKey: "b_time") as? NSArray
        if arr_bTime != nil {
            for item in arr_bTime! {
                let str = item as! NSString
                self.atype_time.append(str as String)
            }
        }
        
        self.btype_time.removeAll()
        let arr_mTime = object.object(forKey: "m_time") as? NSArray
        if arr_mTime != nil {
            for item in arr_mTime! {
                let str = item as! NSString
                self.btype_time.append(str as String)
            }
        }
        
        self.ctype_time.removeAll()
        let arr_cTime = object.object(forKey: "p_time") as? NSArray
        if arr_cTime != nil {
            for item in arr_cTime! {
                let str = item as! NSString
                self.ctype_time.append(str as String)
            }
        }
        
        self.time_pay.removeAll()
        let arr_TimePay = object.object(forKey: "time_pay") as? NSArray
        if arr_TimePay != nil {
            for item in arr_TimePay! {
                let str = item as! NSString
                self.time_pay.append(str as String)
            }
        }
        
        self.use_time.removeAll()
        let arr_UseTime = object.object(forKey: "use_time") as? NSArray
        if arr_UseTime != nil {
            for item in arr_UseTime! {
                let str = item as! NSString
                self.use_time.append(str as String)
            }
        }
        
        self.theme.removeAll()
        let arr_theme = object.object(forKey: "theme") as? NSArray
        if arr_theme != nil {
            for item in arr_theme! {
                let str = item as! NSString
                self.theme.append(str.integerValue)
            }
        }
    }
}
