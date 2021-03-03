//
//  BaseExtension.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/6/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Foundation
import CommonCrypto

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


extension Sequence where Iterator.Element == (key: String, value: Any) {
    func toArray() -> [(String, Any)]{
        var array:[(String, Any)] = []
        
        for (key, value) in self {
            array.append((key, value))
        }
        return array
    }
}


extension Sequence where Iterator.Element == Substring {
    func toStringArray() -> [String]{
        var array:[String] = []
        for element in self{
            array.append(String(element))
        }
        return array
    }
}

extension Data {
    enum Algorithm {
        case md5
        case sha1
        case sha224
        case sha256
        case sha384
        case sha512
        var digestLength: Int {
            switch self {
            case .md5: return Int(CC_MD5_DIGEST_LENGTH)
            case .sha1: return Int(CC_SHA1_DIGEST_LENGTH)
            case .sha224: return Int(CC_SHA224_DIGEST_LENGTH)
            case .sha256: return Int(CC_SHA256_DIGEST_LENGTH)
            case .sha384: return Int(CC_SHA384_DIGEST_LENGTH)
            case .sha512: return Int(CC_SHA512_DIGEST_LENGTH)
            }
        }
    }
}
extension Data.Algorithm: RawRepresentable {
    typealias RawValue = Int
    init?(rawValue: Int) {
        switch rawValue {
        case kCCHmacAlgMD5: self = .md5
        case kCCHmacAlgSHA1: self = .sha1
        case kCCHmacAlgSHA224: self = .sha224
        case kCCHmacAlgSHA256: self = .sha256
        case kCCHmacAlgSHA384: self = .sha384
        case kCCHmacAlgSHA512: self = .sha512
        default: return nil
        }
    }
    var rawValue: Int {
        switch self {
        case .md5: return kCCHmacAlgMD5
        case .sha1: return kCCHmacAlgSHA1
        case .sha224: return kCCHmacAlgSHA224
        case .sha256: return kCCHmacAlgSHA256
        case .sha384: return kCCHmacAlgSHA384
        case .sha512: return kCCHmacAlgSHA512
        }
    }
}
extension Data {
    func hmac(algorithm: Algorithm, secretKey: String = "") -> Data {
        guard let secretKeyData = secretKey.data(using: .utf8) else { fatalError() }
        return hmac(algorithm: algorithm, secretKey: secretKeyData)
    }
    
    func hmac(algorithm: Algorithm, secretKey: Data) -> Data {
        let hashBytes = UnsafeMutablePointer<UInt8>.allocate(capacity: algorithm.digestLength)
        defer { hashBytes.deallocate() }
        withUnsafeBytes { (bytes) -> Void in
            secretKey.withUnsafeBytes { (secretKeyBytes) -> Void in
                CCHmac(CCHmacAlgorithm(algorithm.rawValue), secretKeyBytes, secretKey.count, bytes, count, hashBytes)
            }
        }
        return Data(bytes: hashBytes, count: algorithm.digestLength)
    }
    
    func md5() -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    func sha256() -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &hash)
        }
        return Data(hash)
    }
    
}
