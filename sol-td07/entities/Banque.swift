//
//  Banque.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import Foundation
class Banque : Codable {
    
    var id: String
    var nom: String
    var ville:String
    
    init(id: String, nom: String, ville: String) {
        self.id = id
        self.nom = nom
        self.ville = ville
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nom
        case ville
    }
    
}
