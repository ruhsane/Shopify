//
//  CollectionDetailsViewController.swift
//  Shopify
//
//  Created by Ruhsane Sawut on 3/30/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class CollectionDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var productsTableView: UITableView!
    
    var collectionID: Int!
    
    var products: [Int] = []
    
    var productDetail = [ProductDetails]() {
        didSet {
            DispatchQueue.main.async {
                // reload the table view with new datas when product details are retrieved
                self.productsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProductsList()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    func getProductsList() {
        // fetch products list for the specific collection
        NetworkRequest().fetchProducts(collectionID: collectionID) { (responseObj) in
            if let results = responseObj["collects"] as? [[String: Any]] {
                for entry in results {
                    // add every products' IDs onto products array
                    let products = Products(dict: entry)
                    self.products.append((products?.product_id)!)
                }
                // after getting the full list of products, get the product detail for each
                self.getProductDetail()

            }
        }
    }
    
    func getProductDetail() {
        NetworkRequest().fetchProductDetails(products: products) { (responseObj) in
            //got the data, remove the loading spinner from view
            self.removeSpinner()
            if let results = responseObj["products"] as? [[String: Any]] {
                for entry in results {
                    // add product details onto an array
                    let product = ProductDetails(dict: entry)
                    self.productDetail.append(product!)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // cell count = product count
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Products", for: indexPath) as! ProductTableViewCell
        cell.productName.text = productDetail[indexPath.row].name
        cell.totalQuantity.text = "✔️ \(productDetail[indexPath.row].quantities) Available "
        
        // get specific image for each cell
        let urlString = productDetail[indexPath.row].image
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                cell.collectionIMG.image = UIImage(data: data!)
            }
        }.resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
