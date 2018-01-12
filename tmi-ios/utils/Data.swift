//
//  Data.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 22/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import PromiseKit
import RealmSwift
import SwiftyJSON

class Data {
    public static var roles:[NSDictionary] = []
    public static var announcements:[NSDictionary] = []
    public static var sessions:[NSDictionary] = []
    public static var attandance:[NSDictionary] = []
    public static var clubMembers:[NSDictionary] = []
    public static var accessToken = ""
	public static var authToken = ""
	public static var loggedIn = false
	public static var userId = ""
	public static var username = ""
	public static var name = ""
	public static var email = ""
	public static var dob : Int64 = 0
	public static var clubId = ""
	
    public static func initialize() {
        let defaults = UserDefaults.standard
        accessToken = defaults.string(forKey: Constants.accessToken) ?? ""
        authToken = defaults.string(forKey: Constants.authToken) ?? ""
        loggedIn = defaults.bool(forKey: Constants.loggedIn)
        userId = defaults.string(forKey: Constants.userId) ?? ""
        username = defaults.string(forKey: Constants.username) ?? ""
        name = defaults.string(forKey: Constants.name) ?? ""
        email = defaults.string(forKey: Constants.email) ?? ""
        dob = defaults.object(forKey: Constants.dob) as? Int64 ?? 0
        clubId = defaults.string(forKey: Constants.clubId) ?? ""
    }
    
    public static func save() {
        let defaults = UserDefaults.standard
        defaults.set(accessToken, forKey: Constants.accessToken)
        defaults.set(authToken, forKey: Constants.authToken)
        defaults.set(loggedIn, forKey: Constants.loggedIn)
        defaults.set(userId, forKey: Constants.userId)
        defaults.set(username, forKey: Constants.username)
        defaults.set(name, forKey: Constants.name)
        defaults.set(email, forKey: Constants.email)
        defaults.set(dob, forKey: Constants.dob)
        defaults.set(clubId, forKey: Constants.clubId)
        defaults.synchronize()
    }
    
    public static func loadData() -> Promise<JSON> {
        let realm = try! Realm()
        
        return NetworkAPI.PrivateAPI.getProfile().then { json -> Promise<JSON> in
            if json[Constants.success].bool != true {
                return Promise().then {
                    return json
                }
            }
            
            userId = json[Constants.userId].string!
            username = json[Constants.username].string!
            name = json[Constants.name].string!
            email = json[Constants.email].string!
            dob = json[Constants.dob].int64!
            clubId = json[Constants.clubId].string!
            
            return NetworkAPI.PrivateAPI.getUsers(clubId: clubId)
            }.then { json -> Promise<JSON> in
                if json[Constants.success].bool != true {
                    return Promise().then {
                        return json
                    }
                }
                
                var users : [User] = []
                for member in json[Constants.members].array! {
                    let user = User()
                    user.userId = member[Constants.userId].string!
                    user.name = member[Constants.name].string!
                    users.append(user)
                }
                
                try! realm.write {
                    realm.delete(realm.objects(User.self))
                    realm.add(users)
                }
                
                return NetworkAPI.PrivateAPI.getSessions(clubId: clubId)
            }.then { json -> Promise<JSON> in
                if json[Constants.success].bool != true {
                    return Promise().then {
                        return json
                    }
                }
                
                try! realm.write {
                    realm.delete(realm.objects(Session.self))
                    realm.delete(realm.objects(Role.self))
                }
                
                var promises = Promise().then {
                    return json
                }
                for sessionJson in json[Constants.sessions].array! {
                    let session = Session()
                    
                    session.sessionId = sessionJson[Constants.sessionId].string!
                    session.date = sessionJson[Constants.date].int64!
                    session.wordOfDay = sessionJson[Constants.wordOfDay].string ?? ""
                    session.wordMeaning = sessionJson[Constants.wordMeaning].string ?? ""
                    session.wordUsage = sessionJson[Constants.wordUsage].string ?? ""
                    session.genEvalReport = sessionJson[Constants.genEvalReport].string ?? ""
                    
                    try! realm.write {
                        realm.add(session)
                    }
                    
                    promises = promises.then { json -> Promise<JSON> in
                        if json[Constants.success].bool != true {
                            return Promise().then {
                                return json
                            }
                        }
                        
                        return NetworkAPI.PrivateAPI.getRoles(sessionId: session.sessionId)
                        }.then { json -> Promise<JSON> in
                            if json[Constants.success].bool == true {
                                var roles : [Role] = []
                                for roleJson in json[Constants.roles].array! {
                                    let role = Role()
                                    
                                    role.session = session
                                    role.user = realm.objects(User.self)
                                        .filter("userId == '\(roleJson[Constants.userId].string!)'")
                                        .first!
                                    role.roleId = roleJson[Constants.roleId].string!
                                    role.role = roleJson[Constants.role].string!
                                    role.notes = roleJson[Constants.notes].string ?? ""
                                    role.topic = roleJson[Constants.topic].string ?? ""
                                    role.time = roleJson[Constants.time].int ?? 0
                                    role.ahs = roleJson[Constants.ahs].int ?? 0
                                    role.grammarianReport = roleJson[Constants.grammarianReport].string ?? ""
                                    role.evaluatee = realm.objects(User.self)
                                        .filter("userId == '" + (roleJson[Constants.evaluatee].string ?? "none") + "'")
                                        .first ?? nil
                                    roles.append(role)
                                }
                                
                                try! realm.write {
                                    realm.add(roles)
                                }
                            }
                            
                            return Promise().then {
                                return json
                            }
                    }
                }
                return promises
            }.then { json -> Promise<JSON> in
                if json[Constants.success].bool != true {
                    return Promise().then {
                        return json
                    }
                }
                
                return NetworkAPI.PrivateAPI.getAttendance()
            }.then { json -> Promise<JSON> in
                if json[Constants.success].bool != true {
                    return Promise().then {
                        return json
                    }
                }
                
                try! realm.write {
                    realm.delete(realm.objects(Attendance.self))
                }
                
                var attendances : [Attendance] = []
                let myself = realm.objects(User.self)
                    .filter("userId == '\(userId)'")
                    .first!
                for attendanceJson in json[Constants.attendance].array! {
                    let attendance = Attendance()
                    
                    attendance.session = realm.objects(Session.self)
                        .filter("sessionId == '\(attendanceJson[Constants.sessionId].string!)'")
                        .first!
                    attendance.user = myself
                    attendance.attendanceImpl = attendanceJson[Constants.attendance].string!
                    attendances.append(attendance)
                }
                
                try! realm.write {
                    realm.add(attendances)
                }
                
                return Promise().then {
                    return JSON(parseJSON: "{\"\(Constants.success)\":true}")
                }
        } // TODO messages later
    }
}
