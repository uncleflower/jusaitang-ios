//
//  CompetitionCollectionVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift

class CompetitionCollectionCellVM: NSObject {
    var model: Competition!
    
    init(model: Competition) {
        self.model = model
    }
}

class CompetitionCollectionVM: NSObject {
    let competitionCollectionCellVMs: BehaviorSubject<[CompetitionCollectionCellVM]> = BehaviorSubject(value: [])
    
    static var itemSize: CGSize {
        get {
            return CGSize.init(width: 128, height: 180)
        }
    }
    
    override init() {
        super.init()
    }
    
    func getCompetitionByType(competitionTypeID: String = "1", complete: @escaping (IError?) -> Void) {
        let req = CompetitionAPI.GetCompetitionByTypeReq()
        req.competitionType = competitionTypeID
        CompetitionAPI.getCompetitionByType(request: req) {[weak self] (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            
            var vms: [CompetitionCollectionCellVM] = []
            for model in res.competitions {
                let vm = CompetitionCollectionCellVM(model: model)
                vms.append(vm)
            }
            
            self?.competitionCollectionCellVMs.onNext(vms)
            complete(nil)
        }
    }
}
