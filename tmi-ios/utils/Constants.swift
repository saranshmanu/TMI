//
//  Constants.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 22/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import UIKit

struct dateStructure {
    var date:Int = 0
    var month:Int = 0
    var year:Int = 0
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
}

class Constants {
    
    public static let baseUrl = "https://api.tmivit.com"
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
    public static let fcmToken = "fcmToken"
    
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
    
    public static func getMonth(monthInNumber:Int) -> String {
        switch(monthInNumber) {
            case 1: return "January"
            case 2: return "Febuary"
            case 3: return "March"
            case 4: return "April"
            case 5: return "May"
            case 6: return "June"
            case 7: return "July"
            case 8: return "August"
            case 9: return "September"
            case 10: return "October"
            case 11: return "November"
            case 12: return "December"
            default: return ""
        }
    }
    
    public static func findDate(milliSeconds:Int) -> dateStructure {
        let d = Date.init(timeIntervalSince1970: TimeInterval(milliSeconds/1000))
        var flag:dateStructure = dateStructure()
        let calendar = Calendar.current
        flag.year = calendar.component(.year, from: d)
        flag.month = calendar.component(.month, from: d)
        flag.date = calendar.component(.day, from: d)
        flag.hour = calendar.component(.hour, from: d)
        flag.minutes = calendar.component(.minute, from: d)
        flag.seconds = calendar.component(.second, from: d)
        return flag
    }
}

