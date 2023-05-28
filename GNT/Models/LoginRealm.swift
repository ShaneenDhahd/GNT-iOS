//
//  LoginRealm.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

import Foundation
import RealmSwift

class LoginRealm : Object {

    @objc dynamic var id : String = "userRealm"

    override class func primaryKey() -> String? {
        "id"
    }
    @objc private dynamic var structData:Data? = nil
    
    var loginModel : LoginModel? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(LoginModel.self, from: data)
            }
            return nil
        }
        set {
            structData = try? JSONEncoder().encode(newValue)
        }
    }
}
