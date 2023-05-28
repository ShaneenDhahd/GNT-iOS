//
//  LoginViewModel.swift
//  GNT
//
//  Created by Shaneen on 5/28/23.
//

import Foundation
import UIKit
import RealmSwift

class LoginViewModel {
    
    var errorMsg = "Something went wrong, Please try again later!"
    
   
    var updateUI: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    func login(email: String, password: String){
        showLoading?()
        AlamofireBuilder().login(email: email, password: password) { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.storeData(user: model)
                    self.updateUI?()
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
    
    
    private func storeData(user: LoginModel){
        let realm = try! Realm()
        try! realm.write({
            clearCache(realm)
            let loginRealm = LoginRealm()
            loginRealm.loginModel = user
            print("login realm model \(loginRealm.loginModel), \(user)")
            realm.add(loginRealm)
        })
    }
    
    func getUser() -> LoginModel? {
        let realm = try! Realm()
        let realmData = realm.object(ofType: LoginRealm.self, forPrimaryKey: "userRealm")
        if let loginRealmObject = realmData?.loginModel {
            return loginRealmObject
        } else {
            return nil
        }
    }
    private func clearCache(_ realm: Realm) {
        let loginRealmObject = realm.object(ofType: LoginRealm.self, forPrimaryKey: "userRealm")
        if let loginRealmObject = loginRealmObject {
            realm.delete(loginRealmObject.self)
        }
    }
    
}
