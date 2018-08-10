//
//  MiniPediaUtil.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal class MiniPediaUtil {
    fileprivate let TAG = "MiniPediaUtil"
    
    func getWidthScreenPercent(percent: CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.width - 16) * (percent / 100)
    }
    
    internal func getAPI(apiParams: APIParams, page: Int = 0) -> String {
        return "\(Config.baseDomain)\(Config.product)?q=\(apiParams.keyword)&pmin=\(apiParams.pmin)&pmax=\(apiParams.pmax)&wholesale=\(apiParams.wholesale ? "true":"false")&official=\(apiParams.official ? "true":"false")&fshop=\(apiParams.fshop)&start=\((page * 10))&rows=\(apiParams.rows)"
    }
    
    internal func requestData(url: String, completion: @escaping(_ data: Data) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.sync {
                    completion(data)
                }
            } else if let error = error {
                print("\(self.TAG) - requestData: \(error.localizedDescription)")
            }
        }.resume()
    }
}
