//
//  ViewController.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/29/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var collectionsTableView: UITableView!
    
    var collections = [Collections]() {
        didSet {
            DispatchQueue.main.async {
                // when collections are updated, reload the table view with new datas
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
        // Configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath) as! CollectionTableViewCell
        cell.collectionName.text = collections[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get which collection is selected
        let collection = collections[indexPath.row]
        
        // present detail page for the selected collection
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let productView = storyboard.instantiateViewController(withIdentifier: "collectionDetail") as? CollectionDetailsViewController else {
            return
        }
        // pass in the collectionID for the selected collection to the detailed page
        productView.collectionID = collection.id
        
        // show loading spinner until getting the data for the specific collection
        self.showSpinner(onView: productView.view)
    
        navigationController?.pushViewController(productView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}
