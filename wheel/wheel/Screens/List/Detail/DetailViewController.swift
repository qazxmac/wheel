//
//  DetailViewController.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tbvDetail: UITableView!
    
    
    let vm: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        tbvDetail.dataSource = self
        tbvDetail.delegate = self
        tbvDetail.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tbvDetail.register(UINib(nibName: "DetailMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailMoreTableViewCell")
        tbvDetail.rowHeight = 60.0
        tfTitle.delegate = self
        vm.delegate = self
        vm.fetchPieces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfTitle.text = vm.parentTitle
        if let title = tfTitle.text, title.isEmpty {
            tfTitle.becomeFirstResponder()
        }
        if vm.parentTitle == "Unnamed" {
            tfTitle.placeholder = "Unnamed"
            tfTitle.text = ""
            tfTitle.becomeFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tbvDetail.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 30, right: 0)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        tbvDetail.contentInset = UIEdgeInsets.zero
    }


    @IBAction func tapBack(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func tapClose(_ sender: Any) {
        vm.save()
        if let nav = self.navigationController {
            nav.dismiss(animated: true)
        }
        self.dismiss(animated: true)
    }
    
    
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Cell cuoi la dau +
        if indexPath.row == vm.items.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMoreTableViewCell", for: indexPath) as! DetailMoreTableViewCell
            cell.onTapPlus = { [weak self] in
                self?.vm.createNewPeace()
     
            }
            return cell
        }
        
        // Cac cell con lai
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        
        let data = vm.items[indexPath.row]
        cell.tfValue.text = data.content
        cell.tfValue.placeholder = "Option \(indexPath.row+1)"
        
        cell.onTapDelete = { [weak self] in
            self?.vm.removePiece(at: indexPath.row)
        }
        
        cell.onChangeValue = {[weak self] text in
            print(text)
            self?.vm.updatePiece(value: text, at: indexPath.row)
        }
        
        cell.tfValue.delegate = self
        return cell
    }
    
    
}

extension DetailViewController: DetailViewModelDelegate {
    func didChangeItems() {
        tbvDetail.reloadData()
        print("============= \(vm.items)")
    }
}

extension DetailViewController: UITextFieldDelegate {
    
    // Phương thức gọi khi nút "Done" trên bàn phím được bấm
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Ẩn bàn phím
        textField.resignFirstResponder()
        
        // Xử lý logic khi bấm nút "Done" ở đây
        
        return true
    }
    
    // Phương thức gọi mỗi khi có ký tự nhập vào textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField != tfTitle { return true }
        
        // Lấy giá trị của textField sau khi nhập ký tự mới
        if let text = textField.text,
           let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            
            // Xử lý logic với updatedText ở đây
            
            print(updatedText)
            vm.parentTitle = updatedText
        }
        
        return true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
