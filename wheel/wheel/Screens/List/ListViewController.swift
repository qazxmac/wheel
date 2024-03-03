//
//  ListViewController.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tbvList: UITableView!
    
    let vm: ListViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        vm.delegate = self
        tbvList.dataSource = self
        tbvList.delegate = self
        tbvList.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tbvList.rowHeight = 60.0
        vm.add(content: "aaaaaaaaa")
        self.vm.loadAll()
        
    }
    
    func moveToDetail() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        moveToDetail()
    }
    
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.lblTitle.text = vm.items[indexPath.row].id
        cell.onTap = { [weak self] in
            self?.moveToDetail()
        }
        return cell
    }
    
    
}

extension ListViewController: ListViewModelDetelage {
    func didChangeItems() {
        self.tbvList.reloadData()
    }
    
}
