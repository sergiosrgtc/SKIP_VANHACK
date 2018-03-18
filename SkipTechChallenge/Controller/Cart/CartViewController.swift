//
//  SecondViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var totalitems: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    var sumItems = 0
    var sumPrice: Double = 0
    
    let disposeBag = DisposeBag()

    var arrayOrderItems = [OrderItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cart"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateTotals()
        cartTableView.reloadData()
    }
    
    func updateTotals(){
        sumItems = 0
        sumPrice = 0
        
        if let orders = Order.sharedInstance.orderItems{
             arrayOrderItems = orders
        }
        
        for item in arrayOrderItems{
            sumItems = sumItems + item.quantity
            sumPrice = sumPrice + item.total
        }
        totalitems.text? = "Total Items: " + sumItems.description
        totalPrice.text? = "Total Price: " + Utils.formatCurrency(value: sumPrice)
    }

    @IBAction func placeOrder(_ sender: Any) {
         let observableOrder = ApiSkipDataprovider.sharedInstance.postOrder(order: Order.sharedInstance).debug()
        observableOrder.subscribe(onNext: { (response) in
            
        }, onError: { (error) in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            Order.sharedInstance.orderItems?.removeAll()
            self.arrayOrderItems.removeAll()
            self.updateTotals()
            self.cartTableView.reloadData()
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }
    
    //MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOrderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        let productItem = Order.sharedInstance.orderItems?[indexPath.row]
        
        cell.name.text = productItem?.product.name
        cell.price.text = Utils.formatCurrency(value: productItem!.price)
        cell.quantity.text = productItem?.quantity.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        Order.sharedInstance.orderItems?.remove(at: indexPath.row)
        arrayOrderItems.remove(at: indexPath.row)
    }
}

