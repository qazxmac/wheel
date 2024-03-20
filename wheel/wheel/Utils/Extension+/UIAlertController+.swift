//
//  UIAlertController+.swift
//  wheel
//
//  Created by admin on 20/03/2024.
//

import UIKit

extension UIAlertController {
    typealias AlertActionHandler = () -> Void

    static func showAlertWithCancelAndUpdate(from viewController: UIViewController, title: String?, message: String?, updateButtonTitle: String, updateHandler: AlertActionHandler?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: updateButtonTitle, style: .default) { _ in
            updateHandler?()
        }
        alertController.addAction(updateAction)
        
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
