//
//  College.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import HandyJSON

class College: HandyJSON {
    var collegeID: String = ""
    var university: University = University()
    var collegeName: String = ""
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.collegeID <-- "collegeId"
    }
    
    required init() {
        
    }
}
