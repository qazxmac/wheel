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
    var items: [CircleDetailModel] = [
        CircleDetailModel(),
        CircleDetailModel(),
    ] {
        didSet {
            delegate?.didChangeItems()
        }
    }
    var parentItem: CircleModel = CircleModel()
    
    
    
    func createNewPeace() {
        let newPiece = CircleDetailModel()
        newPiece.idQuestion = parentItem.id
        
        items.append(newPiece)
    }
    
    func removePiece(at index: Int) {
        items.remove(at: index)
    }
}
