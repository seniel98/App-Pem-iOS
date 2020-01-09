//
//  UserTableViewCell.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 30/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var gi50: UILabel!
    @IBOutlet weak var cellLine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
