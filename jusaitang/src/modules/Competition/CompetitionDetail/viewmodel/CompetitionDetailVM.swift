//
//  CompetitionDetailVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxCocoa
import RxSwift

class CompetitionDetailVM: NSObject {
    var id: String = ""
    var model: CompetitionDetailModel!
    
    init(id: String) {
        super.init()
        self.id = id
    }
    
    func getCompetitionDetail(complete: @escaping(IError?) -> Void) {
        let req = CompetitionAPI.GetCompetitionDetailReq()
        req.competitionId = id
        CompetitionAPI.getCompetitionDetail(request: req) { (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            
            self.model = res.model
            complete(nil)
        }
    }
    
    func singleDoApply(complete: @escaping(IError?) -> Void) {
        let req = CompetitionAPI.SingleDoApplyReq()
        req.competitionId = self.id
        CompetitionAPI.singleDoApply(request: req) { (_, error) in
            if let error = error {
                complete(error)
                return
            }
            complete(nil)
        }
    }
    
    func teamUpDoApply(teamContent: String, complete: @escaping(IError?) -> Void) {
        let req = CompetitionAPI.TeamUpReq()
        let competition = Competition()
        let user = DataManager.shared.user
        competition.id = self.id
        req.competition = competition
        req.teamContent = teamContent
        req.teamName = "\(user?.name ?? "XXX")的队伍"
        CompetitionAPI.TeamUp(request: req) { _, error in
            if let error = error {
                complete(error)
                return
            }
            complete(nil)
        }
        
    }
}
