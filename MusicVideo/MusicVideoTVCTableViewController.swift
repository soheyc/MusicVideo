//
//  MusicVideoTVCTableViewController.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/21/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class MusicVideoTVCTableViewController: UITableViewController {
    
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func didLoadData(videos: [Video]){
        self.videos = videos
        
        for (i, vid) in videos.enumerate(){
            print("Top \(i+1): \(vid.vName)")
        }
        
        //        for i in 0..<videos.count{
        //            print("Top \(i+1) : \(videos[i].vName)")
        //        }
        
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
    
    func runAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }

    
    deinit{
        //        NSNotificationCenter.defaultCenter().removeObserver("ReachStatusChanged")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
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
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
