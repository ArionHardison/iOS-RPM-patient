//
//  CategoryEntity.swift
//  MiDokter User
//
//  Created by AppleMac on 16/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct Category : Mappable {
    var id : Int?
    var name : String?
    var image : String?
    var status : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        status <- map["status"]
    }
    
}


struct CategoryList : Mappable {
    var category : [Category]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        category <- map["category"]
    }
    
}
