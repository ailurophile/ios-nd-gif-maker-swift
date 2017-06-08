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
import AVKit
import AVFoundation

//Regift constants
let frameCount = 16
let delayTime:Float = 0.2
let loopCount = 0 // 0 means loop forever

extension UIViewController{

    @IBAction func presentVideoOptions(){
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            //use photo album
            self.launchPhotoLibrary()
        } else {
            let newGifActionSheet = UIAlertController(title: "Create New Gif", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let recordVideo = UIAlertAction(title: "Record a video", style: .default, handler: {(UIAlertAction) in
                self.launchVideoCamera(sender: self)
            })
            let useExisting = UIAlertAction(title: "Use existing video", style: .default, handler: {(UIAlertAction) in
                self.launchPhotoLibrary()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            newGifActionSheet.addAction(recordVideo)
            newGifActionSheet.addAction(useExisting)
            newGifActionSheet.addAction(cancel)
            present(newGifActionSheet, animated: true, completion: nil)
            let pinkColor = UIColor(colorLiteralRed: 1.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            newGifActionSheet.view.tintColor = pinkColor
        }
    
    
    }
    func pickerControllerWithSource(_ source: UIImagePickerControllerSourceType)->UIImagePickerController{
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = source
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = self
        return picker
        
    }
    func convertVideoToGif(videoURL: URL, start: Float?, duration: Float?){
        var regift: Regift
        if start == nil{
            regift = Regift(sourceFileURL: videoURL as URL, frameCount: frameCount, delayTime: delayTime)
        } else {
            regift = Regift(sourceFileURL: videoURL, destinationFileURL: nil, startTime: start!, duration: duration!, frameRate: frameCount, loopCount: loopCount)
        }
        let gifURL = regift.createGif()
        let gif = Gif(gifURL!, videoURL: videoURL, caption: nil)
        displayGIF(gif)
        
    }
    func displayGIF(_ gif: Gif){
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(gifEditorVC, animated: true)
            self.dismiss(animated: false, completion: nil)
            
        }
    }
    func cropVideoToSquare(_ rawVideoURL: URL, start: Float?, duration: Float?){
        //Create the AVAsset and AVAssetTrack
        let videoAsset = AVAsset(url: rawVideoURL)
        let videoTrack = videoAsset.tracks(withMediaType: AVMediaTypeVideo)[0]
        // Crop to square
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.height)
        videoComposition.frameDuration = CMTime(seconds: 1.0/30.0, preferredTimescale: 30)
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRange(start: kCMTimeZero,duration: CMTime(seconds: 60.0, preferredTimescale: 30))
        // rotate to portrait
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        let t1 = CGAffineTransform(translationX: videoTrack.naturalSize.height, y: -(videoTrack.naturalSize.width - videoTrack.naturalSize.height)/2)
        let t2 = t1.rotated(by: CGFloat(M_PI_2))
        transformer.setTransform(t2, at: kCMTimeZero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        // export
        let exporter = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComposition
        let path = createPath()
        if path == ""{
            print("No path")
            return
        }
        exporter?.outputURL = URL(fileURLWithPath: path)
        exporter?.outputFileType = AVFileTypeQuickTimeMovie
        exporter?.exportAsynchronously(completionHandler: {
            let croppedURL = exporter?.outputURL
            self.convertVideoToGif(videoURL: croppedURL!, start: start, duration: duration)
        })
        
    }
    func createPath()-> String{

//        var paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let manager = FileManager()
        var outputURL = documentsDirectory + "/output"
        print("output url: \(outputURL)")
        do {
            try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
        } catch  {
            print("caught error creating directory")
            return""
        }
        outputURL += "/output.mov"
        print("output url: \(outputURL)")

        // Remove Existing File
        do {
            try         manager.removeItem(atPath: outputURL)

        } catch  {
            print("caught error removing existing file")
            

        }
        
        return outputURL
        
    }
    /*
 -(void)cropVideoToSquare:(NSURL*)rawVideoURL start:(NSNumber*)start duration:(NSNumber*)duration {
 //Create the AVAsset and AVAssetTrack
 AVAsset *videoAsset = [AVAsset assetWithURL:rawVideoURL];
 AVAssetTrack *videoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
 
 // Crop to square
 AVMutableVideoComposition* videoComposition = [AVMutableVideoComposition videoComposition];
 videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.height);
 videoComposition.frameDuration = CMTimeMake(1, 30);
 
 AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
 instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30) );
 
 // rotate to portrait
 AVMutableVideoCompositionLayerInstruction* transformer = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
 CGAffineTransform t1 = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, -(videoTrack.naturalSize.width - videoTrack.naturalSize.height) /2 );
 CGAffineTransform t2 = CGAffineTransformRotate(t1, M_PI_2);
 
 CGAffineTransform finalTransform = t2;
 [transformer setTransform:finalTransform atTime:kCMTimeZero];
 instruction.layerInstructions = [NSArray arrayWithObject:transformer];
 videoComposition.instructions = [NSArray arrayWithObject: instruction];
 
 // export
 AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:videoAsset presetName:AVAssetExportPresetHighestQuality] ;
 exporter.videoComposition = videoComposition;
 NSString *path = [self createPath];
 
     exporter.outputURL = [NSURL fileURLWithPath:path];
 exporter.outputFileType = AVFileTypeQuickTimeMovie;
 
 __block NSURL *croppedURL;
 
 [exporter exportAsynchronouslyWithCompletionHandler:^(void){
 croppedURL = exporter.outputURL;
 [self convertVideoToGif:croppedURL start:start duration:duration];
 }];
 }
     
     - (NSString*)createPath {
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSFileManager *manager = [NSFileManager defaultManager];
     NSString *outputURL = [documentsDirectory stringByAppendingPathComponent:@"output"] ;
     [manager createDirectoryAtPath:outputURL withIntermediateDirectories:YES attributes:nil error:nil];
     outputURL = [outputURL stringByAppendingPathComponent:@"output.mov"];
     
     // Remove Existing File
     [manager removeItemAtPath:outputURL error:nil];
     
     return outputURL;
     }

*/
    @IBAction func launchVideoCamera(sender: AnyObject){
        present(pickerControllerWithSource(UIImagePickerControllerSourceType.camera), animated: true, completion: nil)
        
    }
    func launchPhotoLibrary(){
        present(pickerControllerWithSource(UIImagePickerControllerSourceType.photoLibrary), animated: true, completion: nil)
        
    }
}
//MARK: UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate{
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeMovie as String{
            let videoURL = info["UIImagePickerControllerMediaURL"] as! URL
            let start = info["_UIImagePickerControllerVideoEditingStart"] as! Float?
            let end = info["_UIImagePickerControllerVideoEditingEnd"] as! Float?
            var duration:Float?
            if let start = start{
                duration = end! - start
            } else{
                duration = nil
            }
            
            cropVideoToSquare(videoURL, start: start, duration: duration)
//            convertVideoToGif(videoURL: videoURL, start: start, duration: duration )
//            print(videoURL.path)
//            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
//            dismiss(animated: true, completion: nil)
            
        }
    }
    
}
//MARK: UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {
    
}
