//
//  ProductController.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit
import iProgressHUD

internal class ProductController: UIViewController, ProductViewDelegete {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    
    fileprivate var iprogress: iProgressHUD!
    
    internal var presenter: ProductPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProductPresenter(delegete: self)
        
        iprogress = iProgressHUD(style: .ballPulseSync)
        iprogress.isShowCaption = false
        iprogress.modalColor = UIColor(rgb: 0x42B549)
        iprogress.alphaModal = 0.7
        iprogress.isShowBox = false
        iprogress.isShowModal = true
        iprogress.indicatorColor = .white
    }
    
    func setProduct(image: String) {
        ImageLoader.image(for: URL(string: image)!) { image in
            self.productImage.image = image
            self.productImage.dismissProgress()
        }
    }
    
    func setProduct(title: String) {
        productTitle.text = title
    }
    
    func setBadge(image: String) {
        ImageLoader.image(for: URL(string: image)!) { image in
            self.badgeImage.image = image
            self.badgeImage.dismissProgress()
        }
    }
    
    func setLocation(city: String) {
        location.text = city
    }
    
    func setPrice(idr: String) {
        price.text = idr
    }
    
    func getProductView(frame: CGRect) -> UIView {
        self.view.frame = frame
        self.view.layer.borderColor = UIColor(rgb: 0x42B549).cgColor
        self.view.layer.borderWidth = 0.5
        self.view.layoutSubviews()
        iprogress.attachProgress(toViews: productImage, badgeImage)
        productImage.showProgress()
        badgeImage.showProgress()
        return self.view
    }
}
