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
        self.tabBarController?.tabBar.barTintColor =  UIColor.white
        self.navigationController?.navigationBar.barTintColor =  UIColor.white
        self.tabBarController?.tabBar.tintColor = UIColor.black
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.barTintColor =  UIColor.white
        self.navigationController?.navigationBar.barTintColor =  UIColor.white
        self.tabBarController?.tabBar.tintColor = UIColor.black
        UIApplication.shared.statusBarStyle = .default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
