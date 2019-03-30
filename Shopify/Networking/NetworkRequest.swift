//
//  NetworkRequest.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/29/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest {

    func fetchCollections(completion: @escaping([String: Any])->()) {
        let defaultSession = URLSession(configuration: .default)
        
        //Create URL (...and send request and process response in closure...)
        if let url = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") {
            
            // Create Request
            let request = URLRequest(url: url)
            
            // Create Data Task
            let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let data = data {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        return completion(jsonObject)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            })
            dataTask.resume()
            
        }
        
        
    }

}
