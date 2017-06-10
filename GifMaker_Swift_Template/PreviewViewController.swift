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
    
    var gif: Gif?
    var delegate:SavedGifsViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        gifPreviewView.image = gif?.gifImage

        // Do any additional setup after loading the view.
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
