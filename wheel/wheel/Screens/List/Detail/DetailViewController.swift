//
//  DetailViewController.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import UIKit
import Lottie

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lottieButton: LottieAnimationView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tbvDetail: UITableView!
    
    
    let vm: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieButton.loopMode = .loop
        tbvDetail.dataSource = self
        tbvDetail.delegate = self
        tbvDetail.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tbvDetail.register(UINib(nibName: "DetailMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailMoreTableViewCell")
        tbvDetail.rowHeight = 60.0
        vm.delegate = self
        vm.fetchPieces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lottieButton.play()
        tfTitle.text = vm.parentItem.content
    }


    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapClose(_ sender: Any) {
        vm.save()
        if let nav = self.navigationController {
            nav.dismiss(animated: true)
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func tapSpace(_ sender: Any) {
        self.view.endEditing(true)
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
        
        cell.onTapDelete = { [weak self] in
            self?.vm.removePiece(at: indexPath.row)
        }
        
        cell.onChangeValue = {[weak self] text in
            print(text)
            data.content = text
            self?.vm.updatePiece(value: data, at: indexPath.row)
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
    

    
}
