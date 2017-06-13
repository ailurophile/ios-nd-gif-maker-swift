//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/10/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func deleteGif(gif: Gif)
}
class DetailViewController: UIViewController {
    var gif: Gif! = nil
    var delegate: DetailViewControllerDelegate?

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.image = gif.gifImage

        shareButton.layer.cornerRadius =   4.0
        deleteButton.layer.cornerRadius =   4.0
//        deleteButton.layer.backgroundColor = UIColor(red: 1.0, green: 65.0/255.0, blue: 112.0/255.0 , alpha: 1.0).cgColor
        deleteButton.backgroundColor = shareButton.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Alert", message: " Are you sure you want to delete this gif?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "DELETE", style: .destructive) { action in
            self.delegate?.deleteGif(gif: self.gif)
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)})
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)

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
