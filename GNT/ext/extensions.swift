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

extension UILabel {
    func setText(_ text: Any?){
        if let text = text {
            self.text = "\(text)"
        }
    }
}

extension String {
    func formatDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale()
        return dateFormatter.date(from: self)?.formatted()
    }
}

extension UITextField {
fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
    } else{
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
public extension UIView {

    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
               self.layer.borderColor = UIColor.red.cgColor
               self.layer.borderWidth = 1
               self.transform = CGAffineTransform(translationX: translation, y: 0)
           }

           propertyAnimator.addAnimations({
               self.transform = CGAffineTransform(translationX: 0, y: 0)
           }, delayFactor: 0.2)

           propertyAnimator.addCompletion { (_) in
               self.layer.borderWidth = 0
           }

           propertyAnimator.startAnimation()
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func navigateTo(id: String) {
        DispatchQueue.main.async { [self] in
            performSegue(withIdentifier: id, sender: self)
        }
    }
}
