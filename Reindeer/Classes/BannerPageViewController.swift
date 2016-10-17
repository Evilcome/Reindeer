//
//  BannerPageViewController.swift
//  Pods
//
//  Created by Wayne on 15/12/4.
//
//

import UIKit

open class BannerPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: Private Property
    
    // this view did load
    fileprivate var _loaded = false
    
    // user setted callback when tapped
    fileprivate var _bannerTapHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    fileprivate var _remoteImageFetcher: RemoteImageFetcher?
    
    // page controler 
    fileprivate var _pageControl: UIPageControl
    
    // a timer for control the page
    
    fileprivate var _timer: Timer?
    
    // MARK: Public Property
    
    // rolling images
    open var images: [AnyObject?] = [] {
        didSet {
            _pageControl.numberOfPages = images.count
            
            if self._loaded {
                self._setupFirstView()
            }
        }
    }
    
    // rolling interval
    open var interval: TimeInterval = 0 {
        willSet {
            if newValue <= 1 && newValue != 0 {
                self.interval = 1
            } else {
                self.interval = newValue
            }
        }
    }
    
    // placeholder image
    open var placeholderImage: UIImage?
    
    // MARK: Init
    
    public init() {
        
        // init the page controller and banner views
        _pageControl = UIPageControl()
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    open override func encode(with aCoder: NSCoder) {
        
    }

    required public init?(coder: NSCoder) {
        
        // init the page controller and banner views
        _pageControl = UIPageControl()
        
        super.init(coder: coder)
    }

    // MARK: Life Circle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self._loaded = true

        self.dataSource = self
        self.delegate = self
        
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(_pageControl)
        
        // layout page control
        _pageControl.translatesAutoresizingMaskIntoConstraints = false
        let bindings = [ "_pageControl": _pageControl ]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[_pageControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[_pageControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        
        // init first view controller and show
        _setupFirstView()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Function
    
    fileprivate func _getNextIndex(_ currentIndex: Int, isBefore: Bool) -> Int {
        var nextIndex = -1
        var currentIndex = currentIndex
        
        if isBefore {
            
            // index should -1
            currentIndex -= 1
            if currentIndex == -1 {
                nextIndex = images.count-1
            } else {
                nextIndex = currentIndex
            }
            
        } else {
            
            // index should +1
            currentIndex += 1
            if currentIndex == images.count {
                nextIndex = 0
            } else {
                nextIndex = currentIndex
            }
        }
        
        return nextIndex
    }
    
    fileprivate func _nextViewController(_ viewController: UIViewController, isBefore: Bool) -> BannerViewController? {
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
    
    fileprivate func _setupFirstView() {
        if images.count > 0 {
            let banner = BannerViewController()
            banner.index = 0
            banner.placeholderImage = placeholderImage
            banner.setImage(images[0])
            banner.tapHandler = _bannerTapHandler
            banner.remoteImageFetcher = _remoteImageFetcher
            
            self.setViewControllers([banner], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func _autoNextPage() {
        if let currentBanner = viewControllers?.first as? BannerViewController {
            if let nextView = _nextViewController(currentBanner, isBefore: false) {
                self.setViewControllers([nextView], direction: .forward, animated: true, completion: { (finished) -> Void in
                    self._pageControl.currentPage = nextView.index
                })
            }
        }
    }
    
    fileprivate func _pauseRolling() {
        _timer?.fireDate = Date.distantFuture
    }
    
    fileprivate func _resumeRolling() {
        _timer?.fireDate = Date(timeInterval: interval, since: Date())
    }

    // MARK: Public Function
    
    func setInterval(_ interval:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: interval, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: true)
    }
    
    open func startRolling() {
        if interval != 0 {
            if _timer == nil {
                _timer = setInterval(interval, block: { () -> Void in
                    self._autoNextPage()
                })
            }
        }
    }
    
    open func stopRolling() {
        _timer?.invalidate()
        _timer = nil
    }
    
    open func setRemoteImageFetche(_ fetcher: @escaping RemoteImageFetcher) {
        _remoteImageFetcher = fetcher
    }
    
    open func setBannerTapHandler(_ handler: @escaping BannerTapHandler) {
        _bannerTapHandler = handler
    }
    
    // MARK: UIPageViewControllerDataSource
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return _nextViewController(viewController, isBefore: true)
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return _nextViewController(viewController, isBefore: false)
    }
    
    // MARK: UIPageViewControllerDelegate
    
    open func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self._pauseRolling()
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self._resumeRolling()
        if let currentBanner = pageViewController.viewControllers?.first as? BannerViewController {
            _pageControl.currentPage = currentBanner.index
        }
    }
}
