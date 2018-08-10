//
//  APIParams.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 10/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal class APIParams {
    
    internal var keyword: String = "samsung"
    internal var pmin: Int = 100
    internal var pmax: Int = 10000000
    internal var wholesale: Bool = true
    internal var official: Bool = true
    internal var fshop: Int = 2
    internal var rows: Int = 10
    
    init() {}
    
    init(keyword: String, pmin: Int, pmax: Int, wholesale: Bool, official: Bool, fshop: Int, rows: Int) {
        self.keyword = keyword
        self.pmin = pmin
        self.pmax = pmax
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
        self.rows = rows
    }
}
