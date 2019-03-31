//
//  ProductDetail.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/31/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation

struct ProductDetails {
    let name: String
    var quantities = 0
    let image: String
    
    init?(dict: [String: Any]) {
        self.name = dict["title"] as! String
        if let variants = dict["variants"] as? [[String: Any]] {
            for entry in variants {
                self.quantities += entry["inventory_quantity"] as! Int
            }
        }
        let image = dict["image"] as! [String: Any]
        self.image = image["src"] as! String
        
    }
    
}
