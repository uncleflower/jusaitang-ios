//
//  Router.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/10/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

class Router {
    static let shared = Router()
    
    // UserCenter
    static func openAccountInfo() {
        let vc = AccountInfoVC()
        App.navigationController?.show(vc, sender: true)
    }
    
    static func openAboutUs() {
        let vc = AboutUsVC()
        App.navigationController?.show(vc, sender: true)
    }
    
    static func openFeedback() {
        let vc = FeedbackVC()
        App.navigationController?.show(vc, sender: true)
    }
}

