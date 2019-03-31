//
//  Products.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/30/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation

struct Products {
    let product_id: Int
    
    init?(dict: [String: Any]) {
        self.product_id = dict["product_id"] as! Int
    }
}
