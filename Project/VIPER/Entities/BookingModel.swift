//
//  BookingModel.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper




struct BookingModel : Mappable {
    var success : String?
    var appointment : Appointment?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["success"]
        appointment <- map["appointment"]
    }
    
}



struct Appointment : Mappable {
    var doctor_id : String?
    var patient_id : Int?
    var booking_for : String?
    var scheduled_at : String?
    var consult_time : Int?
    var description : String?
    var status : String?
    var appointment_type : String?
    var updated_at : String?
    var created_at : String?
    var id : Int?
    var invoice : Invoice?
    
    init() {
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        doctor_id <- map["doctor_id"]
        patient_id <- map["patient_id"]
        booking_for <- map["booking_for"]
        scheduled_at <- map["scheduled_at"]
        consult_time <- map["consult_time"]
        description <- map["description"]
        status <- map["status"]
        appointment_type <- map["appointment_type"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        id <- map["id"]
        invoice <- map["invoice"]
    }
    
}



struct BookingReq : Codable {
    var doctor_id : String = ""
    var booking_for : String = ""
    var scheduled_at : String = ""
    var consult_time : String = ""
    var appointment_type : String = ""
    var description : String = ""
    var selectedPatient : String = ""
    var service_id : String = ""

}
