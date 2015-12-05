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
    
    // this view did load
    private var _loaded = false
    
    // user setted callback when tapped
    private var _bannerTapHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    private var _remoteImageFetcher: RemoteImageFetcher?
    
    // page controler 
    private var _pageControl: UIPageControl
    
    // a timer for control the page
    
    private var _timer: NSTimer?
    
    // MARK: Public Property
    
    // rolling images
    public var images: [AnyObject?] = [] {
        didSet {
            _pageControl.numberOfPages = images.count
            
            if self._loaded {
                self._setupFirstView()
            }
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
        
        // init the page controller and banner views
        _pageControl = UIPageControl()
        
        super.init(coder: coder)
    }

    // MARK: Life Circle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self._loaded = true

        self.dataSource = self
        self.delegate = self
        
        self.view.backgroundColor = UIColor.grayColor()
        self.view.addSubview(_pageControl)
        
        // layout page control
        _pageControl.translatesAutoresizingMaskIntoConstraints = false
        let bindings = [ "_pageControl": _pageControl ]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[_pageControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[_pageControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        
        // init first view controller and show
        _setupFirstView()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Function
    
    private func _getNextIndex(currentIndex: Int, isBefore: Bool) -> Int {
        var nextIndex = -1
        var currentIndex = currentIndex
        
        if isBefore {
            
            // index should -1
            currentIndex--
            if currentIndex == -1 {
                nextIndex = images.count-1
            } else {
                nextIndex = currentIndex
            }
            
        } else {
            
            // index should +1
            currentIndex++
            if currentIndex == images.count {
                nextIndex = 0
            } else {
                nextIndex = currentIndex
            }
        }
        
        return nextIndex
    }
    
    private func _nextViewController(viewController: UIViewController, isBefore: Bool) -> BannerViewController? {
        if let currentBanner = viewController as? BannerViewController {
            let currentIndex = currentBanner.index
            let nextIndex = _getNextIndex(currentIndex, isBefore: isBefore)
            
            if nextIndex == -1 {
                return nil
            }
            
            let banner = BannerViewController()
            banner.index = nextIndex
            banner.placeholderImage = placeholderImage
            banner.setImage(images[nextIndex])
            banner.tapHandler = _bannerTapHandler
            banner.remoteImageFetcher = _remoteImageFetcher
            
            return banner
        }
        
        return nil
    }
    
    private func _setupFirstView() {
        if images.count > 0 {
            let banner = BannerViewController()
            banner.index = 0
            banner.placeholderImage = placeholderImage
            banner.setImage(images[0])
            banner.tapHandler = _bannerTapHandler
            banner.remoteImageFetcher = _remoteImageFetcher
            
            self.setViewControllers([banner], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    private func _autoNextPage() {
        if let currentBanner = viewControllers?.first as? BannerViewController {
            if let nextView = _nextViewController(currentBanner, isBefore: false) {
                self.setViewControllers([nextView], direction: .Forward, animated: true, completion: { (finished) -> Void in
                    self._pageControl.currentPage = nextView.index
                })
            }
        }
    }
    
    private func _pauseRolling() {
        _timer?.fireDate = NSDate.distantFuture()
    }
    
    private func _resumeRolling() {
        _timer?.fireDate = NSDate(timeInterval: interval, sinceDate: NSDate())
    }

    // MARK: Public Function
    
    func setInterval(interval:NSTimeInterval, block:()->Void) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(interval, target: NSBlockOperation(block: block), selector: "main", userInfo: nil, repeats: true)
    }
    
    public func startRolling() {
        if interval != 0 {
            if _timer == nil {
                _timer = setInterval(interval, block: { () -> Void in
                    self._autoNextPage()
                })
            }
        }
    }
    
    public func stopRolling() {
        _timer?.invalidate()
        _timer = nil
    }
    
    public func setRemoteImageFetche(fetcher: RemoteImageFetcher) {
        _remoteImageFetcher = fetcher
    }
    
    public func setBannerTapHandler(handler: BannerTapHandler) {
        _bannerTapHandler = handler
    }
    
    // MARK: UIPageViewControllerDataSource
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        return _nextViewController(viewController, isBefore: true)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        return _nextViewController(viewController, isBefore: false)
    }
    
    // MARK: UIPageViewControllerDelegate
    
    public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        self._pauseRolling()
    }
    
    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self._resumeRolling()
        if let currentBanner = pageViewController.viewControllers?.first as? BannerViewController {
            _pageControl.currentPage = currentBanner.index
        }
    }
}
