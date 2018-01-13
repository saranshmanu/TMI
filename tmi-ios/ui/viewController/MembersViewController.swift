//
//  MembersViewController.swift
//  tmi-ios
//
//  Created by Saransh Mittal on 06/01/18.
//  Copyright © 2018 Rakshith Ravi. All rights reserved.
//

import UIKit
import Alamofire

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var membersTableView: UITableView!
    
    var clubMembers:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        membersTableView.dataSource = self
        membersTableView.delegate = self
        
//        let urlProfile = "https://api.tmivit.com/info/members"
//        Alamofire.request(urlProfile, method: .post, parameters : ["clubId" : Data.clubId], headers : ["accessToken" : Data.accessToken]).responseJSON{ res in
//            if res.result.isSuccess{
//                let result:NSDictionary = res.result.value as! NSDictionary
//                let check:Bool = result["success"]! as! Bool
//                if check == true{
//                    Data.clubMembers = result["members"] as! [NSDictionary]
//                    self.membersTableView.reloadData()
//                }else{
//                    print("Failed to fetch profile")
//                }
//            }else{
//                print("Failed JSON response")
//            }
//        }
        
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
        cell.textLabel?.text = clubMembers[indexPath.row]["name"]! as! String
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubMembers.count
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
