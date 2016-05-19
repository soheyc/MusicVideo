//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/13/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Video]()

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Video]){
        self.videos = videos

        for (i, vid) in videos.enumerate(){
            print("Top \(i+1): \(vid.vName)")
        }
        
//        for i in 0..<videos.count{
//            print("Top \(i+1) : \(videos[i].vName)")
//        }

        tableview.reloadData()

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

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
//        print("1 section")
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        print("video count:\(videos.count)")

        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableview.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row+1)"
        cell.detailTextLabel?.text = "\(videos[indexPath.row].vName)"

        return cell
        
    }
}

