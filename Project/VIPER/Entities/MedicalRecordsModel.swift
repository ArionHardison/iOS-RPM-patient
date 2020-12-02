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


struct PatientRecord : Mappable {
   var status : Int?
   var record_details : [Record_details]?
    
    init() {
        
    }

   init?(map: Map) {

   }

   mutating func mapping(map: Map) {

       status <- map["status"]
       record_details <- map["record_details"]
   }

}


struct Record_details : Mappable {
    var id : Int?
    var appointment_id : Int?
    var patient_id : Int?
    var doctor_id : Int?
    var drug_id : Int?
    var inventory_item_id : String?
    var dosage : String?
    var dosage_unit : String?
    var frequency : String?
    var intake : String?
    var duration : String?
    var duration_unit : String?
    var instruction : String?
    var title : String?
    var file : String?
    var created_by : String?
    var status : String?
    var record_date : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var patient : Patient?
    var appointments : Appointment?
    
    init() {
        
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        appointment_id <- map["appointment_id"]
        patient_id <- map["patient_id"]
        doctor_id <- map["doctor_id"]
        drug_id <- map["drug_id"]
        inventory_item_id <- map["inventory_item_id"]
        dosage <- map["dosage"]
        dosage_unit <- map["dosage_unit"]
        frequency <- map["frequency"]
        intake <- map["intake"]
        duration <- map["duration"]
        duration_unit <- map["duration_unit"]
        instruction <- map["instruction"]
        title <- map["title"]
        file <- map["file"]
        created_by <- map["created_by"]
        status <- map["status"]
        record_date <- map["record_date"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        patient <- map["patient"]
        appointments <- map["appointments"]
    }

}
