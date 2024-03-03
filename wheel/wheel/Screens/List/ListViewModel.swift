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
    
    func add(content: String) {
        do {
            let repository = try RealmRepository()
            // Thêm một đối tượng CircleModel vào cơ sở dữ liệu
            try! repository.addCircle(content: content)
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
    
    func edit(id: Int, newContent: String) {
        do {
            let repository = try RealmRepository()
            // Cập nhật nội dung của đối tượng CircleModel có id là 1
            try repository.updateCircleContent(id: id, newContent: newContent)
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
    }
    
    func delete(id: Int) {
        do {
            let repository = try RealmRepository()
            // Xóa đối tượng CircleModel có id là 1
            try repository.deleteCircle(id: id)
        } catch {
            // Xử lý lỗi
            print("Error: \(error)")
        }
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
