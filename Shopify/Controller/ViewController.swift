//
//  ViewController.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/29/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var collectionsTableView: UITableView!
    
    var collections = [Collections]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateCollections()
    }


    func populateCollections() {
        NetworkRequest().fetchCollections { (jsonObject) in
            if let results = jsonObject["custom_collections"] as? [[String: Any]] {
                for entry in results {
                    let collection = Collections(dict: entry)
                    self.collections.append(collection!)
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.collectionsTableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath) as! CollectionTableViewCell
        
        // Configure the cell...
        cell.collectionName.text = collections[indexPath.row].title
        
        return cell
    }
    
}
