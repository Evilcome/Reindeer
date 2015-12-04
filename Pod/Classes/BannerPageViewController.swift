//
//  BannerPageViewController.swift
//  Pods
//
//  Created by Wayne on 15/12/4.
//
//

import UIKit

public class BannerPageViewController: UIPageViewController {
    
    // MARK: Private Property
    
    // MARK: Public Property
    
    // rolling images
    public var image: [AnyObject?] = []
    
    // rolling interval
    public var interval: NSTimeInterval = 0
    
    // placeholder image
    public var placeholderImage: UIImage?
    
    // user setted callback when tapped
    public var bannerTapperHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    public var remoteImageFetcher: RemoteImageFetcher?

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
}
