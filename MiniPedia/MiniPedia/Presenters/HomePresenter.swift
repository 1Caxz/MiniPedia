//
//  HomePresenter.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal class HomePresenter: HomePresenterDelegete {
    
    /** TAG for initial in log. */
    fileprivate let TAG = "HomePresenter"
    /** Instantiation utilities programs. */
    fileprivate let util: MiniPediaUtil = MiniPediaUtil()
    /** APIParams objects. */
    fileprivate var apiParamObj: APIParams = APIParams()
    /** Delegete home presenter class. */
    internal var delegete: HomeViewDelegete!
    
    init(delegete: HomeViewDelegete) {
        self.delegete = delegete
        delegete.showProgress(show: true)
        requestProducts { (success) in
            self.delegete.showProgress(show: false)
            if !success {
                self.delegete.showDialog(title: "Error", message: "Something wrong. Please check your internet connections.")
            }
        }
    }
    
    /** Request products from API and convert to view. */
    internal func requestProducts(page: Int = 0, completion: @escaping(_ success: Bool) -> ()) {
        let url = util.getAPI(apiParams: apiParamObj, page: page)
        util.requestData(url: url) { (data) in
            do {
                let model = try JSONDecoder().decode(MasterModel.self, from: data)
                if model.status.error_code == 0 {
                    for product in model.data {
                        self.delegete.addProduct(data: product)
                        completion(true)
                    }
                } else {
                    completion(false)
                    self.delegete.showDialog(title: "Error Code \(model.status.error_code)", message: model.status.message)
                }
            } catch let error {
                completion(false)
                print("\(self.TAG) - requestProducts: \(error)")
            }
        }
    }
    
    /** Catch response value from filter form. */
    func filterResult(apiParams: APIParams) {
        apiParamObj = apiParams
        delegete.showProgress(show: true)
        delegete.clearProducts()
        requestProducts(page: 0) { (success) in
            self.delegete.showProgress(show: false)
            if !success {
                self.delegete.showDialog(title: "Error", message: "Something wrong. Please check your internet connections.")
            }
        }
    }
}
