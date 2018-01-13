//
//  SplashViewController.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 22/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyJSON

class SplashViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Data.loggedIn == true {
            Data.loadData()
                .then { json -> Promise<JSON> in
                    if json[Constants.success].bool == true {
                        // Successfully loaded data
                        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                        self.present(viewController, animated: true, completion: nil)
                    } else {
                        // Some error. Show the error
                        let alert = UIAlertController(
                            title: "Error",
                            message: json[Constants.message].string!,
                            preferredStyle: UIAlertControllerStyle.alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    return Promise().then {
                        return json
                    }
                }
                .catch { err in
                    // Not connected to the internet
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.present(viewController, animated: true, completion: nil)
            }
        } else {
            // Show login screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController")
                self.present(viewController, animated: true, completion: nil)
            })
        }
    }
}

