//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Rio Chang on 5/15/16.
//  Copyright © 2016 sohey. All rights reserved.
//

import Foundation

class Video{
    var vRank = 0
    private var _vName: String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl: String
    private var _vArtist:String
    private var _vVideoUrl: String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String

    
    //getters
    var vName: String{
        return _vName
    }
    var vRights: String{
        return _vRights
    }
    var vPrice: String{
        return _vPrice
    }
    var vImageUrl: String{
        return _vImageUrl
    }
    var vArtist: String{
        return _vArtist
    }
    var vVideoUrl: String{
        return _vVideoUrl
    }
    var vImid: String{
        return _vImid
    }
    var vGenre: String{
        return _vGenre
    }
    var vLinkToiTues: String{
        return _vLinkToiTunes
    }
    var vReleaseDate: String{
        return _vReleaseDate
    }
    
    
    init(data: JSONDictionary) {
        if let imname = data["im:name"] as? JSONDictionary,
            let vname = imname["label"] as? String{
            _vName = vname
        }else{
            _vName = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
            let label = rights["label"] as? String{
                _vRights = label
        }else{
            _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
            let label = price["label"] as? String{
                _vPrice = label
        }else{
            _vPrice = ""
        }
        
        if let imimageArray = data["im:image"] as? JSONArray,
            let imimage2 = imimageArray[2] as? JSONDictionary,
            let imgUrl = imimage2["label"] as? String{
            self._vImageUrl = imgUrl.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else{
            _vImageUrl = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary,
            let label = artist["label"] as? String{
                _vArtist = label
        }else{
            _vArtist = ""
        }
        
        if let linkArray = data["link"] as? JSONArray,
            let link1 = linkArray[1] as? JSONDictionary,
            let attrib = link1["attributes"] as? JSONDictionary,
            let vlink = attrib["href"] as? String{
                _vVideoUrl = vlink
        }else{
            _vVideoUrl = ""
        }
        
        if let id = data["id"] as? JSONDictionary,
            let attributes = id["attributes"] as? JSONDictionary,
            let imid = attributes["im:id"] as? String{
                _vImid = imid
        }else{
            _vImid = ""
        }
        
        if let cate = data["category"] as? JSONDictionary,
            let attributes = cate["attributes"] as? JSONDictionary,
            let term = attributes["term"] as? String{
                _vGenre = term
        }else{
            _vGenre = ""
        }
        
        if let linkArray = data["link"] as? JSONArray,
            let link0 = linkArray[0] as? JSONDictionary,
            let attributes = link0["attributes"] as? JSONDictionary,
            let itunesLink = attributes["href"] as? String{
                _vLinkToiTunes = itunesLink
        }else{
            _vLinkToiTunes = ""
        }
        
        if let imrelease = data["im:releaseDate"] as? JSONDictionary,
            let attributes = imrelease["attributes"] as? JSONDictionary,
            let label = attributes["label"] as? String{
                _vReleaseDate = label
        }else{
            _vReleaseDate = ""
        }
    }
}