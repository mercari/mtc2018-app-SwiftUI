//
//  ImageLoader.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/14.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    var image: Image? {
        willSet {
            objectWillChange.send()
        }
    }

    func load(url: String) {
        ImageCache.shared.loadImageForURL(url) { [weak self] image, _ in
            guard let image = image else { return }
            self?.image = Image(uiImage: image)
        }
    }
}
