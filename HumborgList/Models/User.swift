//
//  User.swift
//  HumborgList
//
//  Created by Amir Daliri on 3/22/18.
//  Copyright © 2018 AmirDaliri. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, ResponseObjectSerializable {
    
    var id: Int?
    var appUserID: Int?
    var fullName: String?
    var mobile: String?
    var dob: String?
    var uuid: String?
    var email: String?
    var agencyId: Int?
    var activated: Bool?
    
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: AnyObject] else {
            return
        }
        self.id = representation["$id"] as?  Int
        self.appUserID = representation["AppUserID"] as? Int
        self.fullName = representation["FullName"] as? String
        self.mobile = representation["Mobile"] as? String
        self.dob = representation["BirthDay"] as? String
        self.uuid = representation["IMEI"] as? String
        self.email = representation["Email"] as? String
        self.agencyId = representation["AgencyID"] as? Int
        self.activated = representation["Activated"] as? Bool
    }

    
    static func setToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: Constants.UserDefaults.apiToken)
    }
    static func getToken() -> String? {
        return UserDefaults.standard.object(forKey: Constants.UserDefaults.apiToken) as? String
    }
    
    static func removeCacheValue(_ forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
    static func logOut() {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
    
    static func isUser() -> Bool {
        if getToken() != nil {
            return true
        } else {
            return false
        }
    }
    
}


