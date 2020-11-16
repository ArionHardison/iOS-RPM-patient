//
//  ProfileModel.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileModel : Mappable {
    var patient : Patient?
    var profile_complete : String?
    var allergies : [String]?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        patient <- map["patient"]
        profile_complete <- map["profile_complete"]
        allergies <- map["allergies"]
    }
    
}


struct Patient : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var phone : String?
    var secondary_mobile : String?
    var other_id : String?
    var payment_mode : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var login_by : String?
    var social_unique_id : String?
    var wallet_balance : Int?
    var rating : String?
    var email : String?
    var otp : Int?
    var regn_id : String?
    var email_verified : Int?
    var email_token : String?
    var email_verified_at : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var profile : Profile?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        phone <- map["phone"]
        secondary_mobile <- map["secondary_mobile"]
        other_id <- map["other_id"]
        payment_mode <- map["payment_mode"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        login_by <- map["login_by"]
        social_unique_id <- map["social_unique_id"]
        wallet_balance <- map["wallet_balance"]
        rating <- map["rating"]
        email <- map["email"]
        otp <- map["otp"]
        regn_id <- map["regn_id"]
        email_verified <- map["email_verified"]
        email_token <- map["email_token"]
        email_verified_at <- map["email_verified_at"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        profile <- map["profile"]
    }
    
}

struct Profile : Mappable {
    var id : Int?
    var patient_id : String?
    var age : String?
    var gender : String?
    var dob : String?
    var blood_group : String?
    var profile_pic : String?
    var description : String?
    var refered_by : String?
    var occupation : String?
    var groups : String?
    var address : String?
    var street : String?
    var locality : String?
    var city : String?
    var country : String?
    var postal_code : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var merital_status : String?
    var height : String?
    var weight : String?
    var emergency_contact : String?
    var allergies : String?
    var current_medications : String?
    var past_medications : String?
    var chronic_diseases : String?
    var injuries : String?
    var surgeries : String?
    var smoking : String?
    var alcohol : String?
    var activity : String?
    var food : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        patient_id <- map["patient_id"]
        age <- map["age"]
        gender <- map["gender"]
        dob <- map["dob"]
        blood_group <- map["blood_group"]
        profile_pic <- map["profile_pic"]
        description <- map["description"]
        refered_by <- map["refered_by"]
        occupation <- map["occupation"]
        groups <- map["groups"]
        address <- map["address"]
        street <- map["street"]
        locality <- map["locality"]
        city <- map["city"]
        country <- map["country"]
        postal_code <- map["postal_code"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        merital_status <- map["merital_status"]
        height <- map["height"]
        weight <- map["weight"]
        emergency_contact <- map["emergency_contact"]
        allergies <- map["allergies"]
        current_medications <- map["current_medications"]
        past_medications <- map["past_medications"]
        chronic_diseases <- map["chronic_diseases"]
        injuries <- map["injuries"]
        surgeries <- map["surgeries"]
        smoking <- map["smoking"]
        alcohol <- map["alcohol"]
        activity <- map["activity"]
        food <- map["food"]
    }
    
}


struct Remainder : Mappable {
    var status : Int?
    var reminder : [Reminder]?
    
    init() {
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        reminder <- map["reminder"]
    }

}

struct Reminder : Mappable {
    var id : Int?
    var patient_id : Int?
    var name : String?
    var date : String?
    var time : String?
    var alarm : Int?
    var notify_me : Int?

    init() {
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        patient_id <- map["patient_id"]
        name <- map["name"]
        date <- map["date"]
        time <- map["time"]
        alarm <- map["alarm"]
        notify_me <- map["notify_me"]
    }

}
