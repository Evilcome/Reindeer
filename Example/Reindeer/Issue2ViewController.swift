//
//  Issue2ViewController.swift
//  Reindeer
//
//  Created by Wayne on 16/6/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import Reindeer
import Kingfisher
import SnapKit

class Issue2ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var bannerViewController: BannerPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bannerViewController = BannerPageViewController()
        
        if let bannerViewController = bannerViewController {
            contentView.addSubview(bannerViewController.view)
            bannerViewController.view.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(self.contentView)
            }
            
            bannerViewController.interval = 3
            
            bannerViewController.placeholderImage = UIImage(named: "placeholder")
            
            bannerViewController.setRemoteImageFetche({ (imageView, url, placeHolderImage) -> Void in
                imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeHolderImage)
            })
            
            bannerViewController.images = [
                "https://cdn-ifnotalk-com.alikunlun.com/images/3/cd/cbf38bc67d58fb61c42a14f6b468c.jpg",
                UIImage(named: "reindeer-1"),
                UIImage(named: "reindeer-2")
            ]
            
            bannerViewController.startRolling()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
