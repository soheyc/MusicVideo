//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/24/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    var video: Video?{
        didSet {
            updateCell()
        }
    }

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicRank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell(){
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        musicRank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        musicRank.text = "\(video!.vRank)"
//        print("video name:\(video?.vName)")
        musicTitle.text = video?.vName
//        musicImage.image = UIImage(named: "imageNotAvailable")
        
        if let data = video?.vImageData{
            print("get from array")
            musicImage.image = UIImage(data: data)
        }else{
            GetVideoImage(video!, imageView: musicImage)
            print("get from background thread.")
        }
        
    }
    
    func GetVideoImage(video:Video, imageView: UIImageView){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image: UIImage?
            
            if data != nil{
                video.vImageData = data
                image = UIImage(data: data!)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageView.image = image
            })
        }
    }
}
