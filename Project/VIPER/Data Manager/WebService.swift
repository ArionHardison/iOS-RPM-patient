//
//  WebService.swift
//  Swift_Base
//
//  Created by Ranjith on 17/02/19.
//  Copyright © 2019 Ranjith. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class Webservice {
    
    var interactor: WebServiceToInteractor?
    var completion: ((CustomError?, Data?) -> ())?
}

extension Webservice : WebServiceProtocol {
    
    func retrieve<T: Mappable>(api: String, params: Parameters?, imageData: [String : Data]?, type: HttpType, modelClass: T.Type, token: Bool, completion: ((CustomError?, Data?) -> ())?) {
        if params != nil{
//            print("Params----\(params!)")
        }
        
        let reach = Reachability.init(hostname: baseUrl)
        
        guard reach?.connection == .wifi || reach?.connection == .cellular else {  // Internet not available
            self.completion?(CustomError(description: ErrorMessage.list.notReachable, code: StatusCode.notreachable.rawValue), nil)
            
            self.interactor?.responseError(error: CustomError(description: ErrorMessage.list.notReachable, code:StatusCode.notreachable.rawValue))
            return
        }
        
        guard let url = URL(string: baseUrl+api) else {
            print("Invalid Url")
            return
        }
        let encoding:ParameterEncoding = (type == .GET ? URLEncoding.default : JSONEncoding.default)
        
        self.completion = completion
        var headers = HTTPHeaders()
        headers.updateValue(WebConstants.string.application_json, forKey: WebConstants.string.Content_Type)
        headers.updateValue(WebConstants.string.XMLHttpRequest, forKey: WebConstants.string.X_Requested_With)
      
        if(token) {
            
            let accessToken = UserDefaultConfig.Token ?? ""
            headers.updateValue("\(WebConstants.string.bearer) \(accessToken)", forKey: WebConstants.string.Authorization)
        }
        
        let httpMethod = HTTPMethod(rawValue: type.rawValue) //GET or POST
    
        switch imageData { //GET or POST
            
        case nil:
            
            print("**url", url)
            print("**httpMethod", httpMethod!)
            print("**params", params)
            print("**token", UserDefaultConfig.Token ?? "")
            
            Alamofire.request(url, method: httpMethod!, parameters: params,encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                print("response.result",response.result)
                switch response.result {
                case .failure:
                    print("ERROR---\(response.error?.localizedDescription ?? "API ERROR")")
                    self.handleError(responseError: response, modelClass: modelClass)  //Handling Error Cases:
                case .success:
                    print("RESPONSE---\(response)")
                    
                    if response.response?.statusCode == StatusCode.success.rawValue {
                        if(response.result.value as AnyObject).isKind(of: NSDictionary.self){ //Dictionary:
                            guard let responseJSON = response.result.value as? [String: AnyObject] else {
                                print("Error reading response")
                               
                                return
                            }
                             print("responseJSON: ",responseJSON)
                            self.interactor?.responseSuccess(api: api, className: modelClass, responseDict: responseJSON, responseArray: [])
                        }else{ //Array:
                            if let json = response.result.value as? [[String:Any]] {
                                   print("responseJSON: ",json)
                                self.interactor?.responseSuccess(api: api, className: modelClass, responseDict: [:], responseArray: json)
                            }
                        }
                    }else{
                        self.handleError(responseError: response, modelClass: modelClass)
                    }
                }
            }
            break
            
            
        
        default: //Image Post:
            Alamofire.upload(multipartFormData: { multipartFormData in
                if let imageArray = imageData{ //Image:
                    for array in imageArray {
                        multipartFormData.append(array.value, withName: array.key, fileName: "image.png", mimeType: "image/png")
                    }
                }
                for (key, value) in params ?? [:] { //Other Params:
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            },to:url,method: .post,headers:headers) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        switch response.result {
                        case .failure(let err):
                            print("IMAGE POST ERROR---\(err)")
                            self.handleError(responseError: response, modelClass: modelClass)
                        case .success(let val):
                            print("IMAGE POST RESPONSE---\(val)")
                            if response.response?.statusCode == StatusCode.success.rawValue {
                                if(response.result.value as AnyObject).isKind(of: NSDictionary.self){  //Dictionary
                                    guard let responseJSON = response.result.value as? [String: AnyObject] else {
                                        print("Error reading response")
                                        return
                                    }
                                    self.interactor?.responseSuccess(api: api, className: modelClass, responseDict: responseJSON, responseArray: [])
                                }else{  //Array
                                    if let json = response.result.value as? [[String:Any]] {
                                        self.interactor?.responseSuccess(api: api, className: modelClass, responseDict: [:], responseArray: json)
                                    }
                                }
                            }else {
                                self.handleError(responseError: response, modelClass: modelClass)
                            }
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
            break
        }
    }
    
    
  
    
    //MARK: Handle Error:
    func handleError(responseError: (DataResponse<Any>)?, modelClass: Any) {
        
        if responseError?.response?.statusCode == StatusCode.unAuthorized.rawValue  { // Validation For UnAuthorized Login:
            
            self.completion?(CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError!.response?.statusCode) ?? StatusCode.ServerError.rawValue), nil)
            
            self.interactor?.responseError(error: CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError?.response?.statusCode) ?? StatusCode.ServerError.rawValue))
            
            if(responseError?.error?.localizedDescription == "token_expired"){
                forceLogout()
                //Force Logout: [Clear all the caches before logout the user in our application]
            }else{
                forceLogout()
                //Force Logout: [Clear all the caches before logout the user in our application]
            }
        }else if responseError?.response?.statusCode != StatusCode.success.rawValue {  //  Validation for Error Log, Retrieving error from Server:
            
            if responseError?.error != nil {
                
                self.completion?(CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError!.response?.statusCode) ?? StatusCode.ServerError.rawValue), nil)
                
                self.interactor?.responseError(error: CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError?.response?.statusCode) ?? StatusCode.ServerError.rawValue))
                
            } else if responseError?.data != nil  {
                
                var errMessage : String = ""
                do {
                    
                    if let errValue = try JSONSerialization.jsonObject(with: (responseError?.data!)!, options: .allowFragments) as? [String : [Any]] {
                        for err in errValue.values where err.count>0 {
                            errMessage.append("\n\(err.first ?? "")")
                        }
                    } else if let errValue = try JSONSerialization.jsonObject(with: (responseError?.data!)!, options: .allowFragments) as? NSDictionary {
                        for err in errValue.allValues{
                            errMessage.append("\n\(err)")
                        }
                    }
                }catch let err {
                    print("Err  ",err.localizedDescription)
                }
                
                if errMessage.isEmpty {
                    errMessage = "Server Error"
                }
                
                self.completion?(CustomError(description:errMessage, code: responseError?.response?.statusCode ?? StatusCode.ServerError.rawValue), nil)
                
                self.interactor?.responseError(error: CustomError(description: errMessage, code: (responseError?.response?.statusCode) ?? StatusCode.ServerError.rawValue))
            }else{
                
                self.completion?(CustomError(description: responseError?.error?.localizedDescription ?? "", code: responseError?.response?.statusCode ?? StatusCode.ServerError.rawValue), nil)
                
                self.interactor?.responseError(error: CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError?.response?.statusCode) ?? StatusCode.ServerError.rawValue))
                
            }
        }else if let data = responseError?.data {  // Validation For Server Data
            self.completion?(nil, data)
            
            if(responseError?.result.value as AnyObject).isKind(of: NSDictionary.self){ //Dictionary:
                guard let responseJSON = responseError?.result.value as? [String: AnyObject] else {
                    print("Error reading response")
                    return
                }
                /* self.interactor?.dictModelClass(className: modelClass, response: responseJSON)*/
            }else{ //Array:
                if let json = responseError?.result.value as? [[String:Any]] {
                    /*self.interactor?.arrayModelClass(className: modelClass, arrayResponse: json)*/
                }
            }
            
        }else{ // Validation for Exceptional Cases
            self.completion?(CustomError(description: "Server Error", code: StatusCode.ServerError.rawValue), nil)
            self.interactor?.responseError(error: CustomError(description: responseError?.error?.localizedDescription ?? "", code: (responseError?.response?.statusCode) ?? StatusCode.ServerError.rawValue))
        }
    }
}







