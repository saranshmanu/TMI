//
//  RolesViewController.swift
//  TMI
//
//  Created by Saransh Mittal on 15/12/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit
import Alamofire

var sessionId = ""

class RolesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var sessions:[NSDictionary] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barTintColor =  UIColor.black
        self.navigationController?.navigationBar.barTintColor =  UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor =  UIColor.black
        self.navigationController?.navigationBar.barTintColor =  UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let urlSessions = "https://api.tmivit.com/info/sessions"
//        Alamofire.request(urlSessions, method: .post, parameters : ["clubId" : Data.clubId], headers : ["accessToken" : Data.accessToken]).responseJSON{ response in
//            if response.result.isSuccess{
//                let results:NSDictionary = response.result.value as! NSDictionary
//                let check:Bool = results["success"]! as! Bool
//                if check == true{
//                    print("Successully fetched sessions")
//                    sessions = results["sessions"] as! [NSDictionary]
//                    print(sessions)
//                    self.fetchRoles()
//                }else{
//                    print("Failed to fetch sessions")
//                }
//            }else{
//                print("Failed JSON response")
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var roles = [[NSDictionary]]()
    func fetchRoles() {
        if sessions.count != 0 {
            functionToFetchRolesForEachSession()
        }
    }
    
    var i = 0
    func functionToFetchRolesForEachSession() {
        if i == sessions.count{
            // do nothing
        }else{
            let session = String(describing: sessions[i]["sessionId"]!)
//            let urlSessions = "https://api.tmivit.com/info/roles"
//            Alamofire.request(urlSessions, method: .post, parameters : ["sessionId" : session], headers : ["accessToken" : Data.accessToken]).responseJSON{ res in
//                if res.result.isSuccess{
//                    let result:NSDictionary = res.result.value as! NSDictionary
//                    let check:Bool = result["success"]! as! Bool
//                    if check == true{
//                        self.roles.append(result["roles"] as! [NSDictionary])
//                        print(self.roles)
//                    } else {
//                        print("Failed to fetch roles")
//                    }
//                } else {
//                    print("Failed JSON response")
//                }
//                self.collectionView.reloadData()
//                self.i = self.i+1
//                self.functionToFetchRolesForEachSession()
//            }
        }
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roles", for: indexPath) as! RolesCollectionViewCell
        cell.background.layer.cornerRadius = 5.0
        let milisecond = sessions[indexPath.row]["date"]! as! Int
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond/1000))
        let calendar = Calendar.current
        let year = calendar.component(.year, from: dateVar)
        let month = calendar.component(.month, from: dateVar)
        let day = calendar.component(.day, from: dateVar)
        cell.DateTextField.text = String(day) + " " + getMonth(monthInNumber: month)
        cell.YearTextField.text = String(year)
        cell.wordOfDay.text = String(describing: sessions[indexPath.row]["wordOfDay"]!)
        cell.meaningOfTheWord.text = String(describing: sessions[indexPath.row]["wordMeaning"]!)
        cell.wordUsage.text = String(describing: sessions[indexPath.row]["wordUsage"]!)
        if roles.count == sessions.count{
            if let x:[NSDictionary] = roles[indexPath.row] as! [NSDictionary]{
                var roleLabel = ""
                if x.count != 0{
                    for i in 0...(x.count-1) {
                        roleLabel = roleLabel + " " + Constants.getFullRole(role: String(describing: x[i]["role"]!))
                    }
                }else{
                    roleLabel = "You have no role for this coming session!"
                }
                cell.upcomingRoleTextField.text = roleLabel
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        sessionId = String(describing: sessions[indexPath.row]["sessionId"]!)
        if roles.count == sessions.count{
//            guard let vc = storyboard?.instantiateViewController(withIdentifier: "members") else {
//                return
//            }
//            navigationController?.pushViewController(vc, animated: true)
        }else{
            //wait until the roles are fetched
        }
    }
}

func getMonth(monthInNumber:Int) -> String{
    var month = ""
    if monthInNumber == 1{
        return "January"
    }else if monthInNumber == 2{
        return "February"
    }else if monthInNumber == 3{
        return "March"
    }else if monthInNumber == 4{
        return "April"
    }else if monthInNumber == 5{
        return "May"
    }else if monthInNumber == 6{
        return "June"
    }else if monthInNumber == 7{
        return "July"
    }else if monthInNumber == 8{
        return "August"
    }else if monthInNumber == 9{
        return "September"
    }else if monthInNumber == 10{
        return "October"
    }else if monthInNumber == 1{
        return "November"
    }else{
        return "December"
    }
}
