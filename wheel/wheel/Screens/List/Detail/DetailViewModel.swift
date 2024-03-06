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
    var parentItem: CircleModel = CircleModel()
    
    init() {

    }
    
    
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
    
    func updatePiece(value: CircleDetailModel, at index: Int) {
        items.remove(at: index)
        items.insert(value, at: index)
    }
    
    
    func fetchPieces() {
        do {
            let repository = try RealmRepository()
            let pieces = try repository.fetchPieces(idQuestion: self.parentItem.id)
            let fetchedData = Array(pieces)
            if !fetchedData.isEmpty {
                self.items = fetchedData
            } else {
                // Add 2 default empty pieces
                let piece0 = CircleDetailModel()
                piece0.idQuestion = parentItem.id
                let piece1 = CircleDetailModel()
                piece1.idQuestion = parentItem.id
                self.items = [piece0,piece1]
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
            
            // Luu items
            let repository = try RealmRepository()
            try items.forEach { item in
                try repository.addCircleDetail(itemOption: item)
            }
            
            // Xoa item khong nam trong mang items
            try itemsNeedDelete.forEach { id in
                try repository.deleteCircleDetail(id: id)
            }
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
}