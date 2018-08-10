//
//  Status.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct Status: Codable {
    internal let error_code: Int
    internal let message: String
}
