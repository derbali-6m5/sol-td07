//
//  Compte.swift
//  sol-td07
//
//  Created by admin on 2023-03-24.
//

import Foundation
class Compte : Codable {
    var id: String
    var type: String
    var solde:Float
    var clientId:String
    
    init(id: String, type: String, solde: Float, clientId: String) {
        self.id = id
        self.type = type
        self.solde = solde
        self.clientId = clientId
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case solde
        case clientId
    }
    
}
