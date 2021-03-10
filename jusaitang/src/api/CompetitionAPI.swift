//
//  CompetitionAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import UIKit
import Alamofire
import HandyJSON

class CompetitionAPI: NSObject {
    //MARK: 获得Banner
    
    class GetBannerRes: HandyJSON {
        var models: [BannerItemModel] = []
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.models <-- "news"
        }
        
        required init() {
            
        }
    }
    
    static func getBanner(request: EmptyReq, completion: @escaping(GetBannerRes?,IError?) -> Void){
        let request = APIRequest<GetBannerRes>(
            path: "/competition/newCompetitions",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得竞赛的Type
    
    class GetCompetitionTypesRes: HandyJSON {
        var models: [CompetitionSelectionModel] = []
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.models <-- "competitionTypes"
        }
        
        required init() {
            
        }
    }
    
    static func getCompetitionTypes(request: EmptyReq, completion: @escaping(GetCompetitionTypesRes?,IError?) -> Void){
        let request = APIRequest<GetCompetitionTypesRes>(
            path: "/competitionType/findAllType",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 根据Type获得比赛列表
    
    class GetCompetitionByTypeReq: HandyJSON {
        var competitionType: String = ""
        
        required init() {
            
        }
    }
    
    class GetCompetitionByTypeRes: HandyJSON {
        var competitions: [Competition] = []
        
        required init() {
            
        }
    }
    
    static func getCompetitionByType(request: GetCompetitionByTypeReq, completion: @escaping(GetCompetitionByTypeRes?,IError?) -> Void){
        let request = APIRequest<GetCompetitionByTypeRes>(
            path: "/competition/findCompetitionByType",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得比赛通知
    
    class GetCompAnnouncementRes: HandyJSON {
        var models: [AnnouncementItem] = []
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.models <-- "winNotices"
        }
        
        required init() {
            
        }
    }
    
    static func getCompAnnouncement(request: EmptyReq, completion: @escaping(GetCompAnnouncementRes?,IError?) -> Void){
        let request = APIRequest<GetCompAnnouncementRes>(
            path: "/win/findWinNoticeInShow",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得系统通知
    
    class GetSysAnnouncementRes: HandyJSON {
        var models: [AnnouncementItem] = []
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.models <-- "systemNotices"
        }
        
        required init() {
            
        }
    }
    
    static func getSysAnnouncement(request: EmptyReq, completion: @escaping(GetSysAnnouncementRes?,IError?) -> Void){
        let request = APIRequest<GetSysAnnouncementRes>(
            path: "/notice/findSystemNoticeInShow",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得比赛通知列表
    
    class GetCompAnnouncementListReq: HandyJSON {
        var start: Int = 0
        var end: Int = 10
        
        required init() {
            
        }
    }
    
    class GetCompAnnouncementListRes: HandyJSON {
        var isLast: Bool = false
        var models: [AnnouncementItem] = []
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.models <-- "notice"
        }
        
        required init() {
            
        }
    }
    
    static func getCompAnnouncementList(request: GetCompAnnouncementListReq, completion: @escaping(GetCompAnnouncementListRes?,IError?) -> Void){
        let request = APIRequest<GetCompAnnouncementListRes>(
            path: "/win/findWinNoticeByPage",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得系统通知列表
    
    static func getSysAnnouncementList(request: GetCompAnnouncementListReq, completion: @escaping(GetCompAnnouncementListRes?,IError?) -> Void){
        let request = APIRequest<GetCompAnnouncementListRes>(
            path: "/notice/findSystemNoticeByPage",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 获得比赛详情
    
    class GetCompetitionDetailReq: HandyJSON {
        var competitionId: String = ""
        
        required init() {
            
        }
    }
    
    class GetCompetitionDetailRes: HandyJSON {
        var model: CompetitionDetailModel = CompetitionDetailModel()
        
        func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.model <-- "competition"
        }
        
        required init() {
            
        }
    }
    
    static func getCompetitionDetail(request: GetCompetitionDetailReq, completion: @escaping(GetCompetitionDetailRes?,IError?) -> Void){
        let request = APIRequest<GetCompetitionDetailRes>(
            path: "/competition/findCompetitionById",
            request: request
        )
        request.post(completion)
    }
}
