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
    var allergies : [Allergies]?
    var currency : Currency?
    
    init() {
        
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        patient <- map["patient"]
        profile_complete <- map["profile_complete"]
        allergies <- map["allergies"]
        currency <- map["currency"]
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
    
    init() {
        
    }
    
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



struct UpdatedVistedDoctor : Mappable {
    var vistedDoctors : VistedDoctors?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vistedDoctors <- map["visited_doctors"]
    }

}


struct VistedDoctors : Mappable {
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
    var stripe_cust_id : String?
    var appointments : [Appointments]?

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
        stripe_cust_id <- map["stripe_cust_id"]
        appointments <- map["appointments"]
    }

}


struct CardSuccess  : Mappable {
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["message"]
    }

}


struct AddMoneyModel  : Mappable {
    var message : String?
    var user : User?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["message"]
        user <- map["user"]
    }

}


struct User : Mappable {
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
    var stripe_cust_id : String?

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
        stripe_cust_id <- map["stripe_cust_id"]
    }

}


struct Allergies : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
    }

}


struct Currency : Mappable {
    var site_title : String?
    var site_logo : String?
    var site_favicon : String?
    var site_copyright : String?
    var delivery_charge : String?
    var resturant_response_time : String?
    var currency : String?
    var currency_code : String?
    var search_distance : String?
    var tax : String?
    var payment_mode : String?
    var manual_assign : String?
    var transporter_response_time : String?
    var gOOGLE_API_KEY : String?
    var android_api_key : String?
    var ios_api_key : String?
    var tWILIO_SID : String?
    var tWILIO_TOKEN : String?
    var tWILIO_FROM : String?
    var pUBNUB_PUB_KEY : String?
    var pUBNUB_SUB_KEY : String?
    var stripe_charge : String?
    var stripe_publishable_key : String?
    var stripe_secret_key : String?
    var fB_CLIENT_ID : String?
    var fB_CLIENT_SECRET : String?
    var fB_REDIRECT : String?
    var gOOGLE_CLIENT_ID : String?
    var gOOGLE_CLIENT_SECRET : String?
    var gOOGLE_REDIRECT : String?
    var aNDROID_ENV : String?
    var aNDROID_PUSH_KEY : String?
    var iOS_USER_ENV : String?
    var iOS_PROVIDER_ENV : String?
    var sUB_CATEGORY : String?
    var sCHEDULE_ORDER : String?
    var client_id : String?
    var client_secret : String?
    var pRODUCT_ADDONS : String?
    var bRAINTREE_ENV : String?
    var bRAINTREE_MERCHANT_ID : String?
    var bRAINTREE_PUBLIC_KEY : String?
    var bRAINTREE_PRIVATE_KEY : String?
    var rIPPLE_KEY : String?
    var rIPPLE_BARCODE : String?
    var eTHER_ADMIN_KEY : String?
    var eTHER_KEY : String?
    var eTHER_BARCODE : String?
    var cLIENT_AUTHORIZATION : String?
    var sOCIAL_FACEBOOK_LINK : String?
    var sOCIAL_TWITTER_LINK : String?
//    var sOCIAL_G-PLUS_LINK : String?
    var sOCIAL_INSTAGRAM_LINK : String?
    var sOCIAL_PINTEREST_LINK : String?
    var sOCIAL_VIMEO_LINK : String?
    var sOCIAL_YOUTUBE_LINK : String?
    var cOMMISION_OVER_FOOD : String?
    var cOMMISION_OVER_DELIVERY_FEE : String?
    var iOS_APP_LINK : String?
    var aNDROID_APP_LINK : String?
    var default_lang : String?
    var dEMO_MODE : String?
    var about : String?
    var help : String?
    var privacy : String?
    var chat_discount : String?
    var stripe_public_key : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        site_title <- map["site_title"]
        site_logo <- map["site_logo"]
        site_favicon <- map["site_favicon"]
        site_copyright <- map["site_copyright"]
        delivery_charge <- map["delivery_charge"]
        resturant_response_time <- map["resturant_response_time"]
        currency <- map["currency"]
        currency_code <- map["currency_code"]
        search_distance <- map["search_distance"]
        tax <- map["tax"]
        payment_mode <- map["payment_mode"]
        manual_assign <- map["manual_assign"]
        transporter_response_time <- map["transporter_response_time"]
        gOOGLE_API_KEY <- map["GOOGLE_API_KEY"]
        android_api_key <- map["android_api_key"]
        ios_api_key <- map["ios_api_key"]
        tWILIO_SID <- map["TWILIO_SID"]
        tWILIO_TOKEN <- map["TWILIO_TOKEN"]
        tWILIO_FROM <- map["TWILIO_FROM"]
        pUBNUB_PUB_KEY <- map["PUBNUB_PUB_KEY"]
        pUBNUB_SUB_KEY <- map["PUBNUB_SUB_KEY"]
        stripe_charge <- map["stripe_charge"]
        stripe_publishable_key <- map["stripe_publishable_key"]
        stripe_secret_key <- map["stripe_secret_key"]
        fB_CLIENT_ID <- map["FB_CLIENT_ID"]
        fB_CLIENT_SECRET <- map["FB_CLIENT_SECRET"]
        fB_REDIRECT <- map["FB_REDIRECT"]
        gOOGLE_CLIENT_ID <- map["GOOGLE_CLIENT_ID"]
        gOOGLE_CLIENT_SECRET <- map["GOOGLE_CLIENT_SECRET"]
        gOOGLE_REDIRECT <- map["GOOGLE_REDIRECT"]
        aNDROID_ENV <- map["ANDROID_ENV"]
        aNDROID_PUSH_KEY <- map["ANDROID_PUSH_KEY"]
        iOS_USER_ENV <- map["IOS_USER_ENV"]
        iOS_PROVIDER_ENV <- map["IOS_PROVIDER_ENV"]
        sUB_CATEGORY <- map["SUB_CATEGORY"]
        sCHEDULE_ORDER <- map["SCHEDULE_ORDER"]
        client_id <- map["client_id"]
        client_secret <- map["client_secret"]
        pRODUCT_ADDONS <- map["PRODUCT_ADDONS"]
        bRAINTREE_ENV <- map["BRAINTREE_ENV"]
        bRAINTREE_MERCHANT_ID <- map["BRAINTREE_MERCHANT_ID"]
        bRAINTREE_PUBLIC_KEY <- map["BRAINTREE_PUBLIC_KEY"]
        bRAINTREE_PRIVATE_KEY <- map["BRAINTREE_PRIVATE_KEY"]
        rIPPLE_KEY <- map["RIPPLE_KEY"]
        rIPPLE_BARCODE <- map["RIPPLE_BARCODE"]
        eTHER_ADMIN_KEY <- map["ETHER_ADMIN_KEY"]
        eTHER_KEY <- map["ETHER_KEY"]
        eTHER_BARCODE <- map["ETHER_BARCODE"]
        cLIENT_AUTHORIZATION <- map["CLIENT_AUTHORIZATION"]
        sOCIAL_FACEBOOK_LINK <- map["SOCIAL_FACEBOOK_LINK"]
        sOCIAL_TWITTER_LINK <- map["SOCIAL_TWITTER_LINK"]
//        sOCIAL_G-PLUS_LINK <- map["SOCIAL_G-PLUS_LINK"]
        sOCIAL_INSTAGRAM_LINK <- map["SOCIAL_INSTAGRAM_LINK"]
        sOCIAL_PINTEREST_LINK <- map["SOCIAL_PINTEREST_LINK"]
        sOCIAL_VIMEO_LINK <- map["SOCIAL_VIMEO_LINK"]
        sOCIAL_YOUTUBE_LINK <- map["SOCIAL_YOUTUBE_LINK"]
        cOMMISION_OVER_FOOD <- map["COMMISION_OVER_FOOD"]
        cOMMISION_OVER_DELIVERY_FEE <- map["COMMISION_OVER_DELIVERY_FEE"]
        iOS_APP_LINK <- map["IOS_APP_LINK"]
        aNDROID_APP_LINK <- map["ANDROID_APP_LINK"]
        default_lang <- map["default_lang"]
        dEMO_MODE <- map["DEMO_MODE"]
        about <- map["about"]
        help <- map["help"]
        privacy <- map["privacy"]
        chat_discount <- map["chat_discount"]
        stripe_public_key <- map["stripe_public_key"]
    }

}


struct RelativeManagement : Mappable {
    var status : Int?
    var relatives : [Relatives]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        relatives <- map["relatives"]
    }

}


struct Relatives : Mappable {
    var id : Int?
    var patient_id : Int?
    var first_name : String?
    var last_name : String?
    var phone : String?
    var username : String?
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
    var stripe_cust_id : String?
    var regn_id : String?
    var email_verified : Int?
    var email_token : String?
    var email_verified_at : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var profile : Profile?
    
    init() {
        
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        patient_id <- map["patient_id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        phone <- map["phone"]
        username <- map["username"]
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
        stripe_cust_id <- map["stripe_cust_id"]
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


struct CreateRelativeResponse : Mappable {
    var message : String?
    var patient_relative : Patient_relative?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["message"]
        patient_relative <- map["patient_relative"]
    }

}


struct Patient_relative : Mappable {
    var id : Int?
    var patient_id : Int?
    var first_name : String?
    var last_name : String?
    var phone : String?
    var username : String?
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
    var stripe_cust_id : String?
    var regn_id : String?
    var email_verified : Int?
    var email_token : String?
    var email_verified_at : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        patient_id <- map["patient_id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        phone <- map["phone"]
        username <- map["username"]
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
        stripe_cust_id <- map["stripe_cust_id"]
        regn_id <- map["regn_id"]
        email_verified <- map["email_verified"]
        email_token <- map["email_token"]
        email_verified_at <- map["email_verified_at"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}


struct MakeTwilioCall  : Mappable {
    var accessToken : String?
    var roomName : String?
    var user : User?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        accessToken <- map["accessToken"]
        roomName <- map["roomName"]
        user <- map["user"]
    }

}



struct AddMedicalRecordModel : Mappable {
    var patient_prescription : Patient_prescription?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        patient_prescription <- map["patient_prescription"]
    }

}

struct Patient_prescription : Mappable {
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
    var hospital : Hospital?
    var appointment : Appointment?

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
        hospital <- map["hospital"]
        appointment <- map["appointment"]
    }

}


struct GetDoctors  : Mappable {
    var status : Bool?
    var doctor : [Doctor]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        doctor <- map["doctor"]
    }

}


struct Doctor : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var mobile : String?
    var country_code : String?
    var email : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var login_by : String?
    var social_unique_id : String?
    var wallet_balance : Int?
    var otp : String?
    var rating : String?
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

    init() {
        
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        mobile <- map["mobile"]
        country_code <- map["country_code"]
        email <- map["email"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        login_by <- map["login_by"]
        social_unique_id <- map["social_unique_id"]
        wallet_balance <- map["wallet_balance"]
        otp <- map["otp"]
        rating <- map["rating"]
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
    }

}


struct ListMedicalRecord : Mappable {
    var status : Int?
    var medicals : [Medicals]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        medicals <- map["medical"]
    }

}


struct Medicals : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var mobile : String?
    var country_code : String?
    var email : String?
    var device_token : String?
    var push_device_token : String?
    var device_id : String?
    var device_type : String?
    var login_by : String?
    var social_unique_id : String?
    var wallet_balance : Int?
    var otp : Int?
    var rating : String?
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
    var doctor_profile : Doctor_profile?
    var clinic : Clinic?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        mobile <- map["mobile"]
        country_code <- map["country_code"]
        email <- map["email"]
        device_token <- map["device_token"]
        push_device_token <- map["push_device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        login_by <- map["login_by"]
        social_unique_id <- map["social_unique_id"]
        wallet_balance <- map["wallet_balance"]
        otp <- map["otp"]
        rating <- map["rating"]
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
        doctor_profile <- map["doctor_profile"]
        clinic <- map["clinic"]
    }

}
