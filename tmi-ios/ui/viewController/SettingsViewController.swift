//
//  SettingsViewController.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 14/01/18.
//  Copyright © 2018 Rakshith Ravi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
