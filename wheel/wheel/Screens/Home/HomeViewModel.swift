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
    var selectedItemID: String? { get set }
    func updateResult(id: String)
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
            print("------ \(models)")
            result = nil
            delegate?.didSetModels()
        }
    }
    
    var selectedItemID: String? {
        didSet {
            
        }
    }
    
    func updateResult(id: String) {
        if let index = models.firstIndex(where:{ $0.id == id }) {
            self.result = models[index]
        }
    }
}
