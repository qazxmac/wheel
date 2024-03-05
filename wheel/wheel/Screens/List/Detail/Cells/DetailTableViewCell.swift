//
//  DetailTableViewCell.swift
//  wheel
//
//  Created by admin on 04/03/2024.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var onTapDelete: (()->())?
    var onChangeValue: ((String) -> ())?
    @IBOutlet weak var tfValue: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Thêm target cho sự kiện editingChanged
        tfValue.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }


    @IBAction func tapDelete(_ sender: Any) {
        onTapDelete?()
    }
    
    @objc func textFieldDidChange() {
        // Lấy giá trị của textField
        if let text = tfValue.text {
            // Xử lý logic với giá trị text ở đây
            onChangeValue?(text)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tfValue.text?.removeAll()
    }
}
