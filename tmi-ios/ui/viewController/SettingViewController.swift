//
//  SettingViewController.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 28/01/18.
//  Copyright © 2018 Rakshith Ravi. All rights reserved.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tsbleView: UITableView!
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    var name:String = ""
    
    func queryProfile() {
        let realm = try! Realm()
        let user = realm.objects(User.self)
        for i in user {
            name = i.name
        }
        tsbleView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        tsbleView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        tsbleView.delegate = self
        tsbleView.dataSource = self
        queryProfile()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            dismiss(animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileTableViewCell
            cell.nameLabel.text = name
            cell.clubNameLabel.text = Constants.clubId
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setting", for: indexPath) as! SettingsButtonTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
