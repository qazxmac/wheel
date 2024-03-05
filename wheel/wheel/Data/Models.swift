//
//  Models.swift
//  wheel
//
//  Created by admin on 02/03/2024.
//

import RealmSwift

class CircleModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var content: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CircleDetailModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var idQuestion: String = ""
    @objc dynamic var content: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
