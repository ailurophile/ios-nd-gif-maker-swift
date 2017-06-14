//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
//        let firstLaunchGif = UIImage(cgImage: #imageLiteral(resourceName: "tinaFeyHiFive.gif") as! CGImage)
        let testGif = UIImage.gif(name: "tinaFeyHiFive")
        gifImageView.image = testGif
//        gifImageView.loadGif(name: "tinaFeyHiFive.gif")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
