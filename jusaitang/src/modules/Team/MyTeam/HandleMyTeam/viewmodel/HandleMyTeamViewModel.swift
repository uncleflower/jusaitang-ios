//
//  HandleMyTeamViewModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/7/17.
//

import UIKit
import RxCocoa
import RxSwift

class HandleMyTeamListCellVM: NSObject {
    var user: User = User()
    
    init(user: User) {
        self.user = user
    }
}

class HandleMyTeamViewModel: NSObject {
    var handleMyTeamListCellVMs: BehaviorSubject<[HandleMyTeamListCellVM]> = BehaviorSubject.init(value: [])
    var teamID: String = ""
    var competitionName: BehaviorSubject<String> = BehaviorSubject.init(value: "")
    
    init(teamID: String) {
        super.init()
        self.teamID = teamID
    }
    
    func getTeamDetail(complete: @escaping(IError?) -> Void) {
        let req = TeamAPI.GetTeamDetailReq()
        req.teamId = teamID
        TeamAPI.getTeamDetail(request: req) {[weak self] res, error in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else { return }
            var vms: [HandleMyTeamListCellVM] = []
            for model in res.users {
                let vm = HandleMyTeamListCellVM(user: model)
                vms.append(vm)
            }
            
            self?.competitionName.onNext(res.competitionName)
            self?.handleMyTeamListCellVMs.onNext(vms)
            self?.teamID = res.teamId
            complete(nil)
        }
    }
}
