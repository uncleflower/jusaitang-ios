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

class BaseResponse<T>:HandyJSON{
    var message: String = ""
    var code: Int = 0
    var data: T?
    
    required init() {
    }
}

class EmptyReq:HandyJSON {
    required init() {
    }
}

class EmptyRes:HandyJSON {
    required init() {
    }
}

enum AuthStatus: Int{
    case login
    case none
}


enum SignStatus: Int{
    case none = 0
    case `default` = 1
}


private let AppKey = "388fd16b38da405c"

private let AppSecret = "5dd88756388fd16b38da405cf67cacad"

class APIRequest<T>: NSObject {
    
    let host:String
    
    let path:String
    
    let request:HandyJSON
    
    var session:Alamofire.Session?
    
    var url:String{
        return "\(self.host)\(self.path)"
    }
    
    
    init(host:String = apiHost, path:String, request:HandyJSON) {
        self.host = host
        self.path = path
        self.request = request
    }
    
    func get(auth:AuthStatus = .none, _ completion: @escaping(T?, IError?) -> Void){
        var headers:HTTPHeaders = [:]
         if auth == .login, DataManager.shared.accessToken != nil && !DataManager.shared.accessToken.isEmpty{
            headers.add(.token(token: DataManager.shared.accessToken))
        }
        self.request(method: .get, headers: headers, completion: completion)
    }
    
    func post(auth:AuthStatus = .none, sign: SignStatus = .default, _ completion: @escaping(T?, IError?) -> Void){
        let jsonString = self.request.toJSONString()
        print("request url: \(url)")
        if let jsonString = jsonString {
            print("request jsonString: \(jsonString)")
        }
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpBody = jsonString?.data(using: .utf8)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        let configuration = URLSessionConfiguration.af.default
        configuration.headers = APIRequestHeader.default
        
        let signatureHeaders:HTTPHeader
        if let token = DataManager.shared.accessToken, !token.isEmpty, sign == .default{
            signatureHeaders = .signatureHeadersWithToken
            configuration.headers.add(.token(token: token))
        }else{
            signatureHeaders = .signatureHeaders
        }
        configuration.headers.add(signatureHeaders)
        
        if sign  == .default{
            configuration.headers.add(.sign(method: .post, path: self.path, headers: configuration.headers, signatureHeaders: signatureHeaders.value.split(separator: ",").toStringArray(), body: request.httpBody))
        }
        
        let session = Alamofire.Session(configuration: configuration)
        let _request = session.request(request)
        _request.responseString {(dataResponse) in
            self.handleResponse(response: dataResponse, completion: completion)
            self.session = nil
        }
        self.session = session
    }
    
    func request(method:HTTPMethod, sign: SignStatus = .default, headers:HTTPHeaders = [:], completion: @escaping(T?, IError?) -> Void){
        let jsonString = self.request.toJSONString()
        print("request url: \(self.path)")
        if let jsonString = jsonString {
            print("request jsonString: \(jsonString)")
        }
    
        let params = request.toJSON()
        
        let configuration = URLSessionConfiguration.af.default
        configuration.headers = APIRequestHeader.default
        let signatureHeaders:HTTPHeader
        
        if let token = DataManager.shared.accessToken, !token.isEmpty, sign == .default{
            signatureHeaders = .signatureHeadersWithToken
            configuration.headers.add(.token(token: token))
        }else{
            signatureHeaders = .signatureHeaders
        }
        configuration.headers.add(signatureHeaders)
        
        
        if sign  == .default{
            configuration.headers.add(.sign(method: method, path: self.path, headers: configuration.headers, signatureHeaders: signatureHeaders.value.split(separator: ",").toStringArray(), params: params))
        }
        let session = Alamofire.Session(configuration: configuration)
        
        let _request = session.request("\(host)\(path)", method: method, parameters: params, headers: headers)
        _request.responseString {(dataResponse) in
            self.handleResponse(response: dataResponse, completion: completion)
            self.session = nil
        }
        self.session = session
    }
    
    func handleResponse(response: AFDataResponse<String>, completion: @escaping(T?, IError?) -> Void){
        if response.error != nil{
            completion(nil, IError.init(code: .networkError))
            return
        }
        
        guard
            let dataString = try? response.result.get(),
            let response = JSONDeserializer<BaseResponse<T>>.deserializeFrom(json: dataString)
            else {
                completion(nil, IError.init(code: .networkError))
                return
        }
        print("Response: \(dataString)")
        
        //一般 success = 0
        if response.code != 1{
            if response.code == IErrorType.tokenInvalid.rawValue{
                NotificationCenter.default.post(name: .invalidToken, object: nil)
                completion(nil, nil)
                return
            }
            completion(nil, IError.init(code: response.code, message: response.message))
            return
        }
        
        completion(response.data, nil)
    }
    
    
}


class APIRequestHeader {
    static let `default`: HTTPHeaders = [.defaultAcceptEncoding,
                                         .defaultAcceptLanguage,
                                         APIRequestHeader.defaultUserAgent,
                                         .accept("application/json"),
                                         .contentType("application/json;charset=UTF-8"),
                                         .timestamp,
                                         .appKey]
    public static let defaultUserAgent: HTTPHeader = {
        let info = Bundle.main.infoDictionary
        let executable = (info?[kCFBundleExecutableKey as String] as? String) ??
            (ProcessInfo.processInfo.arguments.first?.split(separator: "/").last.map(String.init)) ??
            "Unknown"
        let appBuild = info?[kCFBundleVersionKey as String] as? String ?? "Unknown"

        let osNameVersion: String = {
            let version = ProcessInfo.processInfo.operatingSystemVersion
            let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
            let osName: String = {
                #if os(iOS)
                #if targetEnvironment(macCatalyst)
                return "macOS(Catalyst)"
                #else
                return "iOS"
                #endif
                #elseif os(watchOS)
                return "watchOS"
                #elseif os(tvOS)
                return "tvOS"
                #elseif os(macOS)
                return "macOS"
                #elseif os(Linux)
                return "Linux"
                #elseif os(Windows)
                return "Windows"
                #else
                return "Unknown"
                #endif
            }()

            return "\(osName) \(versionString)"
        }()

        let userAgent = "jusaitang/\(appBuild) (model:\(UIDevice.modelName); os:\(osNameVersion); scale: \(UIScreen.screens.first?.scale ?? 1.0))"

        return .userAgent(userAgent)
    }()
}


extension HTTPHeader{
    static var signatureHeaders: HTTPHeader{
        return HTTPHeader.init(name: "X-Ca-Signature-Headers", value: "X-Ca-Key,X-Ca-Timestamp")
    }
    static var signatureHeadersWithToken: HTTPHeader{
//        return HTTPHeader.init(name: "X-Ca-Signature-Headers", value: "X-Ca-Key,X-Ca-Timestamp,X-Ca-Token")
        return HTTPHeader.init(name: "X-Ca-Signature-Headers", value: "X-Ca-Key,X-Ca-Timestamp,Authorization")
    }
    
    static var timestamp: HTTPHeader{
        return HTTPHeader.init(name: "X-Ca-Timestamp", value: "\(Int(Date.now.timeIntervalSince1970))")
    }
    
    static var appKey: HTTPHeader{
        return HTTPHeader.init(name: "X-Ca-Key", value: "\(AppKey)")
    }
    
    static func token(token: String) -> HTTPHeader{
//        return HTTPHeader.init(name: "X-Ca-Token", value: token)
        return HTTPHeader.init(name: "Authorization", value: token)
    }
    
    
    static func sign(method: HTTPMethod, path: String, headers:HTTPHeaders, signatureHeaders:[String]? = [], params:[String:Any]? = nil, body:Data? = nil) -> HTTPHeader{
        var signature = ""
        signature += method.rawValue
        
        signature += "\n"
        if let body = body{
            signature += body.md5().base64EncodedString()
        }
        signature += "\n"
        
        if let signatureHeaders = signatureHeaders {
            for signatureHeader in signatureHeaders {
                if let header = headers[signatureHeader]{
                    signature += "\(signatureHeader.lowercased()):\(header)\n"
                }
            }
        }
        
        signature += path
        if let params = params {
            var array = params.toArray()
            array = array.sorted { (first, sec) -> Bool in
                return first.0 < sec.0
            }
            
            var arrayString: [String] = []
            for element in array{
                arrayString.append("\(element.0)=\(element.1)")
            }
            let paramsString = arrayString.joined(separator: "&")
            if !paramsString.isEmpty{
                signature += "?\(paramsString)"
            }
        }
        
        print("signature: \n\(signature)")
        let result =  signature.data(using: .utf8)?.hmac(algorithm: .sha256, secretKey: AppSecret).base64EncodedString() ?? ""
        return HTTPHeader.init(name: "X-Ca-Signature", value: result)
    }
}
