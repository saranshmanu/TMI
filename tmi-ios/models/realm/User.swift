//
//  User.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 23/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import RealmSwift

class User : Object {
	
	@objc public dynamic var userId = ""
	@objc public dynamic var name = ""
}
