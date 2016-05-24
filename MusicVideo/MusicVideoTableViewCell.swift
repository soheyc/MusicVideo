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
        musicRank.text = "\(video!.vRank)"
//        print("video name:\(video?.vName)")
        musicTitle.text = video?.vName
        musicImage.image = UIImage(named: "imageNotAvailable")
    }
}
