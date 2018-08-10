//
//  HomePresenterDelegete.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal protocol HomeViewDelegete {
    
    func showProgress(show: Bool)
    func clearProducts()
    func addProduct(data: DataProduct)
    func showDialog(title: String, message: String)
}
