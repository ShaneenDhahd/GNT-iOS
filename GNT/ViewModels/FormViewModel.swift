//
//  FormViewModel.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

import Foundation
import Foundation

class FormViewModel {
    
    var errorMsg = "Something went wrong, Please try again later!"
    
   
    var updateGovernments: ((GovernmentsModel)->())?
    var submitedData: ((SubmitModel)->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private let userInfo = UserInformation()
    
    func getGovs(){
        showLoading?()
        AlamofireBuilder().getGovs() { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.updateGovernments?(model)
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
    
  
    func submit(name: String, username: String, gov: String, comment: String, gps: String){
        showLoading?()
        AlamofireBuilder().submitForm(name: name, username: username, gov: gov, comment: comment, gps: gps) { response in
            self.hideLoading?()
            switch(response){
            case .success(let model):
                if let model = model {
                    self.submitedData?(model)
                }
            case .failure(_):
                self.showError?()
            }
        }
    }
    

   
}
