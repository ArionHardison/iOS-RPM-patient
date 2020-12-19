//
//  ApiList.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

//Http Method Types

enum HttpType : String{
    
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

// Status Code

enum StatusCode : Int {
    
    case notreachable = 0
    case success = 200
    case multipleResponse = 300
    case unAuthorized = 401
    case notFound = 404
    case ServerError = 500
    
}



enum Base : String{
  
    
    case signIn = "api/oauth/token"
    case signUp = "/api/user/signup"
    case login = "/oauth/token"
    case resepwd = "/api/provider/profile/password"
    case distanceMarix = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins="
    case updateLocation = "api/provider/profile/location"
    case onlineStatus = "/api/provider/profile/available"
    
    //loginSingup
    case generateOTP = "/api/patient/otp"
    case verify_otp = "/api/patient/verify_otp"
    case signup = "api/patient/signup"
    case logout = "api/patient/logout"
    case appointment = "/api/patient/appointment"
    case cancelAppointment = "/api/patient/cancel_appointment"
    case catagoryList = "/api/patient/doctor_catagory"
    case addWallet = "/api/patient/add_wallet"
    case articles = "api/patient/articles"
    case medicalRecords = "/api/patient/records_list"
    case searchDoctors = "/api/patient/search_doctor"
    case fav = "/api/patient/favourite_doctor"
    case profile = "/api/patient/profile"
    case feedback = "/api/patient/feedback"
    case booking = "/api/patient/booking"
    case chatPromo = "/api/patient/chat/promocode"
    case proceedToPay = "/api/patient/payment"
    case chatHistory = "/api/patient/chat/history"
    case twilioMakeCall = "/api/patient/video/call" // "/api/patient/video/call/token"
    case twilioRecieveCall =  "/api/patient/video/call/token"
    case twilioCancelCall = "/api/patient//video/cancel"
    case remainderApi = "/api/patient/reminder_list"
    case addRemainder = "/api/patient/reminder"
    case visitedDoctor = "/api/patient/visited_doctors"
    case addCard = "/api/patient/card"
    case addMoney = "/api/patient/add_money"
    case deleteCard = "/api/patient/delete/card"
    case listCard = "//api/patient/card"
    case faq = "/api/patient/faq"
    case getRelative = "/api/patient/relative/list"
    case createRelative = "/api/patient/relative"
    case getDoctor = "/api/patient/doctor"
    case addMedicalRecord = "/api/patient/medical_records"
    case patientRecords = "/api/patient/records_details"
    case chatpush = "api/patient/chat_push"
    
    
    
   
    init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? .signUp
    }
    
    static func valueFor(Key : String?)->Base{
        
        guard let key = Key else {
            return Base.signUp
        }
        
//        for val in iterateEnum(Base.self) where val.rawValue == key {
//            return val
//        }
        
        if let base = Base(rawValue: key) {
            return base
        }
        
        return Base.signUp
        
    }
    
}
