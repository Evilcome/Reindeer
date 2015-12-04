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
    
    // MARK: Public Property
    
    // rolling images
    public var images: [AnyObject?] = []
    
    // rolling interval
    public var interval: NSTimeInterval = 0
    
    // placeholder image
    public var placeholderImage: UIImage?

    // MARK: Life Circle
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
