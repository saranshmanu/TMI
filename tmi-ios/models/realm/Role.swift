//
//  Role.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 23/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import RealmSwift

class Role : Object {
	
	@objc public dynamic var session : Session?
	@objc public dynamic var user : User?
	@objc public dynamic var roleId = ""
	@objc public dynamic var role = ""
	@objc public dynamic var notes = ""
	@objc public dynamic var topic = ""
	@objc public dynamic var time = 0
	@objc public dynamic var ahs = 0
	@objc public dynamic var grammarianReport = ""
	@objc public dynamic var evaluatee : User?
}
