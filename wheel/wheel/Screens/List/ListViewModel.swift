//
//  ListViewModel.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import Foundation



protocol ListViewModelDetelage: AnyObject {
    func didChangeItems()
}

final class ListViewModel {
    
    weak var delegate: ListViewModelDetelage?
    
    var items: [CircleModel] = [] {
        didSet {
            delegate?.didChangeItems()
        }
    }
    
    var selectedItem: CircleModel = CircleModel()
    
//    func add(content: String) {
//        do {
//            let repository = try RealmRepository()
//            // Thêm một đối tượng CircleModel vào cơ sở dữ liệu
//            try! repository.addCircle(content: content)
//        } catch {
//            // Xử lý lỗi
//            print("Error: \(error)")
//        }
//    }
//    
//    func edit(id: Int, newContent: String) {
//        do {
//            let repository = try RealmRepository()
//            // Cập nhật nội dung của đối tượng CircleModel có id là 1
//            try repository.updateCircleContent(id: id, newContent: newContent)
//        } catch {
//            // Xử lý lỗi
//            print("Error: \(error)")
//        }
//    }
    
    func delete(at index: Int) {
        // Remove on local DB
        let id = items[index].id
        do {
            let repository = try RealmRepository()
            try repository.deleteCircle(id: id)
        } catch {
            print("Error: \(error)")
        }
        // Remove on datasource array
        items.remove(at: index)
    }
    
    func loadAll() {
        do {
            let repository = try RealmRepository()
            // Lấy danh sách tất cả các đối tượng CircleModel
            let circles = repository.getAllCircles()
            self.items = Array(circles)
            for circle in circles {
                print(circle.id, circle.content)
            }
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
}
