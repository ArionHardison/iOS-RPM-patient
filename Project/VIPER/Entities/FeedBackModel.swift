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
    
}
