//
//  UserInformation.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

import Foundation
import RealmSwift

class UserInformation {
    
    static var user: LoginModel? = nil
    
    var realm: Realm!
    
    static var didSelectLocation: Bool = false
    static var lat: Double? = nil
    static var long: Double? = nil
    
    init(){
        realm = try! Realm()
        
        UserInformation.user = getUser()
    }
    
    func storeData(user: LoginModel){
        try! realm.write({
            clearCache()
            let loginRealm = LoginRealm()
            loginRealm.loginModel = user
            print("login realm model \(loginRealm.loginModel), \(user)")
            realm.add(loginRealm)
        })
    }
    
    func getUser() -> LoginModel? {
        let realmData = realm.object(ofType: LoginRealm.self, forPrimaryKey: "userRealm")
        if let loginRealmObject = realmData?.loginModel {
            return loginRealmObject
        } else {
            return nil
        }
    }
    
    func clearCache() {
        let loginRealmObject = realm.object(ofType: LoginRealm.self, forPrimaryKey: "userRealm")
        if let loginRealmObject = loginRealmObject {
            realm.delete(loginRealmObject.self)
        }
    }
    func logOut(){
        try! realm.write({
            let loginRealmObject = realm.object(ofType: LoginRealm.self, forPrimaryKey: "userRealm")
            if let loginRealmObject = loginRealmObject {
                realm.delete(loginRealmObject.self)
            }
        })
    }
    
}

