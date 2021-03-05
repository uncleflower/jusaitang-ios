//
//  ImageVM.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImageVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var model = ImageModel()
    
    var isSelectObservable: BehaviorSubject<Bool> = BehaviorSubject.init(value: false)
    
    init(model: ImageModel) {
        self.model = model
        super.init()
    }
}

