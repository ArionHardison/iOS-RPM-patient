//
//  AppData.swift
//  User
//
//  Created by CSS on 10/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

let AppName = "TeleHealth User"
var deviceTokenString = Constants.string.noDevice
var push_device_token = Constants.string.noDevice
var deviceId = Constants.string.noDevice
var deviceType : DeviceType = .ios
let googleMapKey = "AIzaSyA0E5hVa9FQhK7CBqnz4alq23f6LUxrbUI" //"AIzaSyCgW9ZrUixRu9-AbVt78C3Xo6Stp1DjO-g"
let appSecretKey = "FUKbf4dklbxmZJ+09YPAtfKFh341TNP8HGUU8PFl"
let appClientId = 2
let defaultMapLocation = LocationCoordinate(latitude: 13.009245, longitude: 80.212929)
let baseUrl = "https://telehealthmanager.net/" //"http://blabla.deliveryventure.com/"
let imageURL = "https://telehealthmanager.net/storage/"
let supportNumber = "9876543210"
let supportEmail = "support@telehealthmanager.net"
let country_code = "IN"
let currency = "$ "
let mobileNumDigit : Int = 10
var profileDetali = ProfileModel()
var doctorId = "0"
var serviceID = "0"
var GlobalsenderId = String()
var GlobalreciveId = String()
let aboutUrl = "https://telehealthmanager.net/"
let stripeKey = "pk_test_EacUddWKtq5XqAt3dGdpr0YW"
