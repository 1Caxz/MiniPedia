//
//  Shop.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct Shop: Codable {
    internal let id: Int
    internal let name: String
    internal let uri: String
    internal let is_gold: Int
    internal let rating: AnyCodable?
    internal let location: String
    internal let reputation_image_uri: String
    internal let shop_lucky: String
    internal let city: String
}
