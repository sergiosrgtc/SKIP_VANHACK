//
//  WelcomeViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userEmail = UserDefaults.standard.object(forKey: "email") as? String
        let userToken = UserDefaults.standard.object(forKey: "token") as? String
        if userEmail != nil && userToken != nil{
            print("Login Succesfull")
            self.performSegue(withIdentifier: "successfullLoginExistingUser", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
