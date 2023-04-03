//
//  Client.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import Foundation
class Client : Codable {
    var id: String?
    var nom: String
    var telephone:String
    var banqueId:String
    
    init(id: String?, nom: String, telephone: String, banqueId: String) {
        self.id = id
        self.nom = nom
        self.telephone = telephone
        self.banqueId = banqueId
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nom
        case telephone
        case banqueId
    }
    
}

