//
//  LoginReq.swift
//  MiDokter User
//
//  Created by AppleMac on 15/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginReq : Codable{
    var device_type : String = "iOS"
    var device_token  : String = deviceTokenString
    var device_id  : String? = UUID().uuidString
    var client_id : Int = appClientId
    var client_secret : String = appSecretKey
    var grant_type : String = "otp"
    var mobile : String?
    var otp : String?
}


struct SignupReq : Codable{
     var email : String = ""
     var device_type : String = "ios"
     var device_token : String = deviceTokenString
     var device_id : String = deviceId
     var client_id : Int = appClientId
     var client_secret : String = appSecretKey
     var grant_type : String = "password"
     var first_name : String = ""
     var last_name : String = ""
     var phone : String = ""
     var dob : String = ""
     var gender : String = ""
     var otp : String = ""
}



struct MobileVerifyModel : Mappable {
    var success : Bool?
    var message : String?
    var otp : Int?
    var mobileNum : String = ""
    var token : String?
    
    //   var data : Data?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        success <- map["success"]
        message <- map["message"]
        otp <- map["otp"]
        token <- map["token"]
        //   data <- map["data"]
    }
}



struct SignupResponseModel : Mappable {
    var email : String?
    var first_name : String?
    var last_name : String?
    var phone : String?
    var otp : String?
    var updated_at : String?
    var created_at : String?
    var id : Int?
    var token_type : String?
    var access_token : Access_token?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        email <- map["email"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        phone <- map["phone"]
        otp <- map["otp"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        id <- map["id"]
        token_type <- map["token_type"]
        access_token <- map["access_token"]
    }
}


struct Headers : Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
    
}


struct Access_token : Mappable {
    var headers : Headers?
    var original : Original?
    var exception : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        headers <- map["headers"]
        original <- map["original"]
        exception <- map["exception"]
    }
    
}


struct Original : Mappable {
    var token : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        token <- map["token"]
    }
    
}
