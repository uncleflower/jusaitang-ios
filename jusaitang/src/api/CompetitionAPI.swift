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
}
