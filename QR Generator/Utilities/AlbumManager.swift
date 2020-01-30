//
//  AlbumManager.swift
//  QR Generator
//
//  Created by Morten Gustafsson on 8/6/19.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import UIKit

final class AlbumManager: NSObject {
    private var completion: (Bool) -> Void = { _ in }

    func save(image: UIImage, completion: @escaping (Bool) -> Void) {
        self.completion = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        completion( error != nil ? false : true)
    }
}
