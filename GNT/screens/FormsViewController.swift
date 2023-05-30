//
//  FormsViewController.swift
//  GNT
//
//  Created by Shaneen on 5/30/23.
//

import UIKit

class FormsViewController: UIViewController {
    
    @IBOutlet weak var formTableView: UITableView!
    
    var forms: [FormUser] = []
    
    let formsVM = FormViewModel()
    let userVM = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        getForms()
    }
    
    private func getForms(){
        formsVM.getForms()
        formsVM.getFormsData = { formsData in
            self.forms = formsData.data
            DispatchQueue.main.async {
                self.formTableView.reloadData()
            }
        }
    }

    
    private func initViews(){
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        formTableView.contentInset = insets

        formTableView.delegate = self
        formTableView.dataSource = self
        let nib = UINib(nibName: "FormCell", bundle: nil)
        self.formTableView.register(nib, forCellReuseIdentifier: "FormCell")
    }
    
    @IBAction func logout(_ sender: UIButton) {
        userVM.logout()
        userVM.didLogout = {
            UserInformation().logOut()
            self.navigateTo(id: "login_id")
        }
    }
    
    private func navigateToForm(lat: Double, long: Double){
        DispatchQueue.main.async { [self] in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let formViewController = storyboard.instantiateViewController(withIdentifier: "form_map_id") as! FormMapViewController
            formViewController.lat = lat
            formViewController.long = long
            navigationController?.pushViewController(formViewController, animated: true)        }
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
extension FormsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as! FormCell
        cell.setupData(form: forms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let formItem = forms[indexPath.row].gps.components(separatedBy: ", ")
        if let stringLat = formItem.first, let stringLong = formItem.last {
            let lat = Double(stringLat) ?? 0
            let long = Double(stringLong) ?? 0
            navigateToForm(lat: lat, long: long)
        }
        
    }
}
