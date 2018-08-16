//
//  Boardinfo.swift
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

//id        // 아이디값
//user      // 작성자의 아이디값
//nickname  // 작성자의 닉네임
//time      // 작성시간
//content   // 후기/문의글의 내용
//flag      // 답글 더 보기 링크현시기발 (1-현시)


class BoardInfo {
    var id : Int?
    var user : Int?
    var nickname : String?
    var time : String?
    var content : String?
    var flag : Int?
    
    // var comment : [CommentInfo] = []
    
    func parse(_ object : AnyObject) {
        let global = Global()
        
        self.id = global.getIntValue(object, key: "id")
        self.user = global.getIntValue(object, key: "user")
        self.nickname = global.getStringValue(object, key: "nickname")
        self.time = global.getStringValue(object, key: "time")
        self.content = global.getStringValue(object, key: "content")
        self.flag = global.getIntValue(object, key: "flag")
        
        //  let list = object.object(forKey: "comment") as? NSArray
        
        //        if list != nil {
        //            for item in list! {
        //                let commentInfo = CommentInfo()
        //                commentInfo.parse(item as AnyObject)
        //
        //                self.comment.append(commentInfo)
        //            }
        //        }
    }
}
