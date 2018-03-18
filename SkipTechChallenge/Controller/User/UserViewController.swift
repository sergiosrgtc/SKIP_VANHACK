//
//  UserViewController.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 18/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userEmail = UserDefaults.standard.object(forKey: "email") as? String
        userName.text = userEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        self.performSegue(withIdentifier: "successLogout", sender: self)
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
