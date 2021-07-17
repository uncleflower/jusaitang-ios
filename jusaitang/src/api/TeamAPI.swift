//
//  TeamAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/7/17.
//

import UIKit
import HandyJSON

class TeamAPI: NSObject {
    
    //MARK: 申请加入队伍
    class Team: HandyJSON {
        var teamId: String = ""
        
        required init() {}
    }
    
    class JoinApplyReq: HandyJSON {
        var team: Team = Team()
        var applyContent: String = ""
        
        required init() {}
    }
    
    static func joinApply(request: JoinApplyReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/apply/joinApply",
            request: request
        )
        request.post(completion)
    }
    
    //TODO:
    //MARK: 取消申请
    class CancelApplyReq: HandyJSON {
        var teamId: String = ""
        
        required init() {}
    }
    
    static func cancelApply(request: CancelApplyReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/apply/cancelApply",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 组队大厅
    class FindAllTeamRes: HandyJSON {
        var teams: [OrganizeTeamModel] = []
        
        required init() {}
    }
    
    static func findAllTeam(request: EmptyReq, completion: @escaping(FindAllTeamRes?,IError?) -> Void){
        let request = APIRequest<FindAllTeamRes>(
            path: "/team/findAllTeam",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 我的队伍
    class MyTeamRes: HandyJSON {
        var teams: [MyTeamModel] = []
        
        required init() {}
    }
    
    static func myTeam(request: EmptyReq, completion: @escaping(MyTeamRes?,IError?) -> Void){
        let request = APIRequest<MyTeamRes>(
            path: "/team/findMyTeam",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 管理队伍
    class GetTeamDetailReq: HandyJSON {
        var teamId: String = ""
        required init() {}
    }
    
    class GetTeamDetailRes: HandyJSON {
        var teamId: String = ""
        var competitionName: String = ""
        var users: [User] = []
        required init() {}
    }
    
    static func getTeamDetail(request: GetTeamDetailReq, completion: @escaping(GetTeamDetailRes?,IError?) -> Void){
        let request = APIRequest<GetTeamDetailRes>(
            path: "/team/getTeamDetail",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 解散队伍
    class DeleteTeamReq: HandyJSON {
        var teamId: String = ""
        required init() {}
    }
    
    static func deleteTeam(request: DeleteTeamReq, completion: @escaping(EmptyRes?,IError?) -> Void){
        let request = APIRequest<EmptyRes>(
            path: "/team/deleteTeam",
            request: request
        )
        request.post(completion)
    }
    
    //MARK: 申请列表
    class GetApplyListRes: HandyJSON {
        var applies: [TeamApplyModel] = []
        
        required init() {}
    }
    
    static func getApplyList(request: EmptyReq, completion: @escaping(GetApplyListRes?,IError?) -> Void){
        let request = APIRequest<GetApplyListRes>(
            path: "/apply/getApplyList",
            request: request
        )
        request.post(completion)
    }
}

