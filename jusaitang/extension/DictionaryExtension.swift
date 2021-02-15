//
//  DictionaryExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/30/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit

extension Dictionary where Key == String {
    func json() -> String? {
           do {
            let stringData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let string = String(data: stringData, encoding: String.Encoding.utf8){
                   return string
               }
           }catch _ {
               return nil
           }
           return nil
       }
}
