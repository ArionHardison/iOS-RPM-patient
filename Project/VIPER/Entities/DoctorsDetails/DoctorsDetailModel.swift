//
//  DoctorsDetailModel.swift
//  MiDokter User
//
//  Created by AppleMac on 16/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper


struct DoctorsDetailModel : Mappable {
    var specialities : Specialities?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {

        specialities <- map["Specialities"]
    }

}


struct Clinic : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var phone : String?
    var country_code : String?
    var mobile : String?
    var address : String?
    var latitude : String?
    var longitude : String?
    var postal_code : String?
    var doctor_id : Int?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var static_map : String?
    var clinic_photo : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        country_code <- map["country_code"]
        mobile <- map["mobile"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        postal_code <- map["postal_code"]
        doctor_id <- map["doctor_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        static_map <- map["static_map"]
        clinic_photo <- map["clinic_photo"]
    }

}


struct Doctor_profile : Mappable {
    var id : Int?
    var doctor_id : Int?
    var gender : String?
    var profile_pic : String?
    var medical_assoc_name : String?
    var awards : String?
    var profile_description : String?
    var experience : String?
    var internship : String?
    var certification : String?
    var residency : String?
    var medical_school : String?
    var address : String?
    var city : String?
    var country : String?
    var postal_code : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var affiliations : String?
    var specialities : Int?
    var fees : Int?
    var speciality : Speciality?
    var hospital : [Hospital]?
    
    init() {
        
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        doctor_id <- map["doctor_id"]
        gender <- map["gender"]
        profile_pic <- map["profile_pic"]
        medical_assoc_name <- map["medical_assoc_name"]
        awards <- map["awards"]
        profile_description <- map["profile_description"]
        experience <- map["experience"]
        internship <- map["internship"]
        certification <- map["certification"]
        residency <- map["residency"]
        medical_school <- map["medical_school"]
        address <- map["address"]
        city <- map["city"]
        country <- map["country"]
        postal_code <- map["postal_code"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        affiliations <- map["affiliations"]
        specialities <- map["specialities"]
        fees <- map["fees"]
        speciality <- map["speciality"]
        hospital <- map["hospital"]
    }

}

struct Doctor_service : Mappable {
    var id : Int?
    var hospital_id : Int?
    var service_id : Int?
    var service : Service?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        hospital_id <- map["hospital_id"]
        service_id <- map["service_id"]
        service <- map["service"]
    }

}

struct Feedback : Mappable {
    var id : Int?
    var patient_id : Int?
    var hospital_id : Int?
    var experiences : String?
    var visited_for : String?
    var comments : String?
    var created_at : String?
    var updated_at : String?
    var patient : Patient?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        patient_id <- map["patient_id"]
        hospital_id <- map["hospital_id"]
        experiences <- map["experiences"]
        visited_for <- map["visited_for"]
        comments <- map["comments"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        patient <- map["patient"]
    }
    
}

struct Hospital : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var mobile : String?
    var country_code : String?
    var email : String?
    var otp : String?
    var gender : String?
    var tax_id : String?
    var medical_id : String?
    var regn_id : String?
    var clinic_id : Int?
    var services_id : String?
    var specialities_name : String?
    var is_administrative : Int?
    var is_doctor : Int?
    var added_by : Int?
    var is_staff : Int?
    var is_receptionist : Int?
    var role : Int?
    var email_verified : Int?
    var email_token : String?
    var email_verified_at : String?
    var subscribe_from : String?
    var subscribe_to : String?
    var subscribe_limit : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var status : String?
    var feedback_percentage : String?
    var availability : String?
    var is_favourite : String?
    var clinic : Clinic?
    var feedback : [Feedback]?
    var doctor_profile : Doctor_profile?
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
        subscribe_from <- map["subscribe_from"]
        subscribe_to <- map["subscribe_to"]
        subscribe_limit <- map["subscribe_limit"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        status <- map["status"]
        feedback_percentage <- map["feedback_percentage"]
        availability <- map["availability"]
        is_favourite <- map["is_favourite"]
        clinic <- map["clinic"]
        feedback <- map["feedback"]
        doctor_profile <- map["doctor_profile"]
        timing <- map["timing"]
        doctor_service <- map["doctor_service"]
    }

}

struct Service : Mappable {
    var id : Int?
    var name : String?
    var status : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
    }
    
}


struct Specialities : Mappable {
    var id : Int?
    var name : String?
    var image : String?
    var status : Int?
    var discount : String?
    var fees : Int?
    var offer_fees : String?
    var doctor_profile : [Doctor_profile]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        status <- map["status"]
        discount <- map["discount"]
        fees <- map["fees"]
        offer_fees <- map["offer_fees"]
        doctor_profile <- map["doctor_profile"]
    }

}


struct Timing : Mappable {
    var id : Int?
    var doctor_id : Int?
    var start_time : String?
    var end_time : String?
    var day : String?
    var date_value : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        doctor_id <- map["doctor_id"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        day <- map["day"]
        date_value <- map["date_value"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}


struct PromoCodeEntity : Mappable {
    var status : Int?
    var message : String?
    var promo_discount : Int?
    var final_fees : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
        promo_discount <- map["promo_discount"]
        final_fees <- map["final_fees"]
    }
    
}

struct FAQModel : Mappable {
   var status : Int?
   var faq : [Faq]?
    init() {
        
    }
   init?(map: Map) {

   }

   mutating func mapping(map: Map) {

       status <- map["status"]
       faq <- map["faq"]
   }

}


struct Faq : Mappable {
    var id : Int?
    var question : String?
    var answer : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    init() {
        
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        question <- map["question"]
        answer <- map["answer"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}
