//
//  CompteRestAPI.swift
//  sol-td07
//
//  Created by admin on 2023-04-05.
//

import Foundation
class CompteRestAPI {
    
    var whenComptesReady : WhenComptesReady?
    
    let session = URLSession.shared
    let url = URL(string: "https://derbali-36d8.restdb.io/rest/comptes")
    
    
    
    func getByClient(clientId:String) {
        let filter = URLQueryItem(name: "q", value: "{\"clientId\":\"\(clientId)\"}")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "derbali-36d8.restdb.io"
        urlComponents.path = "/rest/comptes"
        urlComponents.queryItems = [filter]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("232ec52be6fc72935ea68431ecf658ba36b5a", forHTTPHeaderField: "x-apikey")
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder  = JSONDecoder()
                    let comptes:[Compte] = try decoder.decode([Compte].self, from: data!)
                    
                    self.whenComptesReady?.loadData(comptes: comptes)
                    
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
    func addCompte(compte:Compte) {
        
        let headers = [
            "Content-Type":"application/json",
            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
        ]
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(compte)
        request.httpBody = data
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            if let resp = response as? HTTPURLResponse {
                print(resp.statusCode)
            }
        })
        
        task.resume()
    }
    
    func updateCompte(idCompte:String, compte:Compte) {
        
        let headers = [
            "Content-Type":"application/json",
            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
        ]
        let urlPut = URL(string: "https://derbali-36d8.restdb.io/rest/comptes/\(idCompte)")
        var request = URLRequest(url: urlPut!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "PUT"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(compte)
        request.httpBody = data
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
                
                if let resp = response as? HTTPURLResponse , resp.statusCode == 200 {
                    print(resp.statusCode)
                }
        })
        
        task.resume()
    }
//    
//    func deleteClient(idClient:String) {
//        
//        let headers = [
//            "Content-Type":"application/json",
//            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
//        ]
//        let urlDelete = URL(string: "https://derbali-36d8.restdb.io/rest/clients/\(idClient)")
//        var request = URLRequest(url: urlDelete!)
//        request.allHTTPHeaderFields = headers
//        request.httpMethod = "DELETE"
//        
//        let task = session.dataTask(with: request, completionHandler: {
//            (data, response, error) in
//            do {
//                //traitement
//                
//                if let resp = response as? HTTPURLResponse {
//                    print(resp.statusCode)
//                    //print("Nouveau client ajouté")
////                    let decoder  = JSONDecoder()
////                    let clientsAll:[Client] = try decoder.decode([Client].self, from: data!)
////                    //self.whenBanqueReady?.loadData(data: banques)
////                    var clients:[Client] = []
////                    for c in clientsAll {
////                        if c.banqueId == banqueId{
////                            //print("\(c.id) \(c.nom) \(c.telephone) \(c.banqueId)")
////                            clients.append(c)
////                        }
////                    }
////                    self.whenClientsReady?.loadData(clients: clients)
//                    
//                }
//            }catch{
//                print("error while getting banques")
//            }
//            
//        })
//        
//        task.resume()
//    }
    
}
