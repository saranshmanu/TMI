//
//  Constants.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 22/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

class Constants {
	
    public static let baseUrl = ""
	public static let accessToken = "accessToken"
	public static let authToken = "authToken"
	public static let success = "success"
	public static let loggedIn = "loggedIn"
	public static let userId = "userId"
	public static let password = "password"
	public static let username = "username"
	public static let name = "name"
	public static let email = "email"
	public static let dob = "dob"
	public static let clubId = "clubId"
	public static let error = "error"
	public static let message = "message"
	public static let sessionId = "sessionId"
	public static let date = "date"
	public static let wordOfDay = "wordOfDay"
	public static let wordMeaning = "wordMeaning"
	public static let wordUsage = "wordUsage"
	public static let genEvalReport = "genEvalReport"
	public static let sessions = "sessions"
	public static let roles = "roles"
	public static let role = "role"
	public static let members = "members"
	public static let roleId = "roleId"
	public static let notes = "notes"
	public static let topic = "topic"
	public static let time = "time"
	public static let ahs = "ahs"
	public static let grammarianReport = "grammarianReport"
	public static let evaluatee = "evaluatee"
	public static let attendance = "attendance"
	public static let announcements = "announcements"
	public static let messageId = "messageId"
	public static let title = "title"
	
	public static let ROLE_SPEAKER = "speaker"
	public static let ROLE_EVALUATOR = "evaluator"
	public static let ROLE_TIMER = "timer"
	public static let ROLE_AH_COUNTER = "ah-counter"
	public static let ROLE_GRAMMARIAN = "grammarian"
	public static let ROLE_TTM = "ttm"
	public static let ROLE_TT_SPEAKER = "tt-speaker"
	public static let ROLE_GENERAL_EVALUATOR = "gen-evaluator"
	public static let ROLE_TMOD = "tmod"
	public static let ROLE_OTHER = "other"
	
	public static let ROLE_SPEAKER_FULL = "Speaker"
	public static let ROLE_EVALUATOR_FULL = "Evaluator"
	public static let ROLE_TIMER_FULL = "Timer"
	public static let ROLE_AH_COUNTER_FULL = "Ah Counter"
	public static let ROLE_GRAMMARIAN_FULL = "Grammarian"
	public static let ROLE_TTM_FULL = "Table Topic Master"
	public static let ROLE_TT_SPEAKER_FULL = "Table Topic Speaker"
	public static let ROLE_GENERAL_EVALUATOR_FULL = "General Evaluator"
	public static let ROLE_TMOD_FULL = "Toastmaster Of the Day"
	public static let ROLE_OTHER_FULL = "Other"
	
	public static func getFullRole(role: String) -> String {
		switch(role) {
			case ROLE_SPEAKER:
				return ROLE_SPEAKER_FULL
			case ROLE_EVALUATOR:
				return ROLE_EVALUATOR_FULL
			case ROLE_TIMER:
				return ROLE_TIMER_FULL
			case ROLE_AH_COUNTER:
				return ROLE_AH_COUNTER_FULL
			case ROLE_GRAMMARIAN:
				return ROLE_GRAMMARIAN_FULL
			case ROLE_TTM:
				return ROLE_TTM_FULL
			case ROLE_TT_SPEAKER:
				return ROLE_TT_SPEAKER_FULL
			case ROLE_GENERAL_EVALUATOR:
				return ROLE_GENERAL_EVALUATOR_FULL
			case ROLE_TMOD:
				return ROLE_TMOD_FULL
			default:
				return ROLE_OTHER_FULL
		}
	}
}
