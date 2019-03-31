//
//  ArrayExtension.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/31/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation

extension Array {
    var joinWithComma: String {
        return map { "\($0)" }.joined(separator: ",")
    }
}
