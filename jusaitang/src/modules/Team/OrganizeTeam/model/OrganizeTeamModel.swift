//
//  OrganizeTeamModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/16.
//

import UIKit
import HandyJSON

enum OrganizeTeamStatus: Int {
    case unknown = -1
    case SignedUp = 0
    case full = 1
}

class OrganizeTeamModel: HandyJSON {
    var id: String = ""
    var avatar: String = ""
    var captain: User = User()
    var competition: Competition = Competition()
    var teamDescribe: String = ""
    var teamHeadCount: Int = 0
    var createAt: String = ""
    var deadline: String = ""
    var applied: Bool = false
//    var status: OrganizeTeamStatus = .unknown
        
    required init() {
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "teamId"
        mapper <<<
            self.teamDescribe <-- "teamContent"
        mapper <<<
            self.createAt <-- "applyTime"
        mapper <<<
            self.teamHeadCount <-- "teamHeadcount"
    }
}
