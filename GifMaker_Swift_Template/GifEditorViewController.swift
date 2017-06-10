//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var gif: Gif?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.image = gif?.gifImage
        subscribeToKeyboardNotifications()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - text field delegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Keyboard notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ notification: Notification){
        if (self.view.frame.origin.y >= 0) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification: Notification){
        if (self.view.frame.origin.y < 0) {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    //MARK: gif editor methods
    @IBAction func presentPreview(_ sender: Any) {
       let gifPreviewVC = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
// Set SavedGifsViewController as PreviewViewControllerDelegate
        gifPreviewVC.delegate = navigationController?.viewControllers[0] as! SavedGifsViewController?
        gif?.caption = captionTextField.text
//        let url = Regift.init(sourceFileURL: (gif?.videoURL)!, frameCount: frameCount, delayTime: delayTime)
        let regift = Regift(sourceFileURL: (gif?.videoURL)!, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        let captionFont = captionTextField.font
        let gifURL = regift.createGif(caption: captionTextField.text, font: captionFont)
        let newGif = Gif(gifURL!, videoURL: gif?.videoURL, caption: captionTextField.text)
        gifPreviewVC.gif = newGif
        navigationController?.pushViewController(gifPreviewVC, animated: true)
    }


}
