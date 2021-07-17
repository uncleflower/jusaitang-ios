//
//  OrganizeTeamVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/16.
//

import UIKit
import RxCocoa
import RxSwift

class OrganizeTeamCellVM: NSObject {
    var model: OrganizeTeamModel = OrganizeTeamModel()
    
    init(model: OrganizeTeamModel) {
        self.model = model
    }
}

class OrganizeTeamVM: NSObject {
    var organizeTeamCellVMs: BehaviorSubject<[OrganizeTeamCellVM]> = BehaviorSubject.init(value: [])
    
    override init() {
        super.init()
    }
    
    func findAllTeams(completion: @escaping(IError?) -> Void) {
        TeamAPI.findAllTeam(request: EmptyReq()) {[weak self] res, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let res = res else { return }
            var vms: [OrganizeTeamCellVM] = []
            for model in res.teams {
                let vm = OrganizeTeamCellVM(model: model)
                vms.append(vm)
            }
            self?.organizeTeamCellVMs.onNext(vms)
            completion(nil)
        }
    }
}
