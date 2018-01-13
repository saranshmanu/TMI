//
//  LoginViewController.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 24/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyJSON

class LoginViewController : UIViewController {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userId.text = "test"
//        password.text = "1234"
    }
    
    @IBAction func onLogin(_ sender: Any) {
        disableControls()
        if userId.text == nil || userId.text! == "" {
            let alert = UIAlertController(
                title: "Error",
                message: "The username cannot be empty!",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            enableControls()
            return
        }
        if password.text == nil || password.text! == "" {
            let alert = UIAlertController(
                title: "Error",
                message: "The password cannot be empty!",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            enableControls()
            return
        }
        NetworkAPI.PublicAPI.signIn(userId: userId.text!, password: password.text!)
            .then { json -> Promise<JSON> in
                if json[Constants.success].bool == true {
                    Data.accessToken = json[Constants.accessToken].string!
                    Data.authToken = json[Constants.authToken].string!
                    return Data.loadData()
                } else {
                    return Promise().then {
                        return json
                    }
                }
            }
            .then { json -> Promise<JSON> in
                if json[Constants.success].bool == true {
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.present(viewController, animated: true, completion: nil)
                } else {
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
            .always {
                self.enableControls()
        }
    }
    
    func disableControls() {
        userId.isEnabled = false
        password.isEnabled = false
        loadingIndicator.isHidden = false
    }
    
    func enableControls() {
        self.userId.isEnabled = true
        self.password.isEnabled = true
        self.loadingIndicator.isHidden = true
    }
}

