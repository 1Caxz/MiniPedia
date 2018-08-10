//
//  Header.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct Header: Codable {
    internal let total_data: Int
    internal let total_data_no_category: Int
    internal let additional_params: String
    internal let process_time: Double
    internal let suggestion_instead: String?
}
