//
//  ImageLoader.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 10/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal class ImageLoader {
    
    private static let cache = NSCache<NSString, NSData>()
    class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
    }
    
}
