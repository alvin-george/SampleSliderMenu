//
//  SideMenuProfileTableCell.swift
//  LaCart_iOSNative
//
//  Created by Pushpam Group on 10/03/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

class SideMenuProfileTableCell: UITableViewCell {

    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var useranameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
