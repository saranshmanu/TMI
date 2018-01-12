//
//  Attendance.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 23/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import RealmSwift

class Attendance : Object {
	
	@objc public dynamic var session : Session?
	@objc public dynamic var user : User?
	@objc public dynamic var attendanceImpl = ""
	public var attendance : Presence {
		get {
			if attendanceImpl == "present" {
				return .present
			} else {
				return .absent
			}
		}
		set(value) {
			if value == .present {
				attendanceImpl = "present"
			} else {
				attendanceImpl = "absent"
			}
		}
	}
	
	override static func ignoredProperties() -> [String] {
		return ["attendance"]
	}
}

enum Presence {
	case present
	case absent
	func toString() -> String {
		if self == .present {
			return "Present"
		}
		return "Absent"
	}
}
