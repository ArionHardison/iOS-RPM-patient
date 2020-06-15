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
    var device_token  : String = ""
    var device_id  : String? = ""
    var client_id : Int = appClientId
    var client_secret : String = appSecretKey
    var grant_type : String = "otp"
    var mobile : String?
    var otp : String?
}


struct SignupReq : Codable{
     var email : String = ""
     var device_type : String = "iOS"
     var device_token : String = "iOS"
     var device_id : String = ""
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
