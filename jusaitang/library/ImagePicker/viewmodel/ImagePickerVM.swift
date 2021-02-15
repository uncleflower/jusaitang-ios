//
//  ImagePickerVM.swift
//  an-xin-bang
//
//  Created by Jiehao Zhang on 2020/7/25.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Photos

enum AlbumName: Int {
    case recents
    case recentlyAdded
    case livePhotos
    case screenshots
    case unknown
}

class AlbumVM: NSObject {
    var id:Int = 0
    
    var title:String? = ""
    
    var isSelect:Bool = false
    
    var images:[ImageVM] = []
    
}

class ImagePickerVM: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var selectedImgs: [ImageModel] = []
    
    var selectedAlbumObservable: BehaviorSubject<AlbumVM> = BehaviorSubject(value: AlbumVM())

    var albumLibrarys = [AlbumVM]()
    
    static var itemSize:CGSize {
        get{
            return CGSize.init(width: (App.screenWidth - 10)/3, height: (App.screenWidth - 10)/3)
        }
    }
    
    override init() {
        super.init()
        fetchAssetCollections()
    }
    
    func fetchAssetCollections() {
        let smartAssetCollections = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                            subtype: .albumRegular,
                                                                            options: nil)
        // TODO: 存在数组越界
    
        for index in 0 ..< smartAssetCollections.count {
            let fetchResults = PHAsset.fetchAssets(in: smartAssetCollections[index], options: nil)
            if fetchResults.count == 0 {
                continue;
            }
            let album = AlbumVM()
            for index in 0 ..< fetchResults.count {
                let asset = fetchResults[index]
                let model = ImageModel()
                model.id = asset.localIdentifier
                model.asset = asset
                album.images.append(ImageVM.init(model: model))
                
            }
            album.id = index
            album.title = smartAssetCollections[index].localizedTitle
            albumLibrarys.append(album)
        }
        
        if self.albumLibrarys.count > 0 {
            self.selectedAlbumObservable.onNext(self.albumLibrarys[0])
        }
    }
    
}
