//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Rio Chang on 6/3/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var autoDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!	
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("secSetting")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVCTableViewController.prefferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("APICnt") != nil{
            let count = NSUserDefaults.standardUserDefaults().objectForKey("APICnt") as! Int
            sliderCnt.value = Float(count)
            APICnt.text = "\(count)"
        }else{
            sliderCnt.value = 10.0
            APICnt.text = "\(Int(sliderCnt.value))"
        }
    }
    
    
    @IBAction func touchID(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "secSetting")
        }else{
            defaults.setBool(false, forKey: "secSetting")
        }
    }

    
    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICnt")
        APICnt.text = "\(Int(sliderCnt.value))"
    }

    
    func prefferredFontChange(){
        autoDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification , object: nil)
    }
}
