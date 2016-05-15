//
//  APIManager.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/14/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import Foundation

class APIManager{
    
    
    func loadData(urlString: String, completion: (result:String)->Void){
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
  
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
       
        let task = session.dataTaskWithURL(url){
            (data, response, error)->Void in
            
            if error != nil{
                completion(result: error!.localizedDescription)
            }else{
                do{
                    if let json_data = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]{
                        print(json_data)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()){
                                completion(result: "NSJSONSerialization Successful")
                            }
                        }
                    }
                }catch{
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "Error in JSONSerialization")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}