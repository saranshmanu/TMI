//
//  Message.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 23/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import RealmSwift

class Message : Object {
	
	@objc public dynamic var messageId = ""
	@objc public dynamic var groupId = ""
	@objc public dynamic var sender : User?
	@objc public dynamic var title = ""
	@objc public dynamic var message = ""
	@objc public dynamic var expiry : Int64 = 0
}
