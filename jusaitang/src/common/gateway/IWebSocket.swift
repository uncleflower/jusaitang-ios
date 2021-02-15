//
//  IWebSocket.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/30/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import HandyJSON
import SocketRocket

protocol IWebSocketDelegate {
    func responseHander(text:String) -> Bool
}


class IWebSocket: NSObject {

    let websocketHost = "wss://***"
    
    var socket:SRWebSocket?
    
    var hearBeatTimer:Timer?
    
    var retryTimer:Timer?
    
    var lastFire:TimeInterval = 0
    
    var isConnected:Bool {
        guard let socket = self.socket else {return false}
        return socket.readyState == .OPEN
    }
    
    var isConnecting:Bool {
        guard let socket = self.socket else {return false}
        return socket.readyState == .CONNECTING
    }

    var _isWaitingForConnect:Bool = false

    var delegate:IWebSocketDelegate?
    
    func start(){
        self.establishConnection()
    }
    
    func establishConnection(){
        if _isWaitingForConnect || isConnected || isConnecting {
            return
        }
        self.socket?.delegate = nil
        
        let request = URLRequest(url: URL(string: "\(websocketHost):33333")!)
        
        self.socket = SRWebSocket(urlRequest: request)
        self.socket?.delegate = self
//        self.socket?.callbackQueue = .main
        self.socket?.open()
    }
    
    func stop(){
        retryTimer?.invalidate()
        retryTimer = nil
        _isWaitingForConnect = false
        stopHearbeat()
        self.socket?.delegate = nil
        self.socket?.close()
        self.socket = nil
    }
    
    func reconnect(interval:TimeInterval){
        if isConnected || _isWaitingForConnect || retryTimer != nil {
            return
        }
        self._isWaitingForConnect = true
        retryTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(reconnectImmediately), userInfo: nil, repeats: false)
    }
    
    @objc func reconnectImmediately(){
        retryTimer?.invalidate()
        retryTimer = nil
        _isWaitingForConnect = false
        if isConnected || isConnecting {
            return
        }
        self.establishConnection()
    }
    
    func startHearbeat(){
        hearBeatTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(sendHearbeat), userInfo: nil, repeats: true)
        hearBeatTimer?.fire()
    }
    
    func stopHearbeat(){
        hearBeatTimer?.invalidate()
        hearBeatTimer = nil
    }
}

extension IWebSocket: SRWebSocketDelegate{
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
//        print("message: \(message as? String)")
        if let message = message as? String{
            self.handler(text:message)
        }
    }
    
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        Gateway.shared.login()
        startHearbeat()
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        stopHearbeat()
        self.reconnect(interval: 5)
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        stopHearbeat()
        self.reconnect(interval: 10)
    }
    
    
    @objc func sendHearbeat(){
        let current = Date().timeIntervalSince1970
        if lastFire >= current - 5{
            return
        }
        if !isConnected {
            self.reconnect(interval: 5)
            return
        }
        self.sendPing()
        lastFire = current
    }
    
    func handler(error:Error?){
        
    }
    
    func handler(text:String){
        _ = self.delegate?.responseHander(text: text)
    }
    
    func sendPing(){
        if isConnected{
            socket?.sendPing(Data())
        }
    }
    
    func send(text:String){
        if isConnected{
            self.socket?.send(text)
        }
        lastFire = Date().timeIntervalSince1970
    }
    
    
    func send(request:HandyJSON){
        guard let string = request.toJSONString() else {
            return
        }
        self.send(text: string)
    }
}


extension IWebSocket {

    class BaseRequest:HandyJSON{
        
        var id:Int
        var type:Int
        var body: HandyJSON?
        
        required init(id: Int, type: Int, body: HandyJSON) {
            self.id = id
            self.type = type
            self.body = body
        }
        
        required init() {
            id = 0
            type = 0
        }
    }

    class BaseResponse:HandyJSON{
        var id:Int = 0
        var type:Int = 0 //只有主动下发的消息才会有type。不然就是0
        var message: String = ""
        var code: Int = 0
        var data: [String:Any]?
        
        required init() {
        }
    }


}
