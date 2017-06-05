//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/5/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func launchVideoCamera(sender: AnyObject){
        present(pickerControllerWithSource(UIImagePickerControllerSourceType.camera), animated: true, completion: nil)
        
    }
    func pickerControllerWithSource(_ source: UIImagePickerControllerSourceType)->UIImagePickerController{
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = source
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = self
        return picker
        
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeMovie as String{
            let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
            print(videoURL.path)
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
            dismiss(animated: true, completion: nil)

        }
    }
}
