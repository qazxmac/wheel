import RealmSwift

class RealmRepository {
    private let realm: Realm
    
    init() throws {
        realm = try Realm()
    }
    
    // Thêm một đối tượng CircleModel vào cơ sở dữ liệu
    func addCircle(circle: CircleModel) throws {
        try realm.write {
            realm.add(circle, update: .modified)
        }
    }
    
    // Cập nhật nội dung của một đối tượng CircleModel
    func updateCircleContent(id: Int, newContent: String) throws {
        if let circle = realm.object(ofType: CircleModel.self, forPrimaryKey: id) {
            try realm.write {
                circle.content = newContent
            }
        }
    }
    
    // Xóa một đối tượng CircleModel
    func deleteCircle(id: String) throws {
        if let circle = realm.object(ofType: CircleModel.self, forPrimaryKey: id) {
            try realm.write {
                realm.delete(circle)
            }
        }
    }
    
    // Lấy danh sách tất cả các đối tượng CircleModel
    func getAllCircles() -> Results<CircleModel> {
        return realm.objects(CircleModel.self)
    }
    
    func fetCircle(id: String) throws -> Results<CircleModel> {
        return realm.objects(CircleModel.self).filter("id == %@", id)
    }
    
    
    
    
    
    
    
    // MARK: - DETAIL
    // Thêm một đối tượng CircleDetailModel vào cơ sở dữ liệu
    func addCircleDetail(itemOption: CircleDetailModel) throws {
        try realm.write {
            realm.add(itemOption, update: .modified)
        }
    }
    
    // Xóa một đối tượng CircleDetailModel
    func deleteCircleDetail(id: String) throws {
        if let circle = realm.object(ofType: CircleDetailModel.self, forPrimaryKey: id) {
            try realm.write {
                realm.delete(circle)
            }
        }
    }
    
    // Lấy danh sách tất cả các đối tượng CircleDetailModel
    func getAllCirclesDetail() -> Results<CircleDetailModel> {
        return realm.objects(CircleDetailModel.self)
    }
    
    func fetchPieces(idQuestion: String) throws -> Results<CircleDetailModel> {
        return realm.objects(CircleDetailModel.self).filter("idQuestion == %@", idQuestion)
    }
}
