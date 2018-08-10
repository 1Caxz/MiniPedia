//
//  ProductPresenter.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal class ProductPresenter {
    
    /** Delegete product presenter class. */
    internal var delegete: ProductViewDelegete!
    
    init(delegete: ProductViewDelegete) {
        self.delegete = delegete
    }
    
    /** Add data products. */
    func addData(data: DataProduct, frame: CGRect) -> UIView {
        delegete.setProduct(image: data.image_uri)
        delegete.setProduct(title: data.name)
        if data.badges.indices.contains(0) {
            delegete.setBadge(image: data.badges[0].image_url)
        }
        delegete.setLocation(city: data.shop.location)
        delegete.setPrice(idr: data.price)
        return delegete.getProductView(frame: frame)
    }
}
