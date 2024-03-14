//
//  DetailViewModel.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didChangeItems()
}

final class DetailViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    var items: [CircleDetailModel] = []
    var itemsNeedDelete: [String] = []
    var parentItem: CircleModel = CircleModel() {
        didSet {
            parentTitle = parentItem.content
        }
    }
    var parentTitle: String = "Unnamed"
    
    func createNewPeace() {
        let newPiece = CircleDetailModel()
        newPiece.idQuestion = parentItem.id
        
        items.append(newPiece)
        delegate?.didChangeItems()
    }
    
    func removePiece(at index: Int) {
        // Luu id can xoa
        itemsNeedDelete.append(items[index].id)
        // Xoa item khoi items
        items.remove(at: index)
        delegate?.didChangeItems()
    }
    
    func updatePiece(value: String, at index: Int) {
        let newValue = CircleDetailModel()
        newValue.id = items[index].id
        newValue.idQuestion = items[index].idQuestion
        newValue.content = value
        items.remove(at: index)
        items.insert(newValue, at: index)
    }
    
    
    func fetchPieces() {
        do {
            let repository = try RealmRepository()
            let pieces = try repository.fetchPieces(idQuestion: self.parentItem.id)
            let fetchedData = Array(pieces)
            if !fetchedData.isEmpty {
                self.items = fetchedData
            } else {
                // Add 4 default empty pieces
                let piece0 = CircleDetailModel()
                piece0.idQuestion = parentItem.id
                let piece1 = CircleDetailModel()
                piece1.idQuestion = parentItem.id
                let piece2 = CircleDetailModel()
                piece2.idQuestion = parentItem.id
                let piece3 = CircleDetailModel()
                piece3.idQuestion = parentItem.id
                self.items = [piece0,piece1,piece2,piece3]
            }
            delegate?.didChangeItems()
            print(self.items)
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
    
    func save() {
        do {
            
            let repository = try RealmRepository()
            // Luu Title
            let parrent = CircleModel()
            parrent.id = parentItem.id
            parrent.content = self.parentTitle
            try repository.addCircle(circle: parrent)
            
            // Luu gia tri
            try items.forEach { item in
                try repository.addCircleDetail(itemOption: item)
            }
            
            // Xoa item khong nam trong mang items
            try itemsNeedDelete.forEach { id in
                try repository.deleteCircleDetail(id: id)
            }
            UserDefaults.standard.set(self.parentItem.id, forKey: "selected.id")
            NotificationCenter.default.post(name: Notification.Name("RELOAD_HOME"), object: nil)
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
    
    func loadDefault() {
        
    }
}
