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
    var selectedItem: CircleModel? { get set }
    func updateResult(id: String)
    func loadData()
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
    
    var selectedItem: CircleModel?
    var listCircles: [CircleModel] = []
    
    func loadData() {
        fetchCircle()
        fetchPieces()
    }
    
    func updateResult(id: String) {
        if let index = models.firstIndex(where:{ $0.id == id }) {
            self.result = models[index]
        }
    }
    
    func fetchCircle() {
        do {
            let repository = try RealmRepository()
            // Lấy danh sách tất cả các đối tượng CircleModel
            let circles = repository.getAllCircles()
            self.listCircles = Array(circles)
            for circle in circles {
                print(circle.id, circle.content)
            }
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
    
    func fetchPieces() {
        do {
            let repository = try RealmRepository()
            var idQuestion: String?
            if let id = UserDefaults.standard.string(forKey: "selected.id"),
                let fetchedItem = try repository.fetCircle(id: id).last {
                selectedItem = fetchedItem
                idQuestion = id
            } else {
                if let idQuestion = listCircles.first?.id {
                    UserDefaults.standard.setValue(idQuestion, forKey: "selected.id")
                    fetchPieces()
                }
            }
            guard let id = idQuestion else { return }
            let pieces = try repository.fetchPieces(idQuestion: id)
            let fetchedData = Array(pieces)
            if !fetchedData.isEmpty {
                models = fetchedData
                
            } else {
                print("empty-------------")
            }
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
}
