//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import Foundation
import RealmSwift

class PokemonModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var weight: Int = 0
    @Persisted var height: Int = 0
    @Persisted var imageURL: String = ""
    @Persisted var order: Int = 0
    @Persisted var date: Date = Date()
    @Persisted var baseExperience: Int = 0
    @Persisted var type: List<String> = List<String>()
    
    override init() {
        super.init()
    }
    
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yy, h:mm a"
        return formatter.string(from: date)
    }
    
    var types: String {
//        var types: [String] = []
//        type.forEach { value in
//            if let type = value.type {
//                types.append(type.name.capitalized)
//            }
//        }
        
        return type.joined(separator: ", ")
    }
    
    init(id: Int = 0, name: String = "", weight: Int = 0, height: Int = 0, imageURL: String = "", order: Int = 0, date: Date = Date(), baseExperience: Int = 0, type: [String] = []) {
        self.id = id
        self.name = name
        self.weight = weight
        self.height = height
        self.imageURL = imageURL
        self.order = order
        self.date = date
        self.baseExperience = baseExperience
        
        let realmTypes = List<String>()
        realmTypes.append(objectsIn: type)
        self.type = realmTypes
    }
    
    static func store(model: PokemonModel) {
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
        try! realm.write({
            realm.add(model, update: .all)
        })
    }
}

extension PokemonModel {
    static var empty: PokemonModel {
        PokemonModel()
    }
}
