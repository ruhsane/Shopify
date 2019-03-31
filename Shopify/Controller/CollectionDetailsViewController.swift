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
                self.productsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getProductsList()
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    func getProductsList() {
        NetworkRequest().fetchProducts(collectionID: collectionID) { (responseObj) in
            print(responseObj)
            if let results = responseObj["collects"] as? [[String: Any]] {
                for entry in results {
                    let products = Products(dict: entry)
                    self.products.append((products?.product_id)!)
                }
                self.getProductDetail()

            }
        }
    }
    
    func getProductDetail() {
        NetworkRequest().fetchProductDetails(products: products) { (responseObj) in
            print(responseObj)
            if let results = responseObj["products"] as? [[String: Any]] {
                for entry in results {
                    let product = ProductDetails(dict: entry)
                    self.productDetail.append(product!)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Products", for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        cell.productName.text = productDetail[indexPath.row].name
        cell.totalQuantity.text = "\(productDetail[indexPath.row].quantities) available"
        
        let urlString = productDetail[indexPath.row].image
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error)
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
