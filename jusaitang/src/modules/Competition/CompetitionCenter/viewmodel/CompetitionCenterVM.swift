//
//  CompetitionCenterVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit

class CompetitionCenterVM: NSObject {
    
    let competitionsVM = CompetitionsVM()
    let bannerViewModel: BannerViewModel = BannerViewModel()
    let compAnnouncementTableVM: AnnouncementTableVM = AnnouncementTableVM()
    let sysAnnouncementTableVM: AnnouncementTableVM = AnnouncementTableVM()
    
    func getBanner(complete: @escaping(IError?) -> Void) {
        CompetitionAPI.getBanner(request: EmptyReq()) {[weak self] (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            self?.bannerViewModel.reload(models: res.models)
            complete(nil)
        }
    }
    
    func getCompAnnouncement(complete: @escaping(IError?) -> Void) {
        CompetitionAPI.getCompAnnouncement(request: EmptyReq()) {[weak self] (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            self?.compAnnouncementTableVM.reload(models: res.models, title: "获奖公告")
            complete(nil)
        }
    }
    
    func getSysAnnouncement(complete: @escaping(IError?) -> Void) {
        CompetitionAPI.getSysAnnouncement (request: EmptyReq()) {[weak self] (res, error) in
            if let error = error {
                complete(error)
                return
            }
            
            guard let res = res else {return}
            self?.sysAnnouncementTableVM.reload(models: res.models, title: "系统公告")
            complete(nil)
        }
    }
}
