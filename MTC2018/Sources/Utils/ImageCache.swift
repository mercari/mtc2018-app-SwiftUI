//
//  ImageCache.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/14.
//  Copyright © 2019 Mercari. All rights reserved.
//

import UIKit

class ImageCache {
    private let imageCache = NSCache<NSString, UIImage>()

    static let shared = ImageCache()

    func loadImageForURL(_ url: String, completion: @escaping (_ image: UIImage?, _ isCached: Bool) -> Void) {
        let key = url as NSString
        if let cacheImage = self.imageCache.object(forKey: key) {
            completion(cacheImage, true)
        } else {
            guard let url = URL(string: url) else {
                completion(nil, false)
                return
            }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: key)
                        completion(image, false)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                }
            }
            task.resume()
        }
    }
}
