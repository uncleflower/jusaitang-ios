//
//  HandyJsonExtension.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/16.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import HandyJSON

extension HandyJSON{
    static func copy(target:HandyJSON?) -> Self?{
        return Self.deserialize(from: target?.toJSONString())
    }
}




