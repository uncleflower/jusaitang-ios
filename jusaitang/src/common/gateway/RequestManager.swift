//
//  RequestManager.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/30/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import HandyJSON

class RequestManager: NSObject {
    
    static let shared = RequestManager()
    
    typealias ResponseComplete = (([String:Any]?, IError?) -> Void)
    
    var requests:[Int:ResponseComplete] = [:]
    
    func send<T:HandyJSON>(type: Int, request:HandyJSON, completion: ((T?, IError?) -> Void)?){
        let request = IWebSocket.BaseRequest(id: createUniqueID(), type: type, body: request)
        let complete:ResponseComplete = {
            (res, err) in
            if let err = err{
                completion?(nil,err)
                return
            }
            if let json = res?.json() {
                completion?(JSONDeserializer<T>.deserializeFrom(json: json),nil)
                return
            }
            completion?(nil,nil)
            return
        }

        let requestID = createUniqueID()
        self.requests[requestID] = complete
//        Gateway.shared.websocket.send(request: request) {
//            error in
//            if let error = error {
//                completion?(nil, error)
//            }
//        }
        Gateway.shared.websocket.send(request: request)
    }
    
    func createUniqueID() -> Int{
        return Int(Date().timeIntervalSince1970)
    }
}

extension RequestManager:IWebSocketDelegate {
    //看这里
    func responseHander(text:String) -> Bool {
        guard
            let response = JSONDeserializer<IWebSocket.BaseResponse>.deserializeFrom(json: text)
            else {return false}
        
        // 主动请求的回包，类似http
        if response.type == 0 {
            if response.id > 0, let completion = self.requests[response.id]{
                completion(response.data, nil)
            }
        }
        
        switch response.type/10000 {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
        return true
    }
}

//extension RequestManager:IWebSocketDelegate {
//    //看这里
//    func responseHander(text:String) -> Bool {
//        guard
//            let response = JSONDeserializer<IWebSocket.BaseResponse>.deserializeFrom(json: text)
////            let completion = self.requests[response.id]
//            else {return false}
//
//        print(response.type)
//
//        // 主动请求的回包，类似http
//        if response.type == 0 {
//            if response.code != 0{
////                completion(nil, IError.init(code: response.code, message: response.message))
//                return true
//            }
//        }
//
//        // 服务端主动下发的请求
////        if response.type > 0 {
////            let data = response.data
////            if response.type == 3000001{
////                sssss
////                notifaOrderAccpt(sssss)
////            }
////
////        }
//
//
////        completion(response.data, nil)
//        if let completion = self.requests[response.id]{
//            completion(response.data, nil)
//        }
//        return true
//    }
//
////    func notifaOrderAccpt(sssss){
////
////    }
//}
