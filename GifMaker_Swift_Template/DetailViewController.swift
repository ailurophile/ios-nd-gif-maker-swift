//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/10/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var gif: Gif! = nil

    @IBOutlet weak var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.image = gif.gifImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        let gifToShare = NSData(data:gif.gifData as! Data)
        let itemsToShare = [gifToShare]
        let shareController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        shareController.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems, activityError) in
            if(completed) {
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
        self.present(shareController, animated: true, completion: nil)
    }
}
