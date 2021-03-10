//
//  CompetitionDetailModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import HandyJSON

//TODO: otherStatus
enum CompetitionStatus: Int, HandyJSONEnum {
    case unknown = -1
    case end = 0
    case goingon = 1
}

class CompetitionDetailModel: HandyJSON {
    var id: String = ""
    var name: String = ""
    var content: String = ""
    var status: CompetitionStatus = .unknown
    var deadline: String = ""
    var level: CompetitionLevel = .unknown
    var address: String = ""
    var peopelSum: Int = 0
    var imageURL: String = ""
    var organizer: String = ""
    var contactPeople: String = ""
    var contactInformation: String = ""
    var officialWebsite: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "competitionId"
        mapper <<<
            self.name <-- "competitionName"
        mapper <<<
            self.content <-- "competitionContent"
        mapper <<<
            self.status <-- "competitionState"
        mapper <<<
            self.deadline <-- "competitionStoptime"
        mapper <<<
            self.level <-- "competitionLevel"
        mapper <<<
            self.address <-- "competitionSite"
        mapper <<<
            self.peopelSum <-- "competitionPeopleSum"
        mapper <<<
            self.imageURL <-- "competitionPicUrl"
    }
    
    required init() {
    }
}
