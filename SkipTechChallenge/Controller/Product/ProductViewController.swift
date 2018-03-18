//
//  ProductViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var productsTableView: UITableView!
    
    var productsArray = [Product]()
    let disposeBag = DisposeBag()
    var restaurant: Restaurant?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getProducts(restaurantID: restaurant!.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProducts(restaurantID: Int){
        let observableProducts = ApiSkipDataprovider.sharedInstance.getProducts(restaurantID: restaurantID).debug()
        observableProducts.subscribe(onNext: { (products) in
            print("Succesfull got products from restaurants")
            self.productsArray = products
            self.productsTableView.reloadData()
        }, onError: { (error) in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }
    
    //MARK:- Tableview Delagate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        let product = productsArray[indexPath.row]
        
        cell.name.text = product.name
        cell.productDescription.text = product.description
        cell.price.text = Utils.formatCurrency(value: product.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productsArray[indexPath.row]
        self.performSegue(withIdentifier: "goToDetailDish", sender: product)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailDish"{
            let productDetail = segue.destination as? ProductDetailViewController
            productDetail?.product = sender as? Product
        }
    }
}
