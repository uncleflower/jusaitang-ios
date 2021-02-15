//
//  API.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/7/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class EmptyRes:HandyJSON {
    required init() {
        
    }
}

class BaseResponse<T>:HandyJSON{
    var message: String = ""
    var code: Int = 0
    var data: T?
    
    required init() {
    }
}

enum AuthStatus: Int{
    case login
    case none
}

class APIRequest<T>: NSObject {
    
    let url:String
    
    let request:HandyJSON
    
    init(url:String, request:HandyJSON) {
        self.url = url
        self.request = request
    }
    
    func get(auth:AuthStatus = .none, _ completion: @escaping(T?, IError?) -> Void){
        
        var headers:HTTPHeaders = [:]
        if auth == .login{
            headers["access_token"] = DataManager.shared.accessToken
//            headers["access_token"] = "45c12e7063f04a04be1828468dbb3f38"
        }
        self.request(method: .get, headers: headers, completion: completion)
    }
    
    func post(auth:AuthStatus = .none, image:UIImage, _ completion: @escaping(T?, IError?) -> Void){
      
           var headers:HTTPHeaders = [:]
           if auth == .login{
               headers["access_token"] = DataManager.shared.accessToken
//            headers["access_token"] = "45c12e7063f04a04be1828468dbb3f38"
           }
    }
    
    func post(auth:AuthStatus = .none, _ completion: @escaping(T?, IError?) -> Void){
        
        let jsonString = self.request.toJSONString()
        print("request url: \(self.url)")
        if let jsonString = jsonString {
            print("request jsonString: \(jsonString)")
        }
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpBody = jsonString?.data(using: .utf8)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if auth == .login{
            request.setValue(DataManager.shared.accessToken, forHTTPHeaderField: "access_token")
//            request.setValue("45c12e7063f04a04be1828468dbb3f38", forHTTPHeaderField: "access_token")
        }
        
        AF.request(request).responseString { (dataResponse) in
            if dataResponse.error != nil{
                completion(nil, IError.init(code: .networkError))
                return
            }
            
            guard
                let dataString = try? dataResponse.result.get(),
                let response = JSONDeserializer<BaseResponse<T>>.deserializeFrom(json: dataString)
                else {
                    completion(nil, IError.init(code: .networkError))
                    return
            }
            
            
            print("Response: \(dataString)")
            if response.code != 0{
                completion(nil, IError.init(code: response.code, message: response.message))
                return 
            }
            
            
            completion(response.data, nil)
        }
    }
    
    func request(method:HTTPMethod, headers:HTTPHeaders? = nil, completion: @escaping(T?, IError?) -> Void){
        let params = request.toJSON()
        let _request = AF.request(url, method: method, parameters: params, headers: headers)
        _request.responseString { (dataResponse) in
            if dataResponse.error != nil{
                completion(nil, IError.init(code: .networkError))
                return
            }
            
            guard
                let dataString = try? dataResponse.result.get(),
                let response = JSONDeserializer<BaseResponse<T>>.deserializeFrom(json: dataString)
                else {
                    completion(nil, IError.init(code: .networkError))
                    return
            }
            print("Response: \(dataString)")
            
            if response.code != 0{
                completion(nil, IError.init(code: response.code, message: response.message))
                return
            }
            
            completion(response.data, nil)
        }
    }
}
