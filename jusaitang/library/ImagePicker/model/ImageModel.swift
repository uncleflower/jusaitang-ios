//
//  ImageModel.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import Photos
import UIKit

class ImageModel {
    var id:String?
    var image: UIImage?
    var asset: PHAsset?
}

// MARK: - 将PHAsset对象转为UIImage对象
func PHAssetToUIImage(asset: PHAsset) -> UIImage {
    var image = UIImage()

    // 新建一个默认类型的图像管理器imageManager
    let imageManager = PHImageManager.default()

    // 新建一个PHImageRequestOptions对象
    let imageRequestOption = PHImageRequestOptions()

    // PHImageRequestOptions是否有效
    imageRequestOption.isSynchronous = true

    // 缩略图的压缩模式设置为无
    imageRequestOption.resizeMode = .none

    // 缩略图的质量为高质量，不管加载时间花多少
    imageRequestOption.deliveryMode = .highQualityFormat

    // 按照PHImageRequestOptions指定的规则取出图片
    imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 1080, height: 1920), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
        (result, _) -> Void in
        image = result!
    })
    return image
}
