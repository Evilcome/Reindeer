//
//  ViewController.swift
//  Reindeer
//
//  Created by Evilcome on 12/04/2015.
//  Copyright (c) 2015 Evilcome. All rights reserved.
//

import UIKit
import Reindeer

class ViewController: UIViewController {
    
    @IBOutlet weak var bannerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let banner = segue.destinationViewController as? BannerPageViewController {
            
            // 1. Set the rolling interval, 0 means no auto-rolling
            banner.interval = 5
            
            // 2. Set placeholder image
            banner.placeholderImage = UIImage(named: "placeholder")
            
            // 
        }
    }

}

