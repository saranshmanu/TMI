//
//  AnnouncementsViewController.swift
//  TMI
//
//  Created by Saransh Mittal on 15/12/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit
import Alamofire

class AnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let token:String = Data.accessToken
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.black
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        let urlProfile = "https://api.tmivit.com/user/profile"
        Alamofire.request(urlProfile, method: .post, headers : ["accessToken" : token]).responseJSON{ res in
            if res.result.isSuccess{
                let result:NSDictionary = res.result.value as! NSDictionary
                let check:Bool = result["success"]! as! Bool
                if check == true{
                    print("Successully fetched profile")
                    Data.email = String(describing: result["email"]!)
                    Data.name = String(describing: result["name"]!)
                    Data.userId = String(describing: result["userId"]!)
                    Data.username = String(describing: result["username"]!)
                    Data.dob = Int64(result["dob"] as! Int)
                    Data.clubId = String(describing: result["clubId"]!)
                }else{
                    print("Failed to fetch profile")
                }
            }else{
                print("Failed JSON response")
            }
        }
        let url = "https://api.tmivit.com/info/announcements"
        Alamofire.request(url, method: .post, headers : ["accessToken" : token]).responseJSON{ res in
            if res.result.isSuccess{
                let result:NSDictionary = res.result.value as! NSDictionary
                let check:Bool = result["success"]! as! Bool
                if check == true{
                    print("Successully fetched announcements")
                    Data.announcements = result["announcements"] as! [NSDictionary]
                    print(Data.announcements)
                    self.tableView.reloadData()
                }else{
                    print("Failed to fetch accouncements")
                }
            }else{
                print("Failed JSON response")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath) as! AnnouncementsTableViewCell
        cell.background.layer.cornerRadius = 5.0
        cell.subjectTextField.text = String(describing: Data.announcements[indexPath.row]["title"])
        cell.messageTextField.text = String(describing: Data.announcements[indexPath.row]["message"])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.announcements.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
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
