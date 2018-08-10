//
//  ViewController.swift
//  MiniPedia
//
//  Created by Saiful I. Wicaksana on 09/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit
import iProgressHUD

internal class HomeController: UIViewController, HomeViewDelegete, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UIBarButtonItem!
    
    fileprivate let util: MiniPediaUtil = MiniPediaUtil()
    fileprivate var presenter: HomePresenter!
    fileprivate var filterVC: FilterController!
    fileprivate var pagination: Int = 1
    fileprivate var filterView: UIView!
    fileprivate var loadingView: UIView!
    fileprivate var isFilterShow: Bool = false
    
    fileprivate var xDynamic: CGFloat = 8
    fileprivate var yDynamic: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup loading view
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        loadingView.isHidden = true
        
        // Instantiate iProgressHUD and attach progress to main view
        let iprogress = iProgressHUD(style: .ballPulseSync)
        iprogress.isShowCaption = false
        iprogress.boxSize = 25
        iprogress.modalColor = UIColor(rgb: 0x42B549)
        iprogress.alphaModal = 0.7
        iprogress.isShowBox = false
        iprogress.isShowModal = true
        iprogress.indicatorColor = .white
        iprogress.attachProgress(toViews: self.navigationController!.view, loadingView)
        
        
        // Instantiate iProgressHUD and attach progress to loading view
        let iprogressLoadingView = iProgressHUD(style: .ballPulseSync)
        iprogressLoadingView.isShowCaption = false
        iprogressLoadingView.boxSize = 100
        iprogressLoadingView.isShowBox = false
        iprogressLoadingView.isShowModal = false
        iprogressLoadingView.indicatorColor = UIColor(rgb: 0x42B549)
        iprogressLoadingView.attachProgress(toViews: loadingView)
        
        // Set scrollview delegete.
        scrollView.addSubview(loadingView)
        scrollView.delegate = self
        
        // Init presenter and filter view controller.
        presenter = HomePresenter(delegete: self)
        filterVC = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterController
        filterVC.homeDelegete = presenter
        filterVC.loadViewIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Add filter view controller to home.
        filterView = filterVC.view
        filterView.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        filterView.frame = CGRect(x: 0, y: -self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(filterView)
    }
    
    /** Filter button click action. */
    @IBAction func didClickedFilterBar(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            if !self.isFilterShow {
                self.searchBar.title = "Close"
                self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            } else {
                self.searchBar.title = "Search"
                self.filterView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
        }) { (_) in
            self.isFilterShow = !self.isFilterShow
        }
    }
    
    /** Show load more progress view. */
    fileprivate func loadMore(show: Bool) {
        loadingView.isHidden = !show
        if show {
            scrollView.contentSize.height += 50
            loadingView.setY(y: (yDynamic + 8))
            loadingView.showProgress()
        } else {
            loadingView.dismissProgress()
        }
    }
    
    /** Delegete method show progress. */
    func showProgress(show: Bool) {
        if show {
            self.navigationController!.view.showProgress()
        } else {
            self.navigationController!.view.dismissProgress()
        }
    }
    
    /** Clear all view products with tag 1. */
    func clearProducts() {
        xDynamic = 8
        yDynamic = 8
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.title = "Search"
            self.filterView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        }) { (_) in
            self.isFilterShow = !self.isFilterShow
        }
        for subview in self.view.subviews {
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
    }
    
    /** Add view product with tag 1. */
    func addProduct(data: DataProduct) {
        let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductController
        productVC.loadViewIfNeeded()
        
        let viewProduct = productVC.presenter.addData(data: data, frame: CGRect(x: xDynamic, y: yDynamic, width: util.getWidthScreenPercent(percent: 50), height: 320))
        viewProduct.tag = 1
        viewProduct.accessibilityIdentifier = data.uri
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink(_:)))
        viewProduct.addGestureRecognizer(tapGesture)
        scrollView.addSubview(viewProduct)
        
        xDynamic += util.getWidthScreenPercent(percent: 50)
        if (xDynamic + 8) >= UIScreen.main.bounds.width {
            yDynamic += 320
            xDynamic = 8
        }
        scrollView.contentSize.height = (yDynamic + 8)
    }
    
    
    @objc func openLink(_ gesture: UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string : gesture.view!.accessibilityIdentifier!)!, options: [:], completionHandler: { (status) in
            print("Link openend: \(String(describing: gesture.view!.accessibilityIdentifier))")
        })
    }
    
    /** Show dialog popup info. */
    func showDialog(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) && (loadingView.isHidden) {
            loadMore(show: true)
            presenter.requestProducts(page: pagination, completion: { (success) in
                if success {
                    self.loadMore(show: false)
                    self.pagination += 1
                } else {
                    self.showDialog(title: "Info", message: "Request product failed!")
                }
            })
        }
    }
}

