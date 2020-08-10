//
//  Array+Safe.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2020/8/10.
//


import Foundation

extension Array {
    /// Array防呆
    subscript(safe index: Int) -> Element? {
        if !indices.contains(index) {
            return nil
        } else {
            return self[index]
        }
    }
}
