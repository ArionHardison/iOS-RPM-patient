//
//  FeedBackModel.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct FeedBackModel : Mappable {
    var message : String?
    var feedback : Feedback?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        feedback <- map["feedback"]
    }
    
}

struct FeedBackReq : Codable {
    var hospital_id : String = ""
    var experiences : String = ""
    var visited_for : String = ""
    var comments : String = ""
    var rating : String = ""
    var title : String = ""
    var appointment_id : Int = 0
    
}


struct CardsModel : Mappable {
    var id : Int?
    var user_id : Int?
    var last_four : String?
    var type : String?
    var card_id : String?
    var brand : String?
    var is_default : Int?
    var deleted_at : String?
    var created_at : String?
    var updated_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        user_id <- map["user_id"]
        last_four <- map["last_four"]
        type <- map["type"]
        card_id <- map["card_id"]
        brand <- map["brand"]
        is_default <- map["is_default"]
        deleted_at <- map["deleted_at"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }

}
