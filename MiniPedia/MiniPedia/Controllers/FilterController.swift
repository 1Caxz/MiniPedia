//
//  FilterController.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal class FilterController: UIViewController, FilterViewDelegete {
    
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var maxPrice: UILabel!
    @IBOutlet weak var sliderPrice: RangeSeekSlider!
    @IBOutlet weak var wholesaleSwitch: UISwitch!
    @IBOutlet weak var goldShopType: CustomButton!
    @IBOutlet weak var officialShopType: CustomButton!
    @IBOutlet weak var searchButton: CustomButton!
    
    fileprivate var presenter: FilterPresenter!
    
    internal var homeDelegete: HomePresenterDelegete!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FilterPresenter(delegete: self, homeDelegete: homeDelegete)
        sliderPrice.delegate = presenter
    }
    
    /** Reset click action. */
    @IBAction func didClickedReset(_ sender: Any) {
        setMin(price: "Rp. 100")
        setMax(price: "Rp. 10.000.000")
        sliderPrice.selectedMinValue = 100
        sliderPrice.minValue = 100
        sliderPrice.selectedMaxValue = 10000000
        sliderPrice.maxValue = 10000000
        wholesaleSwitch.isOn = true
        
        // Disable shop type buttons
        goldShopType.setTitleColor(UIColor(rgb: 0x42B549), for: .normal)
        goldShopType.layer.borderColor = UIColor(rgb: 0x42B549).cgColor
        goldShopType.isSelected = true
        
        officialShopType.setTitleColor(UIColor(rgb: 0x42B549), for: .normal)
        officialShopType.layer.borderColor = UIColor(rgb: 0x42B549).cgColor
        officialShopType.isSelected = true
    }
    
    
    /** Gold shop button click action. */
    @IBAction func didClickedGoldShopType(_ sender: Any) {
        if goldShopType.isSelected {
            goldShopType.setTitleColor(UIColor(rgb: 0xEBEBF1), for: .normal)
            goldShopType.layer.borderColor = UIColor(rgb: 0xEBEBF1).cgColor
            goldShopType.isSelected = false
        } else {
            goldShopType.setTitleColor(UIColor(rgb: 0x42B549), for: .normal)
            goldShopType.layer.borderColor = UIColor(rgb: 0x42B549).cgColor
            goldShopType.isSelected = true
        }
    }
    
    /** Official shop button click action. */
    @IBAction func didClickedOfficialShopType(_ sender: Any) {
        if officialShopType.isSelected {
            officialShopType.setTitleColor(UIColor(rgb: 0xEBEBF1), for: .normal)
            officialShopType.layer.borderColor = UIColor(rgb: 0xEBEBF1).cgColor
            officialShopType.isSelected = false
        } else {
            officialShopType.setTitleColor(UIColor(rgb: 0x42B549), for: .normal)
            officialShopType.layer.borderColor = UIColor(rgb: 0x42B549).cgColor
            officialShopType.isSelected = true
        }
    }
    
    /** Search button click action. */
    @IBAction func didClickedSearch(_ sender: Any) {
        presenter.searchAction()
    }
    
    func getAPIParams() -> APIParams {
        return APIParams(keyword: "samsung", pmin: Int(sliderPrice.selectedMinValue), pmax: Int(sliderPrice.selectedMaxValue), wholesale: wholesaleSwitch.isOn, official: officialShopType.isSelected, fshop: goldShopType.isSelected ? 2 : 0, rows: 10)
    }
    
    /** Set minimal price label. */
    func setMin(price: String) {
        minPrice.text = price
    }
    
    /** Set maximum price label. */
    func setMax(price: String) {
        maxPrice.text = price
    }
}
