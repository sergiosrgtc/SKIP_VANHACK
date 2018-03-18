//
//  LoginViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func performLogin(_ sender: UIButton) {
        if userLogin.text != "" && userPassword.text != ""{
            if Utils.isValidEmail(email: userLogin.text!){
                let userObservable = ApiSkipDataprovider.sharedInstance.getCustomer(email: userLogin.text!, password: userPassword.text!).debug()
                userObservable.subscribe(onNext: { (customer) in
                    print("Login Succesfull")
    
                    print(customer)
                    self.performSegue(withIdentifier: "successfullLogin", sender: self)
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
