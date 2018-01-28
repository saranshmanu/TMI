//
//  RolesViewController.swift
//  TMI
//
//  Created by Saransh Mittal on 15/12/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit
import RealmSwift

class RolesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var sessionsCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var sessions:[NSDictionary] = []
    var roles:[NSDictionary] = []
    
    func querySessions() {
        let session = realm.objects(Session.self)
        var temp:NSDictionary
        for i in session{
            temp = [
                "sessionId": i.sessionId,
                "date": i.date,
                "wordOfDay": i.wordOfDay,
                "wordMeaning": i.wordMeaning,
                "wordUsage": i.wordMeaning,
                "genEvalReport": i.genEvalReport
            ]
            sessions.append(temp)
        }
        sessionsCollectionView.reloadData()
    }
    
    func queryRoles() {
        let role = realm.objects(Role.self)
        var temp:NSDictionary
        var tempSession:NSDictionary
        var tempUser:NSDictionary
        for i in role{
            tempSession = [
                "sessionId": i.session?.sessionId,
                "date": i.session?.date,
                "wordOfDay": i.session?.wordOfDay,
                "wordMeaning": i.session?.wordMeaning,
                "wordUsage": i.session?.wordMeaning,
                "genEvalReport": i.session?.genEvalReport
            ]
            tempUser = [
                "userId" : i.user?.userId,
                "name" : i.user?.userId
            ]
            temp = [
                "session":tempSession,
                "user":tempUser,
                "roleId":i.roleId,
                "role":i.role,
                "notes":i.notes,
                "topic":i.topic,
                "time":i.time,
                "ahs":i.ahs,
                "grammarianReport":i.grammarianReport,
                "evaluatee":i.evaluatee
            ]
            roles.append(temp)
        }
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        sessionsCollectionView.reloadData()
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        collectionView.delegate = self
        collectionView.dataSource = self
        sessionsCollectionView.delegate = self
        sessionsCollectionView.dataSource = self
        querySessions()
        queryRoles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sessionsCollectionView{
            return sessions.count
        } else {
            return roles.count
        }
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sessionsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessions", for: indexPath) as! SessionsCollectionViewCell
            let x = Constants.findDate(milliSeconds: sessions[indexPath.row][Constants.date] as! Int)
            cell.date.text = String(x.date)
            cell.month.text = Constants.getMonth(monthInNumber: x.month)
            cell.background.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roles", for: indexPath) as! RolesCollectionViewCell
            let x = roles[indexPath.row] as NSDictionary
            let y = x["session"] as! NSDictionary
            let z = Constants.findDate(milliSeconds: y[Constants.date]! as! Int)
            cell.DateTextField.text = String(z.date) + " " + Constants.getMonth(monthInNumber: z.month)
            cell.wordOfDay.text = String(describing: y[Constants.wordOfDay]!)
            cell.meaningOfTheWord.text = String(describing: y[Constants.wordMeaning]!)
            cell.wordUsage.text = String(describing: y[Constants.wordUsage]!)
            cell.upcomingRoleTextField.text = Constants.getFullRole(role: String(describing: x[Constants.role]!))
            cell.background.layer.cornerRadius = 10
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
