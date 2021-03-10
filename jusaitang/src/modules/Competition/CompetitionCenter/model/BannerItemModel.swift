//
//  BannerItemModel.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/9.
//

import UIKit
import HandyJSON

class BannerItemModel: HandyJSON {

    var id: String = ""
    var name: String = ""
    var imageURL: String = ""
    
    required init(){
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "competition_id"
        mapper <<<
            self.name <-- "competition_name"
        mapper <<<
            self.imageURL <-- "competition_pic_url"
    }
}
