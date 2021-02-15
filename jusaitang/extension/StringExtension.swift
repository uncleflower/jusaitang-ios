//
//  StringExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/6/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import CommonCrypto

protocol Jsonable {
    func toJSONString(prettyPrint: Bool) -> String?
}

extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
                        withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
    
    func phoneChunkFormatted(withChunkSize chunkSize: Int = 4,
                             withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.phoneChunk()
            .map{ String($0) }.joined(separator: String(separator))
    }
    
    func removeAllSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    //[NSAttributedString.Key.font:UIFont.pf_semibold(15)]
    func resize(maxWidth: CGFloat, attributes: [NSAttributedString.Key : Any]? = nil) -> CGSize{
        let rect = self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size
    }
    
    
    func phoneLengthValidation() -> Bool{
        let phone = self.removeAllSpace()
        if phone.count == 11 {
            return true
        }
        return false
    }
    
    
    func phoneValidation()->Bool {
        let phone = self.removeAllSpace()
        let mobile = "^1(7[0-9]|3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: phone) == true)
            || (regextestcm.evaluate(with: phone)  == true)
            || (regextestct.evaluate(with: phone) == true)
            || (regextestcu.evaluate(with: phone) == true)){
            return true
        }
        
        return false
    }
    
    func json() ->[String:Any]?{
        
        guard let jsonData = self.data(using: .utf8) else {return nil}
        return try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
    }
    
    func md5() -> String{
        let ccharArray = self.cString(using: String.Encoding.utf8)
        
            var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            
            CC_MD5(ccharArray, CC_LONG(ccharArray!.count - 1), &uint8Array)
            
            return uint8Array.reduce("") { $0 + String(format: "%02X", $1)
        }
    }
}


