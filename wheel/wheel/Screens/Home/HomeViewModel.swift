//
//  HomeViewModel.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import Foundation



protocol HomeViewModelProtocol {
    var models: [CircleDetailModel] { get set }
    var result: CircleDetailModel? { get }
    var titleList: String { get set }
    func updateResult(id: String)
}

protocol HomeViewModelDelegate: AnyObject {
    func didSetModels()
    func didSetResult()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    weak var delegate: HomeViewModelDelegate?
    
    var result: CircleDetailModel? {
        didSet {
            delegate?.didSetResult()
        }
    }
    
    var models: [CircleDetailModel] = [] {
        didSet {
            print("------ \(models)")
            result = nil
            delegate?.didSetModels()
        }
    }
    
    var titleList: String = ""
    
    func updateResult(id: String) {
        if let index = models.firstIndex(where:{ $0.id == id }) {
            self.result = models[index]
        }
    }
    
    func fetchPieces() {
        do {
            let repository = try RealmRepository()
            let id = UserDefaults.standard.string(forKey: "selected.id") ?? ""
            titleList = try repository.fetCircle(id: id).last?.content ?? ""
            
            let pieces = try repository.fetchPieces(idQuestion: id)
            let fetchedData = Array(pieces)
            if !fetchedData.isEmpty {
                models = fetchedData
                
            } else {
                print("empty")
            }
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
}
