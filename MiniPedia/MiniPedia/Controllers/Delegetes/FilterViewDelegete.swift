//
//  FilterPresenterDelegete.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal protocol FilterViewDelegete {
    
    func setMin(price: String)
    func setMax(price: String)
    func getAPIParams() -> APIParams
}
