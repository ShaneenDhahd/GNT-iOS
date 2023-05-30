//
//  FormCell.swift
//  GNT
//
//  Created by Shaneen on 5/30/23.
//

import UIKit

class FormCell: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(form: FormUser?){
        if let form = form {
            id.setText("#\(form.id)")
            username.setText("@\(form.username)")
            name.setText(form.name)
            date.setText(form.createdAt.formatDate())
        }
    }
    
}
