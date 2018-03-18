//
//  FirstViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var restaurantTableView: UITableView!
    var restaurantsArray = [Restaurant]()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        loadRestaurants(filter: "")
    }

    func loadRestaurants(filter: String){
        let observableRestaurants = ApiSkipDataprovider.sharedInstance.getRestaurants(searchString: "").debug()
        observableRestaurants.subscribe(onNext: { (restaurants) in
            print("Succesfull got restaurants")
            self.restaurantsArray = restaurants
            self.restaurantTableView.reloadData()
        }, onError: { (error) in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell") as! RestaurantTableViewCell
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.name.text = restaurant.name
        cell.address.text = restaurant.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurantsArray[indexPath.row]
        self.performSegue(withIdentifier: "goToProductDetails", sender: restaurant)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProductDetails"{
            let productVC = segue.destination as? ProductViewController
            productVC?.restaurant = sender as? Restaurant
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

