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
    let pensionSubLocation: String
}

struct PensionDetailParsing: Decodable {
    let pk: Int
    let pensionName: String
    let pensionImage: String
    let pensionPrice: Int
    let pensionDiscountRate: Int
    let pensionLatitude: Double
    let pensionLongitude: Double
    let pensionAddress: String
    let pensionCheckInTime: String
    let pensionCheckOutTime: String
    let pensionPickUp: String
    let pensionRoomNumber: Int
    let pensionInfo: String
    let pensionTheme: String
    let pensionCheckInOutDetail: String
    let pensionPickUpDetail:String
    let pensionGretting: String
    let pensionPrecations: String
    let pensionImages: Array<String>
    let pensionRoom: Array<pensionRoomDetail>
    
    enum CodingKeys: String, CodingKey {
        case pk = "pk"
        case pensionName = "name"
        case pensionImage = "pension_image_thumbnail"
        case pensionPrice = "lowest_price"
        case pensionDiscountRate = "discount_rate"
        case pensionLatitude = "lat"
        case pensionLongitude = "lng"
        case pensionAddress = "address"
        case pensionCheckInTime = "check_in"
        case pensionCechkOutTime = "check_out"
        case pensionPickUp = "pickup"
        case pensionRoomNumber = "room_num"
        case pensionInfo = "info"
        case pensionTheme = "theme"
        case pensionCheckInOutDetail = "check_in_out_detail"
        case pensionPickUpDetail = "pickup_detail"
        case pensionGretting = "gretting"
        case pensionPrecations = "precations"
        case pensionImages = "pensionimages"
        case pensionRoom = "room"
    }
    
    struct pensionRoomDetail: Decodable{
        let roomPk: Int
        let roomName: String
        let roomSize: String
        let roomNormalNumPeople: Int
        let roomMaxNumPeople: Int
        let roomPrice: Int
        let roomStructure: String
        let roomEquipments: String
        let roomInfo: String
        
        enum CodingKeys: String, CodingKey{
            case roomPk = "pk"
            case roomName = "name"
            case roomSize = "size"
            case roomNormalNumPeople = "normal_num_people"
            case roomMaxNumPeople = "max_num_people"
            case roomPrice = "price"
            case roomStructure = "structure"
            case roomEquipments = "equipments"
            case roomInfo = "info"
        }
        init(from decoder: Decoder) throws{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            roomPk = try values.decode(Int.self, forKey: .roomPk)
            roomName = try values.decode(String.self, forKey: .roomName)
            roomSize = try values.decode(String.self, forKey: .roomSize)
            roomNormalNumPeople = try values.decode(Int.self, forKey: .roomNormalNumPeople)
            roomMaxNumPeople = try values.decode(Int.self, forKey: .roomMaxNumPeople)
            roomPrice = try values.decode(Int.self, forKey: .roomPrice)
            roomStructure = try values.decode(String.self, forKey: .roomStructure)
            roomEquipments = try values.decode(String.self, forKey: .roomEquipments)
            roomInfo = try values.decode(String.self, forKey: .roomInfo)
        }
    }
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pk = try values.decode(Int.self, forKey: .pk)
        pensionName = try values.decode(String.self, forKey: .pensionName)
        pensionImage = try values.decode(String.self, forKey: .pensionImage)
        pensionPrice = try values.decode(Int.self, forKey: .pensionPrice)
        pensionDiscountRate = try values.decode(Int.self, forKey: .pensionDiscountRate)
        pensionLatitude = try values.decode(Double.self, forKey: .pensionLatitude)
        pensionLongitude = try values.decode(Double.self, forKey: .pensionLongitude)
        pensionAddress = try values.decode(String.self, forKey: .pensionAddress)
        pensionCheckInTime = try values.decode(String.self, forKey: .pensionCheckInTime)
        pensionCheckOutTime = try values.decode(String.self, forKey: .pensionCechkOutTime)
        pensionPickUp = try values.decode(String.self, forKey: .pensionPickUp)
        pensionRoomNumber = try values.decode(Int.self, forKey: .pensionRoomNumber)
        pensionInfo = try values.decode(String.self, forKey: .pensionInfo)
        pensionTheme = try values.decode(String.self, forKey: .pensionTheme)
        pensionCheckInOutDetail = try values.decode(String.self, forKey: .pensionCheckInOutDetail)
        pensionPickUpDetail = try values.decode(String.self, forKey: .pensionPickUpDetail)
        pensionGretting = try values.decode(String.self, forKey: .pensionGretting)
        pensionPrecations = try values.decode(String.self, forKey: .pensionPrecations)
        pensionImages = try values.decode(Array<String>.self, forKey: .pensionImages)
        pensionRoom = try values.decode(Array<pensionRoomDetail>.self, forKey: .pensionRoom)
    }
}

struct pensionDetailData {
    let pk: Int
    let pensionName: String
    let pensionImage: String
    let pensionPrice: Int
    let pensionDiscountRate: Int
    let pensionLatitude: Double
    let pensionLongitude: Double
    let pensionAddress: String
    let pensionCheckInTime: String
    let pensionCheckOutTime: String
    let pensionPickUp: String
    let pensionRoomNumber: Int
    let pensionInfo: String
    let pensionTheme: String
    let pensionCheckInOutDetail: String
    let pensionPickUpDetail:String
    let pensionGretting: String
    let pensionPrecations: String
    let pensionImages: Array<String>
    let pensionRoom: Array<pensionRoomDetail>
    
    struct pensionRoomDetail{
        let roomPk: Int
        let roomName: String
        let roomSize: String
        let roomNormalNumPeople: Int
        let roomMaxNumPeople: Int
        let roomPrice: Int
        let roomStructure: String
        let roomEquipments: String
        let roomInfo: String
}
 

let urlString = "https://www.pmb.kr/location/location-name/"
var pensionLocationData = Array<PensionLocationData>()
var pensionData = Array<PensionList>()






