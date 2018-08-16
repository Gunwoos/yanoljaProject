//
//  Global.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//
import Foundation
import UIKit

class Global {
    
    func isPhone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
    }
    
    func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    func getScreenMaxLength() -> CGFloat {
        return max(getScreenWidth(), getScreenHeight())
    }
    
    func getScreenMinLength() -> CGFloat {
        return min(getScreenWidth(), getScreenHeight())
    }
    
    func isDevice_35Inch() -> Bool {
        return (UIScreen.main.bounds.size.equalTo(CGSize(width: 320.0, height: 480.0)) ||
            UIScreen.main.bounds.size.equalTo(CGSize(width: 480.0, height: 320.0)))
    }
    
    func isDevice_4Inch() -> Bool {
        return (UIScreen.main.bounds.size.equalTo(CGSize(width: 320.0, height: 568.0)) ||
            UIScreen.main.bounds.size.equalTo(CGSize(width: 568.0, height: 320.0)))
    }
    
    func isDevice_47Inch() -> Bool {
        return (UIScreen.main.bounds.size.equalTo(CGSize(width: 375.0, height: 667.0)) ||
            UIScreen.main.bounds.size.equalTo(CGSize(width: 667.0, height: 375.0)))
    }
    
    func isDevice_55Inch() -> Bool {
        return (UIScreen.main.bounds.size.equalTo(CGSize(width: 414.0, height: 736.0)) ||
            UIScreen.main.bounds.size.equalTo(CGSize(width: 736.0, height: 414.0)))
    }
    
    func isPhone6OrOver() -> Bool {
        return isPhone() && getScreenMaxLength() >= 667.0
    }
    
    func isHeadSetConnected() -> Bool {
        return false
    }
    
    func isGPSAvailable() -> Bool {
        return false
    }
    
    /**
     * 35200 -> "35,200" 으로 변환
     */
    func getFormattedPrice(_ price : Int?) -> String! {
        if price == nil {
            return ""
        }
        
        let formatter = NumberFormatter.init()
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        return formatter.string(from: NSNumber(value:Int32(price!)))!
    }
    
    /**
     * NSDate 를 "yyyy-MM-dd" 형식의 String으로 변환
     */
    func stringFromDate (_ date : Date?) -> String! {
        if date == nil {
            return ""
        }
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date!)
    }
    
    /**
     * NSDate 를 "yyyy-MM-dd HH:mm:ss" 형식의 String으로 변환
     */
    func stringFromTime (_ time : Date?) -> String! {
        if time == nil {
            return ""
        }
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: time!)
    }
    
    /**
     * "yyyy-MM-dd HH:mm:ss" 혹은 "yyyy-MM-dd" 형식의 문자열을 NSDate형으로 변환
     */
    func dateFromString(_ dateString : String?) -> Date! {
        if dateString == nil {
            return nil
        }
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date : Date! = dateFormatter.date(from: dateString!)
        if date != nil {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString!)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: self)
    }
    
    ////////////////////////////////////////////////
    // Common Functions to get values from Object
    ////////////////////////////////////////////////
    func getStringValue (_ object : AnyObject!, key : String!) -> String {
        
        if object == nil || key == nil {
            return ""
        }
        
        var value : String!
        var intValue : Int? = 0
        value = object.object(forKey: key) as? String
        
        if value == nil {
            intValue = object.object(forKey: key) as? Int
            if intValue == nil {
                value = ""
            } else {
                value = String(format: "%d", intValue!);
            }
        }
        
        return value
    }
    
    
    func getIntValue (_ object : AnyObject!, key : String!) -> Int {
        
        if object == nil || key == nil {
            return 0
        }
        
        var value : String?
        var intValue : Int? = 0
        value = object.object(forKey: key) as? String
        
        if (value != nil) {
            intValue = Int(value!)
            if (intValue == nil) {
                intValue = 0
            }
        } else {
            intValue = object.object(forKey: key) as? Int
            if intValue == nil {
                intValue = 0
            }
        }
        
        return intValue!
    }
    
    func getFloatValue (_ object : AnyObject!, key : String!) -> Float {
        
        if object == nil || key == nil {
            return 0
        }
        
        var value : String?
        var floatValue : Float? = 0
        value = object.object(forKey: key) as? String
        
        if (value != nil) {
            floatValue = Float(value!)
            if (floatValue == nil) {
                floatValue = 0
            }
        } else {
            floatValue = object.object(forKey: key) as? Float
            if floatValue == nil {
                floatValue = 0
            }
        }
        
        return floatValue!
    }
    
    func getDoubleValue (_ object : AnyObject!, key : String!) -> Double {
        
        if object == nil || key == nil {
            return 0
        }
        
        var value : String?
        var doubleValue : Double? = 0
        value = object.object(forKey: key) as? String
        
        if (value != nil) {
            doubleValue = Double(value!)
            if (doubleValue == nil) {
                doubleValue = 0
            }
        } else {
            doubleValue = object.object(forKey: key) as? Double
            if doubleValue == nil {
                doubleValue = 0
            }
        }
        
        return doubleValue!
    }
    
    func decoded (_ JWTEncoded : String) -> String {
        let arr = JWTEncoded.characters.split{$0 == "."}.map(String.init)
        
        if arr.count < 2 {
            return ""
        }
        var base64string = arr[1] as String
        if base64string.characters.count % 4 != 0 {
            let padlen = 4 - base64string.characters.count % 4
            base64string += String(repeating: "=", count: padlen)
        }
        return base64DecodeString(base64string)
    }
    
    func base64EncodeString (_ string : String!) -> String {
        if (string == nil || string.isEqual("")) {
            return "";
        } else {
            let plainData = string.data(using: String.Encoding.utf8)
            let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            print(base64String!) // Zm9v
            return base64String!;
        }
    }
    
    func base64DecodeString(_ base64String : String!) -> String {
        
        if (base64String == nil || base64String.isEqual("")) {
            return "";
        } else {
            let decodedData = Data(base64Encoded: base64String!, options: NSData.Base64DecodingOptions(rawValue: 2))
            let decodedString : String = String(data: decodedData!, encoding: String.Encoding.utf8)!
            return decodedString
        }
        
    }
    
    func checkUserId (_ userId : String) -> Bool {
        let regX : NSString = "[A-Z0-9a-z]+";
        let userIdTest : NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", regX)
        let isValid : Bool =  userIdTest.evaluate(with: userId)
        
        return isValid;
    }
    
    func checkEmail(_ email : String)-> Bool {
        let emailRegex : NSString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        let emailTest : NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        let isValidEmail : Bool = emailTest.evaluate(with: email)
        
        return isValidEmail
    }
    
    /**
     * 현재의 서버시간을 참조하여 날자를 변환한다.
     *
     * @param strDate       : 변환하려는 날짜 (Y-m-d H:i:s)
     * @param strServerTime : 참조하는 서버시간 (Y-m-d)
     
     * @return 현재 변환하려는 날짜가 서버날짜와 같으면 시간만을,
     * 다르면 날짜까지 Y.m.d 오전(후) hh:mm 형식으로 귀환한다.
     */
    func convertTime(_ strDate : String, _ strServerTime : String) -> String {
        
        if (strDate.isEmpty || strServerTime.isEmpty) {
            return strDate
        }
        
        var strResDate : String = ""
        var strResTime : String = ""
        
        var startIndex = strDate.index(strDate.startIndex, offsetBy: 0)
        var endIndex = strDate.index(strDate.startIndex, offsetBy: 10)
        var range = startIndex..<endIndex
        
        let strSubDate : String = strDate.substring(with: range)
        
        startIndex = strDate.index(strDate.startIndex, offsetBy: 11)
        endIndex = strDate.index(strDate.startIndex, offsetBy: 16)
        range = startIndex..<endIndex
        
        let strSubTime : String = strDate.substring(with: range)
        
        startIndex = strServerTime.index(strServerTime.startIndex, offsetBy: 0)
        endIndex = strServerTime.index(strServerTime.startIndex, offsetBy: 10)
        range = startIndex..<endIndex
        
        // 날짜 형식 변환
        if strSubDate == strServerTime.substring(with: range) {
            strResDate = ""
        } else {
            strResDate = strSubDate.replacingOccurrences(of: "-", with: ".")
        }
        
        startIndex = strDate.index(strDate.startIndex, offsetBy: 0)
        endIndex = strDate.index(strDate.startIndex, offsetBy: 2)
        range = startIndex..<endIndex
        
        // 시간 형식 변환
        let nHour : Int = Int.init(strSubTime.substring(with: range))!
        if nHour >= 12 {
            strResTime = "오후 " + String.init(nHour - 12) + strSubTime.substring(from: endIndex)
        } else {
            strResTime = "오전 " + String.init(nHour) + strSubTime.substring(from: endIndex)
        }
        
        return strResDate + " " + strResTime;
    }
}
