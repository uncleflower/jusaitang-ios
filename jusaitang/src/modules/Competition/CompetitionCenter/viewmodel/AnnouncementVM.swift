//
//  AnnouncementVM.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/14.
//

import UIKit

class AnnouncementVM: NSObject {
    func getCompAnnouncementDetail(id: String, complete: @escaping(CompetitionAnnDetailModel?,IError?) -> Void) {
        let req = CompetitionAPI.GetCompAnnouncementDetailReq()
        req.id = id
        CompetitionAPI.getCompAnnouncementDetail(request: req) { (res, error) in
            if let error = error {
                complete(nil, error)
                return
            }
            
            guard let res = res else {return}
            
            complete(res.files.first, nil)
        }
    }
    
    func getSysAnnouncementDetail(id: String, complete: @escaping(SystemAnnDetailModel?,IError?) -> Void) {
        let req = CompetitionAPI.GetSysAnnouncementDetailReq()
        req.id = id
        CompetitionAPI.getSysAnnouncementDetail(request: req) { (res, error) in
            if let error = error {
                complete(nil, error)
                return
            }
            
            guard let res = res else {return}
            
            complete(res.notice.first, nil)
        }
    }

}
