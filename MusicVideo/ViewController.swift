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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

