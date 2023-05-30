//
//  LoginViewModel.swift
//  GNT
//
//  Created by Shaneen on 5/28/23.
//

import Foundation

class LoginViewModel {
    
    var errorMsg = "Something went wrong, Please try again later!"
    
   
    var updateUI: (()->())?
    var didLogout: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private let userInfo = UserInformation()
    
    func login(email: String, password: String){
        showLoading?()
        AlamofireBuilder().login(email: email, password: password) { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.userInfo.storeData(user: model)
                    self.updateUI?()
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
    
   func refresh(){

        showLoading?()
        AlamofireBuilder().refresh() { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.userInfo.storeData(user: model)
                    self.updateUI?()
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
     func logout(){

        showLoading?()
        AlamofireBuilder().logout() { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.didLogout?()
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
    
   
}
