//
//  ShareAppVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift

enum shareScene: String {
    case none = ""
    case wechat = "微信好友"
    case moment = "朋友圈"
}

class ShareAppVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var shareAppCellVMs: [ShareAppCellVM] = []
    
    static var itemSize:CGSize {
        get{
            return CGSize.init(width: App.screenWidth/2, height: 100)
        }
    }
    
    override init() {
        let wxVm: ShareAppCellVM!
        let momentVm: ShareAppCellVM!
//        if WXApi.isWXAppInstalled() {
         wxVm = ShareAppCellVM(image: UIImage(named: "share_wechat")!, scene: .wechat)
         momentVm = ShareAppCellVM(image: UIImage(named: "share_moment")!, scene: .moment)
//        } else {
//             wxVm = ShareAppCellVM(image: UIImage(named: "unable_share_wechat")!, scene: .wechat)
//             momentVm = ShareAppCellVM(image: UIImage(named: "unable_share_moment")!, scene: .moment)
//        }
        shareAppCellVMs = [wxVm,momentVm]
        super.init()
    }
}

class ShareAppCellVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var image: UIImage = UIImage()
    var scene: shareScene = .none
    
    init(image: UIImage, scene: shareScene) {
        self.image = image
        self.scene = scene
        super.init()
    }
}
