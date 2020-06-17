//
//  DoctorsListModel.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper



struct DoctorsListModel : Mappable {
    var search_doctors : [Search_doctors]?
    var visited_doctors : [Visited_doctors]?
    var favourite_Doctors : [Favourite_Doctors]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        search_doctors <- map["search_doctors"]
        visited_doctors <- map["visited_doctors"]
        favourite_Doctors <- map["favourite_Doctors"]
    }
    
}


struct Favourite_Doctors : Mappable {
    var id : Int?
    var patient_id : Int?
    var hospital_id : Int?
    var hospital : Hospital?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        patient_id <- map["patient_id"]
        hospital_id <- map["hospital_id"]
        hospital <- map["hospital"]
    }
    
}

struct Search_doctors : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var mobile : String?
    var country_code : String?
    var email : String?
    var otp : Int?
    var gender : String?
    var tax_id : String?
    var medical_id : String?
    var regn_id : String?
    var clinic_id : Int?
    var services_id : String?
    var specialities_name : String?
    var is_administrative : Int?
    var is_doctor : Int?
    var added_by : String?
    var is_staff : Int?
    var is_receptionist : Int?
    var role : Int?
    var email_verified : Int?
    var email_token : String?
    var email_verified_at : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var feedback_percentage : String?
    var availability : String?
    var is_favourite : String?
    var doctor_profile : Doctor_profile?
    var clinic : Clinic?
    var feedback : [Feedback]?
    var timing : [Timing]?
    var doctor_service : [Doctor_service]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        mobile <- map["mobile"]
        country_code <- map["country_code"]
        email <- map["email"]
        otp <- map["otp"]
        gender <- map["gender"]
        tax_id <- map["tax_id"]
        medical_id <- map["medical_id"]
        regn_id <- map["regn_id"]
        clinic_id <- map["clinic_id"]
        services_id <- map["services_id"]
        specialities_name <- map["specialities_name"]
        is_administrative <- map["is_administrative"]
        is_doctor <- map["is_doctor"]
        added_by <- map["added_by"]
        is_staff <- map["is_staff"]
        is_receptionist <- map["is_receptionist"]
        role <- map["role"]
        email_verified <- map["email_verified"]
        email_token <- map["email_token"]
        email_verified_at <- map["email_verified_at"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        feedback_percentage <- map["feedback_percentage"]
        availability <- map["availability"]
        is_favourite <- map["is_favourite"]
        doctor_profile <- map["doctor_profile"]
        clinic <- map["clinic"]
        feedback <- map["feedback"]
        timing <- map["timing"]
        doctor_service <- map["doctor_service"]
    }
    
}


struct Visited_doctors : Mappable {
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
        hospital <- map["hospital"]
    }
    
}
