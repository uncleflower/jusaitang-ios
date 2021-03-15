//
//  AnnouncementListVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import RxCocoa
import RxSwift

class AnnouncementListVM: AnnouncementVM {
    
    let announcementCellVMs: BehaviorSubject<[AnnouncementCellVM]> = BehaviorSubject.init(value: [])
    
    override init() {
        super.init()
    }
    
    func getCompAnnouncementList(complete: @escaping (Bool ,IError?) -> Void) {
        let req = CompetitionAPI.GetCompAnnouncementListReq()
        CompetitionAPI.getCompAnnouncementList(request: req) {[weak self] (res, error) in
            if let error = error {
                complete(true, error)
                return
            }
            
            guard let res = res else {return}
            
            var vms: [AnnouncementCellVM] = []
            for model in res.models {
                let vm = AnnouncementCellVM(model: model)
                vms.append(vm)
            }
            self?.announcementCellVMs.onNext(vms)
            
            complete(res.isLast, nil)
        }
    }
    
    func getMoreCompAnnouncementList(complete: @escaping (Bool ,IError?) -> Void) {
        let req = CompetitionAPI.GetCompAnnouncementListReq()
        guard var announcementCellVMs = try? announcementCellVMs.value() else {return}
        req.start = announcementCellVMs.count
        req.end = announcementCellVMs.count + 10
        CompetitionAPI.getCompAnnouncementList(request: req) {[weak self] (res, error) in
            if let error = error {
                complete(true, error)
                return
            }
            
            guard let res = res else {return}
            
            for model in res.models {
                let vm = AnnouncementCellVM(model: model)
                announcementCellVMs.append(vm)
            }
            self?.announcementCellVMs.onNext(announcementCellVMs)
            
            complete(res.isLast, nil)
        }
    }
    
    func getSysAnnouncementList(complete: @escaping (Bool ,IError?) -> Void) {
        let req = CompetitionAPI.GetCompAnnouncementListReq()
        CompetitionAPI.getSysAnnouncementList(request: req) {[weak self] (res, error) in
            if let error = error {
                complete(true, error)
                return
            }
            
            guard let res = res else {return}
            
            var vms: [AnnouncementCellVM] = []
            for model in res.models {
                let vm = AnnouncementCellVM(model: model)
                vms.append(vm)
            }
            self?.announcementCellVMs.onNext(vms)
            
            complete(res.isLast, nil)
        }
    }
    
    func getMoreSysAnnouncementList(complete: @escaping (Bool ,IError?) -> Void) {
        let req = CompetitionAPI.GetCompAnnouncementListReq()
        guard var announcementCellVMs = try? announcementCellVMs.value() else {return}
        req.start = announcementCellVMs.count
        req.end = announcementCellVMs.count + 10
        CompetitionAPI.getSysAnnouncementList(request: req) {[weak self] (res, error) in
            if let error = error {
                complete(true, error)
                return
            }
            
            guard let res = res else {return}
            
            for model in res.models {
                let vm = AnnouncementCellVM(model: model)
                announcementCellVMs.append(vm)
            }
            self?.announcementCellVMs.onNext(announcementCellVMs)
            
            complete(res.isLast, nil)
        }
    }
}
