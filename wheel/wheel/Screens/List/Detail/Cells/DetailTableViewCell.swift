//
//  DetailTableViewCell.swift
//  wheel
//
//  Created by admin on 04/03/2024.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var onTapDelete: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBAction func tapDelete(_ sender: Any) {
        onTapDelete?()
    }
    
}
