//
//  BannerViewModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/9.
//

import UIKit
import RxCocoa
import RxSwift

class BannerItemViewModel: NSObject {
    var model:BannerItemModel = BannerItemModel.init()
    
    init(model:BannerItemModel) {
        self.model = model
    }
}
class BannerViewModel: TableCellViewModel {
    var bannerItemViewModels: BehaviorSubject<[BannerItemViewModel]> = BehaviorSubject(value: [])
    
    func reload(models: [BannerItemModel]){
        var newViewModels:[BannerItemViewModel] = []
        for model in models{
            newViewModels.append(BannerItemViewModel(model: model))
        }
        self.bannerItemViewModels.onNext(newViewModels)
    }
}
