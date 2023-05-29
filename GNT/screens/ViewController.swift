//
//  ViewController.swift
//  GNT
//
//  Created by Shaneen on 5/28/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    var emailText = ""
    var passwordText = ""
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewStuff()
    }
  
    private func initViewStuff(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        email.delegate = self
        password.delegate = self
        password.enablePasswordToggle()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    @IBAction func login(_ sender: UIButton) {
        if validateFields() {
            viewModel.login(email: emailText, password: passwordText)
            loadingIndicator.start(button: sender)
            self.errorMessage.isHidden = true
            errorMessage.text = "Wrong email or password"
        } else {
            errorMessage.text = "all fields are required"
            errorMessage.isHidden = false
        }
        handleLoginCallback()
        
    }

    private func handleLoginCallback(){
        viewModel.showError = { [self] in
            loadingIndicator.stop(button: loginBtn, title: "Login")
            self.errorMessage.isHidden = false
        }
        viewModel.updateUI = { [self] in
            loadingIndicator.stop(button: loginBtn, title: "Login")
            navigateToForm()
            self.errorMessage.isHidden = true
        }

    }
    
    private func navigateToForm(){
        DispatchQueue.main.async { [self] in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let formViewController = storyboard.instantiateViewController(withIdentifier: "form") as! FormViewController
            navigationController?.pushViewController(formViewController, animated: true)        }
    }
    
    private func validateFields() -> Bool {
        if let email = email.text, let password = password.text {
            emailText = email
            passwordText = password
            return !email.isEmpty && !password.isEmpty
        }
        return false
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField) {
        case email:
            password.becomeFirstResponder()
            updateFocusIfNeeded()
        case password: view.endEditing(true)
            
        default:
            return true
        }
        return true
    }
}
