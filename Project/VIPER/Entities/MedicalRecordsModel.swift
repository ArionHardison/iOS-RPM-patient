//
//  MedicalRecordsModel.swift
//  MiDokter User
//
//  Created by AppleMac on 16/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper


struct MedicalRecordsModel : Mappable {
    var status : Int?
    var medical : [Medical]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        medical <- map["medical"]
    }
    
}



struct Medical : Mappable {
    var id : Int?
    var doctor_id : Int?
    var patient_id : Int?
    var service_id : Int?
    var appointment_type : String?
    var booking_for : String?
    var scheduled_at : String?
    var engaged_at : String?
    var checkin_at : String?
    var consult_time : String?
    var checkedout_at : String?
    var description : String?
    var report : String?
    var patient_reminder : Int?
    var doctor_reminder : Int?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var status : String?
    var patient_files : [String]?
    var hospital : Hospital?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        doctor_id <- map["doctor_id"]
        patient_id <- map["patient_id"]
        service_id <- map["service_id"]
        appointment_type <- map["appointment_type"]
        booking_for <- map["booking_for"]
        scheduled_at <- map["scheduled_at"]
        engaged_at <- map["engaged_at"]
        checkin_at <- map["checkin_at"]
        consult_time <- map["consult_time"]
        checkedout_at <- map["checkedout_at"]
        description <- map["description"]
        report <- map["report"]
        patient_reminder <- map["patient_reminder"]
        doctor_reminder <- map["doctor_reminder"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        status <- map["status"]
        patient_files <- map["patient_files"]
        hospital <- map["hospital"]
    }
    
}
