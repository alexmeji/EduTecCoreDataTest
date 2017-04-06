//
//  PersonCell.swift
//  CoreDataTest
//
//  Created by Alex Mejicanos on 3/04/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet var firstName: UILabel?
    @IBOutlet var lastname: UILabel?
    @IBOutlet var username: UILabel?
    @IBOutlet var sex: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
