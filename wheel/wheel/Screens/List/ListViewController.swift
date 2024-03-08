//
//  ListViewController.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import UIKit
import Lottie

class ListViewController: UIViewController {
    
    @IBOutlet weak var lottieButton: LottieAnimationView!
    
    @IBOutlet weak var tbvList: UITableView!
    
    let vm: ListViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieButton.loopMode = .loop

        vm.delegate = self
        tbvList.dataSource = self
        tbvList.delegate = self
        tbvList.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tbvList.rowHeight = 60.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lottieButton.play()
        self.vm.loadAll()
    }
    
    func moveToDetail(selectedItem: CircleModel) {
        let vc = DetailViewController()
        vc.vm.parentItem = selectedItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        moveToDetail(selectedItem: CircleModel())
    }
    
    @IBAction func tapClose(_ sender: Any) {
        if let nav = self.navigationController {
            nav.dismiss(animated: true)
        }
        self.dismiss(animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let selectedItem = vm.items[indexPath.row]
        cell.lblTitle.text = selectedItem.content
        cell.onTap = { [weak self] in
            self?.moveToDetail(selectedItem: selectedItem)
        }
        cell.onDelete = { [weak self] in
            self?.vm.delete(at: indexPath.row)
        }
        return cell
    }
    
    
}

extension ListViewController: ListViewModelDetelage {
    func didChangeItems() {
        self.tbvList.reloadData()
    }
    
}
