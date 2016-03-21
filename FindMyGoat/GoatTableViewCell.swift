//
//  GoatTableViewCell.swift
//  FindMyGoat
//
//  Created by Guo Xiaoyu on 3/5/16.
//  Copyright © 2016 Xiaoyu Guo. All rights reserved.
//

import UIKit

class GoatTableViewCell: UITableViewCell {
    
    var goat : Goat! {
        didSet(newValue) {
            updateUI()
        }
    }

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI() {
        nameTextField.text = goat.name
        ageTextField.text = "\(goat.age)"
        if goat.imgData != nil {
            imgView.image = UIImage.init(data: goat.imgData!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
