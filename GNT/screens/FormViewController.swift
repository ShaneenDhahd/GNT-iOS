//
//  FormViewController.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

import UIKit
import GoogleMaps

class FormViewController: UITableViewController {
    
    let formVM = FormViewModel()
    
    @IBOutlet weak var nameField: UITextField!
    var name = ""
    
    @IBOutlet weak var usernameField: UITextField!
    var username = ""
    @IBOutlet weak var commentField: UITextField!
    var comment = ""
    
    @IBOutlet weak var govIndicator: UIActivityIndicatorView!
    @IBOutlet weak var govPicker: UIPickerView!
    var selectedGovernment = 1
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var submitIndicator: UIActivityIndicatorView!
    
    var listOfGov: GovernmentsModel = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        submitBtn.isEnabled = UserInformation.didSelectLocation
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews(){
        hideKeyboardWhenTappedAround()
        navigationController?.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.white

        govPicker.delegate = self
        govPicker.dataSource = self

        formVM.getGovs()
        formVM.updateGovernments = { govs in
            self.listOfGov = govs
            DispatchQueue.main.async {
                self.govPicker.reloadAllComponents()
                self.govIndicator.stopAnimating()
                print("table view \(self.listOfGov[1].govName)")
            }
        }
        
        formVM.showError = {
            DispatchQueue.main.async { [self] in
                submitIndicator.stop(button: submitBtn, title: "Submit")
            }
        }
        formVM.submitedData = { submitModel in
            DispatchQueue.main.async { [self] in
                submitIndicator.stop(button: submitBtn, title: "Submit")
                clearFields()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func clearFields(){
        DispatchQueue.main.async { [self] in
            usernameField.text = ""
            nameField.text = ""
            commentField.text = ""
            govPicker.selectRow(0, inComponent: 0, animated: true)
            submitBtn.isEnabled = false
            UserInformation.lat = nil
            UserInformation.long = nil
            UserInformation.didSelectLocation = false
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        validateFields {
            showProgress()
            let latlong = "\(UserInformation.lat!), \(UserInformation.long!)"
            formVM.submit(name: name, username: username, gov: "\(selectedGovernment)", comment: comment, gps: latlong)
            print("its done")
        }
    }
    
    private func showProgress(){
        DispatchQueue.main.async { [self] in
            submitIndicator.start(button: submitBtn)
        }
    }
    
    private func validateFields(completion: ()->() ){
        if let name = nameField.text, let username = usernameField.text, let comment = commentField.text {
            if name.isEmpty {
                nameField.shake(withTranslation: 10)
            }
            if username.isEmpty {
                usernameField.shake(withTranslation: 10)
            }
            if comment.isEmpty {
                commentField.shake(withTranslation: 10)
            }
            if !comment.isEmpty && !username.isEmpty, !name.isEmpty {
                self.name = name
                self.username = username
                self.comment = comment
                completion()
            }
        }
    }
    

}
extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        listOfGov.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("table view \(listOfGov[row].govName)")
        return listOfGov[row].govName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGovernment = listOfGov[row].govID
    }
}
