//
//  MyTeamViewModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/7/17.
//

import UIKit
import RxCocoa
import RxSwift

class MyTeamCellViewModel: NSObject {
    var model: MyTeamModel = MyTeamModel()
    
    init(model: MyTeamModel) {
        self.model = model
    }
}

class MyTeamViewModel: NSObject {
    var myTeamCellVMs: BehaviorSubject<[MyTeamCellViewModel]> = BehaviorSubject.init(value: [])
    
    func getMyTeams(complete: @escaping(IError?) -> Void) {
        TeamAPI.myTeam(request: EmptyReq()) {[weak self] res, error in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else { return }
            var vms: [MyTeamCellViewModel] = []
            for model in res.teams {
                let vm = MyTeamCellViewModel(model: model)
                vms.append(vm)
            }
            self?.myTeamCellVMs.onNext(vms)
            complete(nil)
            return
        }
    }
    
    override init() {
        super.init()
    }
}
