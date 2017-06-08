//
//  SavedGifsViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lisa Litchfield on 6/8/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class SavedGifsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var savedGifs: [Gif] = []
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // set up flow layout
        configureFlowLayout(view.frame.size)
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureFlowLayout(size)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: UICollectionView Delegate & Data Source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
       // return savedGifs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionCell", for: indexPath) as! GifCell
//        let gif = savedGifs[indexPath.item]
  //      cell.configureForGif(gif: gif)
        return cell
    }
//MARK:  Collection View Flow Layout Methods
    
    func configureFlowLayout( _ size: CGSize){
        let space: CGFloat = 3.0
        let width = size.width
        let height = size.height
        var dimension = (width - (2*space))/3.0
        if width > height {
            dimension = (width - (5 * space))/6.0
        }
        
        flowLayout?.minimumLineSpacing = space
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.itemSize = CGSize(width: dimension,height: dimension)
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
