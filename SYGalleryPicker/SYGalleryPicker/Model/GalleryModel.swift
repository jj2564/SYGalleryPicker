//
//  AlbumFolder.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/4.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import Photos
import UIKit




//struct AlbumFolder {
//    /// 相簿資料夾名稱
//    var title: String = ""
//    /// 相簿內的照片
//    var photos: [AlbumPhoto]!
//    /// 選到時顏色
//    var pickColor: UIColor = UIColor(0xffc107)
//    /// 是否點選到
//    var isCheck: Bool = false
//
//    init(photos: [AlbumPhoto], title: String?, pickColor: UIColor?, isCheck: Bool?) {
//        self.photos = photos
//        if let newTitle = title { self.title = newTitle }
//        if let newColor = pickColor { self.pickColor = newColor }
//        if let newCheck = isCheck { self.isCheck = newCheck }
//    }
//}
//
//struct AlbumPhoto: Equatable, Hashable, CustomStringConvertible {
//
//    /// 照片資訊
//    var asset: PHAsset!
//    /// 選取時的索引
//    var pickNumber: Int = 0
//    /// 選取時的顏色
//    var pickColor: UIColor = UIColor(0xffc107)
//    /// 是否點選到
//    var isCheck: Bool = false
//    /// 照片識別碼
//    var localIdentifier: String {
//        get { return asset.localIdentifier }
//    }
//
//    var description: String {
//        get {
//            let desc =
//            """
//            {
//                localIdentifier: \(localIdentifier),
//                sourceType: \(asset.sourceType.rawValue),
//                mediaType: \(asset.mediaType.rawValue),
//                mediaSubtypes: \(asset.mediaSubtypes.rawValue),
//            }
//            """
//            return desc
//        }
//    }
//
//    init(asset: PHAsset, pickNumber: Int?, pickColor: UIColor?, isCheck: Bool?) {
//        self.asset = asset
//        if let newNumber = pickNumber { self.pickNumber = newNumber }
//        if let newColor = pickColor { self.pickColor = newColor }
//        if let newCheck = isCheck { self.isCheck = newCheck }
//    }
//
//    static func ==(lhs: AlbumPhoto, rhs: AlbumPhoto) -> Bool {
//        return lhs.asset == rhs.asset && lhs.localIdentifier == rhs.localIdentifier
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(localIdentifier.hashValue)
//        hasher.combine(asset.hashValue)
//    }
//
//}
