//
//  CompetitionsVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit
import RxCocoa
import RxSwift

class CompetitionsVM: NSObject {
    let selectionModels: BehaviorSubject<[CompetitionSelectionModel]> = BehaviorSubject(value: [])
    
    let competitionCollectionVM = CompetitionCollectionVM()
    
    override init() {
        super.init()
    }
    
    func getCompetitionTypes(complete: @escaping(IError?) -> Void) {
        CompetitionAPI.getCompetitionTypes(request: EmptyReq()) {[weak self] (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            var models: [CompetitionSelectionModel] = []
            for model in res.models {
                models.append(model)
            }
            self?.selectionModels.onNext(models)
            complete(nil)
        }
    }
}
