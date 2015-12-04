//
//  BannerPageViewController.swift
//  Pods
//
//  Created by Wayne on 15/12/4.
//
//

import UIKit

public class BannerPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: Private Property
    
    // user setted callback when tapped
    private var _bannerTapHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    private var _remoteImageFetcher: RemoteImageFetcher?
    
    // page controler 
    private var _pageControl: UIPageControl
    
    // MARK: Public Property
    
    // rolling images
    public var images: [AnyObject?] = [] {
        didSet {
            _pageControl.numberOfPages = images.count
        }
    }
    
    // rolling interval
    public var interval: NSTimeInterval = 0 {
        willSet {
            if newValue <= 1 && newValue != 0 {
                self.interval = 1
            } else {
                self.interval = newValue
            }
        }
    }
    
    // placeholder image
    public var placeholderImage: UIImage?
    
    // MARK: Init
    
    public init() {
        
        // init the page controller and banner views
        _pageControl = UIPageControl()
        
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Circle
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Function
    
    private func _setUpFirstBanner(banner: BannerViewController) {
        banner.placeholderImage = self.placeholderImage
        banner._image = self.images.first!
        banner.tapHandler = self._bannerTapHandler
        banner.remoteImageFetcher = self._remoteImageFetcher
    }

    // MARK: Public Function
    
    public func startRolling() {
        
    }
    
    public func stopRolling() {
        
    }
    
    public func setRemoteImageFetche(fetcher: RemoteImageFetcher) {
        _remoteImageFetcher = fetcher
    }
    
    public func setBannerTapHandler(handler: BannerTapHandler) {
        _bannerTapHandler = handler
    }
    
    // MARK: UIPageViewControllerDataSource
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    // MARK: UIPageViewControllerDelegate
    
    public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}
