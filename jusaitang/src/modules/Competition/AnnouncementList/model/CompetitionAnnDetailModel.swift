//
//  CompetitionAnnDetailModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/13.
//

import UIKit
import HandyJSON

class CompetitionAnnDetailModel: HandyJSON {
    var fileID: String = ""
    var fileURL: String = ""
    var fileName: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.fileID <-- "fileId"
        mapper <<<
            self.fileURL <-- "filePath"
    }
    
    required init() {
    }
}
