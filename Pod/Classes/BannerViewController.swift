//
//  BannerViewController.swift
//  Pods
//
//  Created by Wayne on 15/12/4.
//
//

import UIKit


typealias BannerTapHandler = (index: Int) -> Void
typealias RemoteImageFetcher = (imageView: UIImageView, url: String, placeHolderImage: UIImage?) -> Void


public class BannerViewController: UIViewController {
    
    // MARK: Private Properties
    
    // banner image wrapper
    private var _imageView: UIImageView!
    
    // an transparent button to response people touch
    private var _tapAreaButton: UIButton!
    
    // showing image
    var _image: AnyObject?
    
    // MARK: Properties
    
    // index of banner group
    var index: Int = 0
    
    // user setted callback when tapped
    var tapHandler: BannerTapHandler?
    
    // user custom remote image fetcher
    var remoteImageFetcher: RemoteImageFetcher?
    
    // placeholder image
    public var placeholderImage: UIImage?

    // MARK: Life Circle
    
    override public func viewDidLoad() {
        super.viewDidLoad()

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

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self._renderImage()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    public func setImage(image: AnyObject?) {
        self._image = image
//        self._renderImage()
    }
}
