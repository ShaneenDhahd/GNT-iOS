//
//  LandingViewController.swift
//  GNT
//
//  Created by Shaneen on 5/30/23.
//

import UIKit

class LandingViewController: UIViewController {

    let loginVM = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkToken()
        // Do any additional setup after loading the view.
    }
    
    private func checkToken(){
        loginVM.refresh()
        loginVM.updateUI = { [self] in
            navigateTo(id:"forms_id")
        }
        loginVM.showError = { [self] in
            navigateTo(id:"login_id")
        }
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
