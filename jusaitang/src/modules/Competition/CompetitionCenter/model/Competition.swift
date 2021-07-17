//
//  Competition.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/4.
//

import UIKit
import HandyJSON

enum CompetitionLevel: Int, HandyJSONEnum {
    case unknown = 0
    case college = 1
    case school = 2
    case provincial = 3
    case national = 4
    
}

class Competition: HandyJSON {
    var id: String = ""
    var name: String = ""
    var time: String = ""
    var place: String = ""
    var level: CompetitionLevel = .unknown
    var peopelSum: Int = 0
    var imageURL: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "competitionId"
        mapper <<<
            self.name <-- "competitionName"
        mapper <<<
            self.time <-- "competitionStoptime"
        mapper <<<
            self.place <-- "competitionSite"
        mapper <<<
            self.level <-- "competitionLevel"
        mapper <<<
            self.imageURL <-- "competitionPicUrl"
        mapper <<<
            self.peopelSum <-- "competitionPeopleSum"
    }
    
    required init() {
    }
}
