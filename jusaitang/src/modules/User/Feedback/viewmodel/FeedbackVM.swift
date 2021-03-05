//
//  FeedbackVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import RxCocoa
import RxSwift

class FeedbackImgCellVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var model: ImageModel!
        
    init(model: ImageModel) {
        self.model = model
        self.model.image = PHAssetToUIImage(asset: model.asset!)
        super.init()
    }
}

class FeedbackVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var imgCellVMsObservable: BehaviorSubject<[FeedbackImgCellVM]> = BehaviorSubject.init(value: [])
    
    static var itemSize:CGSize {
        get{
            return CGSize.init(width: ceil((App.screenWidth - 20)/4), height: 75)
        }
    }

    func sendSuggest(description: String,images: [ImageInfoModel]? = nil,_ completion: @escaping(IError?) -> Void) {
//        let req = MineAPI.SuggestFeedbackReq()
//        req.description = description
//        if let images = images {
//            req.images = images
//        }
//        MineAPI.suggestFeedback(request: req) { (error) in
//            if let error = error {
//                completion(error)
//            }
//            completion(nil)
//        }
    }
    
    override init() {
        super.init()
    }
}
