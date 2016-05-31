//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/30/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {
    var video: Video!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
}
