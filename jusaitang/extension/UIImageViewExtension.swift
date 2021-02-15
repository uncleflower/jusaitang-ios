//
//  UIImageViewExtension.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/9.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import Photos

extension UIImageView{
    func setImage(url: String){
        self.sd_setImage(with: URL.init(string: url), completed: nil)
    }
    
    
    func load(asset: PHAsset?, size:CGSize? = PHImageManagerMaximumSize, isSynchronous:Bool = false, deliveryMode:PHImageRequestOptionsDeliveryMode = .opportunistic, _ completion: (() -> Void)? = nil){
        guard let asset = asset else {
            completion?()
            return
        }
        
        var targetSize = self.frame.size
        if let size = size{
            targetSize = size
        }
        let options = PHImageRequestOptions()
        options.isSynchronous = isSynchronous
        options.deliveryMode = deliveryMode
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image, err) in
            self.image = image
            completion?()
        }
    }
}
