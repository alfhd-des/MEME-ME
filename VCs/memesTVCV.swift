//
//  memesTVCV.swift
//  MemeMeApp
//
//  Created by Fares Alharbi on 24/08/1440 AH.
//  Copyright © 1440 Fares Alharbi. All rights reserved.
//

import UIKit

class memesTVCV: UIViewController {
    
    @IBOutlet weak var memesTV: UITableView!
    var prepareImageForReview = UIImage()
    
    var memes : [Meme] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.memes
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        memesTV.delegate = self
        memesTV.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        memesTV.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue"  {
            
            
            let desitnaion = segue.destination as? imagePreviewerVC
            desitnaion?.passedImageForReviewing = prepareImageForReview
            
            }
    }
    
    

 

}

extension memesTVCV: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        return (appDelegate?.memes.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTVCell") as? memeTVCell
        
        cell?.mainImage.image = memes[indexPath.row].memeImg
        cell?.titleLbl.text = memes[indexPath.row].topText
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        prepareImageForReview = memes[indexPath.row].memeImg
        
        performSegue(withIdentifier: "previewSegue", sender: self)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    
    
}
