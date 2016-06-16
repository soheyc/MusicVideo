//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/30/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {
    var video: Video!
    
    var securitySwitch:Bool = false
    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = video.vArtist
        vName.text = video.vName
        vGenre.text = video.vGenre
        vPrice.text = video.vPrice
        vRights.text = video.vRights

        if let imgData = video.vImageData{
            videoImage.image = UIImage(data: imgData)
        }else{
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        print ("v url: \(video.vVideoUrl)")
        let url = NSURL(string: video.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) { 
            playerViewController.player?.play()
        }
    }

    @IBAction func socialMedia(sender: UIBarButtonItem) {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("secSetting")
        
        if securitySwitch{
            touchIDCheck()
        }else{
            shareMedia()
        }
    }
    
    func touchIDCheck(){
        //Alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "TouchID authentication is needed to share info on social media."
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError){
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success{
                    dispatch_async(dispatch_get_main_queue(), {[unowned self] in
                        self.shareMedia()
                    })
                }else{
                    alert.title = "unsuccessful"
                    
                    switch LAError(rawValue: policyError!.code)! {
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by app."
                    case .AuthenticationFailed:
                        alert.message = "The user failed to provide valid credentials."
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on this device."
                    case .SystemCancel:
                        alert.message = "Authentication was cancelled by the system."
                    case .TouchIDLockout:
                        alert.message = "Too many failed attempts."
                    case .UserCancel:
                        alert.message = "You cancelled the request."
                    case .UserFallback:
                        alert.message = "Password not accepted, must use touchID."
                    default:
                        alert.message = "Unable to authenticate."
                        
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), {[unowned self] in
                    self.presentViewController(alert, animated: true, completion: nil)})
            })
            
        }else{
            alert.title = "Error"
            switch LAError(rawValue: touchIDError!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "TouchID is not enrolled."
                
            case .TouchIDNotAvailable:
                alert.message = "TouchID is not available."
                
            case .PasscodeNotSet:
                alert.message = "Passcode is not set."
            case .InvalidContext:
                alert.message = "The context is invalid."

            default:
                alert.message = "Local authentication is not available."
            }
            
            dispatch_async(dispatch_get_main_queue(), {[unowned self] in
                self.presentViewController(alert , animated: true, completion: nil)})
        }
    }
    
    func shareMedia(){
        let activity1 = "Have ever seen this music video?"
        let activity2 = "\(video.vName) by \(video.vArtist)"
        let activity3 = "The link is: \(video.vLinkToiTues)"
        
        let activityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, itmes, error) in
            
            if activity == UIActivityTypeMail{
                print("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
}
