//
//  Data.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct DataProduct: Codable {
    internal let id: Int
    internal let name: String
    internal let uri: String
    internal let image_uri: String
    internal let image_uri_700: String
    internal let price: String
    internal let price_range: String
    internal let category_breadcrumb: String
    internal let shop: Shop
    internal let wholesale_price: [WholesalePrice]?
    internal let condition: Int
    internal let preorder: Int
    internal let department_id: Int
    internal let rating: Int
    internal let is_featured: Int
    internal let count_review: Int
    internal let count_talk: Int
    internal let count_sold: Int
    internal let labels: [Label]?
    
    internal let top_label: AnyCodable?
    
    internal let bottom_label: AnyCodable?
    
    internal let badges: [Badge]
    internal let original_price: String
    internal let discount_expired: String
    internal let discount_start: String
    internal let discount_percentage: Int
    internal let stock: Int
}

