//
//  SavedGifsViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/8/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class SavedGifsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PreviewViewControllerDelegate {
    var savedGifs: [Gif]?
//    var savedGifs: NSMutableArray?
    let cellMargin:CGFloat = 12.0
    var gifsFilePath:String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
//        let manager = FileManager()
        let path = documentsDirectory + "/savedGifs"
/*        print("path url: \(path)")
        do {
            try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch  {
            print("caught error creating directory")
            return ""
        }*/
        return path
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    @IBOutlet weak var emptyView: UIStackView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //load Gifs from archive
        if  gifsFilePath != ""{
            savedGifs = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath) as? [Gif]

        }
        super.viewWillAppear(animated)
        if savedGifs != nil{
            if (savedGifs?.count)! > 0 && savedGifs?[0] != nil{
//       if (savedGifs?.count)!  > 0 {
                emptyView.isHidden = true
            }
        }
        collectionView.reloadData()

        // set up flow layout
//        configureFlowLayout(view.frame.size)
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        configureFlowLayout(size)
    }

//MARK: UICollectionView Delegate & Data Source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedGifs?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as! GifCell
        let gif = savedGifs?[indexPath.item]
        if gif != nil{
            cell.configureForGif(gif: gif!)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.gif = savedGifs?[indexPath.row]
        present(detailVC, animated: true, completion: nil)
    }
//MARK:  Collection View Flow Layout Methods

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - (cellMargin*2.0))/2.0
        return CGSize(width: width, height: width)
    }

    func configureFlowLayout( _ size: CGSize){
        print("SIZE = \(size)")
        let space: CGFloat = 3.0
        let width = size.width
        let height = size.height
        var dimension = (width - (2*space))/2.0
        if width > height {
            dimension = (width - (5 * space))/6.0
        }
        print("dimension = \(dimension)")
        flowLayout?.minimumLineSpacing = space
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.itemSize = CGSize(width: dimension,height: dimension)
    }
    //MARK: PreviewViewController Delegate
    func previewVC( _ preview:PreviewViewController, didSaveGif gif:Gif){
        if let url = gif.url{
            gif.gifData = NSData(contentsOf: url)
        }
        print("inside previewVC!!!!!!!!!!!!!")
        if savedGifs == nil{
            savedGifs = []
        }
        savedGifs?.append(gif)
        NSKeyedArchiver.archiveRootObject(savedGifs!, toFile: gifsFilePath)
    }

    
    // MARK: - Navigation


    func showWelcome(){
        if !UserDefaults.standard.bool(forKey: "previouslyLaunched"){
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }
}
