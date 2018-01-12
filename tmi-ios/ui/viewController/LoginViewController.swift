//
//  LoginViewController.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 24/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController : UIViewController,UITextFieldDelegate {
    
    var constant:CGFloat = 150.0
    
    // for tapping
    @objc func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.topConstraint.constant -= self.constant
            self.bottomConstraint.constant += self.constant
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(self.usernameTextField.isEditing || self.passwordTextField.isEditing) {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations: {
                self.topConstraint.constant += self.constant
                self.bottomConstraint.constant -= self.constant
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if usernameTextField.text! == "" && passwordTextField.text! == ""{
            print("Fields are empty")
            // create alert to notify the user
            //to initiate alert if login is unsuccesfull
            let alertController = UIAlertController(title: "Incorrect credentials", message: "Incorrect registration number or password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let url = "https://api.tmivit.com/auth/signin"
            Alamofire.request(url, method: .post, parameters: ["userId" : usernameTextField.text!, "password" : passwordTextField.text!]).responseJSON{ res in
                let result:NSDictionary = res.result.value as! NSDictionary
                if res.result.isSuccess{
                    let check:Int = result["success"]! as! Int
                    if check == 1{
                        Data.userId = self.usernameTextField.text!
                        print("successfull login")
                        Data.accessToken = String(describing: result["accessToken"]!)
                        print(Data.accessToken)
                        Data.authToken = String(describing: result["authToken"]!)
                        Data.loggedIn = true
                        //Go to the HomeViewController if the login is sucessful
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    else{
                        print("login failed")
                    }
                }
                else{
                    print("Failed JSON response")
                }
            }
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "test"
        passwordTextField.text = "1234"
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // for tapping
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
}
