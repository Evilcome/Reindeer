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
        
        if let banner = segue.destinationViewController as? BannerViewController {
            let image = UIImage(named: "reindeer-1")
            banner.setImage(image)
        }
    }
}

