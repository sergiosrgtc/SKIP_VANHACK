//
//  LoginViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class NewUserViewController: UIViewController {
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performLogin(_ sender: UIButton) {
        if userLogin.text != "" && userPassword.text != ""{
            if Utils.isValidEmail(email: userLogin.text!){
                let user = Customer.init(id: 0, email: userLogin.text!, name: "John", address: "Winnipeg", creation: Utils.nowTimeStamp(), password: userPassword.text!)
                let userObservable = ApiSkipDataprovider.sharedInstance.postCustomer(customer: user).debug()
                userObservable.subscribe(onNext: { (customer) in
                    print("Created User Succesfull")
                    print(customer)
                    self.performSegue(withIdentifier: "successfullCreatedUser", sender: self)
                }, onError: { (error) in
                    print("Error: \(error.localizedDescription)")
                }, onCompleted: {
                    
                }, onDisposed: {
                    
                }).disposed(by: disposeBag)
            }else{
                self.showAlert(message: "Email format invalid!")
            }
        }else{
            self.showAlert(message: "Please fill both email and password")
        }
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
