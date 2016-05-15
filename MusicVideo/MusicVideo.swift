//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/15/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import Foundation

class Video{
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    //getters
    var vName: String{
        return _vName
    }
    var vImageUrl: String{
        return _vImageUrl
    }
    var vUrl: String{
        return _vVideoUrl
    }
    
    
    init(data: JSONDictionary) {
        if let imname = data["im:name"] as? JSONDictionary,
            let vname = imname["label"] as? String{
            _vName = vname
        }else{
            _vName = ""
        }
        
        if let imimageArray = data["im:image"] as? JSONArray,
            let imimage2 = imimageArray[2] as? JSONDictionary,
            let imgUrl = imimage2["label"] as? String{
            self._vImageUrl = imgUrl.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else{
            _vImageUrl = ""
        }
        
        
        if let linkArray = data["link"] as? JSONArray,
            let link = linkArray[1] as? JSONDictionary,
            let attrib = link["attributes"] as? JSONDictionary,
            let vlink = attrib["href"] as? String{
                _vVideoUrl = vlink
        }else{
            _vVideoUrl = ""
        }
        
    }
    
    
    
    
}