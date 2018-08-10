//
//  Products.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct MasterModel: Codable {
    /** Product Id for lesson. */
    internal let status: Status
    
    /** The certification plan name like A1, A2, B1, B2, etc. Certification plan also called as Level. */
    internal let header: Header
    
    /** Sub certification plan. 1 certification plan usually have more than one course. */
    internal let data: [DataProduct]
}
