//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Rio Chang on 6/3/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1{
            let mailComposeVC = configureMail()
            
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mailComposeVC, animated: true, completion: onComplete)
            }else{
                mailAlert()
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onComplete(){
        print("presented mailComposeVC")
    }
    
    func configureMail() -> MFMailComposeViewController{
        let mfmcVC = MFMailComposeViewController()
        mfmcVC.mailComposeDelegate = self
        mfmcVC.setSubject("Music video app feedback")
        mfmcVC.setToRecipients(["chanchia@me.com"])
        mfmcVC.setMessageBody("Hi,\n\n I would like to share the following feedback...", isHTML: false)
        
        return mfmcVC
        
    }
    
    func mailAlert(){
        let alertC = UIAlertController(title: "Can't write emails", message: "Unable to mail.", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { action-> Void in
            
        }
        
        alertC.addAction(okAction)
        
        self.presentViewController(alertC, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("mail cancelled")
        case MFMailComposeResultSent.rawValue:
            print("mail sent")
        case MFMailComposeResultSaved.rawValue:
            print("mail saved")
        case MFMailComposeResultFailed.rawValue:
            print("mailfailed")
        default:
            print("unknown issue.")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification , object: nil)
    }
}
