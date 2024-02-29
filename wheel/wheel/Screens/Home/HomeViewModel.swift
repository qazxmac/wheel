//
//  HomeViewModel.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var models: [CircleModel] { get set }
    var result: CircleModel? { get }
    func updateResult(id: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func didSetModels()
    func didSetResult()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    weak var delegate: HomeViewModelDelegate?
    
    var result: CircleModel? {
        didSet {
            delegate?.didSetResult()
        }
    }
    
    var models: [CircleModel] = [] {
        didSet {
            delegate?.didSetModels()
        }
    }
    
    func updateResult(id: Int) {
        if let index = models.firstIndex(where:{ $0.id == id }) {
            self.result = models[index]
        }
    }
}
