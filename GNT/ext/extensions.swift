//
//  extensions.swift
//  GNT
//
//  Created by Shaneen on 5/28/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func stop(button: UIButton, title: String) {
        self.stopAnimating()
        button.setTitle(title, for: .normal)
        button.isEnabled = true
    }
    func start(button: UIButton) {
        self.startAnimating()
        button.setTitle("", for: .normal)
        button.isEnabled = false
    }
}
extension UITextField {
fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
    }else{
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
    }
}

func enablePasswordToggle(){
    let button = UIButton(type: .system)
    setPasswordToggleImage(button)
    button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 10)
    button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
    var config = UIButton.Configuration.plain()
     config.imagePadding = 20
     button.configuration = config
}
@IBAction func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
}
}
