//
//  BannerViewController.swift
//  Pods
//
//  Created by Wayne on 15/12/4.
//
//

import UIKit


public typealias BannerTapHandler = (index: Int) -> Void
public typealias RemoteImageFetcher = (imageView: UIImageView, url: String, placeHolderImage: UIImage?) -> Void


class BannerViewController: UIViewController {
    
    // MARK: Private Properties
    
    // banner image wrapper
    private var _imageView: UIImageView!
    
    // an transparent button to response people touch
    private var _tapAreaButton: UIButton!
    
    // showing image
    var _image: AnyObject?
    
    // MARK: Properties
    
    // index of banner group
    var index: Int = -1
    
    // user setted callback when tapped
    var tapHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    var remoteImageFetcher: RemoteImageFetcher?
    
    // placeholder image
    var placeholderImage: UIImage?

    // MARK: Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fix: when the self view under a keeping changing autolayout,
        // the nextpage's imageview will showing out.
        self.view.clipsToBounds = true

        // init the imageView
        _imageView = UIImageView()
        _imageView.contentMode = .ScaleAspectFill
        _imageView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(_imageView)
        
        _tapAreaButton = UIButton()
        _tapAreaButton.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
        self.view.addSubview(_tapAreaButton)
        
        // set the constraint to layout the size
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _tapAreaButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["_imageView": _imageView, "_tapAreaButton": _tapAreaButton]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[_imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[_imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[_tapAreaButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[_tapAreaButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self._renderImage()
    }
    
    // MARK: User Action

    func tapped(sender: AnyObject) {
        if let tapHandler = tapHandler {
            tapHandler(index: self.index)
        }
    }
    
    // MARK: Display Image
    
    private func _renderImage() {
        if let image = _image {
            
            if image is String {
                
                let url = image as! String
                
                // use a remote image fetcher get the image
                if let remoteImageFetcher = remoteImageFetcher {
                    remoteImageFetcher(imageView: self._imageView, url: url, placeHolderImage: self.placeholderImage)
                } else {
                    // WARNING: Reindeer : if you use image url, you should set a remote image fetcher.
                    _imageView.image = placeholderImage
                }
                
            } else if let uiImage = image as? UIImage {
                _imageView.image = uiImage
            } else {
                _imageView.image = placeholderImage
            }
        }
    }
    
    func setImage(image: AnyObject?) {
        self._image = image
//        self._renderImage()
    }
}
