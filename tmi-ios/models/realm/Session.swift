//
//  Session.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 23/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import RealmSwift

class Session : Object {
	
	@objc public dynamic var sessionId = ""
	@objc public dynamic var date : Int64 = 0
	@objc public dynamic var clubId = ""
	@objc public dynamic var wordOfDay = ""
	@objc public dynamic var wordMeaning = ""
	@objc public dynamic var wordUsage = ""
	@objc public dynamic var genEvalReport = ""
}
