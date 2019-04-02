//
//  ArrayExtension.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/31/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation

extension Array {
    // join elements in an array with a comma and make it into string
    // used to pass into url
    var joinWithComma: String {
        return map { "\($0)" }.joined(separator: ",")
    }
}
