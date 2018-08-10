//
//  ProductPresenterDelegete.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal protocol ProductViewDelegete {
    
    func setProduct(image: String)
    func setProduct(title: String)
    func setBadge(image: String)
    func setLocation(city: String)
    func setPrice(idr: String)
    func getProductView(frame: CGRect) -> UIView
}
