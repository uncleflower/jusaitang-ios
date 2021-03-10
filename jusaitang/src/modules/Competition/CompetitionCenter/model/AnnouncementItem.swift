//
//  AnnouncementItem.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import HandyJSON

class AnnouncementItem: HandyJSON {
    var id: String = ""
    var title: String = ""
    var announceAt: Int = 0
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "notification_id"
        mapper <<<
            self.title <-- "notification_title"
        mapper <<<
            self.announceAt <-- "notification_time"
    }
    
    required init() {
    }
}
