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

//Regift constants
let frameCount = 16
let delayTime:Float = 0.2
let loopCount = 0 // 0 means loop forever

extension UIViewController{
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
    func convertVideoToGif(videoURL: URL){
        let regift = Regift(sourceFileURL: videoURL as URL, frameCount: frameCount, delayTime: delayTime)
        let gifURL = regift.createGif()
        let gif = Gif(gifURL!, videoURL: videoURL, caption: nil)
        displayGIF(gif)
        
    }
    func displayGIF(_ gif: Gif){
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif 
        navigationController?.pushViewController(gifEditorVC, animated: true)
    }
}
//MARK: UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate{
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeMovie as String{
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            convertVideoToGif(videoURL: videoURL )
//            print(videoURL.path)
//            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
            dismiss(animated: true, completion: nil)
            
        }
    }
    
}
//MARK: UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {
    
}
