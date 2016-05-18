//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/13/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Video]()

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    
    func didLoadData(videos: [Video]){
        for (i, vid) in videos.enumerate(){
            print("Top \(i+1): \(vid.vName)")
        }
        
//        for i in 0..<videos.count{
//            print("Top \(i+1) : \(videos[i].vName)")
//        }
    }
    
    func reachabilityStatusChanged(){
        switch(reachabilityStatus){
        case WIFI:
            displayLabel.text = "Wifi available"
            view.backgroundColor = UIColor.greenColor()
        case NOACCESS:
            displayLabel.text = "No access to Internet"
            view.backgroundColor = UIColor.redColor()
        case WWAN:
            displayLabel.text = "Celluar Connection"
            view.backgroundColor = UIColor.yellowColor()
        default:return
        }
    }
    
    deinit{
//        NSNotificationCenter.defaultCenter().removeObserver("ReachStatusChanged")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
}

