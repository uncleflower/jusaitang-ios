//
//  Gateway.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/30/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import HandyJSON

class Gateway: NSObject {
    
    static let shared = Gateway()
    
    
    let websocket = IWebSocket()
    
    
    let requestManager = RequestManager.shared
    

    func start(){
        websocket.start()
        websocket.delegate = requestManager
    }
    
    func login(){
//        let request = LoginAPI.SocketLoginReq()
////        request.accessToken = "45c12e7063f04a04be1828468dbb3f38"
//        request.accessToken = DataManager.shared.accessToken
//
//        RequestManager.shared.send(type: 2, request: request) {
//            (res:LoginAPI.SocketLoginRes?, error) in
//            if error != nil{
//                return
//            }
//            self.didLogin()
//        }
    }
    
    func didLogin(){
//        NotificationCenter.default.post(name: .reconnect, object: nil)
    }
}
