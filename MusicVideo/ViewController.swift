//
//  ViewController.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/13/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    
    func didLoadData(result:String){
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default){ action -> Void in
            
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

