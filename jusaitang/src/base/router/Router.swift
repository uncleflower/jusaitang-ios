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
    
    static func openWebView(url: String) {
        let vm = WebBrowserVM(url:url)
        let vc = WebBrowser(viewModel: vm)
        vc.hidesBottomBarWhenPushed = true
        App.navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
    // Competition Detail
    static func openCompetitionDetail(id: String) {
        let vc = CompetitoinDetailVC(competitoinID: id)
        App.navigationController?.show(vc, sender: true)
    }
}

