//
//  PensionData.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 9..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

struct PensionLocationParsingData: Decodable{
    let name: String
    let pensionOfNum: Int
    let sublocations: [Sublocation]

    enum CodingKeys: String, CodingKey{
        case name = "name"
        case pensionOfNum = "pensions_length"
        case sublocations = "sublocations"
    }

    struct Sublocation: Decodable{
        let name: String
        let pensionOfNum: Int
        let sublocationNum: String

        enum CodingKeys: String, CodingKey{
            case name = "name"
            case pensionOfNum = "pensions_length"
            case sublocationNum = "sub_location_no"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decode(String.self, forKey: .name)
            pensionOfNum = try values.decode(Int.self, forKey: .pensionOfNum)
            sublocationNum = try values.decode(String.self, forKey: .sublocationNum)
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        pensionOfNum = try values.decode(Int.self, forKey: .pensionOfNum)
        sublocations = try values.decode([Sublocation].self, forKey: .sublocations)
    }
}

struct PensionLocationData {
    var name: String
    var pensionOfNum: Int
    var sublocations: [pensionSubLocation]

    struct pensionSubLocation{
        var name: String
        var pensionOfNum: Int
        var sublocationNum: String
    }
}

struct PensionData: Decodable{
    let pensionPk: Int
    let pensionName: String
    let pensionImage: String
    let pensionLowestPrice: Int
    let pensionDiscountRate: Int
    let pensionLatitude: Double
    let pensionLongitude: Double
    
    enum CodingKeys: String, CodingKey{
        case pensionPk  = "pk"
        case pensionName = "name"
        case pensionImage = "pension_image_thumbnail"
        case pensionLowestPrice = "lowest_price"
        case pensionDiscountRate = "discount_rate"
        case pensionLatitude = "lat"
        case pensionLongitude = "lng"
    }
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pensionPk = try values.decode(Int.self, forKey: .pensionPk)
        pensionName = try values.decode(String.self, forKey: .pensionName)
        pensionImage = try values.decode(String.self, forKey: .pensionImage)
        pensionLowestPrice = try values.decode(Int.self, forKey: .pensionLowestPrice)
        pensionDiscountRate = try values.decode(Int.self, forKey: .pensionDiscountRate)
        pensionLatitude = try values.decode(Double.self, forKey: .pensionLatitude)
        pensionLongitude = try values.decode(Double.self, forKey: .pensionLongitude)
    }
}

struct PensionList{
    let pensionPk: Int
    let pensionName: String
    let pensionImage: String
    let pensionLowestPrice: Int
    let pensionDiscountRate: Int
    let pensionLatitude: Double
    let pensionLongitude: Double
}
 

let urlString = "\(API.baseURL)location/location-name/"
var pensionLocationData = Array<PensionLocationData>()
var pensionData = Array<PensionList>()





