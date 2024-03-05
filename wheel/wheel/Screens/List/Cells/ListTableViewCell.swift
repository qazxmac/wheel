//
//  ListTableViewCell.swift
//  wheel
//
//  Created by admin on 03/03/2024.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imvSelection: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var onTap: (() -> ())?
    var onDelete: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tapCell(_ sender: Any) {
        onTap?()
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        onDelete?()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblTitle.text = ""
    }
}
