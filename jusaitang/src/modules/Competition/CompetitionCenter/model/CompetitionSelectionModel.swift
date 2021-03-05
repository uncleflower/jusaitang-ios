//
//  CompetitionSelectionModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/3.
//

import Foundation
import HandyJSON

class CompetitionSelectionModel: HandyJSON {
    var type: String = ""
    var name: String = ""
    var imageURL: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.type <-- "competitionTypeId"
        mapper <<<
            self.name <-- "competitionTypeName"
        mapper <<<
            self.imageURL <-- "competitionTypePicUrl"
    }
    
    required init() {
        
    }
}
