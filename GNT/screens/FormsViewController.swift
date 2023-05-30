//
//  FormsViewController.swift
//  GNT
//
//  Created by Shaneen on 5/30/23.
//

import UIKit

class FormsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: UIButton) {
        UserInformation().logOut()
        navigateTo(id: "login_id")
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
