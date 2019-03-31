//
//  ProductTableViewCell.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/30/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var totalQuantity: UILabel!
    
    @IBOutlet weak var collectionIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
