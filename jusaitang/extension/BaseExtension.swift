//
//  BaseExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/6/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation

extension Collection {
    
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
    
    
    public func phoneChunk() -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        var firtPart:Bool = true
        while i != endIndex {
            if firtPart {
                j = index(i, offsetBy: 3, limitedBy: endIndex) ?? endIndex
                firtPart = false
            }else{
                j = index(i, offsetBy: 4, limitedBy: endIndex) ?? endIndex
            }
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
