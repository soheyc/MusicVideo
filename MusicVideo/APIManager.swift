//
//  APIManager.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/14/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import Foundation

class APIManager{
    
    
    func loadData(urlString: String, completion: (result:[Video])->Void){
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
  
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
       
        let task = session.dataTaskWithURL(url){
            (data, response, error)->Void in
            
            if error != nil{
                print(error!.localizedDescription)
            }else{
                do{
                    if let json_data = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary{

                        if let feed = json_data["feed"] as? JSONDictionary,
                            let entryArray = feed["entry"] as? JSONArray{
                                var videos = [Video]()
                                for e in entryArray{
                                    videos.append(Video(data: e as! JSONDictionary))
                                }
                                
                                let count = videos.count
                                print("APIManager - Total count: \(count)\n")

                                let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                                dispatch_async(dispatch_get_global_queue(priority, 0)){
                                    dispatch_async(dispatch_get_main_queue()){
                                        completion(result: videos)
                                    }
                                }
                        }
                        
                    }
                }catch{
                    print("Error in JSONSerialization")
                }
            }
        }
        
        task.resume()
    }
    
}