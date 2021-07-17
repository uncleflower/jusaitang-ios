//
//  TeamApplyViewModel.swift
//  jusaitang
//
//  Created by bytedance on 2021/7/17.
//

import UIKit
import RxSwift
import RxCocoa

class TeamApplyCellViewModel: NSObject {
    var model: TeamApplyModel = TeamApplyModel()
    
    init(model: TeamApplyModel) {
        self.model = model
    }
}

class TeamApplyViewModel: NSObject {
    var teamApplyCellViewModels: BehaviorSubject<[TeamApplyCellViewModel]> = BehaviorSubject.init(value: [])
    
    func getApplyList(complete: @escaping(IError?) -> Void) {
        TeamAPI.getApplyList(request: EmptyReq()) { [weak self] res, error in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else { return }
            var vms: [TeamApplyCellViewModel] = []
            for model in res.applies {
                let vm: TeamApplyCellViewModel = TeamApplyCellViewModel(model: model)
                vms.append(vm)
            }
            self?.teamApplyCellViewModels.onNext(vms)
            complete(nil)
        }
    }
}
