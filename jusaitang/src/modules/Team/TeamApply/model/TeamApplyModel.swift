//
//  TeamApplyModel.swift
//  jusaitang
//
//  Created by bytedance on 2021/7/17.
//

import UIKit
import HandyJSON

class Team: HandyJSON {
    var teamId: String = ""
    var teamName: String = ""
    var competition: Competition = Competition()
    required init() {}
}

class TeamApplyModel: HandyJSON {
    var applyID: String = ""
    var creatAt: Int = 0
    var applyContent: String = ""
    var applyState: Int = 0
    var user: User = User()
    var team: Team = Team()
    var teamContent: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.applyID <-- "applyId"
        mapper <<<
            self.creatAt <-- "applyTime"
        
    }
    required init() {}
}
