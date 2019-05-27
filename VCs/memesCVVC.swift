//
//  memesCVVC.swift
//  MemeMeApp
//
//  Created by Fares Alharbi on 24/08/1440 AH.
//  Copyright © 1440 Fares Alharbi. All rights reserved.
//

import UIKit

class memesCVVC: UIViewController {
    
    
    @IBOutlet weak var memesCV: UICollectionView!

    @IBOutlet weak var flow: UICollectionViewFlowLayout!
    
    var prepareImageForReview = UIImage()
    
    var memes : [Meme] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        memesCV.delegate = self
        memesCV.dataSource = self
        
        setupCellLayout()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        memesCV.reloadData()
    }
    func setupCellLayout(){
        
        
        let space:CGFloat = 3
        let dimension = ( view.frame.size.width - ( 2 * space ) ) / 3
        
        
        flow.minimumInteritemSpacing = space
        flow.minimumLineSpacing = space
        flow.itemSize = CGSize(width: dimension, height: dimension)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue"  {
            
            
            let desitnaion = segue.destination as? imagePreviewerVC
            desitnaion?.passedImageForReviewing = prepareImageForReview
            
        }
    }
    


}


extension memesCVVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCVCell", for: indexPath) as? memeCVCell
        
        cell?.memeImageView.image = memes[indexPath.row].memeImg
        cell?.memeTitlLbl.text = memes[indexPath.row].topText
        
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        prepareImageForReview = memes[indexPath.row].memeImg
        
        performSegue(withIdentifier: "previewSegue", sender: self)
        
        
    }
    
    
    
    
    
}
