//
//  ProductDetailViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var total: UILabel!
    
    var product: Product?
    var qtt = 1
    var totalPrice : Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishName.text = product?.name
        dishDescription.text = product?.description
        updateTotal(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTotal(_ quantity: Int){
        totalPrice = (product?.price)! * Double.init(quantity)
        total.text = "R$ " + totalPrice.description
    }
    
    @IBAction func minusPressed(_ sender: Any) {
        qtt = Int.init(quantity.text!)!
        if qtt > 1 {
            qtt = qtt - 1
            quantity.text = qtt.description
            updateTotal(qtt)
        }
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        qtt = Int.init(quantity.text!)!
        qtt = qtt + 1
        quantity.text = qtt.description
        updateTotal(qtt)
    }
    
    @IBAction func addToOderPressed(_ sender: Any) {
        let orderItem = OrderItem.init(id: 0, orderId: 0, productId: (product?.id)!, product: product!, price: (product?.price)!, quantity: qtt, total: totalPrice)
        
        let order = Order.sharedInstance
        if order.orderItems == nil {
            order.id = 0
            order.customerId = 0
            order.storeId = product?.storeId
            order.deliveryAddress = "Winnipeg"
            order.contact = "Me"
            order.date = Utils.nowTimeStamp()
            order.status = "waiting"
            order.lastUpdate = Utils.nowTimeStamp()
            order.total = 0
            order.orderItems = [OrderItem]()
        }
        
        if product?.storeId != order.storeId {
            print("Products from different restaurants will reset your cart")
            order.orderItems?.append(orderItem)
        }else{
            order.orderItems?.append(orderItem)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
