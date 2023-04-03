//
//  ClientRestAPI.swift
//  sol-td07
//
//  Created by admin on 2023-03-31.
//

import Foundation



class ClientRestAPI {
    
    var whenClientsReady : WhenClientsReady?
    
    let session = URLSession.shared
    let url = URL(string: "https://derbali-36d8.restdb.io/rest/clients")
    
    func getAll() {
        var request = URLRequest(url: url!)
        request.addValue("232ec52be6fc72935ea68431ecf658ba36b5a", forHTTPHeaderField: "x-apikey")
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder  = JSONDecoder()
                    let clients:[Client] = try decoder.decode([Client].self, from: data!)
                    self.whenClientsReady?.loadData(clients: clients)
                    
//                    for c in clients {
//                        print("\(c.id) \(c.nom) \(c.telephone) \(c.banqueId)")
//                    }
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
    
    func getByBanque(banqueId:String) {
        var request = URLRequest(url: url!)
        request.addValue("232ec52be6fc72935ea68431ecf658ba36b5a", forHTTPHeaderField: "x-apikey")
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                if let resp = response as? HTTPURLResponse, resp.statusCode == 200 {
                    let decoder  = JSONDecoder()
                    let clientsAll:[Client] = try decoder.decode([Client].self, from: data!)
                    //self.whenBanqueReady?.loadData(data: banques)
                    var clients:[Client] = []
                    for c in clientsAll {
                        if c.banqueId == banqueId{
                            //print("\(c.id) \(c.nom) \(c.telephone) \(c.banqueId)")
                            clients.append(c)
                        }
                    }
                    self.whenClientsReady?.loadData(clients: clients)
                    
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
    func addClient(client:Client) {
        
        let headers = [
            "Content-Type":"application/json",
            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
        ]
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(client)
        request.httpBody = data
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                
                if let resp = response as? HTTPURLResponse {
                    print(resp.statusCode)
                    //print("Nouveau client ajouté")
//                    let decoder  = JSONDecoder()
//                    let clientsAll:[Client] = try decoder.decode([Client].self, from: data!)
//                    //self.whenBanqueReady?.loadData(data: banques)
//                    var clients:[Client] = []
//                    for c in clientsAll {
//                        if c.banqueId == banqueId{
//                            //print("\(c.id) \(c.nom) \(c.telephone) \(c.banqueId)")
//                            clients.append(c)
//                        }
//                    }
//                    self.whenClientsReady?.loadData(clients: clients)
                    
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
    func updateClient(idClient:String, client:Client, index:Int) {
        
        let headers = [
            "Content-Type":"application/json",
            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
        ]
        let urlPut = URL(string: "https://derbali-36d8.restdb.io/rest/clients/\(idClient)")
        var request = URLRequest(url: urlPut!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "PUT"
        let encoder = JSONEncoder()
        let data = try? encoder.encode(client)
        request.httpBody = data
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                
                if let resp = response as? HTTPURLResponse , resp.statusCode == 200 {
                     let decoder  = JSONDecoder()
                    let clientUpdated:Client = try decoder.decode(Client.self, from: data!)
                    self.whenClientsReady?.updateIsDone(client: clientUpdated, index: index)
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
    func deleteClient(idClient:String) {
        
        let headers = [
            "Content-Type":"application/json",
            "x-apikey":"232ec52be6fc72935ea68431ecf658ba36b5a",
        ]
        let urlDelete = URL(string: "https://derbali-36d8.restdb.io/rest/clients/\(idClient)")
        var request = URLRequest(url: urlDelete!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "DELETE"
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            do {
                //traitement
                
                if let resp = response as? HTTPURLResponse {
                    print(resp.statusCode)
                    //print("Nouveau client ajouté")
//                    let decoder  = JSONDecoder()
//                    let clientsAll:[Client] = try decoder.decode([Client].self, from: data!)
//                    //self.whenBanqueReady?.loadData(data: banques)
//                    var clients:[Client] = []
//                    for c in clientsAll {
//                        if c.banqueId == banqueId{
//                            //print("\(c.id) \(c.nom) \(c.telephone) \(c.banqueId)")
//                            clients.append(c)
//                        }
//                    }
//                    self.whenClientsReady?.loadData(clients: clients)
                    
                }
            }catch{
                print("error while getting banques")
            }
            
        })
        
        task.resume()
    }
    
}
