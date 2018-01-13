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

class LoginViewController : UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var topConstraintToMoveViewUp: NSLayoutConstraint!
    @IBOutlet weak var ConstraintToMoveTextField: NSLayoutConstraint!
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
        userId.delegate = self
        password.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
    
    var constant:CGFloat = 150.0
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.27) {
            self.topConstraintToMoveViewUp.constant -= self.constant
            self.ConstraintToMoveTextField.constant += self.constant
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(self.userId.isEditing || self.password.isEditing) {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.27, animations: {
                self.topConstraintToMoveViewUp.constant += self.constant
                self.ConstraintToMoveTextField.constant -= self.constant
                self.view.layoutIfNeeded()
            })
        }
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
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func enableControls() {
        self.userId.isEnabled = true
        self.password.isEnabled = true
        loginButton.isEnabled = true
        registerButton.isEnabled = true
        self.loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    @objc func dismissKeyboard() {
        userId.resignFirstResponder()
        password.resignFirstResponder()
    }
}

