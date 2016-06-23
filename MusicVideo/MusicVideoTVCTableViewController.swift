//
//  MusicVideoTVCTableViewController.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/21/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class MusicVideoTVCTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var limit = 10
    
    var filterSearch = [Video]()
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVCTableViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVCTableViewController.prefferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func prefferredFontChange(){
        print("Prefferred Font has changed.")
    }
    
    func didLoadData(videos: [Video]){
        self.videos = videos
        
        for (i, vid) in videos.enumerate(){
            print("Top \(i+1): \(vid.vName)")
        }
        
        //        for i in 0..<videos.count{
        //            print("Top \(i+1) : \(videos[i].vName)")
        //        }
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = "Top \(limit) Music Videos"
        
        definesPresentationContext = true
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for artist"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        tableView.tableHeaderView = resultSearchController.searchBar
        
        self.tableView.reloadData()
        
    }
    
    func reachabilityStatusChanged(){
        switch(reachabilityStatus){
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()){

                let myAlert = UIAlertController(title: "No Internet Access", message: "Choose on action", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (ok) -> Void in
                    print("OK")
                })
                
                let cancelAction = UIAlertAction(title: "cancel", style: .Default, handler: { (cancel) -> Void in
                    print("Cancel")
                })
                
                let deleteAction = UIAlertAction(title: "delete", style: .Destructive, handler: { (delete) -> Void in
                    print("Delete")
                })
                
                myAlert.addAction(okAction)
                myAlert.addAction(cancelAction)
                myAlert.addAction(deleteAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
            
        default:
            view.backgroundColor = UIColor.greenColor()
            if videos.count>0{
                print("no need to refresh data.")
            }else{
                runAPI()
            }
        }
    }
    
    func getAPICount(){
        if NSUserDefaults.standardUserDefaults().objectForKey("APICnt") != nil{
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICnt") as! Int
            limit = theValue
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E dd:MMM:yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        
        if resultSearchController.active{
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        }else{
            runAPI()
        }
    }
    
    
    func runAPI(){
        getAPICount()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }

    
    deinit{
        //        NSNotificationCenter.defaultCenter().removeObserver("ReachStatusChanged")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification , object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active{
            return filterSearch.count
        }
        
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    struct storyboard{
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        if resultSearchController.active{
            cell.video = filterSearch[indexPath.row]
        }else{
            cell.video = videos[indexPath.row]
        }
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier{
            if let index = tableView.indexPathForSelectedRow?.row{
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                
                let video:Video
                if resultSearchController.active{
                    video = filterSearch[index]
                }else{
                    video = videos[index]
                }
                
                dvc.video = video
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterSearchArtist(searchController.searchBar.text!.lowercaseString)
    }
    
    func filterSearchArtist(searchText: String){
        filterSearch = videos.filter{ video in
            return video.vArtist.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
}
