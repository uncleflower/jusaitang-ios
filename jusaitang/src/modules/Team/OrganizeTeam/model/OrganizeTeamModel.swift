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
    var leader: String = ""
    var competitionName: String = ""
    var teamDescribe: String = ""
    var createAt: String = ""
    var deadline: String = ""
    var status: OrganizeTeamStatus = .unknown
        
    required init() {
    }
}
