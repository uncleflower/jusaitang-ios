//
//  DataManager.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/11.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DataManager: NSObject {
    
    private static let guardKey = "guard"
    
    private static let addressKey = "address"
    
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenkey = "refreshToken"
    
    static let shared = DataManager()

//    var services: [ServiceModel] = []
//
//    var didLoginObservable: BehaviorSubject<Bool> = BehaviorSubject.init(value: false)
//
//    var guardInfo: GuardModel? = DataManager.readGuard()
//
//    var defaultAddr: UserAddressModel? = DataManager.readDefaultAddr()
//
//    var orderList: [OrderModel] = []
//
////    var loginStatus
//
//    var nearbyVillages: [NearbyVillageModel] {
//        didSet {
//            print(nearbyVillages)
//        }
//    }
    
    var accessToken: String! = DataManager.readToken().0
    
    var refreshToken: String! = DataManager.readToken().1
    
    override init() {
//        nearbyVillages = []
        super.init()
    }
    
    func save(accessToken: String, refreshToken: String){
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        UserDefaults.standard.set(accessToken, forKey: DataManager.accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: DataManager.refreshTokenkey)
    }
    
//    func login(_ completion: @escaping(IError?) -> Void){
//
//        let req = LoginAPI.GetGuardInfoReq()
//        LoginAPI.getGuardInfo(request: req) {[weak self] (res, error) in
//            if let error = error {
//                completion(error)
//                return
//            }
//            guard let res = res else {return}
//
//            _ = self?.save(guardModel: res)
//            completion(nil)
//        }
//    }

//    static func readGuard() -> GuardModel?{
//        if let guardString = UserDefaults.standard.string(forKey: DataManager.guardKey){
//            return GuardModel.deserialize(from: guardString)
//        }
//        return nil
//    }

//    func save(guardModel: GuardModel) -> Bool{
//        self.guardInfo = guardModel
//        if let guardString = self.guardInfo?.toJSONString(){
//            UserDefaults.standard.set(guardString, forKey: DataManager.guardKey)
//            return UserDefaults.standard.synchronize()
//        }
//        return false
//    }
    
    static func readToken() -> (String?, String?) {
        if let accessToken  = UserDefaults.standard.string(forKey: DataManager.accessTokenKey)
            ,let refreshToken = UserDefaults.standard.string(forKey: DataManager.refreshTokenkey) {
            return (accessToken, refreshToken)
        }
        return (nil, nil)
    }
    
    func clearGuard() -> Bool{
        UserDefaults.standard.removeObject(forKey: DataManager.guardKey)
        return UserDefaults.standard.synchronize()
    }
    
//    func clearDefaultAddr() -> Bool{
//        self.defaultAddr = nil
//        UserDefaults.standard.removeObject(forKey: DataManager.addressKey)
//        return UserDefaults.standard.synchronize()
//    }
//    
    func clearToken() -> Bool {
        UserDefaults.standard.removeObject(forKey: DataManager.accessTokenKey)
        UserDefaults.standard.removeObject(forKey: DataManager.refreshTokenkey)
        return UserDefaults.standard.synchronize()
    }
//    
//    static func readDefaultAddr() -> UserAddressModel?{
//        if let userString = UserDefaults.standard.string(forKey: DataManager.addressKey){
//            return UserAddressModel.deserialize(from: userString)
//        }
//        return nil
//    }
//    
//    func save(defaultAddr: UserAddressModel) -> Bool {
//        self.defaultAddr = defaultAddr
//        if let addrString = self.defaultAddr?.toJSONString(){
//            UserDefaults.standard.set(addrString, forKey: DataManager.addressKey)
//            return UserDefaults.standard.synchronize()
//        }
//        return false
//    }
    
//    func login(){
//        Router.shared.openLogin()
//    }
}
