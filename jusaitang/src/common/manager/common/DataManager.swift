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
    
    private static let userKey = "user"
    
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenkey = "refreshToken"
    
    static let shared = DataManager()
    
    var accessToken: String! = DataManager.readToken().0
    
    var refreshToken: String! = DataManager.readToken().1
    
    var user: User! = DataManager.readUser()
    
    var loggedIn: Bool {
        return self.user != nil
    }
    
    override init() {
        super.init()
    }
    
    //Token
    func saveToken(accessToken: String, refreshToken: String){
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        UserDefaults.standard.set(accessToken, forKey: DataManager.accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: DataManager.refreshTokenkey)
    }
    
    static func readToken() -> (String?, String?) {
        if let accessToken  = UserDefaults.standard.string(forKey: DataManager.accessTokenKey)
            ,let refreshToken = UserDefaults.standard.string(forKey: DataManager.refreshTokenkey) {
            return (accessToken, refreshToken)
        }
        return (nil, nil)
    }
    
    func clearToken() -> Bool {
        UserDefaults.standard.removeObject(forKey: DataManager.accessTokenKey)
        UserDefaults.standard.removeObject(forKey: DataManager.refreshTokenkey)
        return UserDefaults.standard.synchronize()
    }
    
    //User
    func saveUser(user: User) {
        self.user = user
        UserDefaults.standard.set(user, forKey: DataManager.userKey)
    }
    
    static func readUser() -> User? {
        if let userString = UserDefaults.standard.string(forKey: DataManager.userKey) {
            return User.deserialize(from: userString)
        }
        return nil
    }
    
    func clearUser() -> Bool {
        UserDefaults.standard.removeObject(forKey: DataManager.userKey)
        return UserDefaults.standard.synchronize()
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
    
//    func login(){
//        Router.shared.openLogin()
//    }
}
