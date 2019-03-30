//
//  Collections.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/29/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation

struct Collections {
    let id: Int
    let title: String
    
    init?(dict: [String: Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as? String ?? ""
    }
}
