//
//  TeamAPI.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/7/17.
//

import UIKit
import HandyJSON

class TeamAPI: NSObject {
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
}

