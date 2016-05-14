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
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url){
            (data, response, error)->Void in
            
            dispatch_async(dispatch_get_main_queue()){
                //Excute closure
                if error != nil {
                    completion(result: error!.localizedDescription)
                }else{
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        
        task.resume()
    }
    
}