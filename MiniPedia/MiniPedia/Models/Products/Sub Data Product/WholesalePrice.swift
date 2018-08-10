//
//  WholesalePrice.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct WholesalePrice: Codable {
    internal let count_min: Int
    internal let count_max: Int
    internal let price: String
}
