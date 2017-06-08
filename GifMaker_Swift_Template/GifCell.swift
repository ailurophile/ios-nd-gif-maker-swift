//
//  GifCell.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/8/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    func configureForGif(gif: Gif){
        gifImageView.image = gif.gifImage
    }
}
