//
//  imagePreviewerVC.swift
//  MemeMeApp
//
//  Created by Fares Alharbi on 24/08/1440 AH.
//  Copyright © 1440 Fares Alharbi. All rights reserved.
//

import UIKit

class imagePreviewerVC: UIViewController {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var passedImageForReviewing = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainImageView.image = passedImageForReviewing
        // Do any additional setup after loading the view.
    }
    



}
