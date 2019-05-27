//
//  memeTVCell.swift
//  MemeMeApp
//
//  Created by Fares Alharbi on 24/08/1440 AH.
//  Copyright © 1440 Fares Alharbi. All rights reserved.
//

import UIKit

class memeTVCell: UITableViewCell {
    
    @IBOutlet weak var mainImage:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
