//
//  MyTeamModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/7/17.
//

import UIKit
import HandyJSON

class MyTeamModel: HandyJSON {
    var teamId: String = ""
    var captain: Captain = Captain()
    var competition: Competition = Competition()
    var teamHeadCount: Int = 0;
    var isMine: Bool = false
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.teamHeadCount <-- "teamHeadcount"
    }
    
    required init() {}
}
