//
//  NetworkAPI.swift
//  tmi-ios
//
//  Created by Rakshith Ravi on 22/12/17.
//  Copyright © 2017 Rakshith Ravi. All rights reserved.
//

import Alamofire
import PromiseKit
import SwiftyJSON

class NetworkAPI {
    
    public class PublicAPI {
		
		public static func signIn(userId: String, password: String) -> Promise<JSON> {
			return publicCall(
				route: "/auth/signIn",
				params: [
					Constants.userId: userId,
					Constants.password: password
				]
			)
		}
		
		public static func forgotPassword(email: String) -> Promise<JSON> {
			return publicCall(
				route: "/auth/forgotPassword",
				params: [
					Constants.email: email
				]
			)
		}
		
		public static func getAccessToken(authToken: String) -> Promise<JSON> {
			return firstly {
				Alamofire.request(
					NetworkAPI.getUrl(route: "/auth/getAccessToken"),
					method: .post,
					parameters: [:],
					encoding: URLEncoding.default,
					headers: [
						Constants.authToken: Data.authToken
					]
				).response()
			}.then { data -> Promise<JSON> in
				if data.1.statusCode == 200 {
					return Promise().then { _ in
						return try! JSON(data: data.2);
					}
				} else {
					// TODO Execute an event to make it logout
					return Promise().then {
						return JSON();
					};
				}
			}
		}
		
        private static func publicCall(route: String, params: Parameters) -> Promise<JSON> {
            return firstly {
                Alamofire.request(
                    NetworkAPI.getUrl(route: route),
                    method: .post,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: [:]
                ).response()
            }.then { data -> Promise<JSON> in
				return Promise().then { _ in
					return try! JSON(data: data.2);
				}
            }
        }
    }
    
    public class PrivateAPI {
		
		public static func getProfile() -> Promise<JSON> {
			return privateCall(
				route: "/user/profile",
				params: [:]
			)
		}
		
		public static func getSessions(clubId: String) -> Promise<JSON> {
			return privateCall(
				route: "/info/sessions",
				params: [
					Constants.clubId: clubId
				]
			)
		}
		
		public static func getRoles(sessionId: String) -> Promise<JSON> {
			return privateCall(
				route: "/info/roles",
				params: [
					Constants.sessionId: sessionId
				]
			)
		}
		
		public static func getUsers(clubId: String) -> Promise<JSON> {
			return privateCall(
				route: "/info/members",
				params: [
					Constants.clubId: clubId
				]
			)
		}
		
		public static func getAttendance() -> Promise<JSON> {
			return privateCall(
				route: "/info/attendance",
				params: [:]
			)
		}
		
		public static func getAnnouncements() -> Promise<JSON> {
			return privateCall(
				route: "/info/announcements",
				params: [:]
			)
		}
		
		public static func updateFCMToken(fcmToken: String) -> Promise<JSON> {
			return privateCall(
				route: "/update/fcmToken",
				params: [
					Constants.fcmToken: fcmToken
				]
			)
		}
		
		private static func privateCall(route: String, params: Parameters) -> Promise<JSON> {
			return firstly {
				Alamofire.request(
					NetworkAPI.getUrl(route: route),
					method: .post,
					parameters: params,
					encoding: URLEncoding.default,
					headers: [
						Constants.accessToken: Data.accessToken
					]
				).response()
			}.then { data -> Promise<JSON> in
				if data.1.statusCode == 401 {
					return PublicAPI.getAccessToken(authToken: Data.authToken).then { tokenData -> Promise<JSON> in
						if tokenData[Constants.success].bool == true {
							Data.accessToken = tokenData[Constants.accessToken].string!
							return privateCall(route: route, params: params)
						} else {
							return Promise().then { _ in
								return tokenData
							}
						}
					}
				} else {
					return Promise().then {
						return try! JSON(data: data.2);
					}
				}
			}
		}
    }
    
    public static func getUrl(route: String) -> String {
        return Constants.baseUrl + route;
    }
}
