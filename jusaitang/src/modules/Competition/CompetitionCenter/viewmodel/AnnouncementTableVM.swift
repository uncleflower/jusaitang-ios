//
//  AnnouncementTableVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxSwift
import RxCocoa

class AnnouncementCellVM: NSObject {
    var model: AnnouncementItem!
    
    init(model: AnnouncementItem) {
        self.model = model
    }
}

class AnnouncementTableVM: NSObject {
    let announcementCellVMs: BehaviorSubject<[AnnouncementCellVM]> = BehaviorSubject.init(value: [])
    
    let titleObservable: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var height: CGFloat = 0
    
    override init() {
        super.init()
        
        if let count = try? announcementCellVMs.value().count {
            height = CGFloat(55 + 37 * count)
        }
    }
    
    func reload(models:[AnnouncementItem], title: String) {
        var newViewModels:[AnnouncementCellVM] = []
        
        for model in models{
            newViewModels.append(AnnouncementCellVM(model:model))
        }
        titleObservable.onNext(title)
        announcementCellVMs.onNext(newViewModels)
        
        height = CGFloat(18 + 55 + 37 * models.count)
    }
}
