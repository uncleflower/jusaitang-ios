//
//  SystemAnnDetailModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/13.
//

import UIKit
import HandyJSON

class SystemAnnDetailModel: HandyJSON {
    var fileID: String = ""
    var fileURL: String = ""
    var fileName: String = ""
    var id: String = ""
    var title: String = ""
    var content: String = ""
    var announceAt: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.fileID <-- "file_id"
        mapper <<<
            self.fileURL <-- "file_path"
        mapper <<<
            self.fileName <-- "file_name"
        mapper <<<
            self.id <-- "notification_id"
        mapper <<<
            self.title <-- "notification_title"
        mapper <<<
            self.content <-- "notification_content"
        mapper <<<
            self.announceAt <-- "notification_time"
    }
    
    required init() {
    }
}
