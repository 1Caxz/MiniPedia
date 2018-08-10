//
//  FilterPresenter.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal class FilterPresenter: RangeSeekSliderDelegate {
    
    /** TAG for initial in log. */
    fileprivate let TAG = "FilterPresenter"
    /** Instantiation utilities programs. */
    fileprivate let util: MiniPediaUtil = MiniPediaUtil()
    /** Delegete for home presenter. */
    fileprivate var homeDelegete: HomePresenterDelegete!
    /** Delegete filter presenter class. */
    internal var delegete: FilterViewDelegete!
    
    /** Initialize presenter. */
    init(delegete: FilterViewDelegete, homeDelegete: HomePresenterDelegete) {
        self.delegete = delegete
        self.homeDelegete = homeDelegete
    }
    
    /** Listener method from RangeSeekSliderDelegete */
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        delegete.setMin(price: "Rp. \(Int(minValue).formattedWithSeparator)")
        delegete.setMax(price: "Rp. \(Int(maxValue).formattedWithSeparator)")
    }
    
    /** Search button action click. */
    internal func searchAction() {
        self.homeDelegete.filterResult(apiParams: delegete.getAPIParams())
    }
}
