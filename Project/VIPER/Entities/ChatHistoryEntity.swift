
//
//  ChatHistoryEntity.swift
//  MiDokter Pro
//
//  Created by AppleMac on 25/09/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct ChatHistoryEntity : Mappable {
    var chats : [Chats]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        chats <- map["chats"]
    }
    
}


struct Chats : Mappable {
    var id : Int?
    var chat_requests_id : Int?
    var patient_id : Int?
    var hospital_id : Int?
    var chennel : String?
    var created_at : String?
    var updated_at : String?
    var chat_request : Chat_request?
    var hospital : Hospital?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        chat_requests_id <- map["chat_requests_id"]
        patient_id <- map["patient_id"]
        hospital_id <- map["hospital_id"]
        chennel <- map["chennel"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        chat_request <- map["chat_request"]
        hospital <- map["hospital"]
    }
    
}


struct Chat_request : Mappable {
    var id : Int?
    var patient_id : Int?
    var hospital_id : Int?
    var speciality_id : Int?
    var paid_hours : Int?
    var status : String?
    var payment_mode : String?
    var paid : Int?
    var started_at : String?
    var finished_at : String?
    var use_wallet : Int?
    var messages : String?
    var chennel : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        patient_id <- map["patient_id"]
        hospital_id <- map["hospital_id"]
        speciality_id <- map["speciality_id"]
        paid_hours <- map["paid_hours"]
        status <- map["status"]
        payment_mode <- map["payment_mode"]
        paid <- map["paid"]
        started_at <- map["started_at"]
        finished_at <- map["finished_at"]
        use_wallet <- map["use_wallet"]
        messages <- map["messages"]
        chennel <- map["chennel"]
    }
    
}
