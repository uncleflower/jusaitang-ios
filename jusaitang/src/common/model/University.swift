//
//  University.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import HandyJSON

class University: HandyJSON {
    var universityID: String = ""
    var universityName: String = ""
    var universityCity: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.universityID <-- "universityId"
    }
    
    required init() {
        
    }
}
