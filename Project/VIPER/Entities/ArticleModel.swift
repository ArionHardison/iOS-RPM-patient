//
//  ArticleModel.swift
//  MiDokter User
//
//  Created by AppleMac on 16/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct Article : Mappable {
    var id : Int?
    var hospital_id : Int?
    var name : String?
    var cover_photo : String?
    var description : String?
    var status : String?
    var created_at : String?
    var updated_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        hospital_id <- map["hospital_id"]
        name <- map["name"]
        cover_photo <- map["cover_photo"]
        description <- map["description"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}


struct ArticleModel : Mappable {
    var article : [Article]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        article <- map["article"]
    }
    
}
