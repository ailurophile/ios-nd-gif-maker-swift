//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/6/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit


class Gif: NSObject {
    var url: URL?
    var videoURL: URL?
    var caption: String?
    let gifImage: UIImage
    var gifData: NSData?
    
    
    init(_ url: URL, videoURL: URL?, caption: String?){
        self.url = url
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        
    }
    init(_ name: String){
        self.gifImage = UIImage.gif(name: name)!

    }
    
}

