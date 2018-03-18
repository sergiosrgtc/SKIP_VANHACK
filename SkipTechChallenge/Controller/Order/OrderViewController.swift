//
//  OrderViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewOrders: UITableView!
    
    var arrayOrders = [Order]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Orders"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getOrders()
    }
    
    func getOrders(){
        let observableProducts = ApiSkipDataprovider.sharedInstance.getOrders().debug()
        observableProducts.subscribe(onNext: { (orders) in
            print("Succesfull got orders from user")
            self.arrayOrders = orders
            self.tableViewOrders.reloadData()
        }, onError: { (error) in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = arrayOrders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! OrderTableViewCell
        cell.id.text? = "Id: " + order.id!.description
        cell.status.text? = "Status: " + order.status!
        cell.address.text? = "Delivery Address: " + order.deliveryAddress!
        cell.date.text? = "Date: " + order.date!
        cell.total.text? = "Last update: " + order.lastUpdate!

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
