//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

protocol PreviewViewControllerDelegate {
    func previewVC(_ preview:PreviewViewController, didSaveGif gif:Gif)
}
class PreviewViewController: UIViewController {
    @IBOutlet weak var gifPreviewView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var gif: Gif?
    var delegate:SavedGifsViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        gifPreviewView.image = gif?.gifImage
        // Do any additional setup after loading the view.
        // Customize Buttons
        shareButton.layer.cornerRadius =   4.0
        shareButton.layer.borderColor = UIColor(red: 1.0, green: 65.0/255.0, blue: 112.0/255.0 , alpha: 1.0).cgColor
        shareButton.layer.borderWidth = 1.0
        saveButton.layer.cornerRadius =   4.0

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareGif(_ sender: Any) {
        let animatedGif = NSData(contentsOf: (gif?.url)!)
        let itemsToShare = [animatedGif]
        let shareController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        shareController.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems, activityError) in
            if(completed) {
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
        self.present(shareController, animated: true, completion: nil)
    }
    @IBAction func createAndSave(){
        delegate?.previewVC(self, didSaveGif: gif!)
        _ = navigationController?.popToRootViewController(animated: true)
    }

    /*
     

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
